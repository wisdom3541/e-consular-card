import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:e_consular_card/core/widget/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import 'dart:io';
import '../../../../core/theme/app_colors.dart';
import '../providers/signature_provider.dart';
import '../../domain/entities/signature.dart' as sig;

class SignaturePage extends StatefulWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Fetch existing signature from server
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<SignatureProvider>().fetchSignature();
  });
  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignatureProvider>();

    if (provider.isLoading) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

    print("hasSignature: ${provider.hasSignature}");
    print("serverUrl: ${provider.serverSignatureUrl}");

    return Scaffold(
     // appBar: const CommonAppBar(title: "Add Signature"),
      body: provider.hasSignature ? _buildSignatureView(provider) : _buildCreateView(),
    );
  }

  Widget _buildSignatureView(SignatureProvider provider) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          SizedBox(height: 30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your Signature',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                provider.deleteSignature();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Signature removed'),
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox(height: 100.h),
        
        // Show signature from server or local
        if (provider.serverSignatureUrl != null)
          Image.network(
            provider.serverSignatureUrl!,
            height: 150.h,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // Fallback to local bytes if network image fails
              if (provider.signatureBytes != null) {
                return Image.memory(
                  provider.signatureBytes!,
                  height: 150.h,
                  fit: BoxFit.contain,
                );
              }
              return const Icon(Icons.error);
            },
          )
        else if (provider.signatureBytes != null)
          Image.memory(
            provider.signatureBytes!,
            height: 150.h,
            fit: BoxFit.contain,
          ),
        
        SizedBox(height: 8.h),
        Text(
          'Type: ${provider.signatureType ?? "Unknown"}',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
  }

  Widget _buildCreateView() {
    return Column(
      children: [
        SizedBox(height: 30.h),
        TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(icon: Icon(Icons.draw), text: 'Draw'),
            Tab(icon: Icon(Icons.upload), text: 'Upload'),
            Tab(icon: Icon(Icons.text_fields), text: 'Type'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              _DrawSignatureTab(),
              _UploadSignatureTab(),
              _TypeSignatureTab(),
            ],
          ),
        ),
      ],
    );
  }
}

// TAB 1: Draw Signature
class _DrawSignatureTab extends StatefulWidget {
  const _DrawSignatureTab();

  @override
  State<_DrawSignatureTab> createState() => _DrawSignatureTabState();
}

class _DrawSignatureTabState extends State<_DrawSignatureTab> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveDrawnSignature() async {
    if (_controller.isNotEmpty) {
      final signature = await _controller.toPngBytes();
      if (signature != null && mounted) {
        final provider = Provider.of<SignatureProvider>(
          context,
          listen: false,
        );
        provider.saveSignature(signature, 'drawn');

        // Upload to server
        _handleSaveSignature(context);
      }
    }
  }

 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Text(
            'Draw your signature below',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10.h),
          Text(
            'Tip: Use your finger or stylus. The signature will be saved as an image.',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          
          // Main signature canvas
          Container(
            height: 250.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 2),
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
            ),
            child: Signature(
              controller: _controller,
              backgroundColor: Colors.white,
            ),
          ),
          
          SizedBox(height: 20.h),
          
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  _controller.clear();
                },
                icon: const Icon(Icons.clear),
                label: const Text('Clear'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _controller.undo();
                },
                icon: const Icon(Icons.undo),
                label: const Text('Undo'),
              ),
              ElevatedButton.icon(
                onPressed: _saveDrawnSignature,
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// TAB 2: Upload Signature
class _UploadSignatureTab extends StatefulWidget {
  const _UploadSignatureTab();

  @override
  State<_UploadSignatureTab> createState() => _UploadSignatureTabState();
}

class _UploadSignatureTabState extends State<_UploadSignatureTab> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
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
      ),
    );

    if (source == null) return;

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 90,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

 
// For Upload tab:
Future<void> _saveUploadedSignature() async {
  if (_selectedImage != null) {
    final provider = Provider.of<SignatureProvider>(
      context,
      listen: false,
    );
    final imageBytes = await _selectedImage!.readAsBytes();
    provider.saveSignature(imageBytes, 'uploaded');

    // Upload to server
    _handleSaveSignature(context);
  }
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Text(
            'Upload a photo of your signature',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10.h),
          Text(
            'Sign on white paper with a dark pen, then take a clear photo.',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 250.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.grey.shade50,
              ),
              child: _selectedImage == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate,
                          size: 64.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Tap to select image',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.contain,
                      ),
                    ),
            ),
          ),
          
          SizedBox(height: 20.h),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (_selectedImage != null)
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedImage = null;
                    });
                  },
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ElevatedButton.icon(
                onPressed: _selectedImage != null ? _saveUploadedSignature : null,
                icon: const Icon(Icons.save),
                label: const Text('Save Signature'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// TAB 3: Type Signature
class _TypeSignatureTab extends StatefulWidget {

  const _TypeSignatureTab();

  @override
  State<_TypeSignatureTab> createState() => _TypeSignatureTabState();
}

class _TypeSignatureTabState extends State<_TypeSignatureTab> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey _signatureKey = GlobalKey();
  String _selectedFont = 'DancingScript';

  final List<Map<String, String>> _fonts = [
    {'name': 'DancingScript', 'display': 'Dancing Script'},
    {'name': 'GreatVibes', 'display': 'Great Vibes'},
    {'name': 'Pacifico', 'display': 'Pacifico'},
    {'name': 'Sacramento', 'display': 'Sacramento'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<Uint8List?> _captureTypedSignature() async {
    try {
      RenderRepaintBoundary boundary = _signatureKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      return null;
    }
  }

// For Type tab:
void _saveTypedSignature() async {
  if (_nameController.text.isNotEmpty) {
    final bytes = await _captureTypedSignature();
    if (bytes != null && mounted) {
      final provider = Provider.of<SignatureProvider>(
        context,
        listen: false,
      );
      provider.saveSignature(bytes, 'typed');
      
      // Upload to server
      _handleSaveSignature(context);
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Text(
            'Type your full name',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10.h),
          Text(
            'Choose a font style and type your name to generate a signature.',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
          
          SizedBox(height: 20.h),
          
          Text(
            'Select Font Style',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10.h),
          
          Wrap(
            spacing: 10.w,
            children: _fonts.map((font) {
              final isSelected = _selectedFont == font['name'];
              return ChoiceChip(
                label: Text(font['display']!),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedFont = font['name']!;
                  });
                },
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: 20.h),
          
          Text(
            'Preview',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10.h),
          
          RepaintBoundary(
            key: _signatureKey,
            child: Container(
              width: double.infinity,
              height: 150.h,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 2),
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  _nameController.text.isEmpty
                      ? 'Your signature will appear here'
                      : _nameController.text,
                  style: TextStyle(
                    
                    fontSize: 32.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          
          SizedBox(height: 20.h),
          
          ElevatedButton.icon(
            onPressed: _saveTypedSignature,
            icon: const Icon(Icons.save),
            label: const Text('Save Signature'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }
}



// Update the save button handler
Future<void> _handleSaveSignature(BuildContext context) async {
  final provider = context.read<SignatureProvider>();

  if (!provider.hasSignature) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please create a signature first'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

 

  // Upload to server
  final success = await provider.uploadSignature();

  // 🔥 VERY IMPORTANT
  if (!context.mounted) return;

  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Signature uploaded successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          provider.errorMessage ?? 'Failed to upload signature',
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
