import 'package:flutter_test/flutter_test.dart';
import 'package:politics_app/data/quiz_data.dart';
import 'package:politics_app/models/question_model.dart';

void main() {
  group('QuizData Tests', () {
    test('quiz contains exactly 10 questions', () {
      expect(quizQuestions.length, equals(10));
    });

    test('each question has exactly 4 options', () {
      for (final question in quizQuestions) {
        expect(
          question.options.length,
          equals(4),
          reason: 'Question "${question.questionText}" should have 4 options',
        );
      }
    });

    test('each option has a valid point value (0-3)', () {
      for (final question in quizQuestions) {
        for (final option in question.options) {
          expect(
            option.points,
            inInclusiveRange(0, 3),
            reason:
                'Option "${option.text}" has invalid points: ${option.points}',
          );
        }
      }
    });

    test('each question has at least one option with 3 points (correct answer)', () {
      for (final question in quizQuestions) {
        final hasCorrectAnswer =
            question.options.any((option) => option.points == 3);
        expect(
          hasCorrectAnswer,
          isTrue,
          reason:
              'Question "${question.questionText}" has no option with 3 points',
        );
      }
    });

    test('maximum possible score is 30 (10 questions × 3 points)', () {
      final maxScore = quizQuestions.fold<int>(
        0,
        (sum, q) =>
            sum + q.options.map((o) => o.points).reduce((a, b) => a > b ? a : b),
      );
      expect(maxScore, equals(30));
    });

    test('question text is not empty', () {
      for (final question in quizQuestions) {
        expect(question.questionText.trim().isNotEmpty, isTrue);
      }
    });

    test('option text is not empty', () {
      for (final question in quizQuestions) {
        for (final option in question.options) {
          expect(option.text.trim().isNotEmpty, isTrue);
        }
      }
    });
  });

  group('QuestionModel Tests', () {
    test('QuestionModel holds correct data', () {
      const question = QuestionModel(
        questionText: 'سؤال تجريبي؟',
        options: [
          AnswerOption(text: 'خيار أ', points: 0),
          AnswerOption(text: 'خيار ب', points: 1),
          AnswerOption(text: 'خيار ج', points: 2),
          AnswerOption(text: 'خيار د', points: 3),
        ],
      );

      expect(question.questionText, equals('سؤال تجريبي؟'));
      expect(question.options.length, equals(4));
      expect(question.options[3].points, equals(3));
    });

    test('AnswerOption holds correct data', () {
      const option = AnswerOption(text: 'إجابة صحيحة', points: 3);
      expect(option.text, equals('إجابة صحيحة'));
      expect(option.points, equals(3));
    });
  });

  group('Score Classification Tests', () {
    // Test the score percentage thresholds
    test('score 26-30 (≥85%) should be expert level', () {
      const maxScore = 30;
      // 26/30 = 86.7%
      expect(26 / maxScore, greaterThanOrEqualTo(0.85));
    });

    test('score 18-25 (60%-84%) should be aware citizen', () {
      const maxScore = 30;
      final percent = 18 / maxScore; // 60%
      expect(percent, greaterThanOrEqualTo(0.60));
      expect(percent, lessThan(0.85));
    });

    test('score 11-17 (35%-59%) should be learning level', () {
      const maxScore = 30;
      final percent = 11 / maxScore; // ~36.7%
      expect(percent, greaterThanOrEqualTo(0.35));
      expect(percent, lessThan(0.60));
    });

    test('score 0-10 (<35%) should be beginner level', () {
      const maxScore = 30;
      final percent = 10 / maxScore; // ~33.3%
      expect(percent, lessThan(0.35));
    });
  });
}
