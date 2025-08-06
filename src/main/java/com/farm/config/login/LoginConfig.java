package com.farm.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.farm.handler.LoginHandler;

import jakarta.servlet.DispatcherType;

//config -> 설정
@Configuration
public class LoginConfig {

	@Autowired
	public LoginHandler myAuthFailureHandler;
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http)
		throws Exception{
		http.csrf((csrf) -> csrf.disable())
			.cors((cors) -> cors.disable())
			//어떤 요청 URL에 누가 접근 가능한지 설정하는 부분
			.authorizeHttpRequests((request) -> request
					.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
					.requestMatchers("/").permitAll()
					.requestMatchers("/css/**","/js/**", "/images/**").permitAll()
					.requestMatchers("/buyer/**").hasAnyRole("buyer")
					.requestMatchers("/seller/**").hasAnyRole("seller")
					.anyRequest().authenticated()
			);
		
		http.formLogin((formLogin) ->
		formLogin.loginPage("/myLogin.do")
				 .loginProcessingUrl("/myLoginAction.do")
//				 .failureUrl("/myError.do")
				 .failureHandler(myAuthFailureHandler)
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
	@Autowired
	private DataSource dataSource;
	
	@Autowired
	protected void configure(AuthenticationManagerBuilder auth)
			throws Exception {
		auth.jdbcAuthentication()
			.dataSource(dataSource)
			.usersByUsernameQuery("select USER_ID, user_pw, enable "
					+ " from member where USER_ID = ?")
			.authoritiesByUsernameQuery("select USER_ID, USER_TYPE "
				+ " from member where USER_ID = ?")
			.passwordEncoder(new BCryptPasswordEncoder());
	}
}
