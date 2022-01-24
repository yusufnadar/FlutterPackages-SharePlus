import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  File? files;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Plus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Yazı yazınız',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result != null) {
                  files = File(result.files.single.path!);
                }
              },
              child: const Text('Fotoğraf Yükle'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.isEmpty) {
                  print('Boş bırakmayınız');
                } else {
                  await Share.share(controller.text);
                }
              },
              child: const Text('Yazı Paylaş'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.isEmpty && files != null) {
                  print('Boş bırakmayınız');
                } else {
                  await Share.shareFiles([files!.path],text: controller.text);
                }
              },
              child: const Text('Fotoğraf Paylaş'),
            )
          ],
        ),
      ),
    );
  }
}
