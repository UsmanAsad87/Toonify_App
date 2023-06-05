import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as Img;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:toonify_app/components/custom_round_button.dart';

import '../components/custom_image_box.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _showSpinner = false; //spinner for processing image
  bool _isImageProcessed = false;

  File? _inputImage;
  final _imagePicker = image_picker.ImagePicker();

  Response? _apiResponse;
  String? _outputImageUrl;
  http.Response? _outputImageUrlResponse;
  Image? _outputImage;

  late double _screenWidth;
  late double _screenHeight;

  String? _uploadError;
  String? _savedLocation;

  // Pick image from gallery/camera
  Future<void> _pickImage(image_picker.ImageSource source) async {
    final pickedFile = await _imagePicker.getImage(
      source: source,
      preferredCameraDevice: image_picker.CameraDevice.front,
      maxWidth: 960,
      maxHeight: 1280,
    );

    if (pickedFile != null) {
      setState(() {
        _inputImage = null;
        _outputImageUrl = null;
        _outputImage = null;
        _uploadError = null;
        _isImageProcessed = false;
        _inputImage = File(pickedFile.path);
      });
      await _postImage2(_inputImage!.path);
      // await makeRequest(_inputImage!.path);
    } else {
      print('No image selected');
    }
  }

  // Post image to Toonify api
  // Future<void> _postImage(String imagePath) async {
  //   try {
  //     var dioRequest = dio.Dio();
  //     var YOUR_API_KEY='6cac79f58amsh0a1813426e5b73cp1';
  //     dioRequest.options.baseUrl = 'https://api.deepai.org/api/toonify';
  //     dioRequest.options.headers = {
  //       'api-key': YOUR_API_KEY,
  //     };
  //     print("here");
  //
  //     var formData = new dio.FormData();
  //
  //     var file = await dio.MultipartFile.fromFile(imagePath,
  //         filename: imagePath, contentType: MediaType('image', imagePath));
  //
  //     formData.files.add(MapEntry('image', file));
  //
  //     setState(() {
  //       _showSpinner = true;
  //     });
  //     print('heret3y');
  //     _apiResponse = await dioRequest.post(
  //       dioRequest.options.baseUrl,
  //       data: formData,
  //       options: Options(responseType: ResponseType.json),
  //     );
  //     print(
  //       _apiResponse
  //     );
  //     _outputImageUrl = json.decode(_apiResponse.toString())['output_url'];
  //
  //     _outputImageUrlResponse = await http.get(
  //       Uri.parse(_outputImageUrl!),
  //     );
  //
  //     setState(() {
  //       _outputImage =Image.network(
  //         _outputImageUrl!,
  //         loadingBuilder: (BuildContext context, Widget? child,
  //             ImageChunkEvent? loadingProgress) {
  //           if (loadingProgress == null) {
  //             return child!;
  //           } else if (loadingProgress.cumulativeBytesLoaded ==
  //               loadingProgress.expectedTotalBytes) {
  //             Future.delayed(Duration.zero, () async {
  //               setState(() {
  //                 _isImageProcessed = true;
  //                 _showSpinner = false;
  //                 _uploadError = null;
  //               });
  //             });
  //           }
  //           return Container();
  //         },
  //       );
  //     });
  //   } catch (err) {
  //     setState(() {
  //       _showSpinner = false;
  //     });
  //     print('ERROR  $err');
  //     _uploadError = err.toString();
  //   }
  // }

  // Future<void> makeRequest(String imagePath) async {
  //   FormData data = FormData();
  //   var file = await MultipartFile.fromFile(imagePath,
  //       filename: imagePath, contentType: MediaType('image', imagePath));
  //   data.files.add(MapEntry(
  //     'image',
  //     file,
  //   ));
  //   data.fields.add(MapEntry('type', 'pixar_plus'));
  //
  //   Dio dio = Dio();
  //   dio.options.headers = {
  //     'X-RapidAPI-Key': '2a66f880fbmshb69b2b96da283ddp130adfjsn49849e4c2f8c',
  //     'X-RapidAPI-Host': 'cartoon-yourself.p.rapidapi.com',
  //   };
  //
  //   try {
  //     Response response = await dio.post(
  //       'https://cartoon-yourself.p.rapidapi.com/facebody/api/portrait-animation/portrait-animation',
  //       data: data,
  //     );
  //     print(response.data);
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  Future<void> _postImage2(String imagePath) async {
    try {
      setState(() {
        _showSpinner = true;
      });
      FormData data = FormData();
      var file = await MultipartFile.fromFile(imagePath,
          filename: imagePath, contentType: MediaType('image', imagePath));
      data.files.add(MapEntry(
        'image',
        file,
      ));
      data.fields.add(MapEntry('type', 'pixar_plus'));

      Dio dio = Dio();
      dio.options.headers = {
        'X-RapidAPI-Key': '2fc2ee2706msh2f3db690f6c4086p1843a2jsn9ac35630b0e6',
        'X-RapidAPI-Host': 'cartoon-yourself.p.rapidapi.com',
      };

        _apiResponse = await dio.post(
          'https://cartoon-yourself.p.rapidapi.com/facebody/api/portrait-animation/portrait-animation',
          data: data,
        );
        // print(response.data);
      print(_apiResponse!.data.toString());
      print( "IMG URL:"+_apiResponse!.data['data']['image_url'].toString());
      _outputImageUrl = _apiResponse!.data['data']['image_url'].toString();


      _outputImageUrlResponse = await http.get(
        Uri.parse(_outputImageUrl!),
      );

      setState(() {
        _outputImage = Image.network(
          _outputImageUrl!,
          loadingBuilder: (BuildContext context, Widget? child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child!;
            } else if (loadingProgress.cumulativeBytesLoaded ==
                loadingProgress.expectedTotalBytes) {
              Future.delayed(Duration.zero, () async {
                setState(() {
                  _isImageProcessed = true;
                  _showSpinner = false;
                  _uploadError = null;
                });
              });
            }
            return Container();
          },
        );
      });
    } catch (err) {
      setState(() {
        _showSpinner = false;
      });
      print('ERROR  $err');
      _uploadError = err.toString();
    }
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  Future<bool> _saveImage() async {
    Img.Image? image = Img.decodeImage(_outputImageUrlResponse!.bodyBytes);

    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(Img.encodeJpg(image!)),
          quality: 100,
          name: 'toonified');

      _savedLocation = result.toString().replaceAll('file://', '');

      return true;
    }
    return false;
  }

  void _shareImage() async {
    bool result = await _saveImage();

    if (result) {
      //Todo 1: share image
      // Share.shareFiles([_savedLocation!], text: 'Toonify your selfie !!!');
    } else {
      print('Error: could not get the image');
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Toonify Your Selfie',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
        backgroundColor: Color(0xff01A0C7),
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Upload your full face photo for the best result',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomImageBox(
                          width: _screenWidth / 2.1,
                          height: _screenHeight / 3,
                          image: _inputImage != null
                              ? Image.file(_inputImage!)
                              : Container(),
                        ),
                        CustomImageBox(
                          width: _screenWidth / 2.1,
                          height: _screenHeight / 3,
                          image: _outputImage != null
                              ? _outputImage!
                              : (_uploadError == null
                                  ? Container()
                                  : Center(
                                      child: Container(
                                        child: Text(
                                          'Some Error Ocurred!',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    )),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomRoundButton(
                          iconData: Icons.image,
                          color: Colors.green,
                          onPressed: () =>
                              _pickImage(image_picker.ImageSource.gallery),
                        ),
                        CustomRoundButton(
                          iconData: Icons.camera,
                          color: Colors.blue,
                          onPressed: () =>
                              _pickImage(image_picker.ImageSource.camera),
                        ),
                        _isImageProcessed
                            ? Builder(
                                builder: (context) {
                                  return CustomRoundButton(
                                      iconData: Icons.save_alt,
                                      color: Colors.red,
                                      onPressed: () async {
                                        bool result = await _saveImage();
                                        if (result) {
                                          _showSnackBar(context,
                                              'Image is saved to gallery');
                                        } else {
                                          _showSnackBar(context,
                                              'Error occured in saving the image');
                                        }
                                      });
                                },
                              )
                            : Container(),
                        // _isImageProcessed
                        //     ? CustomRoundButton(
                        //         iconData: Icons.share,
                        //         color: Colors.yellow,
                        //         onPressed: () => _shareImage(),
                        //       )
                        //     : Container(),
                      ],
                    ),
                  ),
                ],
              ),
              _showSpinner
                  ? Center(
                      child: Text(
                        'Processing ...',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          if (_showSpinner)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
