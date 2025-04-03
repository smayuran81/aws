package com.practice.aws.rest;

import com.practice.aws.service.PriceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @Autowired
    PriceService priceService;

    @GetMapping("/data")
    public String getData() {

        priceService.getPriceForTicker("EUR");
        return "code updated message from AWS Ecs";

    }

    @PostMapping("/testPost")
    public String getPost(@RequestBody String string) {

        System.out.println("test1");
        return string;
    }


}
