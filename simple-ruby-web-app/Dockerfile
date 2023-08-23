# Use the official Ruby image as the base image
FROM ruby:3.0

# Set the working directory in the container
WORKDIR /app

# Copy all files to the container
COPY . ./

# Install gem dependencies
RUN gem install bundler
RUN bundle install


# Expose port 4567 for the Sinatra app
EXPOSE  8080

# Define the command to run the application
CMD ["ruby", "app.rb"]
