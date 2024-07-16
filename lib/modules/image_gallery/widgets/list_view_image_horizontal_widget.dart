// list_view_image_horizontal_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:cross_file_image/cross_file_image.dart';

/*
  O código Dart fornecido define um widget Flutter chamado ListViewHorizontalImageWidget. Este widget é um widget sem estado, o que significa que descreve parte da interface do usuário que pode depender das informações de configuração no construtor e no contexto de construção, mas não depende de nenhum estado mutável.

O widget recebe quatro parâmetros obrigatórios: imageFileList, maxImages, fnAddImage e fnRemoveImage. imageFileList é uma lista de imagens, maxImages é o número máximo de imagens que podem ser adicionadas, fnAddImage é uma função que adiciona uma imagem à lista e fnRemoveImage é uma função que remove uma imagem da lista.

O método build do widget retorna um widget Column que contém um ElevatedButton para adicionar imagens, um widget Padding que exibe o número de imagens selecionadas e um ListView.builder que exibe as imagens em uma lista horizontal.

A propriedade onPressed do ElevatedButton é definida para o método _addImage se o comprimento de imageFileList for menor que maxImages, caso contrário, é definido como nulo, desabilitando o botão. O método _addImage usa o ImagePicker para escolher uma imagem da câmera, e se uma imagem for escolhida, ele chama fnAddImage com a imagem escolhida.

O ListView.builder usa _buildImageItem para construir cada item da lista. _buildImageItem retorna um widget Center que contém um widget Column. O widget Column contém um widget Padding que exibe a imagem e um IconButton para remover a imagem. A propriedade onPressed do IconButton é definida para uma função que chama fnRemoveImage com o contexto e a imagem.

*/

/// Dependências:
///    - [image_picker]: Para abrir o seletor de imagens [flutter pub add image_picker].
///   - [full_screen_image]: Para mostrar a imagem em tela cheia ao ser clicada[flutter pub add full_screen_image].
///  - [cross_file_image]: Para converter um [XFile] em uma imagem[flutter pub add cross_file_image].
/// - [ get]: Para gerenciamento de estado [flutter pub add get].

class ListViewHorizontalImageWidget extends StatelessWidget {
  final RxList<XFile> imageFileList;
  final int maxImages;
  final Future<void> Function(XFile xFile) fnAddImage;
  final Future<void> Function(BuildContext context, XFile xFile) fnRemoveImage;

  ListViewHorizontalImageWidget({
    super.key,
    required this.imageFileList,
    required this.maxImages,
    required this.fnAddImage,
    required this.fnRemoveImage,
  });

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => ElevatedButton.icon(
              onPressed: imageFileList.length < maxImages ? _addImage : null,
              icon: const Icon(Icons.add_a_photo),
              label: const Text('Adicionar imagem'),
            )),
        Obx(() {
          if (imageFileList.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child:
                    Text('Selecionadas: ${imageFileList.length} de $maxImages'),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
        SizedBox(
          height: 200,
          child: Obx(() => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageFileList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildImageItem(context, imageFileList[index]);
                },
              )),
        ),
      ],
    );
  }

  Widget _buildImageItem(BuildContext context, XFile image) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 130,
              child: FullScreenWidget(
                disposeLevel: DisposeLevel.High,
                child: Center(
                  child: Image(
                    image: XFileImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => fnRemoveImage(context, image),
            icon: const Icon(Icons.delete, color: Colors.red, size: 38),
          )
        ],
      ),
    );
  }

  Future<void> _addImage() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (image != null) {
      await fnAddImage(image);
    }
  }
}
