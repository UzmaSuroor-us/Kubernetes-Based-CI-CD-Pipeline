# Use an official base image
FROM openjdk:8-jdk-alpine

# Copy your application JAR file
COPY ./target/my-app-1.0-SNAPSHOT.jar /usr/app/my-app.jar

# Set the working directory
WORKDIR /usr/app

# Run the application
CMD ["java", "-jar", "my-app.jar"]
