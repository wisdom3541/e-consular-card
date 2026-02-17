import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_consular_card/models/register_without_nin_response.dart';
import 'package:e_consular_card/models/update_with_nin.dart';
import 'package:e_consular_card/models/update_without_nin.dart';
import 'package:e_consular_card/providers/otp_provider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class RegisterWithoutNin {
  Future<RegisterWithoutNinResponse?> registerUserWithoutNin(
      BuildContext context,
      String email,
      String password,
      String filePath,
      String fileName) async {
    var op = Provider.of<OtpProvider>(context, listen: false);

    try {
      var headers = {'Accept': 'application/json'};
      var data = FormData.fromMap({
        'docUpload': [
          await MultipartFile.fromFile(filePath, filename: fileName)
        ],
        'email': email,
        'password': password,
        'identificationDocument': 'Birth Certificate'
      });

      var dio = Dio();
      var response = await dio.request(
        'https://api.e-docrequest.com/api/register-without-nin',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 201) {
        print(response.statusMessage);
        print(json.encode(response.data));

        RegisterWithoutNinResponse result =
            RegisterWithoutNinResponse.fromJson(response.data);

        print("Message: ${result.message}");
        print("OTP: ${result.otp}");
        op.updateOtp(result.otp);
        print("Citizen ID: ${result.data.citizenId}");
        return result;
      } else {
        print("${response.data} ");
        print("statusMessage??::${response.statusCode.toString()}");
        print(response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // The server responded with a status other than 200
        print('Server error: ${e.response?.statusCode}');
        print('Message: ${e.response?.data}');
        return null;
      } else {
        // There was a connection error (e.g., no internet)
        print('Connection error: ${e.message}');
        return null;
      }
    } catch (e) {
      // Handle unexpected errors
      print('Unexpected error: $e');
      return null;
    }
    return null;
  }

  Future<bool> updateWithoutNinData(
    UpdateWithoutNin updateWithoutNin,
    File passportFile, // Add this parameter to pass the selected image file
  ) async {
    try {
      // Debug output
      print("Sending update with: ${updateWithoutNin.toJson()}");
      print("Passport file path: ${passportFile.path}");

      // Prepare form data with file and fields
      final formData = FormData.fromMap({
        'passport': await MultipartFile.fromFile(
          passportFile.path,
          filename: basename(passportFile.path),
        ),

          //  Spread the rest of the data manually
  'hashedID': updateWithoutNin.hashedID,
  'FirstName': updateWithoutNin.firstName,
  'MiddleName': updateWithoutNin.middleName,
  'LastName': updateWithoutNin.lastName,
  'BirthDate': updateWithoutNin.birthDate,
  'Gender': updateWithoutNin.gender,
  'PhoneNumber': updateWithoutNin.phoneNumber,
  'IDNumber': updateWithoutNin.idNumber,
  'StateofOrigin': updateWithoutNin.stateofOrigin,
  'LGAOfOrigin': updateWithoutNin.lgaOfOrigin,
  'AddressofResidence': updateWithoutNin.addressofResidence,
  'AddressInNigeria': updateWithoutNin.addressInNigeria,
  'StateofResidence': updateWithoutNin.stateofResidence,
  'CountryofResidence': updateWithoutNin.countryofResidence,
  'MeansofID': updateWithoutNin.meansofID,
  'NOKFirstname': updateWithoutNin.nokFirstname,
  'NOKMiddlename': updateWithoutNin.nokMiddlename,
  'NOKLastName': updateWithoutNin.nokLastName,
  'NOKResidenceAddress': updateWithoutNin.nokResidenceAddress,
  'NOKPhoneNumber': updateWithoutNin.nokPhoneNumber,
  'NOKRelationship': updateWithoutNin.nokRelationship,
  'NOKEmail': updateWithoutNin.nokEmail,
        
      });

      var dio = Dio();
    var response = await dio.post(
      'https://api.e-docrequest.com/api/update-profile-without-nin',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
        },
      ),
    );

     if (response.statusCode == 200) {
  print(json.encode(response.data));

  // Defensive check: ensure it's a Map
  if (response.data is Map<String, dynamic>) {
    final responseBody = response.data;
    print("checkinggg");

    if (responseBody['success'] == true) {
      print("trrurruru");
      return true;
    } else {
      return false;
    }
  } else {
    print("Unexpected response format.");
    return false;
  }
} else {
  print("Request failed with status: ${response.statusCode}");
  return false;
}

    } on DioException catch (e) {
      if (e.response != null) {
        print('Server error: ${e.response?.statusCode}');
        print('Message: ${e.response?.data}');
        return e.response?.data['message'] ?? "Server error occurred";
      } else {
        print('Connection error: ${e.message}');
        return false;
      }
    } catch (e) {
      print('Unexpected error: $e');
      return false;
    }
  }
}
