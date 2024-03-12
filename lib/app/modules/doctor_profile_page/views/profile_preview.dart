import 'package:flutter/material.dart';
import '../../../app_constants/constants_appColors.dart';

class ProfilePreviewView extends StatefulWidget {
  const ProfilePreviewView({super.key});
  @override
  State<ProfilePreviewView> createState() => _ProfilePreviewViewState();
}

class _ProfilePreviewViewState extends State<ProfilePreviewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        // image: therapist?.avatar!=null?DecorationImage(image: NetworkImage(therapist!.avatar!)):null
                    ),

                    child: Center(child: Text('D')),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                         'Salman',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          "Counselling Psychologist",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black54),
                        ),
                        Row(
                          children: List.generate(
                              5,
                                  (index) => Icon(
                                Icons.star,
                                color: AppColors.bluishColor,
                                size: 17,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      border: Border.all(width: 1.5, color: Colors.green.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(25)),
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.bluishColor.withOpacity(0.2),
                      border: Border.all(width: 1.5, color: AppColors.bluishColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(25)),
                  child: Icon(
                    Icons.query_stats,
                    color: AppColors.bluishColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "250 Sessions",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.bluishColor.withOpacity(0.2),
                      border: Border.all(width: 1.5, color: AppColors.bluishColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(25)),
                  child: Icon(
                    Icons.backpack,
                    color: AppColors.bluishColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${'1'} yrs experience",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ],
            ),
            // CHAT AND BOOK SESSION VIEW BELOW
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12),
                ),
                child: const Column(
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.chat,
                                    color: AppColors.bluishColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Chat",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Text(
                                "Connect with john doe for instant guidance.",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Starting at",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "100",
                                style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.bluishColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: AppColors.bluishColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Book Session",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Text(
                                "Book a personal audio/video session for in-depth guidance.",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "20",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "2000",
                                style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.bluishColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // WHAT CAN YOU ASK ME VIEW BELOW
            // Text(
            //   "What can you ask me",
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Column(
            //   children: [
            //     Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Icon(
            //           Icons.format_quote_outlined,
            //           color: AppColors.bluishColor,
            //         ),
            //         SizedBox(
            //           width: 8,
            //         ),
            //         Expanded(
            //             child: Text(
            //               "How do i manage my emotions and thoughts?",
            //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            //             ))
            //       ],
            //     ),
            //     SizedBox(
            //       height: 10,
            //     ),
            //     Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Icon(
            //           Icons.format_quote_outlined,
            //           color: AppColors.bluishColor,
            //         ),
            //         SizedBox(
            //           width: 8,
            //         ),
            //         Expanded(
            //             child: Text(
            //               "How do i achieve a better work-life balance and manage stress?",
            //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            //             ))
            //       ],
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Who can reach out to me",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Wrap(
              children: [
                ...List.generate(4, (index) => Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.bluishColor.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.all(10),
                    child: const Text(
                      'any Info',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.bluishColor),
                    ))),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Who can I help you achieve",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.border_inner_rounded,
                        color: Colors.black38,
                      ),
                      Text(
                        "Emotional \nBalance",
                        style: TextStyle(color: Colors.black87),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 25,
                  width: 2,
                  color: Colors.black38,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cruelty_free,
                        color: Colors.black38,
                      ),
                      Text(
                        "Trauma \nBalance",
                        style: TextStyle(color: Colors.black87),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 25,
                  width: 2,
                  color: Colors.black38,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.heart_broken,
                        color: Colors.black38,
                      ),
                      Text(
                        "Relationship Problems",
                        style: TextStyle(color: Colors.black87),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "About",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text('description',style: TextStyle(
                fontSize: 14,color: AppColors.bluishColor
            ),textAlign: TextAlign.justify,),
            SizedBox(
              height: 15,
            ),
            Text(
              "User Review",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(offset: Offset(0.4, 0.4),
                        spreadRadius: -0.6,
                        blurRadius: 0.9,
                        color: Colors.black54)
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('4.2/5',style: TextStyle(fontSize: 21),),
                  Row(children: List.generate(5, (index) => Icon(Icons.star,color: Colors.yellow,))),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('5',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                          SizedBox(width: 10,),
                          Icon(Icons.star_rate,color: AppColors.bluishColor,),
                          Expanded(child: LinearProgressIndicator(value: 0.7,minHeight: 3,)),
                          // Icon(Icons.star,color: Colors.red),
                        ],
                      ),
                      Row(
                        children: [
                          Text('4',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                          SizedBox(width: 10,),
                          Icon(Icons.star_rate,color: AppColors.bluishColor,),
                          Expanded(child: LinearProgressIndicator(value: 0.6,minHeight: 3,)),
                          // Icon(Icons.star,color: Colors.red),
                        ],
                      ),
                      Row(
                        children: [
                          Text('3',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                          SizedBox(width: 10,),
                          Icon(Icons.star_rate,color: AppColors.bluishColor,),
                          Expanded(child: LinearProgressIndicator(value: 0.4,minHeight: 3,)),
                          // Icon(Icons.star,color: Colors.red),
                        ],
                      ),
                      Row(
                        children: [
                          Text('2',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                          SizedBox(width: 10,),
                          Icon(Icons.star_rate,color: AppColors.bluishColor,),
                          Expanded(child: LinearProgressIndicator(value: 0.3,minHeight: 3,)),
                          // Icon(Icons.star,color: Colors.red),
                        ],
                      ),
                      Row(
                        children: [
                          Text('1',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                          SizedBox(width: 10,),
                          Icon(Icons.star_rate,color: AppColors.bluishColor,),
                          Expanded(child: LinearProgressIndicator(value: 0.1,minHeight: 3,)),
                          // Icon(Icons.star,color: Colors.red),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(child: Text('E'),),
                        SizedBox(width: 6.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Shivani Ramakrishna'),
                            Text('30 Oct, 2023'),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (index) => Icon(Icons.star,color: Colors.red,)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text('The session is amazing'),
                Divider()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
