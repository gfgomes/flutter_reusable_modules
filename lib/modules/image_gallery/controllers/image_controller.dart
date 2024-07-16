// image_controller.dart
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  // Lista observável de imagens
  final RxList<XFile> imageFileList = <XFile>[].obs;

  // Número máximo de imagens permitidas
  final int maxImages;

  ImageController({required this.maxImages});

  // Método para adicionar uma imagem
  Future<void> addImage(XFile image) async {
    if (imageFileList.length < maxImages) {
      imageFileList.add(image);
    }
  }

  // Método para remover uma imagem
  Future<void> removeImage(XFile image) async {
    imageFileList.remove(image);
  }

  // Método para verificar se o botão da câmera deve estar habilitado
  bool get isCameraEnabled => imageFileList.length < maxImages;

  // Método para salvar as imagens (implementação fictícia)
  void saveImages() {
    print('Número de imagens salvas: ${imageFileList.length}');
    // Aqui você implementaria a lógica real de salvamento
  }
}
