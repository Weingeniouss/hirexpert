// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../view/utils/appUrl.dart';
import '../../../../view/utils/app_constance.dart';
import '../../../API_Controller/Candidate/Massge/ChatList_Controller.dart';
import '../../../API_Controller/Candidate/Massge/sendMessage_Controller.dart';

class MessagesentConrollers extends GetxController{
  final SendmessageController sentmegs = Get.put(SendmessageController());
  final ChatlistController chatListing = Get.put(ChatlistController());
  final ImagePicker picker = ImagePicker();
  final WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(AppUrl.WebSocket));
  final TextEditingController textController = TextEditingController();
  final RxList<Map<String, String>> messages = <Map<String, String>>[].obs;
  final String timestamp = DateFormat('hh:mm a').format(DateTime.now());
  final ScrollController scrollController = ScrollController();
  String? previousDate;

@override
  void onInit() {
     chatListing.Chatlistcontroller_fuction(ReceiverId: '6', JobId: '4', RoomId: '2', Tokan: Tokans, Page: '1', Timezone: 'asia/kolkata', CandidateId: '20');
    super.onInit();
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    }
  }

  String formatRelativeDate(String entryDate) {
    try {
      DateTime messageDate = DateTime.parse(entryDate);
      DateTime now = DateTime.now();
      int differenceInDays = now.difference(messageDate).inDays;

      if (differenceInDays == 0) {
        return "Today";
      } else if (differenceInDays == 1) {
        return "Yesterday";
      } else if (differenceInDays < 7) {
        return DateFormat.EEEE().format(messageDate); // Day of the week
      } else {
        return DateFormat('dd- MMMM- yyyy').format(messageDate);
      }
    } catch (e) {
      return 'Invalid date';
    }
  }

  String formatTime(String entryDate) {
    try {
      DateTime dateTime = DateTime.parse(entryDate);
      return DateFormat('HH:mm').format(dateTime);
    } catch (e) {
      return 'Invalid time';
    }
  }

  void sendMessage(String text) {
    if (text.isNotEmpty) {
      final messageData = {'text': text, 'timestamp': DateFormat('hh:mm a').format(DateTime.now()), 'senderId': '2', 'receiverId': '10', 'chatroomId': '2', 'msgType': 'Text'};

      // Add message locally
      messages.add({'text': text, 'timestamp': messageData['timestamp']!});
      textController.clear();

      try {
        channel.sink.add(messageData.toString());
      } catch (e) {
        print('Failed to send message via WebSocket: $e');
      }

      scrollToBottom();

      // Call API to send message
      sentmegs.SendmessageController_Fuction(Tokan: Tokans, RoomId: '2', JobIds: '4', ReceiverId: '6', MsgType: 'Text', MSenderId: '89', Message: text).then((_) {chatListing.Chatlistcontroller_fuction(ReceiverId: '6', JobId: '4', RoomId: '2', Tokan: Tokans, Page: '1', Timezone: 'asia/kolkata', CandidateId: '20');});
    }
  }
}