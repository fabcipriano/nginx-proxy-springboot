#!/bin/bash

# Step 1: Create the resources directory if it doesn't exist
echo "Creating resources directory..."
mkdir -p src/main/resources

# Step 2: Create the application.properties file
echo "Creating application.properties..."
cat <<EOL > src/main/resources/application.properties
# Spring Boot Application Properties

# Enable JMX for the application (if needed)
spring.jmx.enabled=true

# Set the logging level for the entire application
logging.level.root=INFO

# Set the logging level for your specific package
logging.level.br.com.facio.simple=DEBUG

# Customize the log pattern (optional)
logging.pattern.console=%d{yyyy-MM-dd HH:mm:ss} - %msg%n

# Log file configuration (optional)
logging.file.name=logs/spring-boot-app.log
logging.file.path=logs
EOL

echo "application.properties created successfully!"