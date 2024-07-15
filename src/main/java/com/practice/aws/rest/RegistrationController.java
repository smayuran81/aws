package com.practice.aws.rest;


import com.practice.aws.model.UserDto;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.ArrayList;

@Controller
public class RegistrationController {


    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user",new UserDto());
        return "register.html";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("user") UserDto user, BindingResult result) {
        if(result.hasErrors()) {
            return "register";
        }
        return "redirect:register?success";
    }


}
