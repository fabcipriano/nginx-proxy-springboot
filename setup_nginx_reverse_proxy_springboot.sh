#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Step 1: Create the directory structure
echo "Creating project directory structure..."
mkdir -p springboot-app/src/main/java/com/example/demo

# Step 2: Create the Spring Boot Application
echo "Creating Spring Boot application..."

cat <<EOL > springboot-app/src/main/java/com/example/demo/DemoApplication.java
package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class DemoApplication {
    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    @GetMapping("/echo")
    public String echo() {
        return "Hello from Spring Boot!";
    }
}
EOL

# Step 3: Create the pom.xml for Spring Boot
echo "Creating pom.xml..."

cat <<EOL > springboot-app/pom.xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>demo</artifactId>
    <version>0.0.1-SNAPSHOT</version>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
EOL

# Step 4: Create Dockerfile for Spring Boot Application
echo "Creating Dockerfile for Spring Boot application..."

cat <<EOL > springboot-app/Dockerfile
# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file into the container
COPY target/demo-0.0.1-SNAPSHOT.jar /app/demo.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java", "-jar", "demo.jar"]
EOL

# Step 5: Create NGINX configuration
echo "Creating NGINX configuration..."

cat <<EOL > nginx.conf
events {}

http {
    server {
        listen 80;

        location / {
            proxy_pass http://springboot:8080;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }
}
EOL

# Step 6: Create docker-compose.yml
echo "Creating docker-compose.yml..."

cat <<EOL > docker-compose.yml
version: '3.8'

services:
  springboot:
    build:
      context: ./springboot-app
    container_name: springboot-app
    ports:
      - "8080:8080"
    networks:
      - app-network

  nginx:
    image: nginx:1.18.0
    container_name: nginx-reverse-proxy
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    ports:
      - "80:80"
    depends_on:
      - springboot
    networks:
      - app-network

networks:
  app-network:
    driver: bridge
EOL

# Step 7: Build the Spring Boot application
echo "Building the Spring Boot application..."
cd springboot-app
mvn clean package

# Step 8: Run Docker Compose
echo "Starting Docker containers with Docker Compose..."
cd ..
docker-compose up --build

echo "Setup complete! You can access the application at http://localhost/echo"