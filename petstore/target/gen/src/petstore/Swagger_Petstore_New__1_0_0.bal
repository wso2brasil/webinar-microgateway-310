import ballerina/log;
import ballerina/http;
import ballerina/time;
import ballerina/runtime;
import praminda/formatters as vienna;

import wso2/gateway;


    http:Client Swagger_Petstore_New__1_0_0_prod = new (
gateway:retrieveConfig("api_1bff9f11aa45fd8d340e14633413481a2a963a5ff81b21fcebd62cea8e7bb012_prod_endpoint_0","https://petstore.swagger.io/v2"),
{ 
   httpVersion: gateway:getHttpVersion(),
    cache: { enabled: false }

,
secureSocket:{
    trustStore: {
           path: gateway:getConfigValue(gateway:LISTENER_CONF_INSTANCE_ID, gateway:TRUST_STORE_PATH,
               gateway:DEFAULT_TRUST_STORE_PATH),
           password: gateway:getConfigValue(gateway:LISTENER_CONF_INSTANCE_ID, gateway:TRUST_STORE_PASSWORD, gateway:DEFAULT_TRUST_STORE_PASSWORD)
     },
     verifyHostname:gateway:getConfigBooleanValue(gateway:HTTP_CLIENTS_INSTANCE_ID, gateway:ENABLE_HOSTNAME_VERIFICATION, true)
}

});








    
    
    
    
    
    

    
    

    
    int get6849dfecdaa04f918ef7907c7579162a_request_interceptor_index = -1;
    
    


    
    
    
    
    
    

    
    

    
    
    int get2d1baf15747a4ce8b4d1ae4baea6a839_response_interceptor_index = -1;
    


    
    
    
    
    
    

    
    

    
    











@http:ServiceConfig {
    basePath: "/petstore/v1",
    auth: {
        authHandlers: gateway:getAuthHandlers(["oauth2","jwt"], false, false)
    }
   
}

