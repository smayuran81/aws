package com.practice.aws.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @GetMapping("/data")
    public String getData() {

        return "first message from AWS Ecs";

    }


}
