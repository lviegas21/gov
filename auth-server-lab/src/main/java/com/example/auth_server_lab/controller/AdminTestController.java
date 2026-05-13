package com.example.auth_server_lab.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AdminTestController {

    @GetMapping("/admin/test")
    public ResponseEntity<Map<String, Object>> adminTest() {
        return ResponseEntity.ok(Map.of(
                "message", "acesso admin liberado"
        ));
    }
}