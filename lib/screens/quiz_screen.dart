import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/question_model.dart';
import '../theme/app_colors.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int _totalScore = 0;
  int? _selectedOptionIndex;
  bool _hasAnswered = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<QuestionModel> _questions = quizQuestions;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectOption(int index) {
    if (_hasAnswered) return;
    setState(() {
      _selectedOptionIndex = index;
      _hasAnswered = true;
      _totalScore += _questions[_currentQuestionIndex].options[index].points;
    });
  }

  void _nextQuestion() {
    if (!_hasAnswered) return;
    if (_currentQuestionIndex < _questions.length - 1) {
      _animationController.reset();
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
        _hasAnswered = false;
      });
      _animationController.forward();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            score: _totalScore,
            totalQuestions: _questions.length,
            maxScore: _questions.length * 3,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('اختبار الوعي السياسي'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 8.0),
            child: Center(
              child: Text(
                '${_currentQuestionIndex + 1}/${_questions.length}',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar
          _buildProgressBar(progress),
          Expanded(
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Score chip
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _buildScoreChip(),
                      ),
                      const SizedBox(height: 16),
                      // Question card
                      _buildQuestionCard(question),
                      const SizedBox(height: 20),
                      // Answer options
                      ...List.generate(
                        question.options.length,
                        (index) => _buildOptionButton(
                          index,
                          question.options[index],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Next button
                      if (_hasAnswered)
                        _buildNextButton(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'السؤال ${_currentQuestionIndex + 1} من ${_questions.length}',
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white24,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.accentLight),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.stars_rounded,
            color: AppColors.primary,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            'النقاط: $_totalScore',
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(QuestionModel question) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'سؤال ${_currentQuestionIndex + 1}',
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            question.questionText,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.6,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(int index, AnswerOption option) {
    Color borderColor = AppColors.optionBorder;
    Color bgColor = AppColors.optionDefault;
    Color textColor = AppColors.textPrimary;
    IconData? trailingIcon;
    Color iconColor = Colors.transparent;

    if (_hasAnswered && _selectedOptionIndex == index) {
      bgColor = AppColors.optionSelected;
      borderColor = AppColors.optionSelected;
      textColor = Colors.white;
      trailingIcon = Icons.check_circle_rounded;
      iconColor = Colors.white;
    } else if (_hasAnswered) {
      bgColor = AppColors.background;
      borderColor = AppColors.optionBorder.withOpacity(0.5);
      textColor = AppColors.textSecondary;
    }

    return GestureDetector(
      onTap: () => _selectOption(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: _hasAnswered && _selectedOptionIndex == index
              ? [
                  BoxShadow(
                    color: AppColors.optionSelected.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Leading index label
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: _hasAnswered && _selectedOptionIndex == index
                    ? Colors.white.withOpacity(0.2)
                    : AppColors.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  _optionLabel(index),
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: _hasAnswered && _selectedOptionIndex == index
                        ? Colors.white
                        : AppColors.primary,
                  ),
                ),
              ),
            ),
            // Option text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  option.text,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            // Trailing icon
            if (trailingIcon != null)
              Icon(trailingIcon, color: iconColor, size: 22)
            else
              const SizedBox(width: 22),
          ],
        ),
      ),
    );
  }

  String _optionLabel(int index) {
    const labels = ['أ', 'ب', 'ج', 'د'];
    return labels[index % labels.length];
  }

  Widget _buildNextButton() {
    final bool isLast = _currentQuestionIndex == _questions.length - 1;
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: _nextQuestion,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLast ? 'عرض النتيجة' : 'السؤال التالي',
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              isLast
                  ? Icons.emoji_events_rounded
                  : Icons.arrow_forward_ios_rounded,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
