---
title: 'Ribbon和Spring Cloud Consul'
date: 2017-06-29 05:45:01
categories: 
- Service及JavaEE
- Spring
tags: 
- ribbon
- consul
- spring
- loadbalance
- 负载均衡
---
学习一下[Client Side Load Balancing with Ribbon and Spring Cloud](https://spring.io/guides/gs/client-side-load-balancing/)快速入门指南，这里的客户端负载平衡是借助[Netflix Ribbon](https://github.com/Netflix/ribbon)实现的。很魔性，除了application.yml里有Ribbon的配置以及代码包含@RibbonClient、@LoadBalanced注解，应用程序几乎没什么工作要做了。

### @RibbonClient和@LoadBalanced的区别

[Difference between @RibbonClient and @LoadBalanced](https://stackoverflow.com/questions/39587317/difference-between-ribbonclient-and-loadbalanced)讲解了@RibbonClient和@LoadBalanced的区别。 @LoadBalanced是个标记注解，指示被注解的RestTemplate应该使用RibbonLoadBalancerClient与服务进行交互。反过来，这允许在URL除了使用物理主机名+端口号组合外，还可以使用服务名的逻辑标识符。
```
restTemplate.getForObject("http://some-service-name/user/{id}", String.class, 1);
```
@RibbonClient是用于配置Ribbon客户端的。它不是必须的，当使用服务发现且默认Ribbon设置就可以满足需求时，无需使用@RibbonClient注解。
在下列两种情况下需要使用@RibbonClient注解：
*   需要对特定Robbon客户端使用定制Ribbon设置
*   没有使用任何服务发现

定制Robbon设置：
```
@Configuration
@RibbonClient(name = "foo", configuration = FooConfiguration.class)
public class TestConfiguration {
}
```
注意FooConfiguration必须由@Configuration注解，但是它不能在主应用上下文@ComponentScan范围内，否则它将被所有@RibbonClient共享。如果使用@ComponentScan（或@SpringBootApplication），需要避免其被包含在内（例如放入独立不重叠的包内或显示指定@ComponentScan扫描的包）。

### Spring Cloud Consul和Ribbon

在没用使用任何服务发现时，Ribbon从listOfServers配置里的服务器列表进行选择的。偶在项目中是用Consul的，它主业就是干服务发现的工作，而且还支持[Netflix Ribbon](https://github.com/Netflix/ribbon)。
网上有现成的Spring Cloud Consul和Ribbon示例[spring-boot-consul-demo-tax](https://github.com/mgendelman/spring-boot-consul-demo-tax)和[spring-boot-consul-demo-invoice](https://github.com/mgendelman/spring-boot-consul-demo-invoice)。使用默认Ribbon设置，所以bootstrap.yml/application.yml里没有Ribbon设置，代码也没有使用@RibbonClient。
启动两个[spring-boot-consul-demo-tax](https://github.com/mgendelman/spring-boot-consul-demo-tax)微服务实例和一个[spring-boot-consul-demo-invoice](https://github.com/mgendelman/spring-boot-consul-demo-invoice)微服务实例，在浏览器访问[spring-boot-consul-demo-invoice](https://github.com/mgendelman/spring-boot-consul-demo-invoice)微服务，就会发现[spring-boot-consul-demo-invoice](https://github.com/mgendelman/spring-boot-consul-demo-invoice)微服务实例以RoundRobin轮询方式调用两个[spring-boot-consul-demo-tax](https://github.com/mgendelman/spring-boot-consul-demo-tax)微服务实例了。

### Ribbon组件

通过BaseLoadBalancer可以看出Ribbon中的负载均衡器所包含的几个重要组件/属性，正是这几个组件为Ribbon的功能提供支持:

| 组件 | 描述 |
| - | - |
|Rule	| 负载均衡策略，可以插件化地为Ribbon提供各种适用的负载均衡算法。|
|Ping	| 判断目标服务是否存活。对应不同的协议不同的方式去探测，得到后端服务是否存活。如有http的，还有对于微服务框架内的服务存活的NIWSDiscoveryPing是通过eureka client来获取的instanceinfo中的信息来获取。|
|ServerList	| 服务器列表，可以是静态的也可以是动态的。如果是（通过DynamicServerListLoadBalancer实现）动态的，会有后台线程以一定的间隔时间更新和过滤列表。|
|LoadBalancerStats | 负载均衡器运行信息。记录负载均衡器的实时运行信息，这些运行信息可以被用来作为负载均衡器策略的输入。|

#### 负载均衡策略 IRule

![IRule Hierarchy](/images/2017/06/IRule.png)

| 策略名 | 策略描述 | 实现说明 |
| - | - |
| BestAvailableRule | 选择一个最小并发请求的服务器 | 逐个考察服务器的LoadBalancerStats信息，如果服务器被断路器断了则忽略，在其中选择ActiveRequestsCount最小的服务器。 |
| AvailabilityFilteringRule | 过滤掉那些因为一直连接失败的被断路器断了的服务器，并过滤掉那些高并发的服务器（活跃连接数超过配置的阈值） | 使用一个AvailabilityPredicate来包含过滤服务器的逻辑，其实就是检查LoadBalancerStats里记录各个服务器的断路器状态和ActiveRequestsCount状态。当尝试十次后还无法选出合适的服务器，则通关过轮训策略选出一个。 |
| ZoneAvoidanceRule | 通过组合判断服务器所在zone的性能和服务器可用性来选择server | 使用ZoneAvoidancePredicate和AvailabilityPredicate来判断是否选择某个服务器，前一个判断判定一个zone的运行性能是否可用，剔除不可用的zone（的所有服务器），AvailabilityPredicate用于过滤掉连接数过多的服务器。 |
| RoundRobinRule | roundRobin方式轮询选择服务器 | 维护一个AtomicInteger类型的轮询下标，尝试十次从allServers选择下标对应位置的可用服务器（服务器不可用，则下标原子加一取模）。<br>有点疑问，allServers中前十个服务器不可用而第十一服务器可用，RoundRobinRule会取不到服务器，为什么不从reachableServers挑选呢？ |
| WeightedResponseTimeRule | 根据响应时间为每个服务器分配一个权重，使用加权RoundRobin方式选择服务器。 | 一个定时器线程从ServerStats里面读取评估响应时间，为每个服务器计算一个权重。权重为所有服务器平均响应时间总和减去服务器自己的平均响应时间。当刚开始运行，没有形成统计时，使用RoundRobin策略选择服务器。 |
| RandomRule | 随机选择一个服务器 | 在allServers随机选择下标，在reachableServers选择对应下标的可用服务器。<br>还是如上的疑问，为什么从allServers随机选择下标，而在reachableServers选择？ |
| RetryRule | 对已有的负载均衡策略加上重试机制。 | 在一个配置时间段内使用subRule的方式无法选择到可用服务器时，重新尝试。 |

#### 服务器存活检查 IPing

![IPing Hierarchy](/images/2017/06/IPing.png)

| IPing方式 | 描述 | 实现说明 |
| - | - |
| PingConstant | 根据配置返回固定的服务器可用状态。 | isAlive方法仅返回的就是配置值。如果没配置，则默认为true。 |
| DummyPing | 不进行任何实质操作，始终返回服务器可用。 | isAlive方法仅返回true。与NoOpPing类相比多实现了一个空的initWithNiwsConfig方法。 |
| NoOpPing | 不进行任何实质操作，始终返回服务器可用。 | isAlive方法仅返回true。 |
| PingUrl | Ping url以进行健康检查 | 通过对配置的服务器url进行HTTP GET操作，如果返回200 OK且HTTP响应体符合期望，则认为服务器存活，否则认为服务器有故障。 |
| ConsulPing | Ping一个基于Consul服务发现的服务器 | 没有进行实质HTTP请求，通过Consul健康检查结果获取服务器是否可用信息。|

#### 获取服务器列表 ServerList

![ServerList Hierarchy](/images/2017/06/ServerList.png) 其中ConsulServerList是通过serviceId获取某Consul服务的所有服务器实例列表。

#### 过滤服务器 ServerListFilter

![ServerListFilter Hierarchy](/images/2017/06/ServerListFilter.png) 其中HealthServiceServerListFilter是用于过滤，获取通过健康检查的Consul服务器。

### Ribbon配置

像上面所讲的Ribbon组件，负载均衡策略和服务器存活检查都有多种实现，所以Ribbon配置也是很丰富的。
[Working with load balancers](https://github.com/Netflix/ribbon/wiki/Working-with-load-balancers)提供了一些Ribbon配置项，[Client Side Load Balancer: Spring Cloud Ribbon](http://cloud.spring.io/spring-cloud-static/spring-cloud.html#spring-cloud-ribbon)提供了在Spring Boot环境对Ribbon进行配置的方法。
具体配置项可详见代码[com.netflix.client.config.DefaultClientConfigImpl](https://github.com/Netflix/ribbon/blob/master/ribbon-core/src/main/java/com/netflix/client/config/DefaultClientConfigImpl.java)和[com.netflix.client.config.CommonClientConfigKey](https://github.com/Netflix/ribbon/blob/master/ribbon-core/src/main/java/com/netflix/client/config/CommonClientConfigKey.java)。

| 配置项 | 配置类型 |
| - | - |
| AppName | String |
| Version | String |
| Port | Integer |
| SecurePort | Integer |
| VipAddress | String |
| ForceClientPortConfiguration | Boolean |
| DeploymentContextBasedVipAddresses | String |
| MaxAutoRetries | Integer |
| MaxAutoRetriesNextServer | Integer |
| OkToRetryOnAllOperations | Boolean |
| RequestSpecificRetryOn | Boolean |
| ReceiveBufferSize | Integer |
| EnablePrimeConnections | Boolean |
| PrimeConnectionsClassName | String |
| MaxRetriesPerServerPrimeConnection | Integer |
| MaxTotalTimeToPrimeConnections | Integer |
| MinPrimeConnectionsRatio | Float |
| PrimeConnectionsURI | String |
| PoolMaxThreads | Integer |
| PoolMinThreads | Integer |
| PoolKeepAliveTime | Integer |
| PoolKeepAliveTimeUnits | String |
| EnableConnectionPool | Boolean |
| MaxHttpConnectionsPerHost | Integer |
| MaxTotalHttpConnections | Integer |
| MaxConnectionsPerHost | Integer |
| MaxTotalConnections | Integer |
| IsSecure | Boolean |
| GZipPayload | Boolean |
| ConnectTimeout | Integer |
| BackoffTimeout | Integer |
| ReadTimeout | Integer |
| SendBufferSize | Integer |
| StaleCheckingEnabled | Boolean |
| Linger | Integer |
| ConnectionManagerTimeout | Integer |
| FollowRedirects | Boolean |
| ConnectionPoolCleanerTaskEnabled | Boolean |
| ConnIdleEvictTimeMilliSeconds | Integer |
| ConnectionCleanerRepeatInterval | Integer |
| EnableGZIPContentEncodingFilter | Boolean |
| ProxyHost | String |
| ProxyPort | Integer |
| KeyStore | String |
| KeyStorePassword | String |
| TrustStore | String |
| TrustStorePassword | String |
| IsClientAuthRequired | Boolean |
| CustomSSLSocketFactoryClassName | String |
| IsHostnameValidationRequired | Boolean |
| IgnoreUserTokenInConnectionPoolForSecureClient | Boolean |
| ClientClassName | String |
| InitializeNFLoadBalancer | Boolean |
| NFLoadBalancerClassName | String |
| NFLoadBalancerRuleClassName | String |
| NFLoadBalancerPingClassName | String |
| NFLoadBalancerPingInterval | Integer |
| NFLoadBalancerMaxTotalPingTime | Integer |
| NIWSServerListClassName | String |
| ServerListUpdaterClassName | String |
| NIWSServerListFilterClassName | String |
| ServerListRefreshInterval | Integer |
| EnableMarkingServerDownOnReachingFailureLimit | Boolean |
| ServerDownFailureLimit | Integer |
| ServerDownStatWindowInMillis | Integer |
| EnableZoneAffinity | Boolean |
| EnableZoneExclusivity | Boolean |
| PrioritizeVipAddressBasedServers | Boolean |
| VipAddressResolverClassName | String |
| TargetRegion | String |
| RulePredicateClasses | String |
| RequestIdHeaderName | String |
| UseIPAddrForServer | Boolean |
| listOfServers | String |

#### Ribbon调用流

LoadBalancerAutoConfiguration类会创建了一个LoadBalancerInterceptor的Bean，用于实现对客户端发起请求时进行拦截，以实现客户端负载均衡；会创建了一个RestTemplateCustomizer的Bean，用于给RestTemplate增加LoadBalancerInterceptor拦截器；会维护了一个被@LoadBalanced注解修饰的RestTemplate对象列表，并在这里进行初始化，通过调用RestTemplateCustomizer的实例来给需要客户端负载均衡的RestTemplate增加LoadBalancerInterceptor拦截器。
RestTemplate被@LoadBalance注解后，其在ClientHttpRequestExecution调用的过程中被名为LoadBalancerInterceptor的ClientHttpRequestInterceptor拦截器截获，进而交给负载均衡器LoadBalancerClient去处理。
LoadBalancerClient只是一个抽象的负载均衡器接口，核心功能交给了ILoadBalancer实现类来处理。ILoadBalancer实现类通过配置IRule、IPing等信息，通过ConsulClient获取注册列表的信息并定时检查服务器健康状态，得到注册列表后，ILoadBalancer实现类就可以根据IRule的策略进行负载均衡。

### 参考
* * *
[Client Side Load Balancer: Spring Cloud Ribbon](http://cloud.spring.io/spring-cloud-static/spring-cloud.html#spring-cloud-ribbon)  
[Advanced Spring Boot with Consul](https://content.pivotal.io/slides/advanced-spring-boot-consul)  
[SERVICE DISCOVERY USING CONSUL & SPRING CLOUD](http://blog.trifork.com/2016/12/14/service-discovery-using-consul-and-spring-cloud/)  
[GitHub: Netflix/ribbon](https://github.com/Netflix/ribbon)  
[Netflix源码解析之Ribbon：客户端负载均衡器Ribbon的设计和实现](http://www.idouba.net/netflix-source-loadbalancer-implementation-ribbon/)  
[Netflix源码解析之Ribbon：负载均衡策略的定义和实现](http://www.idouba.net/netflix-source-ribbon-rule/)  
[Spring Cloud源码分析（二）Ribbon](http://blog.didispace.com/springcloud-sourcecode-ribbon/)  
[深入理解Ribbon之源码解析](http://blog.csdn.net/forezp/article/details/74820899)  