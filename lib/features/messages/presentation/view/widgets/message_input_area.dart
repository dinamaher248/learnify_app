import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class MessageInputArea extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onSend;
  final void Function(String filePath)? onFilePicked;   // PDF / أي ملف
  final void Function(String filePath)? onImagePicked;  // كاميرا / جاليري

  const MessageInputArea({
    super.key,
    this.controller,
    this.onSend,
    this.onFilePicked,
    this.onImagePicked,
  });

  // ── اختيار ملف (PDF أو أي نوع) ──
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'xlsx'],
    );
    if (result == null) return;
    final path = result.files.single.path;
    if (path != null) onFilePicked?.call(path);
  }

  // ── التقاط صورة من الكاميرا ──
  Future<void> _pickFromCamera() async {
    final picker = ImagePicker();
    final photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) onImagePicked?.call(photo.path);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF6C63FF), width: 1.5),
              ),
              child: Row(
                children: [
                  // ── زرار الملف ──
                  IconButton(
                    onPressed: _pickFile,
                    icon: const Icon(Icons.picture_as_pdf_outlined),
                    tooltip: 'إرسال ملف',
                  ),

                  // ── زرار الكاميرا ──
                  IconButton(
                    onPressed: _pickFromCamera,
                    icon: const Icon(Icons.camera_alt_outlined),
                    tooltip: 'التقاط صورة',
                  ),

                  // ── حقل النص ──
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),

          // ── زرار الإرسال ──
          Container(
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
              color: Color(0xFF6C63FF),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                final text = controller?.text ?? '';
                if (text.trim().isEmpty) return;
                onSend?.call(text.trim());
                controller?.clear();
              },
              icon: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}