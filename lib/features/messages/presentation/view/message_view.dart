import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify_app/core/routing/app_router.dart';
import '../../../lectures/presentation/view/widgets/lecture_card.dart';
import '../../data/models/messages_model.dart';

class MessageView extends StatelessWidget {
  MessageView({super.key});
  final List<MessagesModel> lectures = [
    MessagesModel(
      title: "Dr : ehab gamil",
      subTitle: "hello",
      image: "assets/images/Rectangle 23870-3.png",
      time: "14:49",
      
    ),
    MessagesModel(
      title: "Dr : saeed mohamed ",
      subTitle: "hello",
      image: "assets/images/Rectangle 23870-3.png",
      time: "14:49",
    ),
    MessagesModel(
      title: "Dr : ali medhat",
      subTitle: "hello",
      image: "assets/images/Rectangle 23870-3.png",
      time: "14:49",
    ),
    MessagesModel(
      title: "Dr : omar elfarouk",
      subTitle: "hello",
      image: "assets/images/Rectangle 23870-3.png",
      time: "14:49",
    ),
    MessagesModel(
      title: "Dr : mohamed saeed",
      subTitle: "hello",
      image: "assets/images/Rectangle 23870-3.png",
      time: "14:49",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lectures.length,
      itemBuilder: (context, index) {
        final message = lectures[index];
        return LectureCard(
          title: message.title,
          subtitle: message.subTitle,
          imagePath: message.image,
          isMessageCard: true,
          time: message.time,
          onTap: () {
            context.go(AppRouter.chatPath);
          },
        );
      },
    );
  }
}
