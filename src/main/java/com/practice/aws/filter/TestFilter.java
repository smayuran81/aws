package com.practice.aws.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.util.ContentCachingRequestWrapper;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

@Component
public class TestFilter extends OncePerRequestFilter {
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {


       CachedBodyHttpServletRequest cachedBodyHttpServletRequest =
                new CachedBodyHttpServletRequest(request);
        //cachedBodyHttpServletRequest.getInputStream().

     //   ContentCachingRequestWrapper servletRequest = new ContentCachingRequestWrapper(request);
      //  servletRequest.getParameterMap();
    //    cacheRequestBody(servletRequest);

        String s = new String(cachedBodyHttpServletRequest.getInputStream().readAllBytes(),StandardCharsets.UTF_8);
       filterChain.doFilter(cachedBodyHttpServletRequest, response);

    }

    private void cacheRequestBody(ContentCachingRequestWrapper request) throws IOException {
        // Read the input stream to cache the request body
        BufferedReader reader = request.getReader();
        while (reader.readLine() != null) {
            // Reading the request body
        }
    }
}
