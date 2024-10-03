import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../APIs/apis.dart';
import '../../../../../Models/GetJobInfo/JobInfoModel.dart';
import '../../../../../Utilities/Colors/colors.dart';
import '../../../../../Utilities/Loader/loader.dart';
import '../../../../../Utilities/Snackbar/snackbar.dart';

class PendingVisitFormUI extends StatefulWidget {
  JobInfoModel getJobInfo;

  PendingVisitFormUI({super.key, required this.getJobInfo});

  @override
  State<PendingVisitFormUI> createState() => _PendingVisitFormUIState();
}

class _PendingVisitFormUIState extends State<PendingVisitFormUI> {
  TextEditingController _serialController = TextEditingController();
  TextEditingController _itemController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _partsAmountController = TextEditingController();
  TextEditingController _jobAmountController = TextEditingController();
  DateTime? _dateTime;
  var cdate = DateFormat("dd-MM-yyyy").format(DateTime.now());
  DateTime cdate1 = DateTime.now();

  // DateTime selectedInitialDate = DateTime.now();
  String? status = 'Pending';
  String? warranty;
  String? jobType = 'REPAIRING';
  File? _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setComplainData();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visit Form',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.baigeColor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: _width * 0.4,
                  height: _height * 0.03,
                  child: Row(
                    children: [
                      Container(
                          width: _width * 0.23,
                          child: const Text(
                            'Complain No',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Container(
                        width: _width * 0.02,
                        child: const Text(
                          ':',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          // width: _width * 0.25,
                          child: Text(
                        widget.getJobInfo.tjobnum.toString().trim(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    const Text('Date: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      widget.getJobInfo.tjobdat.toString().trim(),
                      // DateFormat('dd-MM-yyyy').format(selectedInitialDate),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    // const Icon(Icons.calendar_today, color: Colors.green),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: InputDecorator(
                  decoration: InputDecoration(
                      labelText: 'Customer Information',
                      labelStyle: TextStyle(
                          color: ColorsUtils.appcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      )),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: _width * 0.23,
                                child: const Text(
                                  'Customer',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Container(
                              width: _width * 0.02,
                              child: const Text(
                                ':',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                // width: _width * 0.25,
                                child: Flexible(
                              child: Flexible(
                                child: Text(widget.getJobInfo.tcstnam
                                    .toString()
                                    .trim()),
                              ),
                            ))
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                                width: _width * 0.23,
                                child: const Text(
                                  'Address',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Container(
                              width: _width * 0.02,
                              child: const Text(
                                ':',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                // width: _width * 0.25,
                                child: Flexible(
                              child: Text(
                                  widget.getJobInfo.tadd001.toString().trim()),
                            )),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                                width: _width * 0.23,
                                child: const Text(
                                  '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Container(
                              width: _width * 0.02,
                              child: const Text(
                                ':',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                // width: _width * 0.25,
                                child: Flexible(
                              child: Text(
                                  widget.getJobInfo.tadd002.toString().trim()),
                            ))
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                                width: _width * 0.23,
                                child: const Text(
                                  'Mobile No',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Container(
                              width: _width * 0.02,
                              child: const Text(
                                ':',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                // width: _width * 0.25,
                                child: Text(widget.getJobInfo.tmobnum
                                    .toString()
                                    .trim()))
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 0.3,
              height: MediaQuery.of(context).size.height / 16,
              child: TextField(
                readOnly: true,
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Visit Date",
                  suffixIcon: IconButton(
                      onPressed: () {
                        _intSelectDate(context, setState);
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: Colors.blue,
                      )),
                  labelStyle: TextStyle(color: ColorsUtils.appcolor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 0.3,
              height: MediaQuery.of(context).size.height / 16,
              child: TextField(
                // readOnly: true,
                controller: _itemController,
                decoration: InputDecoration(
                  labelText: "Item",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 0.3,
              height: MediaQuery.of(context).size.height / 16,
              child: TextField(
                controller: _serialController,
                decoration: InputDecoration(
                  labelText: "Serial No",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 0.3,
              height: MediaQuery.of(context).size.height / 16,
              child: DropdownButtonFormField<String>(
                value: status,
                onChanged: (newValue) {
                  setState(() {
                    status = newValue;
                  });
                },
                items: <String>[
                  'Pending',
                  'Done',
                  'Cancel',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: "Status",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 0.3,
              height: MediaQuery.of(context).size.height / 16,
              child: DropdownButtonFormField<String>(
                value: jobType,
                onChanged: (newValue) {
                  setState(() {
                    jobType = newValue;
                  });
                },
                items: <String>[
                  'REPAIRING',
                  'INSTALLATION',
                  'WORKSHOP',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: "Job Type",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              // width: MediaQuery.of(context).size.width / 0.3,
              // height: MediaQuery.of(context).size.height / 16,
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: _partsAmountController,
                decoration: InputDecoration(
                  labelText: "Parts Amount",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  // floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps label at the top
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              // width: MediaQuery.of(context).size.width / 0.3,
              // height: MediaQuery.of(context).size.height / 16,
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: _jobAmountController,
                decoration: InputDecoration(
                  labelText: "Job Amount",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  // floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps label at the top
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
                    width: _width * 0.04,
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
            Container(
              // width: MediaQuery.of(context).size.width / 0.3,
              // height: MediaQuery.of(context).size.height / 16,
              child: TextField(
                maxLines: 3,
                controller: _remarkController,
                decoration: InputDecoration(
                  labelText: "Remarks",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  // floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps label at the top
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: _showImageSourceDialog,
              child: Container(
                height: _height * 0.15,
                width: _width * 0.4,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8)),
                child: _image == null
                    ? const Center(
                        child: Icon(
                        Icons.image_outlined,
                        size: 50,
                      ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: _height / 16,
              width: _width / 0.3, // Set the height
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                onPressed: () {
                  post_SaveVisit();
                  CircularIndicator.showLoader(context);
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void _showImageSourceDialog() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                _takePicture(ImageSource.camera);
                Navigator.of(context).pop();
              },
              child: Container(
                height: _height * 0.04,
                child: Image.asset('assets/camera.png'),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                _takePicture(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              child: Container(
                height: _height * 0.04,
                child: Image.asset('assets/gallery.png'),
              ),
            )
          ],
        );
      },
    );
  }

  void _takePicture(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  setComplainData() {
    String formattedDate = DateFormat("dd-MM-yyyy").format(cdate1);
    _itemController.text = widget.getJobInfo.category.toString().trim() ?? '0';
    _dateController.text = formattedDate;
    warranty = widget.getJobInfo.twrnsts.toString().trim() ?? '0';
    _partsAmountController.text =
        widget.getJobInfo.tprtamt.toString().trim() == 'null'
            ? '0.00'
            : _partsAmountController.text =
                widget.getJobInfo.tprtamt.toString().trim() ?? '0';
    _jobAmountController.text =
        widget.getJobInfo.tjobamt.toString().trim() == 'null'
            ? '0.00'
            : _jobAmountController.text =
                widget.getJobInfo.tjobamt.toString().trim() ?? '0';
  }

  Future<void> _intSelectDate(
      BuildContext context, StateSetter setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: cdate1,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != cdate1) {
      setState(() {
        cdate1 = picked;
        _dateController.text = DateFormat("dd-MM-yyyy").format(cdate1);
      });
    }
  }

  Future post_SaveVisit() async {
    var request = http.MultipartRequest('POST', Uri.parse(SaveVisit));
    request.fields['FJobNum'] = widget.getJobInfo.tjobnum.toString();
    request.fields['FJobSts'] = status.toString();
    request.fields['FItmSer'] = _serialController.text;
    request.fields['FVstRem'] = _remarkController.text;
    request.fields['FVstDat'] = cdate1.toString();
    request.fields['FPrtAmt'] = _partsAmountController.text;
    request.fields['FJobAmt'] = _jobAmountController.text;
    request.fields['FWrnSts'] = warranty.toString();
    request.fields['FJobTyp'] = jobType.toString();
    request.fields['FwdDat'] = widget.getJobInfo.tfwddat.toString();
    request.fields['FTchCod'] = widget.getJobInfo.ttchcod.toString();

    if (_image != null) {
      var picture = await http.MultipartFile.fromPath('VstImg', _image!.path);
      request.files.add(picture);
    }
    final response = await http.Response.fromStream(await request.send());
    var result = jsonDecode(response.body.toString());
    if (result["error"] == 200) {
      print(result["message"]);
      Snackbar.showSnackBar(context, result['message'], Colors.teal);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Snackbar.showSnackBar(context, result['message'], Colors.teal);
      Navigator.pop(context);
    }
  }
}
