
import 'package:e_document_request/providers/verify_nin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key});

  @override
  _DatePickerExampleState createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  
  

  Future<void> _selectDate(BuildContext context) async {

var vnp = Provider.of<VerifyNinProvider>(context,listen: false);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: vnp.selectedDate ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1924, 1, 1),
      lastDate: DateTime(2009, 1, 1),
    );

    if (pickedDate != null) {
      setState(() {
        vnp.selectedDate = pickedDate;
        vnp.dobController.text = "${pickedDate.toLocal()}".split(' ')[0]; // YYYY-MM-DD
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    var vnp = Provider.of<VerifyNinProvider>(context,listen: false);
    return TextFormField(
      controller: vnp.dobController,
      readOnly: true,
      decoration: const InputDecoration(
        labelText: "Date of Birth",
        hintText: "Enter your D.O.B",
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () => _selectDate(context),
    );
  }
}
