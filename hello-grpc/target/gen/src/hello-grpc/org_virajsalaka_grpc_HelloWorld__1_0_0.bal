import ballerina/log;
import ballerina/http;
import ballerina/time;
import ballerina/runtime;

import wso2/gateway;


    http:Client org_virajsalaka_grpc_HelloWorld__1_0_0_prod = new (
gateway:retrieveConfig("api_6437d6b27e0e2da992a2b9c4e242f9f2171dc5a827a252414ac39f3d9e47bf64_prod_endpoint_0","http://localhost:50051"),
{ 
   httpVersion: gateway:getHttpVersion() , http2Settings: { http2PriorKnowledge: true } ,
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








    
    
    
    
    
    

    
    

    
    











@http:ServiceConfig {
    basePath: "/org.virajsalaka.grpc.HelloWorld",
    auth: {
        authHandlers: gateway:getAuthHandlers(["apikey"], false, false)
    }
   
}

@gateway:API {
    publisher:"",
    name:"org.virajsalaka.grpc.HelloWorld",
    apiVersion: "1.0.0",
    apiTier : "" ,
    authProviders: ["apikey"],
    security: {
            "apikey":[ { "in": "header", "name": "api_key" } ],
            "mutualSSL": "",
            "applicationSecurityOptional": false
        }
}
service org_virajsalaka_grpc_HelloWorld__1_0_0 on apiListener,
apiSecureListener {


    @http:ResourceConfig {
        methods:["POST"],
        path:"hello",
        auth:{
        
            
        
            authHandlers: gateway:getAuthHandlers(["apikey"], false, false)
        }
    }
    @gateway:Resource {
        authProviders: ["apikey"],
        security: {
            "apikey":[ { "in": "header", "name": "api_key" } ],
            "applicationSecurityOptional": false 
            }
    }
    @gateway:RateLimit{policy : ""}
    resource function post9332e6d5eee749bd8234201197e5450b (http:Caller outboundEp, http:Request req) {
        handleExpectHeaderFororg_virajsalaka_grpc_HelloWorld__1_0_0(outboundEp, req);
        runtime:InvocationContext invocationContext = runtime:getInvocationContext();
        

        
            string urlPostfix = <@untainted>req.rawPath;
        
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
                
                    
    clientResponse = org_virajsalaka_grpc_HelloWorld__1_0_0_prod->forward(urlPostfix, <@untainted>req);

invocationContext.attributes["destination"] = "http://localhost:50051";
                
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

    function handleExpectHeaderFororg_virajsalaka_grpc_HelloWorld__1_0_0 (http:Caller outboundEp, http:Request req ) {
        if (req.expects100Continue()) {
            req.removeHeader("Expect");
            var result = outboundEp->continue();
            if (result is error) {
            log:printError("Error while sending 100 continue response", err = result);
            }
        }
    }

function getUrlOfEtcdKeyForReInitorg_virajsalaka_grpc_HelloWorld__1_0_0(string defaultUrlRef,string etcdRef, string defaultUrl, string etcdKey) returns string {
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

function respondFromJavaInterceptororg_virajsalaka_grpc_HelloWorld__1_0_0(runtime:InvocationContext invocationContext, http:Caller outboundEp) returns boolean {
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

function initInterceptorIndexesorg_virajsalaka_grpc_HelloWorld__1_0_0() {


    
        

        
        


}