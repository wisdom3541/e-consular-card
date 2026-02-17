import 'package:flutter/material.dart';
import 'dart:io';

class FilePickerField extends StatefulWidget {
  final Future<File?> Function() onPickFile; // Your custom file picker function

  const FilePickerField({super.key, required this.onPickFile});

  @override
  State<FilePickerField> createState() => _FilePickerFieldState();
}

class _FilePickerFieldState extends State<FilePickerField> {
  String? selectedFileName;

  void _handleTap() async {
    File? pickedFile = await widget.onPickFile();

    if (pickedFile != null) {
      setState(() {
        selectedFileName = pickedFile.path.split('/').last;
        print(selectedFileName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AbsorbPointer(
        absorbing: true,
        child: TextField(
          decoration: InputDecoration(
             
           labelText: selectedFileName ?? 'Tap to choose file...',
            suffixIcon: const Icon(Icons.attach_file),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
