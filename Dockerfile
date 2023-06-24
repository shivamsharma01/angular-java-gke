# Stage 1: Build the application
FROM maven:3.8.4-openjdk-11-slim AS builder

WORKDIR /app

# Copy the project files
COPY pom.xml ./
COPY src ./src
COPY gulpfile.js ./

# Install Node.js and npm
RUN apt-get update && apt-get install -y curl && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs

# Install angular/cli and gulp-cli globally
RUN npm install -g @angular/cli gulp-cli

# Build the application
RUN mvn clean install -DskipTests

# Stage 2: Create a minimal image
FROM openjdk:8-jre-alpine

WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/users-0.0.1-SNAPSHOT.jar ./users.jar

# Run the application
CMD ["java", "-jar", "users.jar"]