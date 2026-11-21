class GrammarScreen extends StatelessWidget {
  const GrammarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grammar"), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SimpleCard(title: "Parts of Speech", desc: "Learn the eight parts of speech"),
          _SimpleCard(title: "Nouns", desc: "Names of people, places, things"),
          _SimpleCard(title: "Pronouns", desc: "Words that replace nouns"),
          _SimpleCard(title: "Verbs", desc: "Actions and states of being"),
          _SimpleCard(title: "Adjectives", desc: "Words that describe nouns"),
        ],
      ),
    );
  }
}

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vocabulary"), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SimpleCard(title: "Daily Life", desc: "Words you use every day"),
          _SimpleCard(title: "Education", desc: "Academic and classroom vocab"),
          _SimpleCard(title: "Business", desc: "Professional and corporate"),
          _SimpleCard(title: "Technology", desc: "Digital and tech vocabulary"),
        ],
      ),
    );
  }
}

class SentencesScreen extends StatelessWidget {
  const SentencesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sentences"), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SimpleCard(title: "Greetings", desc: "Basic greetings"),
          _SimpleCard(title: "Introducing Yourself", desc: "Tell people about you"),
          _SimpleCard(title: "Shopping", desc: "Buy things confidently"),
          _SimpleCard(title: "Travel", desc: "Travel related sentences"),
        ],
      ),
    );
  }
}

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Practice"), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SimpleCard(title: "Vocabulary Quiz", desc: "10 questions"),
          _SimpleCard(title: "Grammar Quiz", desc: "10 questions"),
          _SimpleCard(title: "Translation", desc: "5 questions"),
        ],
      ),
    );
  }
}

class _SimpleCard extends StatelessWidget {
  final String title;
  final String desc;
  const _SimpleCard({required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252536) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark ? [] : [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}
