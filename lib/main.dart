import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

// ================= THEME NOTIFIER =================
class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

final themeNotifier = ThemeNotifier();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeNotifier,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'English Learner',
          themeMode: themeNotifier.themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF5F5F7),
            primaryColor: const Color(0xFF6366F1),
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            useMaterial3: true,
            cardColor: Colors.white,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF1A1A24),
            primaryColor: const Color(0xFF6366F1),
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            useMaterial3: true,
            cardColor: const Color(0xFF252536),
            appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, iconTheme: IconThemeData(color: Colors.white)),
          ),
          home: const MainNavigation(),
        );
      },
    );
  }
}

// ================= NAVIGATION =================
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const LearnScreen(),
    const ProgressScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: isDark ? const Color(0xFF151520) : Colors.white,
        indicatorColor: const Color(0xFF6366F1).withOpacity(0.2),
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.school), label: "Learn"),
          NavigationDestination(icon: Icon(Icons.show_chart), label: "Progress"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}

// ================= HOME SCREEN =================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.school, size: 30, color: Color(0xFF6366F1)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2D2D44) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: isDark ? [] : [BoxShadow(color: Colors.black12, blurRadius: 5)],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.local_fire_department, color: Colors.orange, size: 18),
                        SizedBox(width: 5),
                        Text("Streak", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Text("Good Morning,", style: TextStyle(fontSize: 16, color: isDark ? Colors.grey : Colors.black54)),
              const Text("Learner", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard(context, "Level", "5 XP", Icons.flash_on, Colors.purpleAccent),
                  _buildStatCard(context, "Day streak", "1", Icons.local_fire_department, Colors.orange),
                  _buildStatCard(context, "Words", "0", Icons.book, Colors.greenAccent),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF252536) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isDark ? [] : [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.3)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Word of the Day", style: TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Negotiate", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        Icon(Icons.volume_up, color: Colors.grey),
                      ],
                    ),
                    Text("/nɪˈɡoʊʃieɪt/", style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
                    SizedBox(height: 10),
                    Text("To discuss to reach an agreement.", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text("Continue Learning", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              _buildContinueCard(context, "Vocabulary", "Words for every day", Icons.menu_book),
              _buildContinueCard(context, "Grammar", "Master rules", Icons.school),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 100,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252536) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark ? [] : [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildContinueCard(BuildContext context, String title, String subtitle, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252536) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark ? [] : [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: isDark ? const Color(0xFF1A1A24) : const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: const Color(0xFF6366F1)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}

// ================= LEARN SCREEN =================
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

// ================= SIMPLE LIST SCREENS =================
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

// ================= PROGRESS SCREEN (NEW DESIGN) =================
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

// ================= SETTINGS SCREEN (NEW DESIGN & THEME) =================
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = themeNotifier.themeMode == ThemeMode.dark;
  bool soundEffects = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), backgroundColor: Colors.transparent, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("Appearance", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF252536) : Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: isDark ? [] : [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.palette, color: Color(0xFF6366F1)),
                  title: const Text("Theme"),
                  trailing: DropdownButton<String>(
                    value: isDarkMode ? "Dark" : "Light",
                    underline: Container(),
                    icon: const Icon(Icons.arrow_drop_down),
                    items: ["Light", "Dark"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        isDarkMode = newValue == "Dark";
                        themeNotifier.toggleTheme(isDarkMode);
                      });
                    },
                  ),
                ),
                const Divider(height: 1, indent: 60),
                SwitchListTile(
                  secondary: const Icon(Icons.volume_up, color: Color(0xFF6366F1)),
                  title: const Text("Sound effects"),
                  value: soundEffects,
                  activeColor: const Color(0xFF6366F1),
                  onChanged: (val) {
                    setState(() {
                      soundEffects = val;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const Text("Profile", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF252536) : Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: isDark ? [] : [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: const ListTile(
              title: Text("Your name", style: TextStyle(color: Colors.grey)),
            ),
          ),
          const SizedBox(height: 25),
          const Text("About", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF252536) : Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: isDark ? [] : [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: const ListTile(
              leading: Icon(Icons.info, color: Colors.blue),
              title: Text("Version"),
              trailing: Text("1.0.0", style: TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= AI VOICE FEATURE (OPTIMIZED) =================
class VoiceFeatureScreen extends StatefulWidget {
  const VoiceFeatureScreen({super.key});

  @override
  State<VoiceFeatureScreen> createState() => _VoiceFeatureScreenState();
}

class _VoiceFeatureScreenState extends State<VoiceFeatureScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final GoogleTranslator _translator = GoogleTranslator();

  bool _isListening = false;
  bool _isProcessing = false;
  String _recognizedText = "";
  String _bengaliTranslation = "";
  String _correctionSuggestion = "";
  String _statusMessage = "Tap the mic and speak in English...";

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) => debugPrint("Speech Status: $status"),
      onError: (error) => debugPrint("Speech Error: $error"),
    );
    if (!available) {
      setState(() => _statusMessage = "Speech recognition not available on this device.");
    }
  }

  void _listen() async {
    if (!_isListening) {
      setState(() {
        _isListening = true;
        _isProcessing = false;
        _recognizedText = "";
        _bengaliTranslation = "";
        _correctionSuggestion = "";
        _statusMessage = "Listening... Speak now";
      });

      bool available = await _speech.initialize();
      if (available) {
        _speech.listen(
          onResult: (val) async {
            setState(() => _recognizedText = val.recognizedWords);
            if (val.finalResult) {
              setState(() {
                _isListening = false;
                _isProcessing = true;
                _statusMessage = "Processing...";
              });
              await _processText(val.recognizedWords);
            }
          },
          listenFor: const Duration(seconds: 15),
          pauseFor: const Duration(seconds: 3),
          localeId: "en_US",
        );
      } else {
        setState(() {
          _isListening = false;
          _statusMessage = "Microphone not available. Check permissions.";
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> _processText(String text) async {
    if (text.trim().isEmpty) {
      setState(() {
        _isProcessing = false;
        _statusMessage = "No speech detected. Try again.";
      });
      return;
    }

    String suggestion = _checkGrammar(text);
    String translationText = "";
    try {
      var translation = await _translator.translate(text, from: 'en', to: 'bn');
      translationText = translation.text;
    } catch (e) {
      translationText = "Translation failed. Check internet connection.";
    }

    setState(() {
      _correctionSuggestion = suggestion;
      _bengaliTranslation = translationText;
      _isProcessing = false;
      _statusMessage = "Done! Tap mic to try again.";
    });
  }

  String _checkGrammar(String text) {
    String lowerText = text.toLowerCase();
    if (lowerText.contains("i is")) {
      return "❌ Correction: Use 'I am' instead of 'I is'.";
    }
    if (lowerText.contains("he go")) {
      return "❌ Correction: Use 'He goes' instead of 'He go'.";
    }
    if (lowerText.contains("she do")) {
      return "❌ Correction: Use 'She does' instead of 'She do'.";
    }
    if (lowerText.contains("they is")) {
      return "❌ Correction: Use 'They are' instead of 'They is'.";
    }
    return "✅ Great! No major grammar mistakes found.";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text("AI Voice Practice"), backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Recognized Text Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2A2A3C) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isDark ? [] : [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("You said:", style: TextStyle(color: isDark ? Colors.grey : Colors.black54, fontSize: 14)),
                  const SizedBox(height: 10),
                  Text(
                    _recognizedText.isEmpty ? _statusMessage : _recognizedText,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _recognizedText.isEmpty ? Colors.grey : null,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Grammar Correction Box
            if (_correctionSuggestion.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _correctionSuggestion.contains("✅") ? Colors.green.withOpacity(0.15) : Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _correctionSuggestion.contains("✅") ? Colors.green : Colors.red),
                ),
                child: Text(
                  _correctionSuggestion,
                  style: TextStyle(
                    color: _correctionSuggestion.contains("✅") ? Colors.green : Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            const SizedBox(height: 20),

            // Bengali Translation Box
            if (_bengaliTranslation.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF6366F1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Bengali Translation:", style: TextStyle(color: Color(0xFF818CF8), fontSize: 14)),
                    const SizedBox(height: 10),
                    Text(_bengaliTranslation, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),

            const Spacer(),

            if (_isProcessing)
              const CircularProgressIndicator(color: Color(0xFF6366F1)),

            const SizedBox(height: 20),

            // Microphone Button
            GestureDetector(
              onTap: _listen,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isListening ? Colors.redAccent : const Color(0xFF6366F1),
                  boxShadow: [
                    BoxShadow(
                      color: (_isListening ? Colors.redAccent : const Color(0xFF6366F1)).withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Icon(_isListening ? Icons.stop : Icons.mic, size: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
