// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentResponse _$DocumentResponseFromJson(Map<String, dynamic> json) =>
    DocumentResponse(
      success: json['success'] as bool,
      country: json['country'] as String,
      documents: (json['documents'] as List<dynamic>)
          .map((e) => Document.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DocumentResponseToJson(DocumentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'country': instance.country,
      'documents': instance.documents,
    };

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      documentId: json['DocumentID'] as String,
      documentName: json['DocumentName'] as String,
      documentDescription: json['DocumentDescription'] as String,
      documentAmount: json['DocumentAmount'] as String,
      documentExpiry: (json['DocumentExpiry'] as num).toInt(),
      documentCountry: json['DocumentCountry'] as String,
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'DocumentID': instance.documentId,
      'DocumentName': instance.documentName,
      'DocumentDescription': instance.documentDescription,
      'DocumentAmount': instance.documentAmount,
      'DocumentExpiry': instance.documentExpiry,
      'DocumentCountry': instance.documentCountry,
    };
