import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/home/controllers/wallet_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';

class WalletPageView extends GetView<WalletPageController> {
  const WalletPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WalletPageController walletPageController = Get.put(WalletPageController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back, size: 18,)
        ),
        // leadingWidth: 30,
        titleSpacing: 0,
        flexibleSpace: Container(
          height: 100,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.bluishColor,
                AppColors.bluishColor.withOpacity(0.7)]),
              image: DecorationImage(image: AssetImage(AppImages.appbarBackgroundPngImage),
                  fit: BoxFit.fitWidth)),
        ),
        centerTitle: false,
        title: Text(
          'My Wallet',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height / 3.5,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.bluishColor.withOpacity(0.9),
                      AppColors.bluishColor.withOpacity(0.6)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  image: DecorationImage(
                      image: AssetImage(AppImages.appbarBackgroundPngImage),
                      fit: BoxFit.fill),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text16by700(
                            text: 'Your Balance:',
                            color: AppColors.whiteShadow,
                            fontSize: 14,
                          ),
                          const SizedBox(height: 8),
                          Text16by700(
                            text: '₹2,500.00', // Replace with actual amount
                            color: AppColors.whiteShadow,
                            fontSize: 24,
                          ),
                        ],
                      )),
                      Column(
                        children: [
                          CustomSolidButton(
                            onClick: () {
                              // Add money functionality
                            },
                            buttonText: 'ADD MONEY',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            boxColor: AppColors.whiteShadow,
                            textColor: AppColors.blackish5E5E5E,
                            vPadding: 15.0,
                          ),
                          // const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              // Withdraw money functionality
                            },
                            child: Text(
                              'WITHDRAW MONEY',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Activity',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackishTextColor),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          TabBar(
              tabAlignment: TabAlignment.fill,
              padding: EdgeInsets.all(10.0),
              controller: walletPageController.tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              indicatorColor: AppColors.bluishTextColor,
              labelStyle: TextStyle(
                  color: AppColors.blackish2D2D2D,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(
                  color: AppColors.blackish5E5E5E,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              // isScrollable: true,
              dividerHeight: 1,
              tabs: const [
                Text('Deposit'),
                Text('Withdraw'),
              ]),
          Expanded(
              child: TabBarView(
            controller: walletPageController.tabController,
            children: [
              ListView.builder(
                itemCount: 2, // Adjust the number of items
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/sample_image.jpg'),
                    ),
                    title: Text('Dr. Rahul '),
                    subtitle: Text('24-01-2024'),
                    trailing: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '₹500',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          )),
        ],
      ),
    );
  }
}
