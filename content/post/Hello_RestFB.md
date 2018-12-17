---
title: 'Hello RestFB'
date: 2015-10-21 05:55:32
categories: 
- DataBuilder
tags: 
- facebook
- restfb
- demo
- crawler
- socialmedia
---
RestFB是一个简单灵活的Facebook图谱API和REST客户端Java库。本演示用它来获取一个Facebook主页下的帖子、评论及回复。

### 获取Facebook AccessToken

![Hello RestFB](/images/2015/10/0026uWfMgy6WnxVpDMZe1.jpg)

### 示例代码

```
package com.yqu.restfb;

import java.util.List;

import com.restfb.Connection;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.Parameter;
import com.restfb.Version;
import com.restfb.types.Comment;
import com.restfb.types.Page;
import com.restfb.types.Post;

public class HelloRestFB {

  public static void main(String[] args) {
    FacebookClient facebookClient = new DefaultFacebookClient(
        MY_ACCESS_TOKEN,
        Version.VERSION_2_5);

    Page pageInfo = (Page) facebookClient.fetchObject("YquTest",
        Page.class, new Parameter[0]);

    Connection
 postConnection = facebookClient.fetchConnection(
        pageInfo.getId() + "/feed",
        Post.class,
        new Parameter[] { Parameter.with("limit", 10),
            Parameter.with("include_hidden", "true") });

    if (postConnection.getData().size() <= 0) {
      System.out.println("No posts found.");
      return;
    }
    for (List
 allPosts : postConnection) {
      for (Post post : allPosts) {
        System.out.println("post:" + post);
        // if (post.getComments() != null)
        {
          Connection commentConnection = facebookClient
              .fetchConnection(
                  post.getId() + "/comments",
                  Comment.class,
                  new Parameter[] {
                      Parameter.with("limit", 10),
                      Parameter.with("include_hidden",
                          "true") });
          if (commentConnection.getData().size() == 0)
            continue;
          for (List allComments : commentConnection) {
            for (Comment comment : allComments) {
              System.out.println("comment:" + comment);
              Connection replyConnection = facebookClient
                  .fetchConnection(comment.getId()
                      + "/comments", Comment.class);
              if (replyConnection.getData().size() == 0)
                continue;
              for (List allReplies : replyConnection) {
                for (Comment reply : allReplies) {
                  System.out.println("reply:" + reply);
                }
              }
            }
          }
        }
      }
    }
  }
}
```

### build.gradle

```
buildscript {
    repositories {
        mavenCentral()
    }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'

jar {
    baseName = 'hello-restfb'
    version =  '0.1.0'
}

repositories {
    mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
    compile 'com.restfb:restfb:1.15.0'
}

task wrapper(type: Wrapper) {
    gradleVersion = '2.3'
}
```

### 输出

