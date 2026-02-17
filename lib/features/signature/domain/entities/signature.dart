import 'dart:typed_data';

enum SignatureType {
  drawn,
  uploaded,
  typed,
}

class UserSignature {
  final String id;
  final SignatureType type;
  final Uint8List imageBytes;
  final DateTime createdAt;

  const UserSignature({
    required this.id,
    required this.type,
    required this.imageBytes,
    required this.createdAt,
  });

  String get typeLabel {
    switch (type) {
      case SignatureType.drawn:
        return 'Drawn Signature';
      case SignatureType.uploaded:
        return 'Uploaded Signature';
      case SignatureType.typed:
        return 'Typed Signature';
    }
  }
}