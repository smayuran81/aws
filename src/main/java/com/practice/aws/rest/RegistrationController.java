package com.practice.aws.rest;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RegistrationController {


    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        return "register2.html";
    }


}
