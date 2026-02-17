// import 'dart:typed_data';
// import 'package:flutter/foundation.dart';
// import '../../domain/entities/signature.dart';

// class SignatureProvider extends ChangeNotifier {
//   UserSignature? _currentSignature;
//   bool _isLoading = false;
//   String? _errorMessage;

//   // Getters
//   UserSignature? get currentSignature => _currentSignature;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   bool get hasSignature => _currentSignature != null;

//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   void _setError(String? message) {
//     _errorMessage = message;
//     notifyListeners();
//   }

//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }

//   Future<bool> saveSignature({
//     required Uint8List imageBytes,
//     required SignatureType type,
//   }) async {
//     _setLoading(true);
//     clearError();

//     try {
//       // TODO: Upload to API when backend is ready
//       await Future.delayed(const Duration(seconds: 1));

//       _currentSignature = UserSignature(
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//         type: type,
//         imageBytes: imageBytes,
//         createdAt: DateTime.now(),
//       );

//       _setLoading(false);
//       return true;
//     } catch (e) {
//       _setError('Failed to save signature: ${e.toString()}');
//       _setLoading(false);
//       return false;
//     }
//   }

//   Future<void> loadSignature() async {
//     _setLoading(true);
//     clearError();

//     try {
//       // TODO: Load from API when backend is ready
//       await Future.delayed(const Duration(seconds: 1));

//       // Simulate no signature
//       _currentSignature = null;

//       _setLoading(false);
//     } catch (e) {
//       _setError('Failed to load signature: ${e.toString()}');
//       _setLoading(false);
//     }
//   }

//   void deleteSignature() {
//     _currentSignature = null;
//     notifyListeners();
//   }
// }


import 'dart:io';
import 'dart:typed_data';
import 'package:e_consular_card/features/signature/data/datasources/segnature_remote_datasource.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/errors/exceptions.dart';

class SignatureProvider extends ChangeNotifier {
  final SignatureRemoteDataSource? signatureDataSource;

  Uint8List? _signatureBytes;
  String? _signatureType;
  bool _isLoading = false;
  String? _errorMessage;
  String? _serverSignatureUrl; // URL from server

  SignatureProvider({this.signatureDataSource});

  Uint8List? get signatureBytes => _signatureBytes;
  String? get signatureType => _signatureType;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get serverSignatureUrl => _serverSignatureUrl;
  bool get hasSignature => _signatureBytes != null || _serverSignatureUrl != null;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Save signature locally (existing functionality)
  void saveSignature(Uint8List bytes, String type) {
    _signatureBytes = bytes;
    _signatureType = type;
    notifyListeners();
  }

  // Upload signature to server
  Future<bool> uploadSignature() async {
    if (_signatureBytes == null) {
      _setError('No signature to upload');
      return false;
    }

    _setLoading(true);
    _setError(null);

    try {
      if (signatureDataSource == null) {
        _setError('Signature service not available');
        _setLoading(false);
        return false;
      }

      // Convert bytes to temporary file
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/signature_${DateTime.now().millisecondsSinceEpoch}.png');
      await tempFile.writeAsBytes(_signatureBytes!);

      // Upload to server
      final response = await signatureDataSource!.uploadSignature(tempFile);

      // Delete temp file
      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      if (response.data != null) {
        _serverSignatureUrl = response.data!.signatureUrl;
        _setLoading(false);
        return true;
      } else {
        _setError('Invalid response from server');
        _setLoading(false);
        return false;
      }

    } on ServerException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } on NetworkException catch (e) {
      _setError(e.message);
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('Failed to upload signature: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Fetch signature from server
  Future<void> fetchSignature() async {
  _setLoading(true);
  _setError(null);

  try {
    if (signatureDataSource == null) {
      _setError('Signature service not available');
      return;
    }

    final response = await signatureDataSource!.fetchSignature();

    _serverSignatureUrl = response.data?.signatureUrl;
    _signatureType = response.data?.docType;

  } on ServerException catch (e) {
    _setError(e.message);
  } on NetworkException catch (e) {
    _setError(e.message);
  } catch (e) {
    _setError('Failed to fetch signature: ${e.toString()}');
  }

  _setLoading(false);
  notifyListeners();
}


  // Delete signature (both local and potentially server)
  void deleteSignature() {
    _signatureBytes = null;
    _signatureType = null;
    _serverSignatureUrl = null;
    notifyListeners();
  }
}