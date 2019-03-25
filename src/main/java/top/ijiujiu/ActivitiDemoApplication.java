package top.ijiujiu;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan({"top.ijiujiu","org.activiti"})
public class ActivitiDemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(ActivitiDemoApplication.class, args);
	}

}
