import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DrawerPages/DailySaleReport/dailySaleReport.dart';
import '../DrawerPages/GetCollection/getCollection.dart';
import '../DrawerPages/TechnicianPayments/technicianPayments.dart';


class AdminDrawerUI extends StatefulWidget {
  const AdminDrawerUI({super.key});

  @override
  State<AdminDrawerUI> createState() => _AdminDrawerUIState();
}

class _AdminDrawerUIState extends State<AdminDrawerUI> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Drawer(
      width: _width * 0.68,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5),
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              // color: Colors.white,
            ),
            child: Image.asset('assets/al-makkah.png'),
          ),
          ListTile(
            leading: Icon(Icons.request_page_outlined),
            title: Text('Daily Sale Report',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey.shade700),),
            dense: true,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DailyJobReport()));
            },
          ),
          ListTile(
            leading: Icon(Icons.collections_bookmark_outlined),
            title: Text('Collection Report',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey.shade700),),
            dense: true,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>GetCollectionUI()));
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Technician Payments',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey.shade700),),
            dense: true,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TechnicianPaymentsUI()));
            },
          ),

        ],
      ),
    );
  }
}