import wso2/gateway;

public function main() {
    int totalResourceLength = 0;
    boolean isRequestValidationEnabled  = gateway:getConfigBooleanValue(gateway:VALIDATION_CONFIG_INSTANCE_ID,
    gateway:REQUEST_VALIDATION_ENABLED, gateway:DEFAULT_REQUEST_VALIDATION_ENABLED);
    boolean isResponseValidationEnabled  = gateway:getConfigBooleanValue(gateway:VALIDATION_CONFIG_INSTANCE_ID,
    gateway:RESPONSE_VALIDATION_ENABLED, gateway:DEFAULT_RESPONSE_VALIDATION_ENABLED);
    
    if (isRequestValidationEnabled || isResponseValidationEnabled) {
    error? err = gateway:extractJAR("petstore", "Swagger_Petstore_New__1_0_0");
    if (err is error) {
        gateway:printError(gateway:MAIN, "Error when retrieving the resources artifacts", err);
    }
    }
    string[] Swagger_Petstore_New__1_0_0_service = [ "get6849dfecdaa04f918ef7907c7579162a"
                                , "get2d1baf15747a4ce8b4d1ae4baea6a839"
                                , "post69c343c03a394ef4a9dc2f8d1bb98236"
                                ];
    totalResourceLength = totalResourceLength +  Swagger_Petstore_New__1_0_0_service.length();
    gateway:populateAnnotationMaps("Swagger_Petstore_New__1_0_0", Swagger_Petstore_New__1_0_0, Swagger_Petstore_New__1_0_0_service);
    
    gateway:initiateInterceptorArray(totalResourceLength);
    
    initInterceptorIndexesSwagger_Petstore_New__1_0_0();
    
    addTokenServicesFilterAnnotation();
    initThrottlePolicies();
    gateway:initThrottleDataPublisher();
    gateway:startObservabilityListener();

    map<string> receivedRevokedTokenMap = gateway:getRevokedTokenMap();
    boolean jmsListenerStarted = gateway:initiateTokenRevocationJmsListener();

    boolean useDefault = gateway:getConfigBooleanValue(gateway:PERSISTENT_MESSAGE_INSTANCE_ID,
        gateway:PERSISTENT_USE_DEFAULT, gateway:DEFAULT_PERSISTENT_USE_DEFAULT);

    //TODO: Re enable this code once the compile errors are fixed
    if (useDefault){
        future<()> initETCDRetriveal = start gateway:etcdRevokedTokenRetrieverTask();
    } else {
        initiatePersistentRevokedTokenRetrieval(receivedRevokedTokenMap);
    }

    startupExtension();

    future<()> callhome = start gateway:invokeCallHome();
}
