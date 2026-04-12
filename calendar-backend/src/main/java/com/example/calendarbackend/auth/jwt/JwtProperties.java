package com.example.calendarbackend.auth.jwt;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

@Getter
@Setter
@ConfigurationProperties(prefix = "jwt")
public class JwtProperties {
    private String issuer;
    private long accessTokenExpirationSeconds;
    private long refreshTokenExpirationSeconds;
    private String secretBase64;
}
