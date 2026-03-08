import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'home_screen.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final int maxScore;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.maxScore,
  });

  /// Calculates the percentage score (0.0 to 1.0)
  double get scorePercent => score / maxScore;

  /// Returns classification details based on score
  _ClassificationResult get classification {
    if (scorePercent >= 0.85) {
      return _ClassificationResult(
        title: 'خبير سياسي',
        description:
            'أنت تمتلك وعياً سياسياً متميزاً ومعرفة عميقة بالنظام السياسي الأردني. '
            'انخراطك في الشأن العام سيُحدث فارقاً حقيقياً في مجتمعك.',
        emoji: '🏆',
        color: AppColors.expertAwareness,
        badgeIcon: Icons.workspace_premium_rounded,
      );
    } else if (scorePercent >= 0.60) {
      return _ClassificationResult(
        title: 'مواطن واعٍ',
        description:
            'لديك وعي سياسي جيد وتفهم جوانب مهمة في النظام السياسي. '
            'تعمّق أكثر في القضايا السياسية لتطوير معرفتك.',
        emoji: '👍',
        color: AppColors.highAwareness,
        badgeIcon: Icons.thumb_up_rounded,
      );
    } else if (scorePercent >= 0.35) {
      return _ClassificationResult(
        title: 'في طريق التعلّم',
        description:
            'معرفتك السياسية في مراحلها الأولى. الاهتمام بالأخبار والقراءة '
            'عن النظام السياسي الأردني ستساعدك كثيراً.',
        emoji: '📚',
        color: AppColors.mediumAwareness,
        badgeIcon: Icons.menu_book_rounded,
      );
    } else {
      return _ClassificationResult(
        title: 'مبتدئ سياسي',
        description:
            'لا بأس! البداية دائماً من الصفر. ابدأ بالتعرف على النظام السياسي الأردني '
            'ومؤسساته وستُلاحظ الفرق بسرعة.',
        emoji: '🌱',
        color: AppColors.lowAwareness,
        badgeIcon: Icons.spa_rounded,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cl = classification;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Header sliver
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: cl.color,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildResultHeader(cl),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Score breakdown card
                  _buildScoreCard(cl),
                  const SizedBox(height: 20),
                  // Classification description
                  _buildDescriptionCard(cl),
                  const SizedBox(height: 20),
                  // Score breakdown stats
                  _buildStatsRow(),
                  const SizedBox(height: 32),
                  // Action buttons
                  _buildRetryButton(context),
                  const SizedBox(height: 12),
                  _buildHomeButton(context),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultHeader(_ClassificationResult cl) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cl.color, cl.color.withOpacity(0.7)],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(
              cl.emoji,
              style: const TextStyle(fontSize: 56),
            ),
            const SizedBox(height: 12),
            Text(
              cl.title,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'نتيجة اختبارك',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(_ClassificationResult cl) {
    return Card(
      elevation: 4,
      shadowColor: cl.color.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$score',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: cl.color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    ' / $maxScore',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 22,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: scorePercent,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(cl.color),
                minHeight: 12,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${(scorePercent * 100).toStringAsFixed(0)}٪',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: cl.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard(_ClassificationResult cl) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'تقييمك',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cl.description,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.7,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cl.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(cl.badgeIcon, color: cl.color, size: 28),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.quiz_rounded,
            label: 'عدد الأسئلة',
            value: '$totalQuestions',
            color: AppColors.primaryLight,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.stars_rounded,
            label: 'نقاطك',
            value: '$score',
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.bar_chart_rounded,
            label: 'أعلى نقطة',
            value: '$maxScore',
            color: AppColors.expertAwareness,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const QuizScreen()),
          );
        },
        icon: const Icon(Icons.refresh_rounded),
        label: const Text(
          'إعادة الاختبار',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context) {
    return SizedBox(
      height: 54,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        },
        icon: const Icon(Icons.home_rounded),
        label: const Text(
          'الصفحة الرئيسية',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

class _ClassificationResult {
  final String title;
  final String description;
  final String emoji;
  final Color color;
  final IconData badgeIcon;

  _ClassificationResult({
    required this.title,
    required this.description,
    required this.emoji,
    required this.color,
    required this.badgeIcon,
  });
}
