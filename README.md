# weather_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

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