
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(appBar: AppBar(title: const Text('XR Demo')
          ,
        )
          ,
          body: ARViewWidget(),
        ));
  }
}

class ARViewWidget extends StatefulWidget {
  @override
  _ARViewWidegetState createState() => _ARViewWidegetState();
}

class _ARViewWidegetState extends State<ARViewWidget> {
  late ARKitController arkitController;

  @override
  Widget build(BuildContext context) {
    return ARKitSceneView(
      onARKitViewCreated: _onARKitViewCreated,
    );
  }


  void _onARKitViewCreated(ARKitController controller) {
    arkitController = controller;

    final box = ARKitBox(
      width: 0.1,
      height: 0.1,
      length: 0.1,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty.color(Colors.blue),
        ),
      ],
    );
    final node = ARKitNode(
      geometry: box,
      position: vm.Vector3(0, 0, -0.5), // カメラの前に配置
    );
    
    arkitController.add(node);
  }

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }
}




