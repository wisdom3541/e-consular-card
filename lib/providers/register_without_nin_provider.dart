import 'dart:io';

import 'package:e_consular_card/core/register_without_nin.dart';
import 'package:e_consular_card/models/register_without_nin_response.dart';
import 'package:e_consular_card/models/update_without_nin.dart';
import 'package:flutter/material.dart';

class RegisterWithoutNinProvider extends ChangeNotifier {
  File? birthCertificate;
  RegisterWithoutNinResponse? registerWithoutNinResponse;


  Future<bool> regWithoutNin(BuildContext context, String email, String password, String filePath, fileName) async {
    registerWithoutNinResponse = await RegisterWithoutNin().registerUserWithoutNin(context, email, password, filePath, fileName);
    notifyListeners();
    if(registerWithoutNinResponse != null){
      return true;
    }else{
      return false;
    }
  }


  Future<bool> updateWithoutNIn(UpdateWithoutNin updateWithoutNin, File passportImage ) async {
    print("where is resultttt");
    var result = await RegisterWithoutNin().updateWithoutNinData(updateWithoutNin, passportImage );
    print("ressss:: $result");
    notifyListeners();
    return result;

  }




}
