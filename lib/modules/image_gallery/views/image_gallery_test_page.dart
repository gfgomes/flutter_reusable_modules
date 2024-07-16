import 'package:flutter/material.dart';
import 'package:flutter_modules/modules/image_gallery/controllers/image_controller.dart';
import 'package:flutter_modules/modules/image_gallery/widgets/list_view_image_horizontal_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Image Gallery Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ImageGalleryTestPage(),
    );
  }
}

class ImageGalleryTestPage extends StatelessWidget {
  ImageGalleryTestPage({super.key});

  // Inicialize o controlador usando Get.put() no construtor
  final ImageController controller = Get.put(ImageController(maxImages: 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery Test'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<ImageController>(
              builder: (controller) => ListViewHorizontalImageWidget(
                imageFileList: controller.imageFileList,
                maxImages: controller.maxImages,
                fnAddImage: _addImage,
                fnRemoveImage: _removeImage,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => _saveImages(),
            child: const Text('Save Images'),
          ),
        ],
      ),
    );
  }

  Future<void> _addImage(XFile image) async {
    await controller.addImage(image);
  }

  Future<void> _removeImage(BuildContext context, XFile image) async {
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Do you want to remove this image?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await controller.removeImage(image);
    }
  }

  void _saveImages() {
    print('Number of images saved: ${controller.imageFileList.length}');
    // Implement actual saving logic here
  }
}
