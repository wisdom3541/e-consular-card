class SignatureUploadResponse {
  final String status;
  final String message;
  final SignatureUploadData? data;

  SignatureUploadResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory SignatureUploadResponse.fromJson(Map<String, dynamic> json) {
    return SignatureUploadResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null
          ? SignatureUploadData.fromJson(json['data'])
          : null,
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class SignatureUploadData {
  final String? signatureUrl;
 // final String? signaturePath;

  SignatureUploadData({
    this.signatureUrl,
 //   this.signaturePath,
  });

  factory SignatureUploadData.fromJson(Map<String, dynamic> json) {
    return SignatureUploadData(
      signatureUrl: json['image_url']?.toString(),
  //   signaturePath: json['signature_path']?.toString(),
    );
  }
}