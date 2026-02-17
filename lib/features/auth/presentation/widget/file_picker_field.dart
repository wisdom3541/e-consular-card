import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerField extends StatefulWidget {
  final Function(File?) onFilePicked;
  final String? initialFileName;

  const FilePickerField({
    Key? key,
    required this.onFilePicked,
    this.initialFileName,
  }) : super(key: key);

  @override
  State<FilePickerField> createState() => _FilePickerFieldState();
}

class _FilePickerFieldState extends State<FilePickerField> {
  File? _selectedFile;
  String? _fileName;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fileName = widget.initialFileName;
  }

  Future<void> _pickFile() async {
    try {
      // Show bottom sheet to choose camera or gallery
      final source = await _showImageSourceDialog();
      if (source == null) return;

      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        setState(() {
          _selectedFile = file;
          _fileName = pickedFile.name;
        });
        widget.onFilePicked(file);
      }
    } catch (e) {
      _showErrorSnackbar('Failed to pick file: ${e.toString()}');
    }
  }

  Future<ImageSource?> _showImageSourceDialog() async {
    return await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _removeFile() {
    setState(() {
      _selectedFile = null;
      _fileName = null;
    });
    widget.onFilePicked(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // File picker button
        InkWell(
          onTap: _pickFile,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Icon(
                  _selectedFile != null ? Icons.check_circle : Icons.upload_file,
                  color: _selectedFile != null ? Colors.green : Colors.grey,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    _fileName ?? 'Click to select birth certificate',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: _selectedFile != null ? Colors.black : Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (_selectedFile != null)
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: _removeFile,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
          ),
        ),
        
        // Show preview if image is selected
        if (_selectedFile != null) ...[
          SizedBox(height: 12.h),
          Container(
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.file(
                _selectedFile!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ],
    );
  }
}