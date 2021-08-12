package com.viewnext.hellofinal;

import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import static org.assertj.core.api.Assertions.*


@SpringBootTest
class SmokeTest {

    @Autowired
    private HomeController controller

    @Test
    void contextLoads() {
        // assert controller!=null
        assertThat(controller).isNotNull()
    }


}
