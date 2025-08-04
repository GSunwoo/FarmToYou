package com.farm.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

import jakarta.servlet.DispatcherType;

@Configuration
public class WebSecurityConfig {
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http)
		throws Exception{
		http.csrf((csrf) -> csrf.disable())
			.cors((cors) -> cors.disable())
			.authorizeHttpRequests((request) -> request
					.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
					.requestMatchers("/").permitAll()
					.requestMatchers("/memberForm/**").permitAll()
					.requestMatchers("/css/**","/js/**", "/images/**").permitAll()
					.anyRequest().authenticated()
			);
		
		http.formLogin((formLogin) ->
				formLogin.loginPage("/myLogin.do")
						 .loginProcessingUrl("/myLoginAction.do")
						 .failureUrl("/myError.do")
//						 .failureHandler(myAuthFailureHandler)
						 .usernameParameter("my_id")
						 .passwordParameter("my_pass")
						 .permitAll());
		
		http.logout((logout) ->
			logout.logoutUrl("/myLogout.do")
				  .logoutSuccessUrl("/")
				  .permitAll());

		http.exceptionHandling((expHandling) -> expHandling
					.accessDeniedPage("/denied.do"));
		
		return http.build();
	}
	
	@Bean
	public UserDetailsService users() {
		System.out.println("패스워드 : " + passwordEncoder().encode("1234"));
		UserDetails user = User.builder()
					.username("user")
					.password(passwordEncoder().encode("1234"))
					.roles("USER")
					.build();
		UserDetails admin = User.builder()
					.username("admin")
					.password(passwordEncoder().encode("1234"))
					.roles("USER", "ADMIN")
					.build();
		
		return new InMemoryUserDetailsManager(user, admin);
	}
	
	public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
}