```
post:Post[actions=[] adminCreator=null application=null attachments=null attribution=null caption=null comments=null commentsCount=0 createdTime=Wed Oct 21 04:22:55 EDT 2015 description=null feedTargeting=null from=null fullPicture=null icon=null id=778979068896920_779019608892866 isHidden=null isPublished=null likes=null likesCount=null link=null message=test again messageTags={} metadata=null name=null objectId=null picture=null place=null privacy=null properties=[] shares=null sharesCount=0 source=null statusType=null story=null targeting=null to=[] type=null updatedTime=null withTags=[]]
post:Post[actions=[] adminCreator=null application=null attachments=null attribution=null caption=null comments=null commentsCount=0 createdTime=Wed Oct 21 03:58:48 EDT 2015 description=null feedTargeting=null from=null fullPicture=null icon=null id=778979068896920_779014235560070 isHidden=null isPublished=null likes=null likesCount=null link=null message=haha messageTags={} metadata=null name=null objectId=null picture=null place=null privacy=null properties=[] shares=null sharesCount=0 source=null statusType=null story=null targeting=null to=[] type=null updatedTime=null withTags=[]]
comment:Comment[attachment=null canRemove=null commentCount=0 comments=null createdTime=Wed Oct 21 04:23:23 EDT 2015 from=CategorizedFacebookType[category=null id=10207944381947076 metadata=null name=Andrew Qu type=null] id=779014235560070_779019725559521 isHidden=null likeCount=null likes=null message=haha metadata=null object=null parent=null type=null userLikes=null canComment=false canHide=false]
post:Post[actions=[] adminCreator=null application=null attachments=null attribution=null caption=null comments=null commentsCount=0 createdTime=Wed Oct 21 03:26:42 EDT 2015 description=null feedTargeting=null from=null fullPicture=null icon=null id=778979068896920_779009285560565 isHidden=null isPublished=null likes=null likesCount=null link=null message=Test2 messageTags={} metadata=null name=null objectId=null picture=null place=null privacy=null properties=[] shares=null sharesCount=0 source=null statusType=null story=null targeting=null to=[] type=null updatedTime=null withTags=[]]
comment:Comment[attachment=null canRemove=null commentCount=0 comments=null createdTime=Wed Oct 21 03:26:55 EDT 2015 from=CategorizedFacebookType[category=null id=778979068896920 metadata=null name=YquTest type=null] id=779009285560565_779009298893897 isHidden=null likeCount=null likes=null message=Comment2 metadata=null object=null parent=null type=null userLikes=null canComment=false canHide=false]
reply:Comment[attachment=null canRemove=null commentCount=0 comments=null createdTime=Wed Oct 21 03:27:04 EDT 2015 from=CategorizedFacebookType[category=null id=778979068896920 metadata=null name=YquTest type=null] id=779009285560565_779009332227227 isHidden=null likeCount=null likes=null message=Reply2 metadata=null object=null parent=null type=null userLikes=null canComment=false canHide=false]
reply:Comment[attachment=null canRemove=null commentCount=0 comments=null createdTime=Wed Oct 21 03:59:09 EDT 2015 from=CategorizedFacebookType[category=null id=10208184284032675 metadata=null name=Bevan Li type=null] id=779009285560565_779014298893397 isHidden=null likeCount=null likes=null message=qie metadata=null object=null parent=null type=null userLikes=null canComment=false canHide=false]
reply:Comment[attachment=null canRemove=null commentCount=0 comments=null createdTime=Wed Oct 21 03:59:35 EDT 2015 from=CategorizedFacebookType[category=null id=10208184284032675 metadata=null name=Bevan Li type=null] id=779009285560565_779014342226726 isHidden=null likeCount=null likes=null message=YquTest hi metadata=null object=null parent=null type=null userLikes=null canComment=false canHide=false]
comment:Comment[attachment=null canRemove=null commentCount=0 comments=null createdTime=Wed Oct 21 03:33:53 EDT 2015 from=CategorizedFacebookType[category=null id=778979068896920 metadata=null name=YquTest type=null] id=779009285560565_779010392227121 isHidden=null likeCount=null likes=null message=Comment22 metadata=null object=null parent=null type=null userLikes=null canComment=false canHide=false]
post:Post[actions=[] adminCreator=null application=null attachments=null attribution=null caption=null comments=null commentsCount=0 createdTime=Wed Oct 21 01:35:54 EDT 2015 description=null feedTargeting=null from=null fullPicture=null icon=null id=778979068896920_778979332230227 isHidden=null isPublished=null likes=null likesCount=null link=null message=Test by Yqu messageTags={} metadata=null name=null objectId=null picture=null place=null privacy=null properties=[] shares=null sharesCount=0 source=null statusType=null story=null targeting=null to=[] type=null updatedTime=null withTags=[]]
comment:Comment[attachment=null canRemove=null commentCount=0 comments=null createdTime=Wed Oct 21 01:53:24 EDT 2015 from=CategorizedFacebookType[category=null id=778979068896920 metadata=null name=YquTest type=null] id=778979332230227_778982235563270 isHidden=null likeCount=null likes=null message=what? metadata=null object=null parent=null type=null userLikes=null canComment=false canHide=false]
reply:Comment[attachment=null canRemove=null commentCount=0 comments=null createdTime=Wed Oct 21 01:59:54 EDT 2015 from=CategorizedFacebookType[category=null id=778979068896920 metadata=null name=YquTest type=null] id=778979332230227_778983255563168 isHidden=null likeCount=null likes=null message=yes metadata=null object=null parent=null type=null userLikes=null canComment=false canHide=false]
reply:Comment[attachment=null canRemove=null commentCount=0 comments=null createdTime=Wed Oct 21 03:59:00 EDT 2015 from=CategorizedFacebookType[category=null id=10208184284032675 metadata=null name=Bevan Li type=null] id=778979332230227_779014268893400 isHidden=null likeCount=null likes=null message=test metadata=null object=null parent=null type=null userLikes=null canComment=false canHide=false]
comment:Comment[attachment=null canRemove=null commentCount=0 comments=null createdTime=Wed Oct 21 02:00:25 EDT 2015 from=CategorizedFacebookType[category=null id=778979068896920 metadata=null name=YquTest type=null] id=778979332230227_778983312229829 isHidden=null likeCount=null likes=null message=yup metadata=null object=null parent=null type=null userLikes=null canComment=false canHide=false]
```

### 参考

[RestFB](http://restfb.com/)  