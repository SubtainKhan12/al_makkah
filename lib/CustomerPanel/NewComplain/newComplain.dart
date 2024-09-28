import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Utilities/Colors/colors.dart';

class NewComplainUI extends StatefulWidget {
  const NewComplainUI({super.key});

  @override
  State<NewComplainUI> createState() => _NewComplainUIState();
}

class _NewComplainUIState extends State<NewComplainUI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _purchaseDateController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  String? type = 'Repair';
  String? warranty = 'NO';

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid mobile number';
    }
    if (!RegExp(r'^03[0-9]{2}[0-9]{7}$').hasMatch(value)) {
      return 'Invalid mobile number format';
    }
    return null;
  }

  setDate() {
    _purchaseDateController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now()) ?? '0';
    _dateController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now()) ?? '0';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDate();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Register Complain',
          style: TextStyle(
              color: ColorsUtils.whiteColor, fontSize: _height * 0.025),
        ),
        backgroundColor: ColorsUtils.baigeColor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      floatingActionButton: Container(
        width: _width * 0.95,
        height: _height * 0.06,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
            child: Text(
              'Submit',
              style: TextStyle(fontSize: _height * 0.03),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: _height * 0.04,
                  width: _width * 0.4,
                  child: TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date",
                      suffixIcon: Icon(Icons.calendar_month),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                TextFormField(
                  maxLength: 11,
                  decoration: InputDecoration(
                    labelText: "Mobile No",
                    hintText: '03XX XXXXXXX',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    counterText: '',
                  ),
                  validator: validateMobile,
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Phone No",
                    hintText: '046 XXXXXXXX Optional',
                    hintStyle: TextStyle(color: ColorsUtils.redColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Address 1",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Address 2",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "City",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Company",
                    hintText: 'Haier',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Item",
                    hintText: 'Air Conditioner',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Model",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Complaint",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                DropdownButtonFormField<String>(
                  value: type,
                  onChanged: (newValue) {
                    setState(() {
                      type = newValue;
                    });
                  },
                  items: <String>[
                    'Installation',
                    'Repair',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: "Type",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Dealer",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                TextField(
                  controller: _purchaseDateController,
                  decoration: InputDecoration(
                    labelText: "Purchase Date",
                    suffixIcon: IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: Icon(Icons.calendar_month)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      const Text(
                        'Warranty:',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: _width * 0.05,
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Yes'),
                          value: 'YES',
                          groupValue: warranty,
                          // contentPadding: EdgeInsets.symmetric(horizontal: -20), // Adjust padding here
                          onChanged: (String? value) {
                            setState(() {
                              warranty = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text(
                            'No',
                          ),
                          value: 'NO',
                          groupValue: warranty,
                          // contentPadding: EdgeInsets.symmetric(horizontal: -20), // Adjust padding here
                          onChanged: (String? value) {
                            setState(() {
                              warranty = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Remarks",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.08,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Set the earliest date you want
      lastDate: DateTime(2101), // Set the latest date you want
    );

    if (pickedDate != null) {
      _purchaseDateController.text =
          DateFormat('dd-MM-yyyy').format(pickedDate);
    }
  }
}
