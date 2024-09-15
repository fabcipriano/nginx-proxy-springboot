package br.com.facio.simple;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class HelloApplication {
    public static void main(String[] args) {
        SpringApplication.run(HelloApplication.class, args);
    }

    @GetMapping("/echo")
    public String echo() {
        try {
            Thread.sleep(100);
        } catch (Exception e) {
            /*ignored*/
        }
        return "Hello from Spring Boot! Sleep ...";
    }
}
