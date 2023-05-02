import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Downloader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String fileName = "";
  var taskId;

//TODO _downloadFile Function
  _downloadFile() async {

    final status = await Permission.storage.request();

    if (status.isGranted) {

      final basrStorage = await getExternalStorageDirectory();

      final String date = DateTime.now().microsecondsSinceEpoch.toString();
      fileName = "$date.mp4";

      taskId = await FlutterDownloader.enqueue(
          url:"https://rr1---sn-n4v7sney.googlevideo.com/videoplayback?expire=1683029767&ei=p6pQZP6WG5OPkgbFnI6oBw&ip=52.53.250.162&id=o-ABcfrboNqgSr9QfQkxlLRtsEqi0XRjiYwSCHuKBcUSTG&itag=137&aitags=133%2C134%2C135%2C136%2C137%2C160%2C242%2C243%2C244%2C247%2C248%2C278%2C394%2C395%2C396%2C397%2C398%2C399&source=youtube&requiressl=yes&mh=ov&mm=31%2C29&mn=sn-n4v7sney%2Csn-o097znz7&ms=au%2Crdu&mv=u&mvi=1&pl=23&vprv=1&mime=video%2Fmp4&ns=FupkUnXWxf3T74JVBMx_UykN&gir=yes&clen=79966844&dur=205.520&lmt=1628193898622239&mt=1683007514&fvip=2&keepalive=yes&fexp=24007246&c=WEB&txp=5535434&n=bwDVOmriDeBJ7Q&sparams=expire%2Cei%2Cip%2Cid%2Caitags%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cdur%2Clmt&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl&lsig=AG3C_xAwRAIgTD607IFpyZUcnocbXMl-4nKgGXOK-qOoeniuF_hDDgICIDzFChuyu5UkOsUIsSDrbibcXZ4myq6AXGxvvp8PlbsX&sig=AOq0QJ8wRgIhAINW2k1uYQ2KVN6DlGLxkkTeyjEFSi-gAk6opFrqqdD2AiEA00FQyRSWESxhBpI76hurDBGbjUa7R5bvZsNxyq9Rad0%3D",
          savedDir: basrStorage!.path,
          fileName: fileName,
          showNotification:true, // show download progress in status bar (for Android)
          openFileFromNotification: true, // click on notification to open downloaded file (for Android)
          saveInPublicStorage: true
  );

      print(taskId);
    } else {
      print("No Permission");
    }
  }

//TODO cancelDownload Function
  cancelDownload() {
    FlutterDownloader.cancel(taskId: taskId);
  }





//TODO cancelAllDownload Function
  cancelAllDownload() {
    FlutterDownloader.cancelAll();
  }




//TODO pauseDownload Function
  pauseDownload() {
    FlutterDownloader.pause(taskId: taskId);
    print("pause click");
  }




//TODO resumeDownload Function
  resumeDownload() {
    FlutterDownloader.resume(taskId: taskId).then((value) {
      print("resume click");
    });
    print("resume not click");
  }







  int progress = 0;
  ReceivePort receivePort = ReceivePort();

  @override
  void initState() {
    // TODO: implement initState
    IsolateNameServer.registerPortWithName(receivePort.sendPort, 'downloadingvideo');

    receivePort.listen((message) {
      setState(() {
        progress = message;
      });

      print(" CAll progress value this --> $progress");

    });

    FlutterDownloader.registerCallback(downloadCallback);

    super.initState();
  }





  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloadingvideo');
    super.dispose();
  }






//TODO downloadCallback Function
  static downloadCallback(id, status, progress) {
    final SendPort? sendPort =
        IsolateNameServer.lookupPortByName('downloadingvideo');
    sendPort!.send(progress);
  }









  //TODO checkDouble Function
  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return 0.0 + value;
    } else {
      return value;
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Download percentage',
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.pink,
              height: 6.5,
              width: 300,
              child: LinearProgressIndicator(
                value: checkDouble(progress),
                minHeight: 5,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00ff00)),
                backgroundColor: Color(0xffD6D6D6),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Text(
              "$progress",
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            IconButton( onPressed: cancelDownload, icon: Icon(Icons.cancel_sharp)),

            TextButton(onPressed: pauseDownload, child: Text("pauseDownload")),

            TextButton(onPressed: () {
                  resumeDownload();
                },
                child: Text("resumeDownload")
            )



          ],
        ),
      ),



      floatingActionButton: FloatingActionButton(
        onPressed: _downloadFile,
        tooltip: 'Increment',
        child: const Icon(Icons.download),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
