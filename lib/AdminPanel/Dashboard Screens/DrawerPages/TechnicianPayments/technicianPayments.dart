import 'dart:convert';

import 'package:al_makkah/Models/GetExpense/GetExpenseModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../../APIs/apis.dart';
import '../../../../Utilities/Colors/colors.dart';
import '../../../../Utilities/Loader/loader.dart';
import '../../../../Utilities/Snackbar/snackbar.dart';

class TechnicianPaymentsUI extends StatefulWidget {
  const TechnicianPaymentsUI({super.key});

  @override
  State<TechnicianPaymentsUI> createState() => _TechnicianPaymentsUIState();
}

class _TechnicianPaymentsUIState extends State<TechnicianPaymentsUI> {
  List<GetExpenseModel> getExpenseList = [];
  TextEditingController _dateController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  DateTime _date = DateTime.now();
  String? expense;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDateData();
    get_GetExpense();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Technicians Payments',
          style: TextStyle(
              color: ColorsUtils.whiteColor, fontSize: _height * 0.025),
        ),
        backgroundColor: ColorsUtils.baigeColor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: _width * 0.4,
              height: _height * 0.05,
              child: TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                    labelText: 'Date',
                    suffixIcon: IconButton(
                        onPressed: () {
                          selectDate(context, setState);
                        },
                        icon: Icon(Icons.calendar_month)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            DropdownButtonFormField<String>(
              value: expense,
              onChanged: (newValue) {
                setState(() {
                  expense = newValue;
                });
              },
              items: getExpenseList.map((expenses) {
                return DropdownMenuItem<String>(
                  value: expenses.texpid ?? '',
                  child: Text(
                    expenses.texpdsc ?? '',
                    style: TextStyle(
                        fontSize:
                        MediaQuery.of(context).size.height *
                            0.018,
                        // Adjust font size based on height
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black),
                    maxLines: 1,
                  ),
                );
              }).toList(),
              isDense: true,
              // Make the dropdown more compact
              decoration: InputDecoration(
                labelText: "Select Expense",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal:
                    10), // Add padding inside the text field
              ),
              style: TextStyle(
                fontSize:
                MediaQuery.of(context).size.height * 0.018,
                // Adjust font size for selected value
                overflow: TextOverflow
                    .ellipsis, // Ensure selected value fits within the field
              ),
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            Container(
                width: double.maxFinite,
                height: _height * 0.065,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      Post_SavePayment();
                      CircularIndicator.showLoader(context);
                    },
                    child: Text('Submit',style: TextStyle(fontSize: _height * 0.025),))),
          ],
        ),
      ),
    );
  }

  setDateData() {
    _dateController.text = DateFormat('dd-MM-yyyy').format(_date) ?? '';
  }

  Future<void> selectDate(BuildContext context, StateSetter setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      helpText: 'Select Date',
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        setDateData();
      });
    }
  }

  Future Post_SavePayment() async {
    var response = await http.post(Uri.parse(SavePayment), body: {
      'FTrnNum': '999999',
      'FTrnDat': _dateController.text,
      'FExpId': expense.toString(),
      'FTrnAmt': _amountController.text,
      'FTrnDsc': _descriptionController.text,
      'FUsrId': '74'
    });
    print(_dateController);
    print(expense);
    print(_amountController);
    print(_descriptionController);
    var result = jsonDecode(response.body);
    if (result['error'] == 200) {
      Snackbar.showSnackBar(context, result['message'], Colors.teal);
      Navigator.pop(context);
      // Navigator.pop(context);
      setState(() {
        _amountController.clear();
        _descriptionController.clear();
      });
    } else {
      Snackbar.showSnackBar(context, result['message'], Colors.red);
      Navigator.pop(context);
      setState(() {
        _amountController.clear();
        _descriptionController.clear();
      });
    }
  }
  Future get_GetExpense()async{
    var response = await http.get(Uri.parse(GetExpense));
    var result = jsonDecode(response.body);
    if(response.statusCode == 200){
      getExpenseList.clear();
      for(Map i in result){
        getExpenseList.add(GetExpenseModel.fromJson(i));
      }
      setState(() {
      });
    }
  }
}
