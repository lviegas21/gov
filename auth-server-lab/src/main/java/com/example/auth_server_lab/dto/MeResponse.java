package com.example.auth_server_lab.dto;

import java.util.List;

public record MeResponse(
        String subject,
        String username,
        String name,
        String email,
        List<String> roles
) {
}
