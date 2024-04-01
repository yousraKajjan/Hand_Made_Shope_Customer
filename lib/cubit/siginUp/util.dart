import 'package:image_picker/image_picker.dart';

imagePicker(ImageSource source) async {
  ImagePicker _imagepicker = ImagePicker();
  XFile? _file = await _imagepicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  } else {
    print('No Image Selected');
  }
}
