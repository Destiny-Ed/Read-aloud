import 'package:file_picker/file_picker.dart';

Future<String> pickDocument() async {
  //Picked Image For Products

  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowCompression: true);

  if (result != null) {
    final String? files = result.files.single.path;
    return files!;
  } else {
    // User canceled the picker
    // print("File Picked canceled");
    return '';
  }
}
