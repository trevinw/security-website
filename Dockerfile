FROM ruby:3.1.1

# Install NodeJS
RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash -
RUN apt-get install -y nodejs

# Install Yarn
RUN npm install --global yarn

# Install FreeTDS
RUN apt-get install -y unixodbc unixodbc-dev freetds-dev freetds-bin tdsodbc

# Set directory
WORKDIR /security-website

# Install gems
COPY Gemfile /security-website/Gemfile
COPY Gemfile.lock /security-website/Gemfile.lock
RUN bundle install

# Copy files to /security-website
ADD . /security-website/

# Set default ENV variables
ENV RAILS_ENV=production
ENV TZ="America/Los_Angeles"

EXPOSE 3000

# Compile CSS and JS files
RUN rails assets:precompile

CMD [ "rails", "server", "-b", "0.0.0.0" ]