FROM ruby:2.3
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list  && \
sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
sed -i '/stretch-updates/d' /etc/apt/sources.list && \
apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

CMD ["puma"]