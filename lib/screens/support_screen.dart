import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';

import '../data/model/chat_message.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  List<ChatMessage> messages = [

    ChatMessage(messageContent: "Здравстуйте! Мы разбираемся со сложившейся ситуацией и скоро напишим вам.", messageType: "receiver"),
    ChatMessage(messageContent: "В моем последнем заказе не привезли яблоки", messageType: "sender"),
  ];

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();


  Future<void> addSupportAnswer() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        messages.insert(0, ChatMessage(messageContent: "Здравстуйте! Мы разбираемся со сложившейся ситуацией и скоро напишим вам.", messageType: "receiver"));
      });
      if (_scrollController.hasClients) {
        const position = 0.0;
        _scrollController.jumpTo(position);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: const AppBarWidget(
            title: 'Поддержка',
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  reverse: true,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                      child: Align(
                        alignment: (messages[index].messageType == "receiver" ? Alignment.topLeft : Alignment.topRight),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: messages[index].messageType == "receiver" ? Colors.grey.shade200 :
                          const Color(0xffbdf5ad)),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, bottom: 15, top: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                        boxShadow: [BoxShadow(color: Colors.grey.shade500, blurRadius: 20, offset: const Offset(0, 10))]),
                    height: 70,
                    width: double.infinity,
                    // color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20,
                        ),
                         Expanded(
                          child: TextField(
                            controller: _textController,
                            decoration: const InputDecoration(hintText: "Напишите сообщение...", hintStyle: TextStyle(color: Colors.black54), border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            if (_textController.text.isNotEmpty) {
                              setState(() {
                                messages.insert(0, ChatMessage(messageContent: _textController.text, messageType: "sender"));
                              });
                              addSupportAnswer();
                              _textController.clear();
                              if (_scrollController.hasClients) {
                                const position = 0.0;
                                _scrollController.jumpTo(position);
                              }
                            }
                          },
                          backgroundColor: Colors.blue,
                          elevation: 0,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
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
      ),
    );
  }
}
