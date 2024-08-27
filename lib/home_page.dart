import 'package:animate_do/animate_do.dart';
import 'package:buddyai/color.dart';
import 'package:buddyai/features.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:buddyai/openai_service.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  // ignore: use_super_parameters
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechTotext = SpeechToText();
  bool speechEnabled = false;
  final flutterTts = FlutterTts();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;
  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    speechEnabled = await speechTotext.initialize();
    setState(() {});
  }

  void initSpeech() async {
    await speechTotext.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechTotext.listen(onResult: onSpeechResult);
    setState(() {});
  }

  void stopListening() async {
    await speechTotext.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechTotext.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BounceInDown(child: const Text('BuddyAi')),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ZoomIn(
              child: Stack(
                children: [
                  Center(
                      child: Container(
                          height: 120,
                          width: 120,
                          margin: const EdgeInsets.only(top: 4),
                          decoration: const BoxDecoration(
                            color: MyColors.assistantCircleColor,
                            shape: BoxShape.circle,
                          ))),
                ],
              ),
            ),
            Container(
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                  'assets/images/image-circle.png',
                )),
              ),
            ),
            FadeInRight(
              child: Visibility(
                visible: generatedImageUrl == null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ).copyWith(
                    top: 30,
                  ),
                  decoration: BoxDecoration(
                    color: MyColors.borderColor,
                    borderRadius: BorderRadius.circular(20).copyWith(
                      topLeft: Radius.zero,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      generatedContent == null
                          ? 'Welcome to BuddyAi!. How can I help you?'
                          : generatedContent!,
                      style: TextStyle(
                        color: MyColors.mainFontColor,
                        fontSize: generatedContent == null ? 25 : 18,
                        fontFamily: 'Cera Pro',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (generatedImageUrl != null)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(generatedImageUrl!)),
              ),
            SlideInLeft(
              child: Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 10, left: 22),
                  child: const Text('Here are some features',
                      style: TextStyle(
                          fontSize: 20,
                          color: MyColors.mainFontColor,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            //features
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Column(children: [
                SlideInLeft(
                  delay: Duration(milliseconds: start),
                  child: const FeatureBox(
                    color: MyColors.firstSuggestionBoxColor,
                    title: 'ChatGPT',
                    description: 'A smarter way to stay informed with ChatGPT',
                  ),
                ),
                SlideInLeft(
                  delay: Duration(milliseconds: start + delay),
                  child: const FeatureBox(
                    color: MyColors.secondSuggestionBoxColor,
                    title: 'Dall-E',
                    description:
                        'Get Inspired and stay creative with your Personal assistant powered by Dall-E',
                  ),
                ),
                SlideInLeft(
                  delay: Duration(milliseconds: start + 2 * delay),
                  child: const FeatureBox(
                    color: MyColors.thirdSuggestionBoxColor,
                    title: 'Smart Voice Assistant',
                    description:
                        'Get the best of both words with voice assistant powered by Dall-E and ChatGPT',
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        delay: Duration(milliseconds: start + 3 * delay),
        child: FloatingActionButton(
          backgroundColor: MyColors.firstSuggestionBoxColor,
          onPressed: () async {
            if (await speechTotext.hasPermission &&
                speechTotext.isNotListening) {
              await startListening();
            } else if (speechTotext.isListening) {
              final speech = await openAIService.isArtPromoptAPI(lastWords);
              if (speech.contains('https')) {
                generatedImageUrl = speech;
                generatedContent = null;
                setState(() {});
              } else {
                generatedContent = speech;
                generatedImageUrl = null;
                setState(() {});
                await systemSpeak(speech);
              }

              stopListening();
            } else {
              initSpeechToText();
            }
          },
          child: Icon(speechTotext.isListening ? Icons.stop : Icons.mic),
        ),
      ),
    );
  }
}
