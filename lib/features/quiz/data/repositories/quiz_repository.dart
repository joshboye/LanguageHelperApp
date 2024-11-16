import 'package:stimuler_task_app/features/quiz/domain/models/exercises.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/node.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/options.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/questions.dart';

class QuizRepository {
  List<Node> fetchQuizData() {
    return [
      Node(
        title: "Adjectives",
        exercises: [
          Exercise(
            title: "Compound Adjectives",
            questions: [
              Question(
                text: "The company implemented a _ security protocol for their data centers.",
                options: [
                  Option(text: "cutting-edge", isCorrect: true),
                  Option(text: "cutting edge", isCorrect: false),
                  Option(text: "edge-cutting", isCorrect: false),
                  Option(text: "edge cutting", isCorrect: false),
                ],
                correctOption: Option(text: "cutting-edge", isCorrect: true),
              ),
              Question(
                text: "The physicist presented a _ theory about quantum entanglement.",
                options: [
                  Option(text: "ground breaking", isCorrect: false),
                  Option(text: "ground-breaking", isCorrect: true),
                  Option(text: "breaking-ground", isCorrect: false),
                  Option(text: "break-grounding", isCorrect: false),
                ],
                correctOption: Option(text: "ground-breaking", isCorrect: true),
              ),
              Question(
                text: "The expedition required _ equipment for the harsh Antarctic conditions.",
                options: [
                  Option(text: "military grade", isCorrect: false),
                  Option(text: "military-grade", isCorrect: true),
                  Option(text: "grade-military", isCorrect: false),
                  Option(text: "grade military", isCorrect: false),
                ],
                correctOption: Option(text: "military-grade", isCorrect: true),
              ),
            ],
          ),
          Exercise(
            title: "Participle Adjectives",
            questions: [
              Question(
                text: "The _ evidence presented at the trial changed the jury's perspective.",
                options: [
                  Option(text: "overwhelming", isCorrect: true),
                  Option(text: "overwhelmed", isCorrect: false),
                  Option(text: "overwhelm", isCorrect: false),
                  Option(text: "overwhelms", isCorrect: false),
                ],
                correctOption: Option(text: "overwhelming", isCorrect: true),
              ),
              Question(
                text: "The archaeologists discovered a _ manuscript in the ancient temple.",
                options: [
                  Option(text: "fascinated", isCorrect: false),
                  Option(text: "fascinating", isCorrect: true),
                  Option(text: "fascinate", isCorrect: false),
                  Option(text: "fascinates", isCorrect: false),
                ],
                correctOption: Option(text: "fascinating", isCorrect: true),
              ),
            ],
          ),
          Exercise(
            title: "Order of Adjectives",
            questions: [
              Question(
                text: "She purchased a _ briefcase for her new job.",
                options: [
                  Option(text: "leather expensive Italian", isCorrect: false),
                  Option(text: "Italian expensive leather", isCorrect: false),
                  Option(text: "expensive Italian leather", isCorrect: true),
                  Option(text: "expensive leather Italian", isCorrect: false),
                ],
                correctOption: Option(text: "expensive Italian leather", isCorrect: true),
              ),
              Question(
                text: "The museum displayed a _ artifact from the Ming Dynasty.",
                options: [
                  Option(text: "porcelain ancient valuable", isCorrect: false),
                  Option(text: "valuable ancient porcelain", isCorrect: true),
                  Option(text: "ancient valuable porcelain", isCorrect: false),
                  Option(text: "porcelain valuable ancient", isCorrect: false),
                ],
                correctOption: Option(text: "valuable ancient porcelain", isCorrect: true),
              ),
            ],
          ),
        ],
      ),
      Node(
        title: "Adverbs",
        exercises: [
          Exercise(
            title: "Adverbs of Manner in Complex Sentences",
            questions: [
              Question(
                text: "The soprano _ executed the challenging aria, earning a standing ovation.",
                options: [
                  Option(text: "flawless", isCorrect: false),
                  Option(text: "flawlessly", isCorrect: true),
                  Option(text: "flawlessness", isCorrect: false),
                  Option(text: "flawlessing", isCorrect: false),
                ],
                correctOption: Option(text: "flawlessly", isCorrect: true),
              ),
              Question(
                text: "The quantum computer _ processed the complex algorithms, surpassing traditional computing methods.",
                options: [
                  Option(text: "efficient", isCorrect: false),
                  Option(text: "efficiency", isCorrect: false),
                  Option(text: "efficiently", isCorrect: true),
                  Option(text: "efficienting", isCorrect: false),
                ],
                correctOption: Option(text: "efficiently", isCorrect: true),
              ),
            ],
          ),
          Exercise(
            title: "Comparative and Superlative Adverbs",
            questions: [
              Question(
                text: "Among all the competitors, Sarah completed the triathlon _ than expected.",
                options: [
                  Option(text: "more impressively", isCorrect: true),
                  Option(text: "more impressive", isCorrect: false),
                  Option(text: "most impressively", isCorrect: false),
                  Option(text: "impressive", isCorrect: false),
                ],
                correctOption: Option(text: "more impressively", isCorrect: true),
              ),
              Question(
                text: "The financial analysis was presented _ of all the quarterly reports.",
                options: [
                  Option(text: "more comprehensively", isCorrect: false),
                  Option(text: "most comprehensively", isCorrect: true),
                  Option(text: "more comprehensive", isCorrect: false),
                  Option(text: "comprehensive", isCorrect: false),
                ],
                correctOption: Option(text: "most comprehensively", isCorrect: true),
              ),
              Question(
                text: "The AI system performed _ in the latest benchmarking tests.",
                options: [
                  Option(text: "more sophisticated", isCorrect: false),
                  Option(text: "sophisticatedly", isCorrect: false),
                  Option(text: "most sophisticatedly", isCorrect: true),
                  Option(text: "sophisticated", isCorrect: false),
                ],
                correctOption: Option(text: "most sophisticatedly", isCorrect: true),
              ),
            ],
          ),
        ],
      ),
      Node(
        title: "Conjunctions",
        exercises: [
          Exercise(
            title: "Correlative Conjunctions",
            questions: [
              Question(
                text: "_ did the research paper receive acclaim for its methodology, _ it was praised for its innovative conclusions.",
                options: [
                  Option(text: "Not only / but also", isCorrect: true),
                  Option(text: "Either / or", isCorrect: false),
                  Option(text: "Neither / nor", isCorrect: false),
                  Option(text: "Both / and", isCorrect: false),
                ],
                correctOption: Option(text: "Not only / but also", isCorrect: true),
              ),
              Question(
                text: "_ the quantum theory _ the string theory could fully explain the observed phenomena.",
                options: [
                  Option(text: "Both / and", isCorrect: false),
                  Option(text: "Either / or", isCorrect: false),
                  Option(text: "Neither / nor", isCorrect: true),
                  Option(text: "Not only / but also", isCorrect: false),
                ],
                correctOption: Option(text: "Neither / nor", isCorrect: true),
              ),
            ],
          ),
          Exercise(
            title: "Subordinating Conjunctions in Academic Context",
            questions: [
              Question(
                text: "The experiment yielded unexpected results _ the researchers followed the protocol precisely.",
                options: [
                  Option(text: "although", isCorrect: true),
                  Option(text: "because", isCorrect: false),
                  Option(text: "unless", isCorrect: false),
                  Option(text: "if", isCorrect: false),
                ],
                correctOption: Option(text: "although", isCorrect: true),
              ),
              Question(
                text: "The archaeological team will continue excavating _ they find evidence of the ancient civilization.",
                options: [
                  Option(text: "unless", isCorrect: false),
                  Option(text: "until", isCorrect: true),
                  Option(text: "while", isCorrect: false),
                  Option(text: "whereas", isCorrect: false),
                ],
                correctOption: Option(text: "until", isCorrect: true),
              ),
            ],
          ),
        ],
      ),
      Node(
        title: "Prefix Suffix",
        exercises: [
          Exercise(
            title: "Scientific and Academic Prefixes",
            questions: [
              Question(
                text: "The scientist presented an _ theory on the origin of dark matter.",
                options: [
                  Option(text: "un", isCorrect: false),
                  Option(text: "pre", isCorrect: false),
                  Option(text: "sub", isCorrect: true),
                  Option(text: "anti", isCorrect: false),
                ],
                correctOption: Option(text: "sub", isCorrect: true),
              ),
              Question(
                text: "The historical manuscript was _ translated from Latin to English.",
                options: [
                  Option(text: "re", isCorrect: false),
                  Option(text: "un", isCorrect: true),
                  Option(text: "mis", isCorrect: false),
                  Option(text: "anti", isCorrect: false),
                ],
                correctOption: Option(text: "un", isCorrect: true),
              ),
            ],
          ),
          Exercise(
            title: "Common Suffixes",
            questions: [
              Question(
                text: "The _ experiment validated the theoretical model proposed by the physicists.",
                options: [
                  Option(text: "scientifically", isCorrect: true),
                  Option(text: "scientific", isCorrect: false),
                  Option(text: "science", isCorrect: false),
                  Option(text: "scientist", isCorrect: false),
                ],
                correctOption: Option(text: "scientifically", isCorrect: true),
              ),
              Question(
                text: "The mathematician presented a _ solution to the complex differential equation.",
                options: [
                  Option(text: "mathematic", isCorrect: false),
                  Option(text: "mathematician", isCorrect: false),
                  Option(text: "mathematically", isCorrect: true),
                  Option(text: "mathematicianly", isCorrect: false),
                ],
                correctOption: Option(text: "mathematically", isCorrect: true),
              ),
            ],
          ),
        ],
      ),
      Node(
        title: "Sentence Structure",
        exercises: [
          Exercise(
            title: "Inverted Sentence Structures",
            questions: [
              Question(
                text: "_ the revolutionary technology that the potential for clean energy became apparent.",
                options: [
                  Option(text: "Not until the scientists developed", isCorrect: true),
                  Option(text: "Until the scientists developed", isCorrect: false),
                  Option(text: "The scientists developed until", isCorrect: false),
                  Option(text: "Developed the scientists until", isCorrect: false),
                ],
                correctOption: Option(text: "Not until the scientists developed", isCorrect: true),
              ),
              Question(
                text: "_ the complex theories of quantum physics lies a simple mathematical principle.",
                options: [
                  Option(text: "Beneath", isCorrect: true),
                  Option(text: "Under", isCorrect: false),
                  Option(text: "Below", isCorrect: false),
                  Option(text: "Underneath of", isCorrect: false),
                ],
                correctOption: Option(text: "Beneath", isCorrect: true),
              ),
            ],
          ),
          Exercise(
            title: "Parallel Structure in Complex Sentences",
            questions: [
              Question(
                text: "The research involved _ data, analyzing statistical patterns, and presenting conclusions.",
                options: [
                  Option(text: "to collect", isCorrect: false),
                  Option(text: "collecting", isCorrect: true),
                  Option(text: "collection of", isCorrect: false),
                  Option(text: "collected", isCorrect: false),
                ],
                correctOption: Option(text: "collecting", isCorrect: true),
              ),
              Question(
                text: "The CEO's strategy was _, innovative, and transformative.",
                options: [
                  Option(text: "being bold", isCorrect: false),
                  Option(text: "to be bold", isCorrect: false),
                  Option(text: "bold", isCorrect: true),
                  Option(text: "boldly", isCorrect: false),
                ],
                correctOption: Option(text: "bold", isCorrect: true),
              ),
            ],
          ),
        ],
      ),
      Node(
        title: "Verbs",
        exercises: [
          Exercise(
            title: "Perfect Progressive Tenses",
            questions: [
              Question(
                text: "By next year, the scientists _ on this project for a decade.",
                options: [
                  Option(text: "will have been working", isCorrect: true),
                  Option(text: "will be working", isCorrect: false),
                  Option(text: "would have been working", isCorrect: false),
                  Option(text: "would be working", isCorrect: false),
                ],
                correctOption: Option(text: "will have been working", isCorrect: true),
              ),
              Question(
                text: "The AI system _ increasingly complex patterns before the anomaly was detected.",
                options: [
                  Option(text: "had been recognizing", isCorrect: true),
                  Option(text: "has been recognizing", isCorrect: false),
                  Option(text: "was recognizing", isCorrect: false),
                  Option(text: "is recognizing", isCorrect: false),
                ],
                correctOption: Option(text: "had been recognizing", isCorrect: true),
              ),
            ],
          ),
          Exercise(
            title: "Modal Perfect Verbs",
            questions: [
              Question(
                text: "The experiment _ different results if the temperature had been controlled more precisely.",
                options: [
                  Option(text: "might yield", isCorrect: false),
                  Option(text: "might have yielded", isCorrect: true),
                  Option(text: "must yield", isCorrect: false),
                  Option(text: "must have yielded", isCorrect: false),
                ],
                correctOption: Option(text: "might have yielded", isCorrect: true),
              ),
              Question(
                text: "The research team _ the deadline, but the equipment malfunction caused delays.",
                options: [
                  Option(text: "could meet", isCorrect: false),
                  Option(text: "could have met", isCorrect: true),
                  Option(text: "should meet", isCorrect: false),
                  Option(text: "should have met", isCorrect: false),
                ],
                correctOption: Option(text: "could have met", isCorrect: true),
              ),
            ],
          ),
          Exercise(
            title: "Subjunctive Mood",
            questions: [
              Question(
                text: "The ethics committee recommended that the study _ immediately.",
                options: [
                  Option(text: "be terminated", isCorrect: true),
                  Option(text: "is terminated", isCorrect: false),
                  Option(text: "was terminated", isCorrect: false),
                  Option(text: "were terminated", isCorrect: false),
                ],
                correctOption: Option(text: "be terminated", isCorrect: true),
              ),
              Question(
                text: "The professor suggested that each student _ their own research methodology.",
                options: [
                  Option(text: "develops", isCorrect: false),
                  Option(text: "developed", isCorrect: false),
                  Option(text: "develop", isCorrect: true),
                  Option(text: "has developed", isCorrect: false),
                ],
                correctOption: Option(text: "develop", isCorrect: true),
              ),
            ],
          ),
        ],
      ),
    ];
  }
}
