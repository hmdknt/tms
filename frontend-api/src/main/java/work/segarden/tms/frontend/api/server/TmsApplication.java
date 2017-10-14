package work.segarden.tms.frontend.api.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * SpringBootアプリケーションクラス.
 */
@SpringBootApplication
public class TmsApplication {

    /**
     * @param args
     */
    public static void main(String[] args) {
        SpringApplication application =
                new SpringApplication(TmsApplication.class);
        application.run(args);
    }
}
