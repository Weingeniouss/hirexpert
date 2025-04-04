// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, non_constant_identifier_names, prefer_const_constructors_in_immutables, avoid_print, sort_child_properties_last, use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hirexpert/view/utils/API_Key.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hirexpert/view/utils/app_color.dart';
import 'package:hirexpert/view/utils/app_loder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../../controller/API_Controller/Candidate/Massge/ChatList_Controller.dart';
import '../../../../../controller/API_Controller/Candidate/Massge/sendMessage_Controller.dart';
import '../../../../utils/appUrl.dart';
import '../../../../utils/app_constance.dart';
import '../../../../utils/app_icon.dart';

class Message_sent extends StatefulWidget {
  final String username; final String techname; final String image; final String chatrromId; final String Jobidmasg; final String MSenderId; final String ReceiverID; final String SenderID;

  Message_sent({
    super.key, required this.username, required this.image, required this.chatrromId, required this.Jobidmasg, required this.MSenderId, required this.ReceiverID, required this.SenderID, required this.techname,
  });

  @override
  State<Message_sent> createState() => _Message_sentState();
}

class _Message_sentState extends State<Message_sent> {
  File? _image;
  File? _document;

  final SendmessageController sentmegs = Get.put(SendmessageController());
  final ChatlistController chatListing = Get.put(ChatlistController());
  final ImagePicker picker = ImagePicker();
  final WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(AppUrl.WebSocket));
  final TextEditingController textController = TextEditingController();
  final RxList<Map<String, String>> messages = <Map<String, String>>[].obs;
  final String timestamp = DateFormat('hh:mm a').format(DateTime.now());

  final ScrollController scrollController = ScrollController();

  final MessageController Imagecontroller = Get.put(MessageController());

  String? previousDate;

  @override
  void initState() {
    super.initState();
    chatListing.Chatlistcontroller_fuction(ReceiverId: widget.ReceiverID, JobId: widget.Jobidmasg, RoomId: widget.Jobidmasg, Tokan: Tokans, Page: '1', Timezone: 'asia/kolkata', CandidateId: Candidate);
    scrollToBottom();
  }

 void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }

    sendImageMessage(_image!).then((_) {
      chatListing.Chatlistcontroller_fuction(ReceiverId: widget.ReceiverID, JobId: widget.Jobidmasg, RoomId: widget.Jobidmasg, Tokan: Tokans, Page: '1', Timezone: 'asia/kolkata', CandidateId: Candidate);
    }).catchError((error) {
      print('Failed to send image: $error');
    });
  }

  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc', 'docx', 'txt']);

    if (result != null) {
      setState(() {
        _document = File(result.files.single.path!);
      });

      sendDocumentMessage(_document!).then((_) {
        chatListing.Chatlistcontroller_fuction(ReceiverId: widget.ReceiverID, JobId: widget.Jobidmasg, RoomId: widget.Jobidmasg, Tokan: Tokans, Page: '1', Timezone: 'asia/kolkata', CandidateId: Candidate);
      });
    } else {
      print("No document selected");
    }
  }

  Future<void> sendImageMessage(File image) async {
    const String url = AppUrl.setmsg;
    const String apiKey = API_KEY.key;
    const String clientIp = Clientip.ip;
    String loginToken = Tokans;

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll({'API-KEY': apiKey, 'Clientip': clientIp, 'Logintoken': loginToken})
        ..fields.addAll({
          'RoomId': widget.chatrromId,
          'IsCandidate': Candidate,
          'EmpCanId': 'Candidate',
          'JobId': widget.Jobidmasg,
          'MsgType': 'Image',
          'Message': ''
        });

      // Ensure the file is properly attached
      if (await image.exists()) {
        request.files.add(await http.MultipartFile.fromPath('FileImage[]', image.path));
      } else {
        print("⚠️ File not found at path: ${image.path}");
        return;
      }

      print("📨 Sending request to: $url");
      print("🔑 Headers: ${request.headers}");
      print("📌 Fields: ${request.fields}");
      print("📎 File: ${image.path}");

      // Send the request and handle the response
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print("✅ Message Sent Successfully: $responseData");
      } else {
        print("❌ Failed to send message. Status: ${response.statusCode}, Response: $responseData");
      }
    } catch (e) {
      print("⚠️ Error while sending message: $e");
    }
    scrollToBottom();
  }

  Future<void> sendDocumentMessage(File document) async {
    const String url = AppUrl.setmsg;
    const String apiKey = API_KEY.key;
    const String clientIp = Clientip.ip;
    String loginToken = Tokans;

    try {
      // File type validation
      List<String> allowedExtensions = ['pdf', 'doc', 'docx', 'ppt', 'pptx'];
      List<String> disallowedExtensions = ['png', 'jpg', 'jpeg', 'gif'];
      String fileExtension = document.path.split('.').last.toLowerCase();

      if (disallowedExtensions.contains(fileExtension)) {
        print("🚫 This file type is not allowed: .$fileExtension");
        return;
      }

      if (!allowedExtensions.contains(fileExtension)) {
        print("⚠️ Only PDF, Word, and PPT files are allowed.");
        return;
      }

      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll({'API-KEY': apiKey, 'Clientip': clientIp, 'Logintoken': loginToken})
        ..fields.addAll({
          'RoomId': widget.chatrromId,
          'IsCandidate': Candidate,
          'EmpCanId': 'Candidate',
          'JobId': widget.Jobidmasg,
          'MsgType': 'Document',
          'Message': ''
        });

      // Ensure the file is properly attached
      if (await document.exists()) {
        request.files.add(await http.MultipartFile.fromPath('FileImage[]', document.path));
      } else {
        print("⚠️ File not found at path: ${document.path}");
        return;
      }

      print("📨 Sending request to: $url");
      print("🔑 Headers: ${request.headers}");
      print("📌 Fields: ${request.fields}");
      print("📎 File: ${document.path}");

      // Send the request and handle the response
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print("✅ Document Sent Successfully: $responseData");
      } else {
        print("❌ Failed to send document. Status: ${response.statusCode}, Response: $responseData");
      }
    } catch (e) {
      print("⚠️ Error while sending document: $e");
    }
    scrollToBottom();
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
      final messageData = {
        'text': text,
        'timestamp': DateFormat('hh:mm a').format(DateTime.now()),
        'senderId': widget.SenderID,
        'receiverId': widget.ReceiverID,
        'chatroomId': widget.chatrromId,
        'msgType': 'Text'
      };

      // Add message locally
      messages.add({'text': text, 'timestamp': messageData['timestamp']!});
      textController.clear();

      try {
        channel.sink.add(messageData.toString());
      } catch (e) {
        print('Failed to send message via WebSocket: $e');
      }

      // Call API to send message
      sentmegs.SendmessageController_Fuction(Tokan: Tokans, RoomId: widget.Jobidmasg, JobIds: widget.Jobidmasg, ReceiverId: widget.ReceiverID, MsgType: 'Text', MSenderId: widget.MSenderId, Message: text)
          .then((_) {
        chatListing.Chatlistcontroller_fuction(ReceiverId: widget.ReceiverID, JobId: widget.Jobidmasg, RoomId: widget.Jobidmasg, Tokan: Tokans, Page: '1', Timezone: 'asia/kolkata', CandidateId: Candidate);
      }).then((_){
        scrollToBottom();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.Textfild_color, surfaceTintColor: AppColor.Textfild_color,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.transparent, contentPadding: EdgeInsets.zero,
                    content: Container(
                      height: Get.height / 3, width: Get.width,
                      decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(widget.image), fit: BoxFit.cover)),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: Get.height / 25, width: double.infinity, alignment: Alignment.center,
                              color: Colors.black.withOpacity(0.4),
                              child: Text(widget.username, style: TextStyle(fontSize: Get.width / 25, color: AppColor.Full_body_color)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Row(
              children: [
                CircleAvatar(radius: 22, backgroundImage: AssetImage(widget.image)),
                SizedBox(width: Get.width / 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.username, style: TextStyle(fontSize: Get.width / 25, color: AppColor.black_all)),
                    Text(widget.techname, style: TextStyle(fontSize: Get.width / 27, color: AppColor.subcolor)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: Get.height, width: Get.width, decoration: BoxDecoration(color: AppColor.Full_body_color),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (chatListing.isloding.value) {return Center(child: Lottie.asset(AppLoder.noData));}
                final data = chatListing.ChatlistController_data?['data'];
                if (data == null || data.isEmpty) {return Center(child: Text('No messages found.'));}

                scrollToBottom();

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
                  child: ListView.builder(
                    controller: scrollController, shrinkWrap: true, itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {

                      final messageData = data[index];
                      final message = messageData['Message'];
                      final msgType = messageData['MsgType'];
                      final entryDate = messageData['EntryDate'];

                      String currentDate = formatRelativeDate(entryDate);
                      bool showDate = previousDate != currentDate;
                      previousDate = currentDate;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showDate)
                            Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: Text(currentDate, style: TextStyle(color: AppColor.subcolor, fontWeight: FontWeight.bold)))),
                          if (msgType == 'Image' && message != null)
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Align(
                                      alignment: Alignment.bottomRight,
                                      child: AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        content: Container(
                                          width: Get.width, height: Get.height / 3,
                                          decoration: BoxDecoration(border: Border.all(color: AppColor.Button_color, width: 3)),
                                          child: Image.network(message, fit: BoxFit.cover),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Align(
                                alignment: messageData['SenderId'] == widget.SenderID ? Alignment.centerRight : Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: Get.height / 80),
                                    Container(child: Image.network(message, height: Get.height / 5, width: Get.width / 2, fit: BoxFit.cover), decoration: BoxDecoration(border: Border.all(color: AppColor.Button_color, width: 5))),
                                    Text(formatTime(entryDate), style: TextStyle(color: AppColor.subcolor)),
                                    SizedBox(height: Get.height / 60),
                                  ],
                                ),
                              ),
                            ),
                          if (msgType == 'Text' && message != null)
                            Align(
                              alignment: messageData['SenderId'] == widget.SenderID ? Alignment.centerRight : Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(color: messageData['SenderId'] == widget.SenderID ? AppColor.Button_color : AppColor.Button_color2, borderRadius: BorderRadius.circular(15)),
                                      child: Text(message, style: TextStyle(color: AppColor.Full_body_color)),
                                  ),
                                  Text(formatTime(entryDate), style: TextStyle(color: AppColor.subcolor)),
                                  SizedBox(height: Get.height / 50),
                                ],
                              ),
                            ),
                          if (msgType == 'Document' && message.endsWith('.pdf'))
                            Align(
                              alignment: messageData['SenderId'] == widget.SenderID ? Alignment.centerRight : Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PDFViewerScreen(pdfUrl: message))),
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(color: AppColor.Button_color, borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.picture_as_pdf, color: Colors.red), SizedBox(width: 8),
                                          Text("View PDF", style: TextStyle(color: AppColor.Full_body_color)),
                                        ],
                                      ),
                                      Text(formatTime(entryDate), style: TextStyle(color: AppColor.subcolor)),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                  ),
                                  width: Get.width / 2,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 20, vertical: Get.height / 50),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onSubmitted: sendMessage,
                      decoration: InputDecoration(
                        prefixIcon: Padding(padding: EdgeInsets.all(13), child: SvgPicture.asset(AppIcons.Write)),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: Get.height / 6, width: Get.width,
                                    decoration: BoxDecoration(color: AppColor.Full_body_color),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Get.width / 3),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            child: Icon(Icons.camera_alt, color: AppColor.subcolor),
                                            onTap: () {
                                              _pickImage(); Get.back();
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _pickDocument(); Get.back();
                                            },
                                            child: Icon(Icons.file_open_sharp, color: AppColor.subcolor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Icon(Icons.attach_file, color: AppColor.subcolor),
                        ),
                        filled: true,
                        fillColor: AppColor.offButton_color,
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.Textfild_color)),
                        hintText: 'Write something here...',
                        border: OutlineInputBorder(borderSide: BorderSide(color: AppColor.Textfild_color)),
                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.Textfild_color)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.Textfild_color)),
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width / 60),
                  Container(
                      height: Get.height / 15, width: Get.width / 7,
                      decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(Get.width / 50), color: AppColor.Button_color),
                      child: IconButton(icon: Icon(Icons.send, color: AppColor.Full_body_color), onPressed: () => sendMessage(textController.text)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PDFViewerScreen extends StatefulWidget {
  final String pdfUrl;

  PDFViewerScreen({required this.pdfUrl});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      final dir = await getTemporaryDirectory();
      final file = File("${dir.path}/temp.pdf");
      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        localPath = file.path;
      });
    } catch (e) {
      print("Error loading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Viewer")),
      body: localPath != null ? PDFView(filePath: localPath!) : Center(child: CircularProgressIndicator()),
    );
  }
}
