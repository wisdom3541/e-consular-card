class SignatureFetchResponse {
  final String status;
  final String message;
  final SignatureFetchData? data;

  SignatureFetchResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory SignatureFetchResponse.fromJson(Map<String, dynamic> json) {
    return SignatureFetchResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null
          ? SignatureFetchData.fromJson(json['data'])
          : null,
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class SignatureFetchData {
  final String? signatureUrl;
  final String? docType;
  //final String? uploadedAt;

  SignatureFetchData({
    this.signatureUrl,
    this.docType,
   // this.uploadedAt,
  });

  factory SignatureFetchData.fromJson(Map<String, dynamic> json) {
    return SignatureFetchData(
      signatureUrl: json['image_url']?.toString(),
      docType: json['doc_type']?.toString(),
   //   uploadedAt: json['uploaded_at']?.toString(),
    );
  }
}