@gateway:API {
    publisher:"",
    name:"Swagger Petstore New",
    apiVersion: "1.0.0",
    apiTier : "" ,
    authProviders: ["oauth2","jwt"],
    security: {
            "apikey":[],
            "mutualSSL": "",
            "applicationSecurityOptional": false
        }
}
service Swagger_Petstore_New__1_0_0 on apiListener,
apiSecureListener {


    @http:ResourceConfig {
        methods:["GET"],
        path:"/pet/findByStatus",
        auth:{
        
            
        
            authHandlers: gateway:getAuthHandlers(["oauth2","jwt"], false, false)
        }
    }
    @gateway:Resource {
        authProviders: ["oauth2","jwt"],
        security: {
            "apikey":[],
            "applicationSecurityOptional": false 
            }
    }
    @gateway:RateLimit{policy : ""}
    resource function get6849dfecdaa04f918ef7907c7579162a (http:Caller outboundEp, http:Request req) {
        handleExpectHeaderForSwagger_Petstore_New__1_0_0(outboundEp, req);
        runtime:InvocationContext invocationContext = runtime:getInvocationContext();
        
        if(get6849dfecdaa04f918ef7907c7579162a_request_interceptor_index == -1) {
        
        } else {
            if(!gateway:invokeRequestInterceptor(get6849dfecdaa04f918ef7907c7579162a_request_interceptor_index, outboundEp, req)) {
                if(respondFromJavaInterceptorSwagger_Petstore_New__1_0_0(invocationContext, <@untainted>outboundEp)) {
                    // return only if  interceptor returned false and respond is called from interceptor.
                    return;
                }
            }
        }
        

        
        string urlPostfix = gateway:replaceFirst(req.rawPath,"/petstore/v1","");
        
        if(urlPostfix != "" && !gateway:hasPrefix(urlPostfix, "/")) {
            urlPostfix = "/" + urlPostfix;
        }
        http:Response|error clientResponse;
        http:Response r = new;
        clientResponse = r;
        string destination_attribute;
        invocationContext.attributes["timeStampRequestOut"] = time:currentTime().time;
        boolean reinitRequired = false;
        string failedEtcdKey = "";
        string failedEtcdKeyConfigValue = "";
        boolean|error hasUrlChanged;
        http:ClientConfiguration newConfig;
        boolean reinitFailed = false;
        boolean isProdEtcdEnabled = false;
        boolean isSandEtcdEnabled = false;
        map<string> endpointEtcdConfigValues = {};
        
            
            
                if("PRODUCTION" == <string>invocationContext.attributes["KEY_TYPE"]) {
                
                    
    clientResponse = Swagger_Petstore_New__1_0_0_prod->forward(urlPostfix, <@untainted>req);

invocationContext.attributes["destination"] = "https://petstore.swagger.io/v2";
                
                    } else {
                
                    http:Response res = new;
res.statusCode = 403;
string errorMessage = "Sandbox key offered to the API with no sandbox endpoint";
if (! invocationContext.attributes.hasKey(gateway:IS_GRPC)) {
    json payload = {
        ERROR_CODE: "900901",
        ERROR_MESSAGE: errorMessage
    };
    res.setPayload(payload);
} else {
    gateway:attachGrpcErrorHeaders (res, errorMessage);
}
invocationContext.attributes["error_code"] = "900901";
clientResponse = res;
                
                }
            
        
        
        invocationContext.attributes["timeStampResponseIn"] = time:currentTime().time;


        if(clientResponse is http:Response) {
            
            var outboundResult = outboundEp->respond(clientResponse);
            if (outboundResult is error) {
                log:printError("Error when sending response", err = outboundResult);
            }
        } else {
            http:Response res = new;
            res.statusCode = 500;
            string errorMessage = clientResponse.reason();
            int errorCode = 101503;
            string errorDescription = "Error connecting to the back end";

            if(gateway:contains(errorMessage, "connection timed out") || gateway:contains(errorMessage,"Idle timeout triggered")) {
                errorCode = 101504;
                errorDescription = "Connection timed out";
            }
            if(gateway:contains(errorMessage, "Malformed URL")) {
                errorCode = 101505;
                errorDescription = "Malformed URL";
            }
            invocationContext.attributes["error_response_code"] = errorCode;
            invocationContext.attributes["error_response"] = errorDescription;
            if (! invocationContext.attributes.hasKey(gateway:IS_GRPC)) {
                json payload = {fault : {
                                code : errorCode,
                                message : "Runtime Error",
                                description : errorDescription
                            }};

                            res.setPayload(payload);
            } else {
                gateway:attachGrpcErrorHeaders (res, errorDescription);
            }
            log:printError("Error in client response", err = clientResponse);
            var outboundResult = outboundEp->respond(res);
            if (outboundResult is error) {
                log:printError("Error when sending response", err = outboundResult);
            }
        }
    }


    @http:ResourceConfig {
        methods:["GET"],
        path:"/pet/{petId}",
        auth:{
        
            
        
            authHandlers: gateway:getAuthHandlers(["oauth2","jwt"], false, false)
        }
    }
    @gateway:Resource {
        authProviders: ["oauth2","jwt"],
        security: {
            "apikey":[],
            "applicationSecurityOptional": false 
            }
    }
    @gateway:RateLimit{policy : ""}
    resource function get2d1baf15747a4ce8b4d1ae4baea6a839 (http:Caller outboundEp, http:Request req) {
        handleExpectHeaderForSwagger_Petstore_New__1_0_0(outboundEp, req);
        runtime:InvocationContext invocationContext = runtime:getInvocationContext();
        

        
        string urlPostfix = gateway:replaceFirst(req.rawPath,"/petstore/v1","");
        
        if(urlPostfix != "" && !gateway:hasPrefix(urlPostfix, "/")) {
            urlPostfix = "/" + urlPostfix;
        }
        http:Response|error clientResponse;
        http:Response r = new;
        clientResponse = r;
        string destination_attribute;
        invocationContext.attributes["timeStampRequestOut"] = time:currentTime().time;
        boolean reinitRequired = false;
        string failedEtcdKey = "";
        string failedEtcdKeyConfigValue = "";
        boolean|error hasUrlChanged;
        http:ClientConfiguration newConfig;
        boolean reinitFailed = false;
        boolean isProdEtcdEnabled = false;
        boolean isSandEtcdEnabled = false;
        map<string> endpointEtcdConfigValues = {};
        
            
            
                if("PRODUCTION" == <string>invocationContext.attributes["KEY_TYPE"]) {
                
                    
    clientResponse = Swagger_Petstore_New__1_0_0_prod->forward(urlPostfix, <@untainted>req);

invocationContext.attributes["destination"] = "https://petstore.swagger.io/v2";
                
                    } else {
                
                    http:Response res = new;
res.statusCode = 403;
string errorMessage = "Sandbox key offered to the API with no sandbox endpoint";
if (! invocationContext.attributes.hasKey(gateway:IS_GRPC)) {
    json payload = {
        ERROR_CODE: "900901",
        ERROR_MESSAGE: errorMessage
    };
    res.setPayload(payload);
} else {
    gateway:attachGrpcErrorHeaders (res, errorMessage);
}
invocationContext.attributes["error_code"] = "900901";
clientResponse = res;
                
                }
            
        
        
        invocationContext.attributes["timeStampResponseIn"] = time:currentTime().time;


        if(clientResponse is http:Response) {
            
            if(get2d1baf15747a4ce8b4d1ae4baea6a839_response_interceptor_index == -1) {
            
                vienna:formatResponse (outboundEp, clientResponse);
                if(invocationContext.attributes.hasKey(gateway:RESPOND_DONE) && <boolean>invocationContext.attributes[gateway:RESPOND_DONE]) {
                    return;
                }
            
            } else {
                if(!gateway:invokeResponseInterceptor(get2d1baf15747a4ce8b4d1ae4baea6a839_response_interceptor_index, outboundEp, clientResponse)) {
                    if(respondFromJavaInterceptorSwagger_Petstore_New__1_0_0(invocationContext, <@untainted>outboundEp)) {
                        // return only if interceptor returned false and respond is called from interceptor.
                        return;
                    }
                }
            }
            var outboundResult = outboundEp->respond(clientResponse);
            if (outboundResult is error) {
                log:printError("Error when sending response", err = outboundResult);
            }
        } else {
            http:Response res = new;
            res.statusCode = 500;
            string errorMessage = clientResponse.reason();
            int errorCode = 101503;
            string errorDescription = "Error connecting to the back end";

            if(gateway:contains(errorMessage, "connection timed out") || gateway:contains(errorMessage,"Idle timeout triggered")) {
                errorCode = 101504;
                errorDescription = "Connection timed out";
            }
            if(gateway:contains(errorMessage, "Malformed URL")) {
                errorCode = 101505;
                errorDescription = "Malformed URL";
            }
            invocationContext.attributes["error_response_code"] = errorCode;
            invocationContext.attributes["error_response"] = errorDescription;
            if (! invocationContext.attributes.hasKey(gateway:IS_GRPC)) {
                json payload = {fault : {
                                code : errorCode,
                                message : "Runtime Error",
                                description : errorDescription
                            }};

                            res.setPayload(payload);
            } else {
                gateway:attachGrpcErrorHeaders (res, errorDescription);
            }
            log:printError("Error in client response", err = clientResponse);
            var outboundResult = outboundEp->respond(res);
            if (outboundResult is error) {
                log:printError("Error when sending response", err = outboundResult);
            }
        }
    }


    @http:ResourceConfig {
        methods:["POST"],
        path:"/pets",
        auth:{
        
            
        
            authHandlers: gateway:getAuthHandlers(["oauth2","jwt"], false, false)
        }
    }
    @gateway:Resource {
        authProviders: ["oauth2","jwt"],
        security: {
            "apikey":[],
            "applicationSecurityOptional": false 
            }
    }
    @gateway:RateLimit{policy : ""}
    resource function post69c343c03a394ef4a9dc2f8d1bb98236 (http:Caller outboundEp, http:Request req) {
        handleExpectHeaderForSwagger_Petstore_New__1_0_0(outboundEp, req);
        runtime:InvocationContext invocationContext = runtime:getInvocationContext();
        

        
        string urlPostfix = gateway:replaceFirst(req.rawPath,"/petstore/v1","");
        
        if(urlPostfix != "" && !gateway:hasPrefix(urlPostfix, "/")) {
            urlPostfix = "/" + urlPostfix;
        }
        http:Response|error clientResponse;
        http:Response r = new;
        clientResponse = r;
        string destination_attribute;
        invocationContext.attributes["timeStampRequestOut"] = time:currentTime().time;
        boolean reinitRequired = false;
        string failedEtcdKey = "";
        string failedEtcdKeyConfigValue = "";
        boolean|error hasUrlChanged;
        http:ClientConfiguration newConfig;
        boolean reinitFailed = false;
        boolean isProdEtcdEnabled = false;
        boolean isSandEtcdEnabled = false;
        map<string> endpointEtcdConfigValues = {};
        
            
            
                if("PRODUCTION" == <string>invocationContext.attributes["KEY_TYPE"]) {
                
                    
    clientResponse = Swagger_Petstore_New__1_0_0_prod->forward(urlPostfix, <@untainted>req);

invocationContext.attributes["destination"] = "https://petstore.swagger.io/v2";
                
                    } else {
                
                    http:Response res = new;
res.statusCode = 403;
string errorMessage = "Sandbox key offered to the API with no sandbox endpoint";
if (! invocationContext.attributes.hasKey(gateway:IS_GRPC)) {
    json payload = {
        ERROR_CODE: "900901",
        ERROR_MESSAGE: errorMessage
    };
    res.setPayload(payload);
} else {
    gateway:attachGrpcErrorHeaders (res, errorMessage);
}
invocationContext.attributes["error_code"] = "900901";
clientResponse = res;
                
                }
            
        
        
        invocationContext.attributes["timeStampResponseIn"] = time:currentTime().time;


        if(clientResponse is http:Response) {
            
            var outboundResult = outboundEp->respond(clientResponse);
            if (outboundResult is error) {
                log:printError("Error when sending response", err = outboundResult);
            }
        } else {
            http:Response res = new;
            res.statusCode = 500;
            string errorMessage = clientResponse.reason();
            int errorCode = 101503;
            string errorDescription = "Error connecting to the back end";

            if(gateway:contains(errorMessage, "connection timed out") || gateway:contains(errorMessage,"Idle timeout triggered")) {
                errorCode = 101504;
                errorDescription = "Connection timed out";
            }
            if(gateway:contains(errorMessage, "Malformed URL")) {
                errorCode = 101505;
                errorDescription = "Malformed URL";
            }
            invocationContext.attributes["error_response_code"] = errorCode;
            invocationContext.attributes["error_response"] = errorDescription;
            if (! invocationContext.attributes.hasKey(gateway:IS_GRPC)) {
                json payload = {fault : {
                                code : errorCode,
                                message : "Runtime Error",
                                description : errorDescription
                            }};

                            res.setPayload(payload);
            } else {
                gateway:attachGrpcErrorHeaders (res, errorDescription);
            }
            log:printError("Error in client response", err = clientResponse);
            var outboundResult = outboundEp->respond(res);
            if (outboundResult is error) {
                log:printError("Error when sending response", err = outboundResult);
            }
        }
    }

}

    function handleExpectHeaderForSwagger_Petstore_New__1_0_0 (http:Caller outboundEp, http:Request req ) {
        if (req.expects100Continue()) {
            req.removeHeader("Expect");
            var result = outboundEp->continue();
            if (result is error) {
            log:printError("Error while sending 100 continue response", err = result);
            }
        }
    }

