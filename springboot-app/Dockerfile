# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file into the container
COPY target/simple-0.0.1-SNAPSHOT.jar /app/simple.jar

# Expose the port the app runs on
EXPOSE 8080

# Expose the JMX port (default is 9010)
EXPOSE 9010

# Run the jar file with JMX options
ENTRYPOINT ["java", \
            "-Dcom.sun.management.jmxremote", \
            "-Dcom.sun.management.jmxremote.port=9010", \
            "-Dcom.sun.management.jmxremote.rmi.port=9010", \
            "-Dcom.sun.management.jmxremote.authenticate=false", \
            "-Dcom.sun.management.jmxremote.ssl=false", \
            "-Djava.rmi.server.hostname=0.0.0.0", \
            "-jar", "simple.jar"]