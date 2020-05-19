# Webinar API Microgateway 3.1.0 - Demo

## hello-grpc
Projeto microgateway para exemplificar o microgateway expondo um serviço GRPC.
O projeto do server e cliente pode ser encontrado [aqui](https://github.com/VirajSalaka/HelloworldGrpcImpl).

Usamos o **HelloWorld.proto** como definição do serviço GRPC.

## petstore
Projeto microgateway para exemplicar um gateway a partir de uma definição Swagger.

## Observability

Para a parte de observability(Prometheus e Grafana) usamos o arquivo **monitoring.yaml**

```
kubectl apply -f monitoring.yaml
```

Essas configurações foram feitas considerando o uso do Docker for Desktop e o Microgateway rodando na máquina host. Na definição do arquivo do prometheus usamos host.docker.internal para fazer referência à máquina host. Caso rode o exemplo em servidores separados basta modificar essa configuração.

Para o Jaeger utilizamos a imagem docker disponível no Dockerhub, e usamos o comando abaixo para iniciá-lo:

```
    docker run -d --name jaeger \
    -e COLLECTOR_ZIPKIN_HTTP_PORT=9411 \
    -p 5775:5775/udp \
    -p 6831:6831/udp \
    -p 6832:6832/udp \
    -p 5778:5778 \
    -p 16686:16686 \
    -p 14268:14268 \
    -p 14250:14250 \
    -p 9411:9411 \
    jaegertracing/all-in-one:1.17	
```

## interceptors-java
Projeto Maven com o exemplo do Interceptor desenvolvido usando Java. Para utilizá-lo é necessário realizar o build com Maven para gerar o arquivo jar, usando o comando abaixo dentro do folder **interceptors-java**

```
mvn clean install
```

Após realizar o build, copiar o arquivo jar gerado na pasta target e colocá-lo na pasta lib do projeto microgateway. E devemos referenciá-lo no arquivo swagger:
```
x-wso2-request-interceptor: java:com.wso2.mgw.interceptors.SampleInterceptor
```


## keycloak

Para o exemplo dos Múltiplos JWT Issuers usamos o Key cloak como Third Party IDP, para inicializá-lo usamos o comando docker abaixo:

```
docker run -d -p 8180:8080 -p 8183:8443 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin jboss/keycloak
```

