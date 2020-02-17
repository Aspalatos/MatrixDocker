# build from stock debian image
FROM debian:latest

# install needed packages
RUN apt-get update && apt-get install -y procps wget net-tools cron && rm -rf /var/lib/apt/lists/*

# add repo scripts
ADD . /matrix

# grab files from official matrix repo and set execute permissions
RUN cd /matrix && wget https://github.com/MatrixAINetwork/GMAN_CLIENT/raw/master/MAINNET/1022/linux/gman https://raw.githubusercontent.com/MatrixAINetwork/GMAN_CLIENT/master/MAINNET/1022/MANGenesis.json https://raw.githubusercontent.com/MatrixAINetwork/GMAN_CLIENT/master/MAINNET/1022/man.json && chmod a+x gman && alias man="/matrix/gman attach /matrix/chaindata/gman.ipc"

# install cron file to cleanup log files - script deletes logs older than 24 hours
RUN chmod 0600 /matrix/cronjob
RUN mv /matrix/cronjob /etc/cron.d/cronjob
RUN crontab -u root /etc/cron.d/cronjob
RUN touch /var/log/cron.log

# Start node script that sets a random entrust password to start node
ENTRYPOINT ["/matrix/nodeConfig.sh"]

#To start your node, run "docker run -d --network matrixnet --ip <ip address> -e MAN_PORT='<modified 50505 port>' -v /path/to/host/chaindata:/matrix/chaindata --name <docker_name> matrix"
#The /path/to/host/chaindata directory should be a directory on the host system that contains your keystore folder, with your wallet inside it.
#The directory can be named whatever you'd like but it will get mounted as the container chaindata folder. The scripts will do the rest.
