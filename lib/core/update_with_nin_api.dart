import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_document_request/models/update_with_nin.dart';

class UpdateWithNinApi {
//   Future<String?> updateNinData(UpdateWithNin updateWithNin) async {

//     final userDataJsonMap = updateWithNin.toJson();
//     print(userDataJsonMap);

//     try{
//  var headers = {
//   'Accept': 'application/json',
//   'Content-Type': 'application/json'
// };
// var data = json.encode(userDataJsonMap);
// var dio = Dio();
// var response = await dio.request(
//   'https://api.e-docrequest.com/api/update-profile-with-nin',
//   options: Options(
//     method: 'POST',
//     headers: headers,
//   ),
//   data: data,
// );

// if (response.statusCode == 200) {
//   print(json.encode(response.data));
// }
//     }on DioException catch (e) {
//       if (e.response != null) {
//         // The server responded with a status other than 200
//         print('Server error: ${e.response?.statusCode}');
//         print('Message: ${e.response?.data}');
//         return e.response?.data['message'] ?? "Server error occurred";
//       } else {
//         // There was a connection error (e.g., no internet)
//         print('Connection error: ${e.message}');
//         return "Connection failed: ${e.message}";
//       }
//     } catch (e) {
//       // Handle unexpected errors
//       print('Unexpected error: $e');
//       return "Unexpected error occurred";
//     }
//     return null;
//   }


Future<String?> updateNinData(UpdateWithNin updateWithNin, File passportFile) async {
    try {
      print("impagegege :: ${passportFile.path}");
      final dio = Dio();

      // Create multipart form data
      final formData = FormData.fromMap({
        ...updateWithNin.toJson(), // adds all other fields
        'passport': await MultipartFile.fromFile(
          passportFile.path,
          filename: 'passport.jpg', // or .png depending on the file
        ),
      });

      final response = await dio.post(
        'https://api.e-docrequest.com/api/update-profile-with-nin',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Upload success: ${response.data}");
        return response.data['message'] ?? 'Success';
      } else {
        print("Upload failed: ${response.statusCode}");
        return 'Failed with status: ${response.statusCode}';
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Server error: ${e.response?.statusCode}');
        print('Message: ${e.response?.data}');
        return e.response?.data['message'] ?? "Server error occurred";
      } else {
        print('Connection error: ${e.message}');
        return "Connection failed: ${e.message}";
      }
    } catch (e) {
      print('Unexpected error: $e');
      return "Unexpected error occurred";
    }
  }
}