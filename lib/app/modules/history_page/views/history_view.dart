import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:gotherepy_doctor/app/modules/history_page/controllers/history_page_controller.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';

class HistoryListView extends GetView<HistoryPageController> {
  const HistoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'History', appBar: AppBar(),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 3, // Adjust the number of items
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('#1248541203458045',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),),
                  ],
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Vaibhavi',
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.bluishTextColor,
                              fontWeight: FontWeight.w800
                          ),
                        ),
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('assets/sample_image.jpg'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text('12-12-2024', style: TextStyle(
                                fontSize: 14,
                                color: AppColors.blackishTextColor,
                                fontWeight: FontWeight.w700
                            ),),
                            SizedBox(height: 5,),
                            Text('Completed', style: TextStyle(
                                fontSize: 14,
                                color: AppColors.redishCC0909,
                            ),),
                          ],
                        ),
                        Column(
                          children: [
                            Text('₹21/min'),
                            SizedBox(height: 5,),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(vertical: 6), // Set padding
                              child: Material(
                                elevation: 0.5,
                                borderRadius: BorderRadius.circular(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle button press
                                    Fluttertoast.showToast(msg: 'Navigated to Chat Screen');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    // primary: Colors.green,
                                    primary: Colors.teal,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    // padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10), // Set padding
                                  ),
                                  child: Text(
                                    'Chat',
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text('Rate:'),
                        SizedBox(width: 5,),
                        Text('₹100/min'),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text('Duration:'),
                        SizedBox(width: 5,),
                        Text('5 minutes'),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text('Deduction:'),
                        SizedBox(width: 5,),
                        Text('₹100'),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                      alignment: Alignment.centerLeft,
                      // padding: EdgeInsets.symmetric(vertical: 6), // Set padding
                      child: Material(
                        elevation: 0.5,
                        borderRadius: BorderRadius.circular(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle button press
                            Fluttertoast.showToast(msg: 'Whatsapp Screen Sharing');
                          },
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.green,
                            primary: Colors.teal,
                            // padding: EdgeInsets.symmetric(horizontal: 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            // padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10), // Set padding
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // WhatsApp icon
                              FaIcon(FontAwesomeIcons.whatsapp,
                                color: AppColors.whiteShadow,),
                              SizedBox(width: 8.0),
                              // Share with your friends text
                              Text(
                                'Share with your friends',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyCustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 20);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}