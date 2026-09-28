package vn.iotstar.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import vn.iotstar.entity.Role;
import vn.iotstar.entity.User;
import vn.iotstar.repository.RoleRepository;
import vn.iotstar.repository.UserRepository;

@Configuration
public class DataInitializer {

	@Bean
	CommandLineRunner initData(RoleRepository roles, UserRepository users, PasswordEncoder encoder,
			@Value("${ADMIN_EMAIL:thongledai@gmail.com}") String adminEmail,
			@Value("${ADMIN_PASSWORD:123456}") String adminPassword) {
		return args -> {
			Role userRole = roles.findByName("ROLE_USER")
					.orElseGet(() -> roles.save(Role.builder().name("ROLE_USER").build()));
			Role adminRole = roles.findByName("ROLE_ADMIN")
					.orElseGet(() -> roles.save(Role.builder().name("ROLE_ADMIN").build()));

			if (users.findByUsername("user01").isEmpty()) {
				users.save(User.builder().username("user01").email("user01@gmail.com")
						.password(encoder.encode("123456")).fullName("Lê Đại Thông").images("/images/user.png")
						.role(userRole).enabled(true).build());
			}

			if (users.findByUsername("admin").isEmpty()) {
				users.save(User.builder().username("admin").email(adminEmail.toLowerCase())
						.password(encoder.encode(adminPassword)).fullName("System Administrator")
						.images("/images/user.png").role(adminRole).enabled(true).build());
			}
		};
	}

}