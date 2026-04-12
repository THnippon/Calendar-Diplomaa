package com.example.calendarbackend.auth.jwt;

import com.example.calendarbackend.entity.UserEntity;
import com.example.calendarbackend.repository.UserRepository;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    private final JwtService jwtService;
    private final UserRepository userRepository;

    public JwtAuthenticationFilter(JwtService jwtService, UserRepository userRepository) {
        this.jwtService = jwtService;
        this.userRepository = userRepository;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException
    {
        String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);

        if (authHeader == null || !authHeader.startsWith("Bearer "))
        {
            filterChain.doFilter(request, response);
            return;
        }

        String jwt = authHeader.substring(7).trim();


        if (jwt.isEmpty())
        {
            filterChain.doFilter(request, response);
            return;
        }

        Integer userId;
        try{
            String subject = jwtService.extractSubject(jwt);
            if (subject == null || subject.isBlank()) {
                filterChain.doFilter(request, response);
                return;
            }
            userId = Integer.valueOf(subject);
        } catch (JwtException | IllegalArgumentException ex){
            filterChain.doFilter(request, response);
            return;
        }

        UserEntity user = userRepository.findById(userId).orElse(null);

        if (user == null)
        {
            filterChain.doFilter(request, response);
            return;
        }

        try {
            if (!jwtService.isAccessTokenValid(jwt, user)) {
                filterChain.doFilter(request, response);
                return;
            }
        } catch (JwtException | IllegalArgumentException ex) {
            filterChain.doFilter(request, response);
            return;
        }

        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(user, null, List.of());

        SecurityContext context = SecurityContextHolder.createEmptyContext();
        context.setAuthentication(authentication);
        SecurityContextHolder.setContext(context);

        filterChain.doFilter(request, response);
    }
}
