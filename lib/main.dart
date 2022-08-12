import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:read_aloud_app/Utils/pick_document.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  FlutterTts flutterTts = FlutterTts();

  void stop() async {
    await flutterTts.stop();
  }

  void speak({String? text}) async {
    await flutterTts.setLanguage("en-US");
    // await flutterTts.setVolume(1.0);

    try {
      await flutterTts.speak(text!);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read Aloud"),
        actions: [
          IconButton(
              onPressed: () {
                stop();
              },
              icon: const Icon(Icons.stop)),
          IconButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  speak(text: controller.text.trim());
                }
              },
              icon: const Icon(Icons.mic))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: TextFormField(
          controller: controller,
          maxLines: MediaQuery.of(context).size.height.toInt(),
          decoration: const InputDecoration(
              border: InputBorder.none, label: Text("Text to read...")),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          pickDocument().then((value) async {
            debugPrint(value);
            if (value != '') {
              PDFDoc doc = await PDFDoc.fromPath(value);

              final text = await doc.text;

              controller.text = text;
            }
          });
        },
        label: const Text("Pick from Pdf"),
      ),
    );
  }
}
