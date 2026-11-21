class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Learn"), backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.1,
          children: [
            _buildModuleCard(context, "Vocabulary", "Learn words", Icons.menu_book, const VocabularyScreen()),
            _buildModuleCard(context, "Grammar", "Master rules", Icons.school, const GrammarScreen()),
            _buildModuleCard(context, "Sentences", "Everyday talk", Icons.chat, const SentencesScreen()),
            _buildModuleCard(context, "Practice", "Quizzes & tests", Icons.quiz, const PracticeScreen()),
            // AI Voice Feature
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VoiceFeatureScreen())),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF6366F1), width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: const Color(0xFF6366F1).withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.mic, color: Color(0xFF6366F1)),
                    ),
                    const SizedBox(height: 15),
                    const Text("AI Voice", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Text("Speak & Correct", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, String title, String subtitle, IconData icon, Widget destination) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destination)),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF252536) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isDark ? [] : [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: isDark ? const Color(0xFF1A1A24) : const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: isDark ? Colors.white70 : Colors.black54),
            ),
            const SizedBox(height: 15),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
