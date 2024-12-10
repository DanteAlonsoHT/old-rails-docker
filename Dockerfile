FROM ruby:1.9.3

# Update sources for Debian Jessie
RUN echo "deb http://archive.debian.org/debian jessie main\ndeb http://archive.debian.org/debian-security jessie/updates main" > /etc/apt/sources.list
RUN echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

# Install system dependencies
RUN apt-get update && apt-get install -y --force-yes \
    nodejs \
    postgresql-client \
    libpq-dev \
    build-essential \
    && apt-get clean

# Set up work directory
WORKDIR /app

# Copy needed files for the project
COPY Gemfile Gemfile.lock /app/

# Install gem dependencies and bundler
RUN gem install bundler -v '<2.0' && bundle install

# Copy all the missing files
COPY . /app

# Expose the port 3000 for rails app
EXPOSE 3000

# Copy script from entrypoint file
COPY entrypoint.sh /usr/bin/entrypoint.sh

# Set up entrypoint file
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

# Run rails server as default
CMD ["rails", "server", "-b", "0.0.0.0"]
