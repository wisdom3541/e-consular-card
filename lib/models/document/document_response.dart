import 'package:json_annotation/json_annotation.dart';

part 'document_response.g.dart';

@JsonSerializable()
class DocumentResponse {
  final bool success;
  final String country;
  final List<Document> documents;

  DocumentResponse({
    required this.success,
    required this.country,
    required this.documents,
  });

  factory DocumentResponse.fromJson(Map<String, dynamic> json) =>
      _$DocumentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentResponseToJson(this);
}

@JsonSerializable()
class Document {
  @JsonKey(name: 'DocumentID')
  final String documentId;

  @JsonKey(name: 'DocumentName')
  final String documentName;

  @JsonKey(name: 'DocumentDescription')
  final String documentDescription;

  @JsonKey(name: 'DocumentAmount')
  final String documentAmount;

  @JsonKey(name: 'DocumentExpiry')
  final int documentExpiry;

  @JsonKey(name: 'DocumentCountry')
  final String documentCountry;

  Document({
    required this.documentId,
    required this.documentName,
    required this.documentDescription,
    required this.documentAmount,
    required this.documentExpiry,
    required this.documentCountry,
  });

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
