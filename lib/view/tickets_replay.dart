import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_hr/contoller/ticket_replay_controller.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/model/ticket_details.dart';
import 'package:max_hr/widgets/header_with_back.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class TicketsReplay extends StatefulWidget {
  int ticketId;

  TicketsReplay(this.ticketId);

  @override
  State<TicketsReplay> createState() => _TicketsReplayState();
}

class _TicketsReplayState extends State<TicketsReplay> {

  TicketReplayController ticketReplayController = Get.put(TicketReplayController());

  IO.Socket? socket;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ticketReplayController.initPage(widget.ticketId);
    // Dart client
    print('connection');
    socket = IO.io('http://3.112.123.226:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    if(!socket!.connected){
      socket!.connect();
      socket!.onConnect((_) {
        print('Connection established');
      });
      socket!.on('typing', (data) => addTyping(data));
      socket!.on('chat-message', (data) => addMsg(data));
      socket!.on('end-typing', (data) => ticketReplayController.typing(false));

      socket!.onDisconnect((_) => print('Connection Disconnection'));
      socket!.onConnectError((err) => Get.back());
      socket!.onError((err) => Get.back());
    }

  }

  addMsg(String data){
    if(int.parse(data.split(":::")[4])==Global.employee!.eId){
      ticketReplayController.ticketsDetailsDecoder!.ticketReplay.add(
          TicketReplay(trId: -1, fromEId: int.parse(data.split(":::")[1]),
              toEId: Global.employee!.eId,
              ticketId: ticketReplayController.ticketsDetailsDecoder!.ticketDetails.ticketId,
              msg: data.split(":::")[0],
              createdAt: DateTime.now(),
              toEmployee: Global.employee!.name,
              fromEmployee: data.split(":::")[2],
              toEmployeeImage: Global.employee!.image,
              fromEmployeeImage: data.split(":::")[3]));
          ticketReplayController.typing(false);
          ticketReplayController.scrollToEnd();
    }

  }

  @override
  void dispose() {
    socket!.dispose();
    // ticketReplayController.scrollController.dispose();
    super.dispose();
  }
  
  Color leftColor = Color(0xffefefef);
  Color rightColor = Color(0xffe8f1f3);

  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() => SizedBox(
          width: Get.width,
          child:Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: App.bgGrey,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 25,
                          spreadRadius: 2,
                          offset: const Offset(0, 3)
                      )
                    ]
                ),
                width: Get.width,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    HeaderBack(hasNotification: false),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              ticketReplayController.fake.value?Center():Center(),
              SizedBox(height: 30,),
              Expanded(
                child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Expanded(
                          child:
                          ticketReplayController.loading.value?App.loading(context)
                          :ListView.builder(
                            controller: ticketReplayController.scrollController,
                              itemCount: ticketReplayController.ticketsDetailsDecoder!.ticketReplay.length,
                              itemBuilder: (context , index){
                                if(ticketReplayController.ticketsDetailsDecoder!.ticketReplay[index].fromEId == Global.employee!.eId){
                                  return rightCard(ticketReplayController.ticketsDetailsDecoder!.ticketReplay[index]);
                                }else{
                                  return leftCard(ticketReplayController.ticketsDetailsDecoder!.ticketReplay[index]);
                                }
                              }
                          ),
                        ),
                        ticketReplayController.typing.value?Row(
                          children: [
                            Container(
                              width: 67,
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.symmetric(vertical: 6),
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                              decoration: BoxDecoration(
                                  color: leftColor,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Text("typing.."),
                            ),
                          ],
                        ):Center(),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: Get.width - 20,
                          height: 45,
                          decoration: BoxDecoration(
                            // color: Colors.red,
                              border: Border.all(color: Color(0xffa8abad)),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              Expanded(
                                child: TextField(
                                  controller: ticketReplayController.msg,
                                  decoration: InputDecoration(
                                      border: InputBorder.none
                                  ),
                                  onChanged: (text) {
                                    if (!_isWriting){
                                      _isWriting = true;
                                      typingSocket();
                                      Future.delayed(Duration(seconds: 2)).whenComplete((){
                                        _isWriting = false;
                                        endTypingSocket();
                                      });
                                    }
                                  },

                                ),
                              ),
                              SizedBox(width: 5,),
                              GestureDetector(
                                onTap: (){
                                  sendMSG();
                                },
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      color: App.primary,
                                      borderRadius: Global.locale == "en"
                                          ?BorderRadius.horizontal(right: Radius.circular(7))
                                          :BorderRadius.horizontal(left: Radius.circular(7))
                                  ),
                                  child: Icon(Icons.send),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                ),
              ),





            ],
          ),
        )),
      ),
    );
  }
  leftCard(TicketReplay ticketsReplay){
    return Container(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
          decoration: BoxDecoration(
              color: leftColor,
              borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: Image.network(Api.media_url+ticketsReplay.fromEmployeeImage,width: 35,errorBuilder: ( context, exception, stackTrace) {
                      return Icon(Icons.person,size: 35,color: App.grey1,);
                    },),
                  ),
                  SizedBox(width: 5,),
                  Text(ticketsReplay.fromEmployee,style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
              Text(ticketsReplay.msg)
            ],
          ),
        ),
      ),
    );
  }
  rightCard(TicketReplay ticketsReplay){
    return Container(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
          decoration: BoxDecoration(
              color: ticketsReplay.isSent.value?
              rightColor:rightColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8)
          ),
          child: Text(ticketsReplay.msg),
        ),
      ),
    );
  }
  addTyping(data){
    if(int.parse(data) == Global.employee!.eId){
      ticketReplayController.typing(true);
    }
  }
  typingSocket(){
    socket!.emit('typing',ticketReplayController.ticketsDetailsDecoder!.ticketDetails.mentionTo == Global.employee!.eId?ticketReplayController.ticketsDetailsDecoder!.ticketDetails.eId:ticketReplayController.ticketsDetailsDecoder!.ticketDetails.mentionTo);
  }
  endTypingSocket(){
    socket!.emit('end-typing',ticketReplayController.ticketsDetailsDecoder!.ticketDetails.mentionTo == Global.employee!.eId?ticketReplayController.ticketsDetailsDecoder!.ticketDetails.eId:ticketReplayController.ticketsDetailsDecoder!.ticketDetails.mentionTo);
  }
  sendMSG(){
    String msgData = '';
    if(ticketReplayController.msg.text.isNotEmpty){
      msgData = ticketReplayController.msg.text+":::";
      msgData += Global.employee!.eId.toString()+":::";
      msgData += Global.employee!.name.toString()+":::";
      msgData += Global.employee!.image.toString()+":::"+(Global.employee!.eId == ticketReplayController.ticketsDetailsDecoder!.ticketDetails.eId?ticketReplayController.ticketsDetailsDecoder!.ticketDetails.mentionTo.toString():ticketReplayController.ticketsDetailsDecoder!.ticketDetails.eId.toString());
      socket!.emit('chat-message',msgData);
      TicketReplay ticketReplay = TicketReplay(
          trId: -1, fromEId: Global.employee!.eId,
          toEId: (Global.employee!.eId == ticketReplayController.ticketsDetailsDecoder!.ticketDetails.eId?ticketReplayController.ticketsDetailsDecoder!.ticketDetails.mentionTo:ticketReplayController.ticketsDetailsDecoder!.ticketDetails.eId),
          ticketId: ticketReplayController.ticketsDetailsDecoder!.ticketDetails.ticketId,
          msg: ticketReplayController.msg.text,
          createdAt: DateTime.now(),
          toEmployee: "", fromEmployee: Global.employee!.name,
          toEmployeeImage: "", fromEmployeeImage: Global.employee!.image);
      ticketReplayController.sendMsg(ticketReplay);
      ticketReplayController.ticketsDetailsDecoder!.ticketReplay.add(ticketReplay);
      ticketReplayController.scrollToEnd();
      ticketReplayController.msg.clear();
    }

  }
}
