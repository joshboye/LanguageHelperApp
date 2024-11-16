import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stimuler_task_app/features/quiz/presentation/provider/quiz_provider.dart';
import 'package:stimuler_task_app/features/quiz/widgets/option_button.dart';

class QuizScreen extends StatefulWidget {
  final int nodeIndex;
  final int selectedButtonIndex;

  const QuizScreen({
    super.key,
    required this.nodeIndex,
    required this.selectedButtonIndex,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quizProvider = Provider.of<QuizProvider>(context, listen: false);
      quizProvider.loadQuizData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        title: const Text(
          "Grammar Practice",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black, // Set AppBar background color to black
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thicker progress indicator
            SizedBox(
              height: 10, // Make the progress bar thicker
              child: LinearProgressIndicator(
                value: 0.6, // Change this value dynamically to show progress
                backgroundColor: Colors.grey.shade700,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
            const SizedBox(height: 20),
            // Question text
            Text(
              quizProvider.currentQuestion,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            // Image
            Center(
              child: Image.asset(
                'assets/images/question_image.png', // Replace with your image path
                height: 250,
              ),
            ),
            const Spacer(),
            // Buttons
            Column(
              children: [
                OptionButton(
                  optionName: 'A',
                  label: quizProvider.currentOptions[0].text,
                  color: Colors.transparent,
                  onPressed: () {
                    quizProvider.selectOption(1);
                    // Add action for Option 1
                  },
                ),
                const SizedBox(height: 20),
                OptionButton(
                  optionName: 'B',
                  color: Colors.transparent,
                  label: quizProvider.currentOptions[1].text,
                  onPressed: () {
                    quizProvider.selectOption(2);
                    // Add action for Option 2
                  },
                ),
                const SizedBox(height: 20),
                OptionButton(
                  optionName: 'C',
                  color: Colors.transparent,
                  label: quizProvider.currentOptions[2].text,
                  onPressed: () {
                    quizProvider.selectOption(3);
                    // Add action for Option 3
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () {
                      // Add action for Option 4
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 68, 66, 66),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                    child: const Text(
                      "Check Answer",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
