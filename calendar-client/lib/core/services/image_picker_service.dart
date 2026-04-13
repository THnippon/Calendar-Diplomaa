import 'package:image_picker/image_picker.dart';

enum ImageSourceType {
  camera,
  gallery,
}

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage (ImageSourceType imageSource) async
  {
    try {
      final source = imageSource == ImageSourceType.camera ? ImageSource.camera : ImageSource.gallery;

      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      return image;
    } catch(e) {
      return null;
    }
  }
}