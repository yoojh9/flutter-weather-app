# 투데이날씨

A new Flutter project.

### 1. Splash 적용
$ flutter pub run flutter_native_splash:create

<br>

### 2. .env 파일 필요
- openWeather API KEY
- google admob banner ID 

```
OPENWEATHER_API_KEY=##############
GOOGLE_ADMOB_BANNER_ID_ANDROID=##############
GOOGLE_ADMOB_BANNER_ID_IOS=##############
```

<br>

### 3. admob app_id 등록
- android

```
[src/main/AndroidManifest.xml]
   <application
        android:label="투데이날씨"
        android:icon="@mipmap/ic_launcher">
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="#########"/>
```

- ios

```
[ios/Runner/Info.plist]
	<key>GADApplicationIdentifier</key>
	<string>########</string>
```

<br>

### 4. firebase 연동
#### 1) android
- /app 하위에 google-services.json 등록

#### 2) ios
- /Runner 하위에 GoogleServivce-Info.plist 등록