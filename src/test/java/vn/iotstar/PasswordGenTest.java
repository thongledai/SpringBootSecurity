package vn.iotstar;

import org.junit.jupiter.api.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordGenTest {
    @Test
    void testEncode() {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String raw = "123456";
        String encoded = encoder.encode(raw);
        System.out.println("=== REAL BCRYPT FOR 123456 ===");
        System.out.println(encoded);
        System.out.println("Matches: " + encoder.matches(raw, encoded));
    }
}
