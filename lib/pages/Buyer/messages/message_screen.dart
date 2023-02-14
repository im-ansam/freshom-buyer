import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/constants/firebase_consts.dart';
import 'package:fresh_om/controller/chat_controller.dart';
import 'package:fresh_om/pages/Buyer/Services/firestore_services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/reusable_bold_text.dart';
import '../../../utils/chat_bubble.dart';

class MessageSeller extends StatelessWidget {
  const MessageSeller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black87,
        backgroundColor: AppColors.mainBackGround,
        title: BoldText(
          text: "${controller.friendName}",
          fontWeight: FontWeight.bold,
          size: Dimensions.fontSize20,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.height10),
        child: Column(
          children: [
            Obx(() => controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.tealColor,
                    ),
                  )
                : Expanded(
                    child: StreamBuilder(
                      stream: FireStoreServices.getChatMessages(
                          controller.chatDocId.toString()),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.tealColor,
                            ),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: "Send a message..."
                                .text
                                .color(Colors.black54)
                                .make(),
                          );
                        } else {
                          return ListView(
                            physics: BouncingScrollPhysics(),
                            children: snapshot.data!.docs
                                .mapIndexed((currentValue, index) {
                              var data = snapshot.data!.docs[index];
                              return Align(
                                  alignment: data['uid'] == currentUser!.uid
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: chatBubble(data));
                            }).toList(),
                          );
                        }
                      },
                    ),
                  )),
            SizedBox(
              height: Dimensions.height10,
            ),
            SizedBox(
              height: Dimensions.height60,
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: controller.msgController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.tealColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.tealColor)),
                        hintText: "Enter Message",
                        border: InputBorder.none),
                  )),
                  IconButton(
                    onPressed: () {
                      controller.sendMSg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(Icons.send),
                    color: AppColors.tealColor,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
