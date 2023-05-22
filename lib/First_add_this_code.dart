

//* Add This packages
//* packages 1 this --> dio: ^5.1.2
//* packages 2 this --> path_provider: ^2.0.14
//* packages 3 this --> permission_handler: ^10.2.0
//* packages 4 this --> open_file_plus: ^3.4.1








//* Open downloaded file from notification 
//* To make tapping on notification open the downloaded file on Android, add the following code to
//* AndroidManifest.xml






/*





* var isStorage = await Permission.storage.status;
* var isAcceslc = await Permission.accessMediaLocation.status;
* var isMangExt = await Permission.manageExternalStorage.status;
* Example  Create Directory then Add this permissions --> final path = Directory('/storage/emulated/0/Download');
* then Add this permissions
xmlns:tools="http://schemas.android.com/tools"   
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" 
    tools:ignore="ScopedStorage"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.ACCESS_MEDIA_LOCATION"/>




* Code add location this --> android/build.gradle
* Example  Create Directory then Add this permissions --> final path = Directory('/storage/emulated/0/Download');
* then Add this code
subprojects {   <-- add this code
    project.configurations.all {
        resolutionStrategy.eachDependency { details ->
            if (details.requested.group == 'com.android.support'
                    && !details.requested.name.contains('multidex') ) {
                details.useVersion "27.1.1"
            }
        }
    }
}




* only Permission.storage.status then add this permission
* Example not Create Directory then Add this permissions --> final Directory? tempDir = await getExternalStorageDirectory();
* then Add this permissions
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />








            * First add this Code

          <provider android:name="androidx.core.content.FileProvider"
                  android:authorities="${applicationId}.fileProvider"
                  android:exported="false"
                  android:grantUriPermissions="true"
                  tools:replace="android:authorities">
            <meta-data android:name="android.support.FILE_PROVIDER_PATHS"
                       android:resource="@xml/filepaths"
                       tools:replace="android:resource" />
        </provider>













   compileSdkVersion 33
   minSdkVersion 21






*/


