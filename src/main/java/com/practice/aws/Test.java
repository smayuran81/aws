package com.practice.aws;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.function.Function;
import java.util.stream.Collectors;

public class Test {

    public static void main(String[] args) {


        List<String> list = new ArrayList<>();

        list.stream().map(str -> str.toUpperCase(Locale.ROOT)).
                collect(Collectors.groupingBy(s->s, Collectors.counting()));
    }
}
