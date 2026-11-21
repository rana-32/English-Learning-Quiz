class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text("Progress"), backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Level Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF4F46E5)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("LEVEL 1", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 5),
                  const Text("5 XP", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const LinearProgressIndicator(value: 0.1, backgroundColor: Colors.white24, color: Colors.white, minHeight: 8),
                  ),
                  const SizedBox(height: 8),
                  const Text("0 - 250 XP to level 2", style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatBox(context, Icons.local_fire_department, "1", "Day Streak", Colors.orange),
                _buildStatBox(context, Icons.emoji_events, "1", "Best Streak", Colors.amber),
                _buildStatBox(context, Icons.book, "0", "Words", Colors.green),
              ],
            ),
            const SizedBox(height: 20),

            // Details Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF252536) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isDark ? [] : [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Column(
                children: [
                  _buildDetailRow(context, Icons.menu_book, "Lessons completed", "0"),
                  const Divider(height: 30, color: Colors.grey),
                  _buildDetailRow(context, Icons.quiz, "Quizzes completed", "1"),
                  const Divider(height: 30, color: Colors.grey),
                  _buildDetailRow(context, Icons.track_changes, "Average quiz score", "67%"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Weekly Activity
            const Text("Weekly Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF252536) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isDark ? [] : [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ["M", "T", "W", "T", "F", "S", "S"].map((day) {
                  return Column(
                    children: [
                      Container(
                        height: 50,
                        width: 12,
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF3A3A4C) : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(day, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(BuildContext context, IconData icon, String value, String label, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 100,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252536) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: isDark ? [] : [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String title, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: const Color(0xFF6366F1).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: const Color(0xFF6366F1), size: 20),
        ),
        const SizedBox(width: 15),
        Text(title, style: const TextStyle(fontSize: 15)),
        const Spacer(),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}
