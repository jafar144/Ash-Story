import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePathCubit extends Cubit<XFile?> {
  ImagePathCubit() : super(null);

  XFile? _imageFile;

  XFile? get imageFile => _imageFile;

  void setImageFile(XFile? file) {
    _imageFile = file;
    emit(_imageFile);
  }

  void resetImageFile() {
    _imageFile = null;
    emit(null);
  }
}
