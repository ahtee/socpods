# ./Dockerfile

FROM ruby:2.3.7

MAINTAINER benottedev@gmail.com

# Configure the main working directory. This is the base 
# directory used in any further RUN, COPY, and ENTRYPOINT 
# commands.
ENV APP_HOME /home/app/
ENV RAILS_ENV development
ENV BUNDLE_PATH /bundle

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# Install apt based dependencies required to run Rails as 
# well as RubyGems. As the Ruby image itself is based on a 
# Debian image, we use apt-get to install those.
RUN apt-get update -qq && apt-get install -y --no-install-recommends \ 
  build-essential \ 
  curl libssl-dev \
  git \
  unzip \
  zlib1g-dev \
  libxslt-dev \
  mysql-client \
  sqlite3 \
  nodejs

# Copy the Gemfile as well as the Gemfile.lock and install 
# the RubyGems. This is a separate step so the dependencies 
# will be cached unless changes to one of those two files 
# are made.
# COPY Gemfile Gemfile.lock $APP_HOME 
RUN gem install bundler 

# Build the Rails application
COPY Gemfile Gemfile
RUN bundle install

# Copy the main application to the workdir
COPY . .

# Expose port 3000 to the Docker host, so we can access it 
# from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also 
# tell the Rails dev server to bind to all interfaces by 
# default.
CMD ["bundle", "exec", "rails", "server"]