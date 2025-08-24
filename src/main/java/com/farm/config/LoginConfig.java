package com.farm.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.farm.handler.LoginHandler;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.DispatcherType;

//config -> 설정
@Configuration
@EnableWebSecurity
public class LoginConfig {

	@PostConstruct
    public void init() {
        System.out.println("LoginConfig 빈이 등록되어 Security 설정이 적용됩니다.");
    }
	
	@Autowired
	public LoginHandler myAuthFailureHandler;

	// DB에서 사용자 정보를 조회하는 커스텀 UserDetailsService 주입
	@Autowired
	private CustomUserDetailsService customUserDetailsService;

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public AuthenticationManager authManager(HttpSecurity http) throws Exception {
		return http.getSharedObject(AuthenticationManagerBuilder.class)
				.userDetailsService(customUserDetailsService)
				.passwordEncoder(passwordEncoder()).and().build();
	}

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.csrf((csrf) -> csrf.disable())
			.cors((cors) -> cors.disable())

				// 어떤 요청 URL에 누가 접근 가능한지 설정하는 부분
				.authorizeHttpRequests((request) -> request
						.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
						.requestMatchers("/","/memberForm/**", "/guest/**" ).permitAll()
						.requestMatchers("/insertPurchase").permitAll()
						.requestMatchers("/css/**", "/js/**", "/images/**", "/uploads/**").permitAll()
						.requestMatchers("/buyer/**", "/wishlist/**").hasAnyRole("BUYER", "ADMIN")
						.requestMatchers("/seller/**").hasAnyRole("SELLER", "ADMIN")
						.requestMatchers("/inq/**").hasAnyRole("SELLER", "BUYER")
						.anyRequest()
						.authenticated());

		http.formLogin((formLogin) -> formLogin
				.loginPage("/myLogin.do")
				.loginProcessingUrl("/myLoginAction.do")
				.defaultSuccessUrl("/", true)
				.failureHandler(myAuthFailureHandler)
				.usernameParameter("my_id")
				.passwordParameter("my_pass")
				.permitAll());

		http.logout((logout) -> logout.logoutUrl("/myLogout.do").logoutSuccessUrl("/").permitAll());

		http.exceptionHandling((expHandling) -> expHandling.accessDeniedPage("/denied.do"));

		
		return http.build();
	}
}
