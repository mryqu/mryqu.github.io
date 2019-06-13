---
title: '处理注解@RequestParam的"Required String parameter is not present"'
date: 2014-02-04 10:04:20
categories: 
- Service+JavaEE
- Spring
tags: 
- springmvc
- requestparam
- required属性
---
最近玩一下SpringMVC，代码如下：
```
@Controller
@RequestMapping("/test.do")
public class TestController {
    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView sync(Model m, 
            @RequestParam("fid") String fid,
            @RequestParam("sid") String sid) throws Exception {        
        if(fid==null || sid==null) {
            m.addAttribute("file", new FileMetaDAO());
            return new ModelAndView(ViewProvider.UPLOAD);
        } else {
            m.addAttribute("sync", new SyncDAO());
            return new ModelAndView(ViewProvider.HR_SYNC);            
        }
    }
}
```
访问http://localhost:8080/hellorest/test.do 时发生如下问题：![处理注解@RequestParam的"Required String parameter is not present"](/images/2014/2/0026uWfMgy6MJkj4sBC5c.jpg)
查了一下[Annotation Type RequestParam的javadoc](http://docs.spring.io/spring/docs/3.0.x/api/org/springframework/web/bind/annotation/RequestParam.html)，加上可选参数required解决战斗。
```
@Controller
@RequestMapping("/test.do")
public class TestController {
    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView sync(Model m, 
            @RequestParam(value="fid", required = false) String fid,
            @RequestParam(value="sid", required = false) String sid) 
    throws Exception {        
        if(fid==null || sid==null) {
            m.addAttribute("file", new FileMetaDAO());
            return new ModelAndView(ViewProvider.UPLOAD);
        } else {
            m.addAttribute("sync", new SyncDAO());
            return new ModelAndView(ViewProvider.HR_SYNC);            
        }
    }
}
```
