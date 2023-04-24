# Use an official Node runtime as a parent image
FROM node:14-alpine

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and yarn.lock files to the container
COPY package*.json ./

# Install dependencies
RUN yarn install

# Copy the rest of the application code to the container
COPY . .

# Build the application
RUN yarn build

# Create a non-root user and set ownership of the /app directory to it
RUN addgroup -S appgroup && adduser -S appuser -G appgroup && chown -R appuser:appgroup /app

# Change user to the non-root user
USER appuser

# Expose port 3000 for the container
EXPOSE 3000

# Start the application
CMD ["yarn", "start"]