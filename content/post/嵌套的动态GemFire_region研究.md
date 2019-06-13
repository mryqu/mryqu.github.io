---
title: '嵌套的动态GemFire region研究'
date: 2013-06-28 16:16:14
categories: 
- Service+JavaEE
- Cache
- GemFire
tags: 
- gemfire
- dynamic
- nested
- region
---
### 研究目的和结论

1. 研究多级动态region是否可行，结论可行
2. 研究嵌套region(一个region是另一个region的值)是否可行，结论可行

### Java代码

```
import java.util.Set;

import com.gemstone.gemfire.cache.Cache;
import com.gemstone.gemfire.cache.CacheFactory;
import com.gemstone.gemfire.cache.DynamicRegionFactory;
import com.gemstone.gemfire.cache.Region;

public class EmbededDynamicRegion {
  public static void main(String[] args) {
    System.out.println("\nConnecting to the distributed system and creating the cache.");
    Cache cache = null;

    try {
      // Create the cache which causes the cache-xml-file to be parsed
      cache = new CacheFactory().set("name", "yqu_test_cache")
          .set("cache-xml-file", "xml/YquTest.xml").create();

      // Get the exampleRegion
      Region yquRegion = cache.getRegion("yqu_region");
      printRegionFullPath(yquRegion);

      DynamicRegionFactory dynRegFactory = DynamicRegionFactory.get(); 
      for(int i=0;i<3;i++) {
        Region keyRegion = dynRegFactory.createDynamicRegion("/yqu_region", "k"+i);
        yquRegion.put("k"+i, keyRegion);        
        for(int j=0;j<10;j++) {
          Region asofRegion = dynRegFactory.createDynamicRegion("/yqu_region/k"+i,"asof"+j);
          keyRegion.put("asof"+j, asofRegion);
        }        
      }

      System.out.println("\nSubregions under /yqu_region:");
      Set<Region> regionSet = yquRegion.subregions(true);
      for(Region region:regionSet) {
        System.out.println("");
        printRegionFullPath(region);
        for(Object obj:region.keySet())
          System.out.println(obj+":"+region.get(obj));          
      }
    } catch (Throwable t) {
      t.printStackTrace();
    } finally {
      // Close the cache and disconnect from GemFire distributed system
      System.out.println("Closing the cache and disconnecting.");
      if(cache!=null)
        cache.close();
    }
  }

  public static void printRegionFullPath(Region region) {
    System.out.println("The path of region " + region.getName() + " :" +region.getFullPath());
  }
}
```

### XML配置文件


