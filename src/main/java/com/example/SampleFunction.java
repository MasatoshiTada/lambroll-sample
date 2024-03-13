package com.example;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;

import java.util.Map;

public class SampleFunction implements RequestHandler<Object, Object> {

    private static final Logger logger = LoggerFactory.getLogger(SampleFunction.class);

    @Override
    public Object handleRequest(Object o, Context context) {
        try {
            MDC.put("requestId", context.getAwsRequestId());
            String message = System.getenv("MESSAGE");
            int version = 4;
            logger.info("Message = {}, Version = {}", message, version);
            return Map.of("message", message + " " + version);
        } finally {
            MDC.clear();
        }
    }
}
