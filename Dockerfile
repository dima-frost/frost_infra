FROM ubuntu:20.04
RUN apt-get update
ENV TZ=Europe/Kiev
RUN apt-get install -y mongodb-server ruby-full ruby-dev build-essential git
RUN gem install bundler:1.16.1
RUN git clone -b monolith https://github.com/express42/reddit.git
COPY mongod.conf /etc/mongod.conf
COPY db_config /reddit/db_config
COPY start.sh /start.sh
RUN cd /reddit && bundle install
RUN chmod 0777 /start.sh
CMD ["/start.sh"]