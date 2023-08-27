# Use an official Ruby runtime as the base image
FROM ruby:3.0

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Expose the port your application will run on
EXPOSE 4567

# Define the command to run your application when the container starts
CMD ["ruby", "app.rb"]
