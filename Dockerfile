FROM ruby:3.3

# Install essential dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    default-libmysqlclient-dev \
    default-mysql-client \
    default-mysql-server \
    && apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*



# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler
RUN bundle install

# Download the wait-for-it.sh script from GitHub using wget
RUN wget -O /app/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh

# Make the wait-for-it.sh script executable
RUN chmod +x /app/wait-for-it.sh

# Copy the rest of the application code into the container
COPY . .

# Start the dependencies and prepare the database
CMD ["bash", "-c", "bundle exec rake db:create db:migrate && bundle exec rails s -b 0.0.0.0"]
#CMD ["bash", "-c", "service mysql start && service elasticsearch start && service redis-server start && bundle exec rake db:create db:migrate && bundle exec rails s -b 0.0.0.0"]

