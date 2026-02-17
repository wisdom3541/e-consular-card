// import 'package:e_consular_card/providers/app_provider.dart';
// import 'package:e_consular_card/providers/update_nin_data_provider.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class DatePickerExample extends StatefulWidget {
//   const DatePickerExample({super.key});

//   @override
//   _DatePickerExampleState createState() => _DatePickerExampleState();
// }

// class _DatePickerExampleState extends State<DatePickerExample> {
//   Future<void> _selectDate(BuildContext context) async {
//     var undp = Provider.of<UpdateNinDataProvider>(context, listen: false);

//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: undp.selectedDate ?? DateTime(2000, 1, 1),
//       firstDate: DateTime(1924, 1, 1),
//       lastDate: DateTime(2009, 1, 1),
//     );

//     // if (pickedDate != null) {
//     setState(() {
//       undp.selectedDate = pickedDate;
//       undp.dobController.text =
//           "${pickedDate!.toLocal()}".split(' ')[0]; // YYYY-MM-DD
//     });
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var undp = Provider.of<UpdateNinDataProvider>(context, listen: false);
//     var ap = Provider.of<AppProvider>(context, listen: false);
//     return TextFormField(
//         controller: undp.dobController,
//         readOnly: true,
//         decoration: const InputDecoration(
//           labelText: "Date of Birth",
//           //hintText: "Enter your D.O.B",
//           suffixIcon: Icon(Icons.calendar_today),
//         ),
//         onTap: () {
//           if (ap.ninRegisteration) {
//           } else {
//             _selectDate(context);
//           }
//         });
//   }
// }
