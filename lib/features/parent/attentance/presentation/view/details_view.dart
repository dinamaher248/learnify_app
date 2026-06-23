import 'package:flutter/material.dart';

import '../../../../../core/utils/custom_widgets/app_bar_widget.dart';
import 'widgets/lecture_list_item.dart';


/// [showCheckboxes] flag:
/// - true  → renders checkboxes (e.g. Attendance Details)
/// - false → plain rows without trailing widget (default)
class DetailsView extends StatefulWidget {
  final bool showCheckboxes;

  const DetailsView({super.key, this.showCheckboxes = false});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  // Local check state — replace with BLoC/Cubit when integrating
  late final List<bool> _checked;

  final _lectures = List.generate(
    5,
    (i) => 'Lecture ${(i + 1).toString().padLeft(2, '0')}:',
  );

  @override
  void initState() {
    super.initState();
    // Only lecture 01 is pre-checked in the design
    _checked = List.generate(_lectures.length, (i) => i == 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const AppBarWidget(title: 'Details'),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _lectures.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return LectureListItem(
            title: _lectures[index],
            showCheckbox: widget.showCheckboxes,
            isChecked: _checked[index],
            onCheckChanged: widget.showCheckboxes
                ? (val) => setState(() => _checked[index] = val ?? false)
                : null,
          );
        },
      ),
    );
  }
}