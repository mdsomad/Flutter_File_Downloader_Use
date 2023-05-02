

//* Add This packages
//* packages 1 this --> flutter_downloader: ^1.10.2
//* packages 2 this --> path_provider: ^2.0.14
//* packages 2 this --> permission_handler: ^10.2.0








//* Open downloaded file from notification 
//* To make tapping on notification open the downloaded file on Android, add the following code to
//* AndroidManifest.xml
/*

xmlns:tools="http://schemas.android.com/tools"   
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

              First add this Code

              <provider
                  android:name="vn.hunghd.flutterdownloader.DownloadedFileProvider"
                  android:authorities="${applicationId}.flutter_downloader.provider"
                  android:exported="false"
                  android:grantUriPermissions="true">
                  <meta-data
                      android:name="android.support.FILE_PROVIDER_PATHS"
                      android:resource="@xml/provider_paths"/>
              </provider>













      2 Add this Code

        <!-- Begin FlutterDownloader customization -->
        <!-- disable default Initializer -->
        <provider
            android:name="androidx.startup.InitializationProvider"
            android:authorities="${applicationId}.androidx-startup"
            android:exported="false"
            tools:node="merge">
            <meta-data
                android:name="androidx.work.WorkManagerInitializer"
                android:value="androidx.startup"
                tools:node="remove" />
        </provider>

        <!-- declare customized Initializer -->
        <provider
            android:name="vn.hunghd.flutterdownloader.FlutterDownloaderInitializer"
            android:authorities="${applicationId}.flutter-downloader-init"
            android:exported="false">
            <!-- changes this number to configure the maximum number of concurrent tasks -->
            <meta-data
                android:name="vn.hunghd.flutterdownloader.MAX_CONCURRENT_TASKS"
                android:value="5" />
        </provider>
        <!-- End FlutterDownloader customization -->






   compileSdkVersion 33
   minSdkVersion 21






*/