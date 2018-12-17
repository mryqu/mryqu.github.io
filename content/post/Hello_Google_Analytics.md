---
title: 'Hello Google Analytics'
date: 2015-09-28 05:57:14
categories: 
- DataBuilder
tags: 
- google
- analytics
- api
- crawler
- socialmedia
---
Google Credential设置见我之前的博文[Google Analytics API Error 403: "User does not have any Google Analytics Account"](/post/google_analytics_api_error_403_user_does_not_have_any_google_analytics_account)。

**示例代码：**
```
package com.yqu.ga;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.analytics.Analytics;
import com.google.api.services.analytics.AnalyticsScopes;
import com.google.api.services.analytics.model.Accounts;
import com.google.api.services.analytics.model.GaData;
import com.google.api.services.analytics.model.GaData.ColumnHeaders;
import com.google.api.services.analytics.model.GaData.Query;
import com.google.api.services.analytics.model.Profiles;
import com.google.api.services.analytics.model.Webproperties;

public class HelloAnalytics { // I18NOK:CLS
  private static enum AuthType {
    SERVICE_ACCOUNT, SERVICE_ACCOUNT_P12, OAUTH
  };

  protected static final String APPLICATION_NAME = "Hello Analytics";
  protected static final JsonFactory JSON_FACTORY = GsonFactory
      .getDefaultInstance();

  protected static final String CREDENTIAL_FILE = "/YquGATest-xxxx.json";
  protected static final String CREDENTIAL_FILE_P12 = "/YquGATest-xxxx.p12";
  private static final String ACCOUNTID_P12 =
    "xxxx@developer.gserviceaccount.com";

  public static void main(String[] args) {
    try {
      Analytics analytics = initializeAnalytics(AuthType.OAUTH,
          "xxxx");

      String profile = getFirstProfileId(analytics);
      System.out.println("First Profile Id: " + profile);
      printResults(getResults(analytics, profile));
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  protected static HttpRequestInitializer setHttpTimeout(
      final HttpRequestInitializer requestInitializer) {
    return new HttpRequestInitializer() {
      @Override
      public void initialize(HttpRequest httpRequest) 
          throws IOException {
        requestInitializer.initialize(httpRequest);
        // 3 minutes connect timeout
        httpRequest.setConnectTimeout(3 * 60000);
        // 3 minutes read timeout
        httpRequest.setReadTimeout(3 * 60000);
      }
    };
  }

  protected static Analytics initializeAnalytics(AuthType authType,
      String accessToken) throws Exception {
    // Initializes an authorized analytics service object.
    HttpTransport httpTransport = GoogleNetHttpTransport
        .newTrustedTransport();
    GoogleCredential credential = null;

    if (authType.equals(AuthType.OAUTH)) {
      credential = new GoogleCredential()
        .setAccessToken(accessToken);
    } else if (authType.equals(AuthType.SERVICE_ACCOUNT)) {
      // Construct a GoogleCredential object with the 
      // service account email
      // and json file downloaded from the developer console.
      try (final InputStream in = ClassLoader.class
          .getResourceAsStream(CREDENTIAL_FILE);) {
        credential = GoogleCredential.fromStream(
          in, httpTransport, JSON_FACTORY)
          .createScoped(AnalyticsScopes.all());
      }
    } else {
      // Construct a GoogleCredential object with the  
      // service account email
      // and p12 file downloaded from the developer console.
      File p12File = new File(ClassLoader.class.getResource(
        CREDENTIAL_FILE_P12).getFile());

      credential = new GoogleCredential.Builder()
        .setTransport(httpTransport)
        .setJsonFactory(JSON_FACTORY)
        .setServiceAccountId(ACCOUNTID_P12)
        .setServiceAccountPrivateKeyFromP12File(p12File)
        .setServiceAccountScopes(AnalyticsScopes.all())
        .build();
    }

    // Construct the Analytics service object.
    return new Analytics.Builder(httpTransport, JSON_FACTORY,
        setHttpTimeout(credential))
        .setApplicationName(APPLICATION_NAME).build();
  }

  protected static String getFirstProfileId(Analytics analytics)
      throws IOException {
    // Get the first view (profile) ID for the authorized user.
    String profileId = null;

    // Query for the list of all accounts associated with
    // the service account.
    Accounts accounts = analytics.management().accounts()
        .list().execute();

    if (accounts.getItems().isEmpty()) {
      System.err.println("No accounts found");
    } else {
      String firstAccountId = accounts.getItems()
          .get(0).getId();

      // Query for the list of properties associated with
      // the first account.
      Webproperties properties = analytics.management()
          .webproperties()
          .list(firstAccountId).execute();

      if (properties.getItems().isEmpty()) {
        System.err.println("No Webproperties found");
      } else {
        String firstWebpropertyId = properties.getItems()
            .get(0).getId();

        // Query for the list views (profiles) associated
        // with the property.
        Profiles profiles = analytics.management()
          .profiles()
          .list(firstAccountId, firstWebpropertyId)
          .execute();

        if (profiles.getItems().isEmpty()) {
          System.err.println("No views (profiles) found");
        } else {
          // Return the first (view) profile associated
          // with the property.
          profileId = profiles.getItems().get(0).getId();
        }
      }
    }
    return profileId;
  }

  protected static GaData getResults(
      Analytics analytics, String profileId)
      throws IOException {
    // Query the Core Reporting API for the number of sessions
    // in the past seven days.
    return analytics
        .data()
        .ga()
        .get("ga:" + profileId, "30daysAgo", "today",
            "ga:sessions,ga:pageviews")
        .setDimensions("ga:source,ga:medium")
        .setSegment("gaid::-14")
        .setSort("-ga:sessions")
        .setFilters("ga:medium!=referral")
        .setMaxResults(5).setStartIndex(10).execute();
  }

  protected static void printResults(GaData results) {
    System.out.println("Printing results for profile: "
        + results.getProfileInfo().getProfileName());

    if (results.getRows() == null || results.getRows().isEmpty()) {
      System.out.println("No results Found.");
    } else {
      // Print the query that was run
      System.out.println();
      System.out.println("Query:");
      Query query = results.getQuery();

      System.out.println("   Dimensions: " + query.getDimensions());
      System.out.println("   Segment: " + query.getSegment());
      System.out.println("   Metrics: " + query.getMetrics());
      List sort = query.getSort();
      System.out.println("   Sort: "
          + (sort == null ? "" : sort.toString()));
      System.out.println("   Interval: " + query.getStartDate() + " ~ "
          + query.getEndDate());
      System.out.println("   Filters: " + query.getFilters());

      System.out.println();
      System.out.println("Results contain sampled data: "
          + results.getContainsSampledData().toString());
      System.out.println();

      // Print column headers.
      for (ColumnHeaders header : results.getColumnHeaders()) {
        System.out.printf("0s", header.getName());
      }
      System.out.println();

      // Print actual data.
      for (List row : results.getRows()) {
        for (String column : row) {
          System.out.printf("0s", column);
        }
        System.out.println();
      }

      System.out.println();
    }
  }
}
```

