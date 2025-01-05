import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:image/image.dart' as img;

List<CameraDescription>? cameras;

// A function to initialize cameras
Future<void> initializeCameras() async {
  try {
    cameras = await availableCameras();
    print("Cameras initialized: ${cameras?.length}");
  } catch (e) {
    print("Error initializing cameras: $e");
    cameras = [];
  }
}

class LivenessState extends StatefulWidget {
  @override
  _LivenessState createState() => _LivenessState();
}

class _LivenessState extends State<LivenessState> {
  @override
  Widget build(BuildContext context) {
    print('in the _LivenessState');
    return MaterialApp(
      title: 'Liveness Detection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraView(),
    );
  }
}

class CameraView extends StatefulWidget {
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _controller;
  bool _isDetecting = false;

  @override
  void initState() {
    print('in the _CameraViewState');
    super.initState();

// Find the front camera from available cameras
    CameraDescription? frontCamera;
    for (var camera in cameras!) {
      if (camera.lensDirection == CameraLensDirection.front) {
        frontCamera = camera;
        break;
      }
    }

    // Initialize the camera controller if the cameras are available
    //if (cameras != null && cameras!.isNotEmpty) {
    if (frontCamera != null) {
      print('found camera');
      //_controller = CameraController(cameras![0], ResolutionPreset.high);
      _controller = CameraController(frontCamera, ResolutionPreset.high);
      // Initialize the camera controller
      _controller?.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        _controller?.startImageStream((image) {
          // Here you will process each frame of the image for face and head detection
          if (!_isDetecting) {
            _isDetecting = true;
            detectHeadMovement(image);
          }
        });
      });
    } else {
      // Handle the case where no cameras are available (e.g., show an error message)
      print("No cameras available.");
    }
  }

  void detectHeadMovement(CameraImage image) {
    // This is where you need to detect head movement.
    // You will send image data to the backend or use a library to process it.
    // For now, we'll simulate the movement detection logic here.
    sendImageToServer(image);
    print("Processing image for head movement...");

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isDetecting = false;
      });
    });
  }

  void sendImageToServer(CameraImage image) async {
    // Convert CameraImage to base64
    final imgBytes = await convertCameraImageToByteList(image);
    print('imgBytes ==' + imgBytes.length.toString());

    final imgBase64 = base64Encode(Uint8List.fromList(imgBytes));

    // New approach to convert BGRA image to base 64 string and send
    // Create an empty image buffer
    final int width = image.width;
    final int height = image.height;

    // Combine the BGRA planes into a single image
    img.Image convertedImage = img.Image.fromBytes(
      width,
      height,
      image.planes[0].bytes,
      format: img.Format.bgra,
    );

    // Encode as JPEG
    final jpegBytes = img.encodeJpg(convertedImage, quality: 85);
    final jpegBase64 = base64Encode(jpegBytes);
    // The above approach to be cleaned up

    // Convert CameraImage to bytes (existing method)
    //final imgBytes = await convertCameraImageToByteList(image);

    // Compress and resize the image
    //final compressedBytes =
    //    await compressAndResizeImage(Uint8List.fromList(imgBytes));

    // Convert compressed image to Base64
    //final imgBase64 = base64Encode(compressedBytes);

    // Send the base64 image to the server
    print('jpegBase64 ==' + jpegBase64.length.toString());
    final response = await http.post(
      Uri.parse('http://192.168.0.195:5001/process-frame'),
      //Uri.parse('http://192.168.0.195:5001/detect-liveness'),
      body: {
        'image': jpegBase64,
      },
    );

    if (response.statusCode == 200) {
      print('Server Response: ${response.body}');
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  // Resize and compress the image
  Future<Uint8List> compressAndResizeImage(Uint8List originalImageBytes) async {
    // Decode the image
    img.Image? originalImage = img.decodeImage(originalImageBytes);
    if (originalImage == null) {
      throw Exception("Failed to decode image");
    }

    // Resize the image (e.g., 300x300 pixels)
    img.Image resizedImage =
        img.copyResize(originalImage, width: 300, height: 300);

    // Encode the image as JPEG with compression
    Uint8List compressedImage =
        Uint8List.fromList(img.encodeJpg(resizedImage, quality: 75));
    return compressedImage;
  }

  Future<List<int>> convertCameraImageToByteList(CameraImage image) async {
    // Convert CameraImage to a byte list
    // Implementation depends on the image format and the CameraImage
    // You can refer to the image manipulation documentation for CameraImage

    //ImageFormat format = image.format;
    ImageFormatGroup imageFormatGroup = image.format.group;
    print('Camera Image Format: $imageFormatGroup');

    if (imageFormatGroup == ImageFormatGroup.yuv420) {
      return convertYUV420ToByteList(image);
    } else if (imageFormatGroup == ImageFormatGroup.nv21) {
      return convertNV21ToByteList(image);
    } else if (imageFormatGroup == ImageFormatGroup.jpeg) {
      return convertJPEGToByteList(image);
    } else if (imageFormatGroup == ImageFormatGroup.bgra8888) {
      // Handle BGRA8888 format
      return convertBGRA8888ToByteList(image);
    } else {
      // Handle unsupported formats
      throw Exception('Unsupported image format: $imageFormatGroup');
    }
    return [];
  }

  Future<List<int>> convertYUV420ToByteList(CameraImage image) async {
    // Get Y, U, and V planes
    Plane yPlane = image.planes[0]; // Y plane
    Plane uPlane = image.planes[1]; // U plane
    Plane vPlane = image.planes[2]; // V plane

    // Convert Y, U, V planes to byte lists
    List<int> yBytes = yPlane.bytes;
    List<int> uBytes = uPlane.bytes;
    List<int> vBytes = vPlane.bytes;

    // Concatenate all the byte arrays into one list
    List<int> byteList = [];
    byteList.addAll(yBytes);
    byteList.addAll(uBytes);
    byteList.addAll(vBytes);

    return byteList;
  }

  // Convert BGRA8888 format to ByteList
  Future<List<int>> convertBGRA8888ToByteList(CameraImage image) async {
    // BGRA8888 format has a single plane (4 bytes per pixel: B, G, R, A)
    Plane plane = image.planes[0];

    // Return the bytes from the BGRA plane
    return plane.bytes;
  }

  Future<List<int>> convertNV21ToByteList(CameraImage image) async {
    // NV21 format typically has the Y plane first, followed by UV interleaved
    Plane yPlane = image.planes[0]; // Y plane
    Plane uvPlane = image.planes[1]; // UV plane

    // Convert Y plane and UV plane to byte lists
    List<int> yBytes = yPlane.bytes;
    List<int> uvBytes = uvPlane.bytes;

    // Concatenate the Y plane and UV interleaved plane
    List<int> byteList = [];
    byteList.addAll(yBytes);
    byteList.addAll(uvBytes);

    return byteList;
  }

  Future<List<int>> convertJPEGToByteList(CameraImage image) async {
    Plane plane = image.planes[0]; // The image is already in JPEG format
    return plane.bytes;
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Head Movement Detection")),
      body: CameraPreview(_controller!),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
