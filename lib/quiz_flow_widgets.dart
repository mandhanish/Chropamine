import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'learning_data.dart';

class QuizFlowWidget extends StatelessWidget {
  final PageController pageController;
  final int currentQuizIndex;
  final int secondsRemaining;
  final bool isTimedOut;
  final String schemeTitle;
  final List<QuizQuestion> questions;
  final List<int?> selectedAnswers;
  final int sessionEarnedKeys;
  final int alreadyEarnedKeys;
  final Function(int questionIdx, int optionIdx) onAnswerSelected;
  final VoidCallback onRetryLearning;
  final VoidCallback onResetQuiz;
  final VoidCallback onFinish;

  const QuizFlowWidget({
    super.key,
    required this.pageController,
    required this.currentQuizIndex,
    required this.secondsRemaining,
    required this.isTimedOut,
    required this.schemeTitle,
    required this.questions,
    required this.selectedAnswers,
    required this.sessionEarnedKeys,
    required this.alreadyEarnedKeys,
    required this.onAnswerSelected,
    required this.onRetryLearning,
    required this.onResetQuiz,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    final formattedTimer = '00:${secondsRemaining.toString().padLeft(2, '0')}';

    return Column(
      children: [
        // Header Kuis
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.blur_on, size: 20, color: Colors.black87),
                    SizedBox(width: 6),
                    Text('Chropamine',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4),
                child:
                    const Icon(Icons.person, size: 22, color: Colors.black87),
              ),
            ],
          ),
        ),

        // Progress Bar & Timer
        if (currentQuizIndex < 3) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: List.generate(3, (idx) {
                return Expanded(
                  child: Container(
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: idx <= currentQuizIndex
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  schemeTitle,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
                Text(
                  formattedTimer,
                  style: TextStyle(
                    color: secondsRemaining <= 5
                        ? Colors.yellowAccent
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],

        // PageView Soal Kuis (0, 1, 2) & Result Screen (3)
        Expanded(
          child: PageView.builder(
            controller: pageController,
            physics: (currentQuizIndex < 3 &&
                    selectedAnswers[currentQuizIndex] == null)
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, pageIndex) {
              if (pageIndex == 3) {
                return _buildCongratsScreen(context);
              }

              final q = questions[pageIndex];
              final hasAnswered = selectedAnswers[pageIndex] != null;
              final selectedOpt = selectedAnswers[pageIndex];

              return SingleChildScrollView(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 18, bottom: 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      q.question,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Pilihan Jawaban
                    ...List.generate(q.options.length, (optIdx) {
                      Color buttonBg = Colors.white;
                      Color textColor = Colors.black87;

                      if (hasAnswered) {
                        if (optIdx == q.correctIndex) {
                          buttonBg = const Color(0xFF00E676);
                          textColor = Colors.white;
                        } else if (selectedOpt == optIdx) {
                          buttonBg = const Color(0xFFD50000);
                          textColor = Colors.white;
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonBg,
                              foregroundColor: textColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            onPressed: () =>
                                onAnswerSelected(pageIndex, optIdx),
                            child: Text(
                              q.options[optIdx],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                          ),
                        ),
                      );
                    }),

                    // Penjelasan & Hint Swipe
                    if (hasAnswered) ...[
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          q.explanation,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.4,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Swipe right to continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward_ios,
                              size: 12, color: Colors.white),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCongratsScreen(BuildContext context) {
    final alreadyMax = alreadyEarnedKeys >= 3;
    final keysToAdd =
        alreadyMax ? 0 : math.max(0, sessionEarnedKeys - alreadyEarnedKeys);

    String resultTitle;
    String resultSubtitle;

    if (isTimedOut) {
      resultTitle = "Time's Up!";
      resultSubtitle = "You ran out of time. Give it another shot!";
    } else if (sessionEarnedKeys == 3) {
      resultTitle = "Flawless!";
      resultSubtitle = "Outstanding! You mastered the $schemeTitle scheme!";
    } else if (sessionEarnedKeys == 2) {
      resultTitle = "Well Done!";
      resultSubtitle =
          "Great effort! You secured 2 keys. One more to perfection!";
    } else if (sessionEarnedKeys == 1) {
      resultTitle = "Keep Practicing!";
      resultSubtitle = "Good start! You got 1 key. Try again to collect more!";
    } else {
      resultTitle = "Don't Give Up!";
      resultSubtitle =
          "You didn't get any keys this round. Review the materials and retry!";
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              resultTitle,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 38,
              child: Text(
                resultSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.92),
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                isTimedOut
                    ? Icons.timer_off_rounded
                    : (sessionEarnedKeys == 3
                        ? Icons.emoji_events_rounded
                        : Icons.lightbulb_outline_rounded),
                size: 64,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 68,
              child: Center(
                child: alreadyMax
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'You already got all 3 keys for this scheme!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              final isKeyUnlocked = index < sessionEarnedKeys;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Icon(
                                  Icons.vpn_key_rounded,
                                  size: 32,
                                  color: isKeyUnlocked
                                      ? const Color(0xFFFFD700)
                                      : Colors.white24,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            keysToAdd > 0
                                ? '+$keysToAdd new key${keysToAdd > 1 ? "s" : ""} added to your collection!'
                                : (isTimedOut
                                    ? 'No keys earned due to timeout'
                                    : '$sessionEarnedKeys of 3 keys earned'),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: const BorderSide(color: Colors.white38),
                          ),
                        ),
                        onPressed: onRetryLearning,
                        child: const Text(
                          'Retry Learning',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: onResetQuiz,
                        child: const Text(
                          'Retry Quiz',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: onFinish,
                    child: const Text(
                      'Next',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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