**输出：**
```
First Profile Id: xxxx
Printing results for profile: Corporate Site (Master Profile)

Query:
   Dimensions: ga:source,ga:medium
   Segment: gaid::-14
   Metrics: [ga:sessions, ga:pageviews]
   Sort: [-ga:sessions]
   Interval: 30daysAgo ~ today
   Filters: ga:medium!=referral

Results contain sampled data: true

      ga:source      ga:medium    ga:sessions   ga:pageviews
        display            cpm           1832           1906
       linkedin         cpc-su           1713           2501
   facebook-ads            cpc           1420           1576
        twitter            cpc           1365           1704
     feedburner           feed           1356           3967
```

### 参考

[Google Analytics](https://www.google.com/analytics/)  
[Google Analytics API](https://developers.google.com/analytics/)  
[Google Analytics API Client Library for Java](https://developers.google.com/api-client-library/java/apis/analytics/v3)  
[Google API Explorer: Analytics](https://developers.google.com/apis-explorer/#p/analytics/v3/)  
[Google Analytics API JavaDoc](https://developers.google.com/resources/api-libraries/documentation/analytics/v3/java/latest/)  
[GitHub: google/google-api-java-client](https://github.com/google/google-api-java-client)  
[Hello Analytics API: Java quickstart for service accounts](https://developers.google.com/analytics/devguides/reporting/core/v3/quickstart/service-java)  
[Instructions for the Google Analytics API Command-Line Samples](http://samples.google-api-java-client.googlecode.com/hg/analytics-cmdline-sample/instructions.html)  
[Google Api Java Client: Timeouts and Errors](https://developers.google.com/api-client-library/java/google-api-java-client/errors)  
[Google Analytics Query Explorer](https://ga-dev-tools.appspot.com/query-explorer/)  
[](http://mvnrepository.com/artifact/com.google.http-client/google-http-client)  
[Google Developer Console](https://console.developers.google.com)  
[Google Developer Console Help](https://developers.google.com/console/help/new/)  
[Using OAuth 2.0 to Access Google APIs](https://developers.google.com/identity/protocols/OAuth2)  
[Google OAuth 2.0 Playground](https://developers.google.com/oauthplayground/)  