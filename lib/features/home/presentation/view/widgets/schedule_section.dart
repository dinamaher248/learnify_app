import 'package:flutter/material.dart';
import 'package:learnify_app/core/utils/assets.dart';
import 'package:learnify_app/features/home/presentation/view/widgets/row_show.dart';

class ScheduleSection extends StatelessWidget {
  const ScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [RowShow(title: "Schedule :", subTitle: "Show All")],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true, 
                  builder: (context) {
                    return Scaffold(
                      backgroundColor: Colors.black,
                      appBar: AppBar(
                        backgroundColor: Colors.black,
                        iconTheme: const IconThemeData(color: Colors.white),
                        elevation: 0,
                      ),
                      body: Center(
                        child: InteractiveViewer(
                          panEnabled: true,
                          minScale: 0.5,
                          maxScale: 4.0,
                          child: Hero(
                            tag: 'schedule_img', 
                            child: Image.asset(AppAssets.schedule_image),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            child: Hero(
              tag: 'schedule_img',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(AppAssets.schedule_image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}