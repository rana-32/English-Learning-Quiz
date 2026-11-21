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
