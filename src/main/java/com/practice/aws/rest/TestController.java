package com.practice.aws.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @GetMapping("/data")
    public String getData() {

        return "code updated message from AWS Ecs";

    }

    @PostMapping("/testPost")
    public String getPost(@RequestBody String string) {

        System.out.println("test");
        return string;
    }


}