function getUrlOfEtcdKeyForReInitSwagger_Petstore_New__1_0_0(string defaultUrlRef,string etcdRef, string defaultUrl, string etcdKey) returns string {
    string retrievedEtcdKey = <string> gateway:retrieveConfig(etcdRef,etcdKey);
    map<any> urlChangedMap = gateway:getUrlChangedMap();
    urlChangedMap[<string> retrievedEtcdKey] = false;
    map<string> etcdUrls = gateway:getEtcdUrlsMap();
    string url = <string> etcdUrls[retrievedEtcdKey];
    if (url == "") {
        return <string> gateway:retrieveConfig(defaultUrlRef, defaultUrl);
    } else {
        return url;
    }
}

function respondFromJavaInterceptorSwagger_Petstore_New__1_0_0(runtime:InvocationContext invocationContext, http:Caller outboundEp) returns boolean {
    boolean tryRespond = false;
    if(invocationContext.attributes.hasKey(gateway:RESPOND_DONE) && invocationContext.attributes.hasKey(gateway:RESPONSE_OBJECT)) {
        if(<boolean>invocationContext.attributes[gateway:RESPOND_DONE]) {
            http:Response clientResponse = <http:Response>invocationContext.attributes[gateway:RESPONSE_OBJECT];
            var outboundResult = outboundEp->respond(clientResponse);
            if (outboundResult is error) {
                log:printError("Error when sending response from the interceptor", err = outboundResult);
            }
            tryRespond = true;
        }
    }
    return tryRespond;
}

