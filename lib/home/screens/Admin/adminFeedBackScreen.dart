import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intel_traffic/Backend/cloud_firebase_methods.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';

class AdminFeedbackScreen extends ConsumerStatefulWidget {
  const AdminFeedbackScreen({Key? key}) : super(key: key);

  @override
  _AdminFeedbackScreenState createState() => _AdminFeedbackScreenState();
}

class _AdminFeedbackScreenState extends ConsumerState<AdminFeedbackScreen> {
  late Future<String> _summaryFuture = Future.value('');

  @override
  void initState() {
    super.initState();
    _summaryFuture = _generateSummary();
  }

 Future<String> _generateSummary() async {
  final feedback = await CloudFirestoreClass().fetchAllFeedback();
  final langChainOpenAI = ChatOpenAI(
    apiKey: "SECRET",
    defaultOptions: const ChatOpenAIOptions(temperature: 0),
  );

  final prompt =
      "Users are facing problems related to traffic challans or the mobile app. Please summarize the feedback below:\n\n";

 
  final chunkSize = 2048;

  
  final chunks = <String>[];
  for (var i = 0; i < feedback.length; i += chunkSize) {
    final chunk = feedback.sublist(i, i + chunkSize).join(' ');
    chunks.add(chunk);
  }

  
  final summaries = <String>[];
  for (var chunk in chunks) {
    final result = await langChainOpenAI([ChatMessage.humanText(prompt), ChatMessage.humanText(chunk)]);
    
   
    final summary = result.content.toString().split(' ').take(20).join(' ');
    summaries.add(summary);
  }

 
  final combinedSummary = summaries.join('\n');

  
  

  return "$combinedSummary";
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Powered Feedback'),
      ),
      body: FutureBuilder<String>(
        future: _summaryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final summary = snapshot.data;
            if (summary != null && summary.isNotEmpty) {
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    summary,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: 100, // Limiting to 10 lines
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            } else {
              return const Center(child: Text('No summary found.'));
            }
          }
        },
      ),
    );
  }
}
