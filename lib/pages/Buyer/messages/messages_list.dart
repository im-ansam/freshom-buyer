import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/pages/Buyer/messages/message_screen.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/reusable_bold_text.dart';

import '../Services/firestore_services.dart';

class AllMessageList extends StatefulWidget {
  const AllMessageList({Key? key}) : super(key: key);

  @override
  State<AllMessageList> createState() => _AllMessageListState();
}

class _AllMessageListState extends State<AllMessageList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainBackGround,
        foregroundColor: AppColors.nicePurple,
        title: BoldText(
          fontWeight: FontWeight.w800,
          size: Dimensions.fontSize20,
          text: "Your Messages",
        ),
      ),
      backgroundColor: AppColors.mainBackGround,
      body: StreamBuilder(
        stream: FireStoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.nicePurple,
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Messages yet!"
                .text
                .semiBold
                .color(AppColors.tealColor)
                .size(Dimensions.fontSize20)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: EdgeInsets.all(Dimensions.width8),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.grey.shade200,
                              child: ListTile(
                                dense: true,
                                onTap: () {
                                  Get.to(() => const MessageSeller(),
                                      arguments: [
                                        data[index]['friend_name'],
                                        data[index]['toId'],
                                      ]);
                                },
                                leading: const CircleAvatar(
                                  backgroundColor: AppColors.nicePurple,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                title: "${data[index]['friend_name']}"
                                    .text
                                    .bold
                                    .color(AppColors.nicePurple)
                                    .size(Dimensions.fontSize18)
                                    .make(),
                                subtitle: "${data[index]['last_msg']}"
                                    .text
                                    .semiBold
                                    .color(Colors.black54)
                                    .size(Dimensions.fontSize16)
                                    .make(),
                                trailing: "10:04"
                                    .text
                                    .semiBold
                                    .color(Colors.black54)
                                    .size(Dimensions.fontSize16)
                                    .make(),
                              ),
                            );
                          }))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
