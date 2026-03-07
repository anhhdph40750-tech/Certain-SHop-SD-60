package com.example.certainshop.controller;

import com.example.certainshop.service.SanPhamService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class HomeController {

    private final SanPhamService sanPhamService;

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("title", "Trang chủ - Certain Shop");
        model.addAttribute("sanPhams", sanPhamService.getAllSanPham());
        return "home/index";
    }
}