// ignore_for_file: non_constant_identifier_names, avoid_print, unused_field, unused_import

import 'package:get/get.dart';
import 'package:hirexpert/controller/API_Controller/Candidate/Massge/ChatRoomExist_Controller.dart';
import 'package:uuid/uuid.dart';
import '../../../../view/screen/Candidate/Menu/message/Message.dart';
import '../../../../view/screen/Candidate/Menu/message/Message_sent.dart';
import '../../../../view/utils/app_constance.dart';
import '../../../API_Controller/Candidate/Massge/SetMagList_Controller.dart';

class MessageControllers extends GetxController {
  var selectedValue = ''.obs;
  SetmaglistController Setmag = Get.put(SetmaglistController());
  ChatroomexistController Chatroomexist = Get.put(ChatroomexistController());

  var listing = [
    'View all communications that are not related to any particular job.',
    'View all communications that are related to any particular job.',
  ];

  var selectedValues = 'View all communications that are not related to any particular job'.obs;

  final Uuid uuid = Uuid();

  String getChatRoomId(String senderId, String receiverId) {
    if (senderId.compareTo(receiverId) > 0) {
      return "${receiverId}_$senderId";
    } else {
      return "${senderId}_$receiverId";
    }
  }

  void Dropdown(String? newValue) {
    if (newValue != null) {
      selectedValue.value = newValue; // Update the selected value
    }
  }


  void ChatList(int index) {
    Chatroomexist.ChatroomexistController_Fuction(Tokan: Tokans, ReceiverId: Setmag.Setmaglist_data['data'][index]['ReceiverId'], SenderId: Setmag.Setmaglist_data['data'][index]['SenderId']);

     // String chatRoomId = getChatRoomId(senderId, receiverId);

    print("Generated Chat Room ID: ${Chatroomexist.Chatroomexist_data['data']['RoomId']}");
    print({Chatroomexist.ChatroomexistController_Fuction(Tokan: Tokans, ReceiverId: Setmag.Setmaglist_data['data'][index]['ReceiverId'],SenderId: Setmag.Setmaglist_data['data'][index]['SenderId'])});

    Get.to(
      () => Message_sent(
        username: Setmag.Setmaglist_data['data'][index]['JobTitle'],
        image: Setmag.Setmaglist_data['data'][index]['ComLogo'],
        chatrromId: Chatroomexist.Chatroomexist_data['data']['RoomId'],
        Jobidmasg: Setmag.Setmaglist_data['data'][index]['JobId'],
        MSenderId: Setmag.Setmaglist_data['data'][index]['MSenderId'],
        ReceiverID: Setmag.Setmaglist_data['data'][index]['ReceiverId'],
        SenderID: Setmag.Setmaglist_data['data'][index]['SenderId'],
        techname: Setmag.Setmaglist_data['data'][index]['TechName'],
      ),
    );
    update();
  }

  @override
  void onInit() {
    Setmag.Setmaglist_Fuction(Page: '1', Timezone: 'asia/kolkata', Tokan: Tokans);
    super.onInit();
  }
}
