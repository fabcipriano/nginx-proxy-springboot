package br.com.facio.simple;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class HelloApplication {

    // Create a logger instance for this class
    private static final Logger logger = LoggerFactory.getLogger(HelloApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(HelloApplication.class, args);
    }

    @GetMapping("/echo")
    public String echo() {
        // Log the start time
        long startTime = System.currentTimeMillis();
        logger.info("Method echo() started at: {}", startTime);

        try {
            Thread.sleep(100);
        } catch (Exception e) {
            logger.error("An error occurred in echo(): ", e);
        }

        // Log the end time and calculate the execution time
        long endTime = System.currentTimeMillis();
        logger.info("Method echo() ended at: {}", endTime);
        logger.info("Method echo() executed in: {} ms", (endTime - startTime));

        return "Hello from Spring Boot! Sleep ...";
    }
}