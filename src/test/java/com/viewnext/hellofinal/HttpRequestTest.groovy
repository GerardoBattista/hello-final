package com.viewnext.hellofinal;

import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.boot.test.web.client.TestRestTemplate
import org.springframework.boot.web.server.LocalServerPort
import static org.assertj.core.api.Assertions.*

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class HttpRequestTest {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate restTemplate;

    @Test
    public void canAdd() throws Exception {
       assertThat(this.restTemplate.getForObject("http://localhost:"+port+"/add?a=1&b=2", String.class))
        .isEqualTo("3.0")
    }

}
