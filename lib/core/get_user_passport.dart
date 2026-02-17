import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class GetUserPassport {
  Future<Uint8List?> getPassport(String citizenId) async {

      String appendId = "${citizenId}_passport.jpg";
      print("appendPATH::; ${appendId}");


    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      var dio = Dio();

      final response = await dio.get<List<int>>(
        'https://api.e-docrequest.com/files/passports/$appendId',
        options: Options(
          headers: headers,
          responseType: ResponseType.bytes, // VERY IMPORTANT
        ),
      );

      if (response.statusCode == 200) {
        print("✅ Passport image received.");
        print(response
            .headers['content-type']); // Should be image/jpeg or image/png
        print(response.data.runtimeType); // Should be List<int>

        return Uint8List.fromList(response.data!);
      } else {
        print("❌ Failed to load image: ${response.statusMessage}");
        return null;
      }
    } on DioException catch (e) {

      if (e.response?.statusCode == 404) {
          print("in imageeee");
    print("🚨 404 Error: ${e.response?.data}");
      }
      print("❌ Dio error: ${e.message}");
      
      return null;
    } catch (e) {
      print("❌ General error: $e");
      return null;
    }
  }
}
