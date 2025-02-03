package com.sp.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication()
public class HyggeApplication {

	public static void main(String[] args) {
		SpringApplication.run(HyggeApplication.class, args);
	}

}
