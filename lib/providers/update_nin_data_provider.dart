import 'package:e_document_request/models/citizen_data.dart';
import 'package:e_document_request/models/update_with_nin.dart';
import 'package:e_document_request/providers/create_acccount_with_nin_provider.dart';
import 'package:flutter/material.dart';

class UpdateNinDataProvider extends ChangeNotifier {
  late CitizenData citizenData;
  late UpdateWithNin updateWithNinData;
  DateTime? selectedDate;

 // final batchidController = TextEditingController();
  final birthcountryController = TextEditingController();
  final birthdateController = TextEditingController();
  //final birthlgaController = TextEditingController();
  //final birthstateController = TextEditingController();
 // final cardstatusController = TextEditingController();
 // final centralIDController = TextEditingController();
  final documentnoController = TextEditingController();
 // final educationallevelController = TextEditingController();
  //final emailController = TextEditingController();
 // final emplymentstatusController = TextEditingController();
  final firstnameController = TextEditingController();
  final genderController = TextEditingController();
//  final heigthController = TextEditingController();
 // final maidennameController = TextEditingController();
 // final maritalstatusController = TextEditingController();
  final middlenameController = TextEditingController();
  final ninController = TextEditingController();
  final nokAddress1Controller = TextEditingController();
  //final nokAddress2Controller = TextEditingController();
  final nokFirstnameController = TextEditingController();
 // final nokLgaController = TextEditingController();
  final nokMiddlenameController = TextEditingController();
  //final nokPostalcodeController = TextEditingController();
  //final nokStateController = TextEditingController();
  final nokSurnameController = TextEditingController();
  //final nokTownController = TextEditingController();
 // final nspokenlangController = TextEditingController();
  //final ospokenlangController = TextEditingController();
 // final othernameController = TextEditingController();
 // final pfirstnameController = TextEditingController();
  //final photoController = TextEditingController();
 // final pmiddlenameController = TextEditingController();
//  final professionController = TextEditingController();
 // final psurnameController = TextEditingController();
 // final religionController = TextEditingController();
  final residenceAddressLine1Controller = TextEditingController();
  final originAddressLine1Controller = TextEditingController();
 // final residenceAddressLine2Controller = TextEditingController();
 // final residenceTownController = TextEditingController();
 // final residenceLgaController = TextEditingController();
  //final residencePostalcodeController = TextEditingController();
  final residenceStateController = TextEditingController();
 // final residencestatusController = TextEditingController();
  //final selfOriginLgaController = TextEditingController();
 // final selfOriginPlaceController = TextEditingController();
////  final selfOriginStateController = TextEditingController();
 // final signatureController = TextEditingController();
  final surnameController = TextEditingController();
  final telephonenoController = TextEditingController();
  //final titleController = TextEditingController();
 // final trackingIdController = TextEditingController();
 // final citizenIDController = TextEditingController();
 // final hashedIDController = TextEditingController();
 final meansOfIDController = TextEditingController();
  final nokTelephonenoController = TextEditingController();
 final nokRelationshipController = TextEditingController();
  final nokEmailController = TextEditingController();
  final dobController = TextEditingController();

  void dispose() {
  //  batchidController.dispose();
    birthcountryController.dispose();
    birthdateController.dispose();
   // birthlgaController.dispose();
 //   birthstateController.dispose();
  //  cardstatusController.dispose();
  //  centralIDController.dispose();
    documentnoController.dispose();
  //  educationallevelController.dispose();
 //   emailController.dispose();
  //  emplymentstatusController.dispose();
    firstnameController.dispose();
    genderController.dispose();
  //  heigthController.dispose();
 //   maidennameController.dispose();
  //  maritalstatusController.dispose();
    middlenameController.dispose();
    ninController.dispose();
    nokAddress1Controller.dispose();
 //   nokAddress2Controller.dispose();
    nokFirstnameController.dispose();
  //  nokLgaController.dispose();
    nokMiddlenameController.dispose();
   // nokPostalcodeController.dispose();
  //  nokStateController.dispose();
    nokSurnameController.dispose();
  //  nokTownController.dispose();
  //  nspokenlangController.dispose();
  ///  ospokenlangController.dispose();
   // othernameController.dispose();
   // pfirstnameController.dispose();
   // photoController.dispose();
   // pmiddlenameController.dispose();
  //  professionController.dispose();
   // psurnameController.dispose();
   // religionController.dispose();
    residenceAddressLine1Controller.dispose();
    originAddressLine1Controller.dispose();
   // residenceAddressLine2Controller.dispose();
   // residenceTownController.dispose();
   // residenceLgaController.dispose();
   // residencePostalcodeController.dispose();
    residenceStateController.dispose();
  //  residencestatusController.dispose();
   // selfOriginLgaController.dispose();
   // selfOriginPlaceController.dispose();
  //  selfOriginStateController.dispose();
   // signatureController.dispose();
    surnameController.dispose();
    telephonenoController.dispose();
    //titleController.dispose();
   // trackingIdController.dispose();
    //citizenIDController.dispose();
    //hashedIDController.dispose();
   // meansOfIDController.dispose();
    nokTelephonenoController.dispose();
    nokEmailController.dispose();
    nokRelationshipController.dispose();
    dobController.dispose();
  }

  // Future<void> getCitizenData(BuildContext context) async {
  //   var data = await VerifyNinApi().verifyNinApi(context);
  //   print(data.toString());
  //   notifyListeners();
  // }

  void updateCitizenData(CitizenData data) {
    citizenData = data;
    notifyListeners();
  }

  void populateRetrievedData() {
    firstnameController.text = citizenData.firstname!;
    surnameController.text = citizenData.surname!;
    middlenameController.text = citizenData.middlename!;
    //residenceAddressLine1Controller.text = citizenData.residence_AdressLine1!;
    //residenceLgaController.text = citizenData.residence_lga!;
    residenceStateController.text = citizenData.residence_state!;
   // selfOriginStateController.text = citizenData.self_origin_state!;
    birthcountryController.text = citizenData.birthcountry!;
    meansOfIDController.text = "National Identity Number";
    selectedDate = DateTime.parse(citizenData.birthdate!);
    var trimedDate = "${selectedDate!.toLocal()}".split(' ')[0]; // YYYY-MM-DD
    dobController.text = trimedDate.toString();
    ninController.text = citizenData.nin!;
    nokFirstnameController.text = citizenData.nok_firstname!;
    nokSurnameController.text = citizenData.nok_surname!;
    nokMiddlenameController.text = citizenData.nok_middlename!;
    telephonenoController.text = citizenData.telephoneno!;
  }

  
UpdateWithNin createModelFromControllers(String hashedID) {
  print("data empty??");
  return UpdateWithNin(
    hashedID: hashedID,
    FirstName: firstnameController.text,
    MiddleName: middlenameController.text,
    LastName: surnameController.text,
    BirthDate: birthdateController.text,
    Gender: genderController.text,
    PhoneNumber: citizenData.telephoneno!,
    AddressofResidence: residenceAddressLine1Controller.text,
    AddressInNigeria: originAddressLine1Controller.text,
    StateofResidence: residenceStateController.text,
    CountryofResidence: "NG",
    MeansofID: "National Identity Number",
    NOKFirstname: nokFirstnameController.text,
    NOKMiddlename: nokMiddlenameController.text,
    NOKLastName: nokSurnameController.text,
    NOKResidenceAddress: nokAddress1Controller.text,
    NOKPhoneNumber: nokTelephonenoController.text,
    NOKRelationship: nokRelationshipController.text,
    NOKEmail: nokEmailController.text,
    passport: "",
  );
}



}

