/*
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SimpleCameraApp());
  }
}

class SimpleCameraApp extends StatefulWidget {
  @override
  _SimpleCameraAppState createState() => _SimpleCameraAppState();
}

class _SimpleCameraAppState extends State<SimpleCameraApp> {
  CameraController? _controller;

  @override
  void initState() {
    super.initState();

    // Find the front camera from available cameras
    CameraDescription? frontCamera;
    for (var camera in cameras!) {
      if (camera.lensDirection == CameraLensDirection.front) {
        frontCamera = camera;
        break;
      }
    }

    // Initialize camera controller if the front camera is available
    if (frontCamera != null) {
      _controller = CameraController(frontCamera, ResolutionPreset.high);
      _controller?.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      }).catchError((e) {
        print("Camera error: $e");
      });
    } else {
      print("No front camera found");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(body: CameraPreview(_controller!));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
*/

import 'package:flutter/material.dart';
import 'router.dart';
import 'package:chain_wallet/chain-work/onboard/liveness.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('going to initialize camera');
  await initializeCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: RouterPage(
          initialRoute: '/',
          initialArguments: {'username': '', 'password': ''}),
    );
  }
}
