# Use the official Ruby base image
FROM ruby:3.0.2

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Bundler and gems
RUN bundle install

# Copy the application code into the container
COPY . .

# Expose port 4567
EXPOSE 4567

# Command to run the Sinatra application
CMD ["ruby", "backend.rb","-o", "0.0.0.0"]

