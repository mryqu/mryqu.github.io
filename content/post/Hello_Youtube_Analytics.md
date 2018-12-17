---
title: 'Hello Youtube Analytics'
date: 2015-10-17 06:10:21
categories: 
- DataBuilder
tags: 
- google
- analytics
- youtube
- crawler
- socialmedia
---
Google Credential设置见我之前的博文[解决 "Access Not Configured. The API (YouTube Analytics API) is not enabled for your project."](/post/解决_access_not_configured._the_youtube_analytics_api_is_not_enabled_for_your_project)。

**示例代码：**
```
package com.yqu.yt;
import java.io.IOException;
import java.io.PrintStream;
import java.math.BigDecimal;
import java.util.List;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.youtube.YouTube;
import com.google.api.services.youtube.model.Channel;
import com.google.api.services.youtube.model.ChannelListResponse;
import com.google.api.services.youtubeAnalytics.YouTubeAnalytics;
import com.google.api.services.youtubeAnalytics.model.ResultTable;
import com.google.api.services.youtubeAnalytics.model.ResultTable.ColumnHeaders;
import com.google.common.collect.Lists;


public class HelloYoutubeAnalytics { //I18NOK:CLS
  
  private static final HttpTransport HTTP_TRANSPORT = 
      new NetHttpTransport();

  
  private static final JsonFactory JSON_FACTORY = 
      new JacksonFactory();

  
  private static YouTube youtube;

  
  private static YouTubeAnalytics analytics;

  
  public static void main(String[] args) {

    // These scopes are required to access information about the
    // authenticated user's YouTube channel as well as Analytics
    // data for that channel.
    List<string> scopes = Lists.newArrayList(
        "https://www.googleapis.com/auth/yt-analytics.readonly",
        "https://www.googleapis.com/auth/youtube.readonly"
    );
    
    try {
      // Authorize the request.
      String accessToken="YOUR_ACCESS_TOKEN";
      Credential  credential = new GoogleCredential()
          .setAccessToken(accessToken);


      // This object is used to make YouTube Data API requests.
      youtube = new YouTube.Builder(
          HTTP_TRANSPORT, JSON_FACTORY, credential)
          .setApplicationName("Hello Youtube Analytics")
          .build();

      // This object is used to make YouTube Analytics API requests.
      analytics = new YouTubeAnalytics.Builder(
          HTTP_TRANSPORT, JSON_FACTORY, credential)
          .setApplicationName("Hello Youtube Analytics")
          .build();

      // Construct a request to retrieve the current user's channel ID.
      YouTube.Channels.List channelRequest = youtube.
          channels().list("id,snippet");
      channelRequest.setMine(true);
      channelRequest.setFields("items(id,snippet/title)");
      ChannelListResponse channels = channelRequest.execute();

      // List channels associated with the user.
      List<channel> listOfChannels = channels.getItems();

      // The user's default channel is the first item in the list.
      Channel defaultChannel = listOfChannels.get(0);
      String channelId = defaultChannel.getId();

      PrintStream writer = System.out;
      if (channelId == null) {
        writer.println("No channel found.");
      } else {
        writer.println("Default Channel: " + 
            defaultChannel.getSnippet().getTitle() +
            " ( " + channelId + " )\n");

        printData(writer, "Views Over Time.", 
            executeViewsOverTimeQuery(analytics, channelId));
        printData(writer, "Top Videos", 
            executeTopVideosQuery(analytics, channelId));
        printData(writer, "Demographics", 
            executeDemographicsQuery(analytics, channelId));
      }
    } catch (IOException e) {
      System.err.println("IOException: " + e.getMessage());
      e.printStackTrace();
    } catch (Throwable t) {
      System.err.println("Throwable: " + t.getMessage());
      t.printStackTrace();
    }
  }

  
  private static ResultTable executeViewsOverTimeQuery(
      YouTubeAnalytics analytics, String id) 
  throws IOException {

    return analytics.reports()
        .query("channel==" + id,   // channel id
            "2015-10-01",     // Start date.
            "2015-10-30",     // End date.
            "views,uniques")    // Metrics.
        .setDimensions("day")
        .setSort("day")
        .execute();
  }

  
  private static ResultTable executeTopVideosQuery(
      YouTubeAnalytics analytics, String id)
  throws IOException {

    return analytics.reports()
        .query("channel==" + id,              // channel id
            "2015-10-01",                // Start date.
            "2015-10-30",                // End date.
            "views,subscribersGained,subscribersLost") // Metrics.
        .setDimensions("video")
        .setSort("-views")
        .setMaxResults(10)
        .execute();
  }

  
  private static ResultTable executeDemographicsQuery(
      YouTubeAnalytics analytics, String id)
  throws IOException {
    return analytics.reports()
        .query("channel==" + id,   // channel id
            "2015-10-01",     // Start date.
            "2015-10-30",     // End date.
            "viewerPercentage")   // Metrics.
        .setDimensions("ageGroup,gender")
        .setSort("-viewerPercentage")
        .execute();
  }

  
  private static void printData(
      PrintStream writer, 
      String title, 
      ResultTable results) {
    writer.println("Report: " + title);
    if (results.getRows() == null || results.getRows().isEmpty()) {
      writer.println("No results Found.");
    } else {

      // Print column headers.
      for (ColumnHeaders header : results.getColumnHeaders()) {
        writer.printf("%二十s", header.getName());
      }
      writer.println();

      // Print actual data.
      int colHeaderCount = results.getColumnHeaders().size();
      for (List<object> row : results.getRows()) {        
        for (int colNum = 0; colNum < colHeaderCount; colNum++) {
          ColumnHeaders header = results.getColumnHeaders().get(colNum);
          Object column = row.get(colNum);
          if ("INTEGER".equals(header.getUnknownKeys().get("dataType"))) {
            long l = ((BigDecimal) column).longValue();
            writer.printf("%二十d", l);
          } else if ("FLOAT".equals(header.getUnknownKeys().get("dataType"))) {
            writer.printf("f", column);
          } else if ("STRING".equals(header.getUnknownKeys().get("dataType"))) {
            writer.printf("%二十s", column);
          } else {
            // default output.
            writer.printf("%二十s", column);
          }
        }
        writer.println();
      }
      writer.println();
    }
  }
}
```

**输出：**
```
Default Channel: Andrew Qu ( UC-OpYDuNCwCt-AIHC6xNYdw )

Report: Views Over Time.
                 day               views             uniques
          2015-10-20                 1.0                 1.0

Report: Top Videos
               video               views   subscribersGained     subscribersLost
         KHqrLhJPdtE                 1.0                 0.0                 0.0

Report: Demographics
No results Found.
```

### 参考

[YouTube Analytics API Client Library for Java](https://developers.google.com/api-client-library/java/apis/youtubeAnalytics/v1)  
[YouTube Analytics and Reporting APIs - Java Code Samples](https://developers.google.com/youtube/reporting/v1/code_samples/java)  
[GitHub：youtube/api-samples之Auth.java](https://github.com/youtube/api-samples/blob/master/java/src/main/java/com/google/api/services/samples/youtube/cmdline/Auth.java)  
[YouTube Analytics API: Content Owner Reports](https://developers.google.com/youtube/analytics/v1/content_owner_reports)  
[Google OAuth 2.0 Playground](https://developers.google.com/oauthplayground/)  