import 'package:flutter/material.dart';
import 'package:quiz_app/pages/score_page.dart';
import 'package:quiz_app/ui/answer_button.dart';
import 'package:quiz_app/ui/answer_result_overlay.dart';
import 'package:quiz_app/ui/question_text.dart';
import 'package:quiz_app/utils/question.dart';
import 'package:quiz_app/utils/quiz.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz = new Quiz([
    Question("Elon musk is human", false),
    Question("Pizz is healthy", false),
    Question("Flutter is asesomen", true),
  ]);

  String questionText;
  int questionNumber;
  bool isCorrect;
  bool showOverlay = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestions;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionsNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      showOverlay = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          //This is our main page
          children: <Widget>[
            AnswerButton(true, () => handleAnswer(true)),
            QuestionText(questionText, questionNumber),
            AnswerButton(false, () => handleAnswer(false)),
          ],
        ),
        showOverlay == true
            ? AnswerResultOverlay(isCorrect, () {
                if (quiz.length == questionNumber) {
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ScorePage(quiz.score, quiz.length)),
                      (Route route) => route == null);
                  return;
                }

                currentQuestion = quiz.nextQuestions;
                this.setState(() {
                  showOverlay = false;
                  questionText = currentQuestion.question;
                  questionNumber = quiz.questionsNumber;
                });
              })
            : Container()
      ],
    );
  }
}