function initInterceptorIndexesSwagger_Petstore_New__1_0_0() {


    
        

        
        string get6849dfecdaa04f918ef7907c7579162a_request_interceptor_name = "java:org.wso2.mgw.interceptors.SampleInterceptor";
        if(get6849dfecdaa04f918ef7907c7579162a_request_interceptor_name.startsWith("java:")) {
            get6849dfecdaa04f918ef7907c7579162a_request_interceptor_index = gateway:loadInterceptorClass(get6849dfecdaa04f918ef7907c7579162a_request_interceptor_name.substring(5, get6849dfecdaa04f918ef7907c7579162a_request_interceptor_name.length()));
        }
        
        


    
        

        
        
        string get2d1baf15747a4ce8b4d1ae4baea6a839_response_interceptor_name = "vienna:formatResponse";
        if(get2d1baf15747a4ce8b4d1ae4baea6a839_response_interceptor_name.startsWith("java:")) {
            get2d1baf15747a4ce8b4d1ae4baea6a839_response_interceptor_index = gateway:loadInterceptorClass(get2d1baf15747a4ce8b4d1ae4baea6a839_response_interceptor_name.substring(5, get2d1baf15747a4ce8b4d1ae4baea6a839_response_interceptor_name.length()));
        }
        


    
        

        
        


}