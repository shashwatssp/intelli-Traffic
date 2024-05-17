import 'package:flutter/material.dart';
import 'package:langchain_openai/langchain_openai.dart';

class AskQuestionScreen extends StatefulWidget {
  const AskQuestionScreen({Key? key}) : super(key: key);

  @override
  _AskQuestionScreenState createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  TextEditingController _textEditingController = TextEditingController();
  String _answer = '';

  void _askQuestion() async {
    final message = _textEditingController.text;

    final langChainOpenAI = ChatOpenAI(
      apiKey: "SECRET",
      defaultOptions: const ChatOpenAIOptions(temperature: 0),
    );

    final prompt =
        "The user will ask questions about traffic or this app in general, answer them in short:\n\n";

    List<String> feedback = [
      message,
      message
    ]; // Assuming feedback is a list of strings

    // Convert feedback strings to ChatMessage objects
    List<ChatMessage> chatMessages =
        feedback.map((fb) => ChatMessage.humanText(fb)).toList();

    final result =
        await langChainOpenAI([ChatMessage.humanText(prompt), ...chatMessages]);

    // Extracting the summary text from the response
    final summaryText = result.content.toString();

    setState(() {
      _answer = "$context $summaryText";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask a Question'),
      ),
      body: Column(
        children: [
          // Container to display the answer
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: _answer.isEmpty
                ? Text('No answer yet.')
                : Text(
                    _answer,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                // Text input field for user to ask question
                TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Ask your question...',
                  ),
                ),
                const SizedBox(height: 10),
                // Button to ask question
                ElevatedButton(
                  onPressed: _askQuestion,
                  child: const Text('Ask'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
