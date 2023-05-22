// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';




 
class DioExamplePageTow extends StatefulWidget {


  @override
  _DioExamplePageOneStTow createState() => _DioExamplePageOneStTow();
}

class _DioExamplePageOneStTow extends State<DioExamplePageTow> {

  
  Dio dio = Dio();
  double progress = 0.0;

  void startDownloading(String url) async {
    final String date = DateTime.now().microsecondsSinceEpoch.toString();
     String fileName = "$date.mp4";
    // const String fileName = "TV.jpg";

    String path = await _getFilePath(fileName);

    await dio.download(
      url,
      path,
      onReceiveProgress: (recivedBytes, totalBytes) {
        setState(() {
          progress = recivedBytes / totalBytes;
        });

        print(progress);
      },
      deleteOnError: true,
    ).then((_) {
      print("File Download Complete");
      // Navigator.pop(context);
    });
  }






  //TODO Create _getFilePath function
  Future<String> _getFilePath(String filename) async {
    // final dir = await getApplicationDocumentsDirectory();
    final dir = Directory('/storage/emulated/0/Download');

    return "${dir.path}/$filename";
  }




  @override
  void initState() {
    super.initState();
    // startDownloading(widget.url.toString());
  }




final controller = TextEditingController();



  

  @override
  Widget build(BuildContext context) {

    String downloadingprogress = (progress * 100).toInt().toString();

    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Enter download video link",
                      border: OutlineInputBorder(),
                    ),
                    
                                 ),
                 ),



          AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               // const CircularProgressIndicator.adaptive(),
                const SizedBox(
                  height: 20,
                ),

         
                CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 3,
                        backgroundColor: Colors.grey,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                        ),


                const SizedBox(
                  height: 20,
                ),

                

                Text(
                  "Downloading: $downloadingprogress%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),


         Center(child: ElevatedButton(onPressed: (){
           startDownloading(controller.text.toString().trim());
         }, child: Icon(Icons.download)))

          
          
          
        ],
      ),
    );
  }
}