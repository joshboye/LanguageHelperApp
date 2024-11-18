import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stimuler_task_app/core/providers/node_provider.dart';
import 'package:stimuler_task_app/features/home/presentation/providers/sheetprovider.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/node.dart';
import 'package:stimuler_task_app/features/quiz/presentation/provider/quiz_provider.dart';
import 'package:stimuler_task_app/features/quiz/widgets/option_button.dart';
import 'package:stimuler_task_app/routes.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final quizProvider = Provider.of<QuizProvider>(context, listen: false);
      final nodeProvider = Provider.of<NodeProvider>(context, listen: false);
      await quizProvider.loadQuizData();
      quizProvider.getCurrentNodeIndex(nodeProvider.nodeIndex);
      quizProvider.getCurrentExcersiseIndex(nodeProvider.selectedExcerciseIndex!);
      quizProvider.resetScore();
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final sheetProvider = Provider.of<SheetProvider>(context);
    final nodeProvider = Provider.of<NodeProvider>(context);

    // Define the dot color based on the quiz state
    Color dotColor = Colors.blue; // Default blue
    if (quizProvider.isAnswered) {
      dotColor = quizProvider.isSelectedOptionCorrect ? Colors.green : Colors.red;
    }

    return Scaffold(
      backgroundColor: Colors.black,
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
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          // Blurred dots background
          Positioned.fill(
            child: CustomPaint(
              painter: BlurredDotsPainter(dotColor),
            ),
          ),
          // Foreground content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                  child: LinearProgressIndicator(
                    value: quizProvider.questionProgress,
                    backgroundColor: Colors.grey.shade700,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  quizProvider.currentQuestion,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/images/question_image.png',
                    height: 250,
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    OptionButton(
                      optionName: 'A',
                      label: quizProvider.currentOptions[0].text,
                      color: quizProvider.selectedOptionIndex == 0
                          ? quizProvider.isSelectedOptionCorrect && quizProvider.isAnswered == true
                              ? Colors.green
                              : quizProvider.isSelectedOptionCorrect == false && quizProvider.isAnswered == true
                                  ? Colors.red
                                  : Colors.blue
                          : Colors.transparent,
                      onPressed: () {
                        quizProvider.selectOption(0);
                      },
                    ),
                    const SizedBox(height: 20),
                    OptionButton(
                      optionName: 'B',
                      label: quizProvider.currentOptions[1].text,
                      color: quizProvider.selectedOptionIndex == 1
                          ? quizProvider.isSelectedOptionCorrect && quizProvider.isAnswered == true
                              ? Colors.green
                              : quizProvider.isSelectedOptionCorrect == false && quizProvider.isAnswered == true
                                  ? Colors.red
                                  : Colors.blue
                          : Colors.transparent,
                      onPressed: () {
                        quizProvider.selectOption(1);
                      },
                    ),
                    const SizedBox(height: 20),
                    OptionButton(
                      optionName: 'C',
                      label: quizProvider.currentOptions[2].text,
                      color: quizProvider.selectedOptionIndex == 2
                          ? quizProvider.isSelectedOptionCorrect && quizProvider.isAnswered == true
                              ? Colors.green
                              : quizProvider.isSelectedOptionCorrect == false && quizProvider.isAnswered == true
                                  ? Colors.red
                                  : Colors.blue
                          : Colors.transparent,
                      onPressed: () {
                        quizProvider.selectOption(2);
                      },
                    ),
                    const SizedBox(height: 20),
                    // Check Answer Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: OutlinedButton(
                        onPressed: quizProvider.selectedOptionIndex != null
                            ? () async {
                                quizProvider.isCorrect();
                                await Future.delayed(const Duration(seconds: 2));
                                if (quizProvider.isSelectedOptionCorrect) {
                                  quizProvider.incrementScore();
                                }
                                quizProvider.nextQuestion();
                                quizProvider.resetSelection();
                                if (quizProvider.isLastQuestion) {
                                  sheetProvider.setNodeIndex(null);
                                  Navigator.pushNamed(context, AppRoutes.home, arguments: nodeProvider.username);
                                }
                              }
                            : null,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: quizProvider.selectedOptionIndex != null
                              ? (quizProvider.isSelectedOptionCorrect && quizProvider.isAnswered == true
                                  ? Colors.green
                                  : quizProvider.isSelectedOptionCorrect == false && quizProvider.isAnswered == true
                                      ? Colors.red
                                      : Colors.blue)
                              : const Color.fromARGB(255, 68, 66, 66),
                          side: const BorderSide(color: Colors.transparent),
                        ),
                        child: Text(
                          quizProvider.selectedOptionIndex != null
                              ? (quizProvider.isSelectedOptionCorrect && quizProvider.isAnswered == true
                                  ? "Good Work!"
                                  : quizProvider.isSelectedOptionCorrect == false && quizProvider.isAnswered == true
                                      ? "That Wasn't Right"
                                      : "Check Answer")
                              : "Check Answer",
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for blurred dots
class BlurredDotsPainter extends CustomPainter {
  final Color dotColor;

  BlurredDotsPainter(this.dotColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor.withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);

    // Draw two dots
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.3), 100, paint);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.7), 120, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
