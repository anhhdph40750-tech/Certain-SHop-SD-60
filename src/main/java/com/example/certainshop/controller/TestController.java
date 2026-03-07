package com.example.certainshop.controller;

import com.example.certainshop.entity.VaiTro;
import com.example.certainshop.repository.VaiTroRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class TestController {

    @Autowired
    private VaiTroRepository vaiTroRepository;

    @GetMapping("/test-db")
    public String testDb() {
        List<VaiTro> vaiTros = vaiTroRepository.findAll();
        return "Có " + vaiTros.size() + " vai trò trong database: " + vaiTros;
    }
}