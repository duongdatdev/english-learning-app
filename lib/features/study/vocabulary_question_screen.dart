import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The four Figma states for Page 1's picture-matching vocabulary question:
/// 593:2887, 593:2968, 593:3051 and 593:3140.
enum PictureQuestionHint { sentence, translation, pronunciation, fullHint }

class Page1PictureQuestionScreen extends StatefulWidget {
  const Page1PictureQuestionScreen({
    super.key,
    this.hint = PictureQuestionHint.sentence,
    this.onBack,
  });

  final PictureQuestionHint hint;
  final VoidCallback? onBack;

  @override
  State<Page1PictureQuestionScreen> createState() =>
      _Page1PictureQuestionScreenState();
}

class _Page1PictureQuestionScreenState
    extends State<Page1PictureQuestionScreen> {
  static const _tts = MethodChannel('page1.local_tts');
  static const _optionImages = [
    'assets/figma/page1_all/58853888cee23f50d48cf9bce0fc4d7c18a48351.jpg',
    'assets/figma/page1_all/bd1706eb869d9d11445317731edf40be8c66d37c.jpg',
    'assets/figma/page1_all/c52f5bfa0fa5e09022f57f9d753f0affe141612e.jpg',
  ];
  int? _selected;
  bool _revealed = false;

  static const _ink = Color(0xFF1F2937);
  static const _muted = Color(0xFF94A3B8);
  static const _canvas = Color(0xFFF7F8FA);
  static const _blue = Color(0xFF2563EB);

  Future<void> _speak() async {
    try {
      await _tts.invokeMethod<void>('speak', {
        'text': 'The weather has a big effect on her mood.',
      });
    } on PlatformException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message ?? 'Không thể phát âm trên thiết bị này.',
          ),
        ),
      );
    } on MissingPluginException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phát âm ngoại tuyến hiện chỉ hỗ trợ trên Android.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final showTranslation =
        widget.hint == PictureQuestionHint.translation ||
        widget.hint == PictureQuestionHint.fullHint;
    return Scaffold(
      backgroundColor: _canvas,
      body: SizedBox.expand(
        child: Column(
          children: [
            const _StatusBar(),
            SizedBox(
              height: 57,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: widget.onBack ?? () => Navigator.maybePop(context),
                      borderRadius: BorderRadius.circular(20),
                      child: const SizedBox(
                        width: 32,
                        height: 44,
                        child: Icon(
                          Icons.chevron_left,
                          size: 28,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ),
                    const SizedBox(width: 9),
                    const Text(
                      'Số từ cần học 9',
                      style: TextStyle(fontSize: 12, color: _muted),
                    ),
                    const Spacer(),
                    const SizedBox(width: 9),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  children: [
                    const SizedBox(height: 31),
                    if (widget.hint == PictureQuestionHint.sentence ||
                        widget.hint == PictureQuestionHint.translation)
                      const Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: _ink,
                            fontSize: 17,
                            height: 1.625,
                            letterSpacing: .425,
                            fontFamily: 'Noto Serif',
                          ),
                          children: [
                            TextSpan(text: 'The weather has a big '),
                            TextSpan(
                              text: 'effect',
                              style: TextStyle(
                                color: _blue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(text: ' on her mood.'),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      )
                    else ...[
                      const Text(
                        'effect',
                        style: TextStyle(
                          color: _blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "/ɪ'fekt/",
                          style: TextStyle(fontSize: 12, color: _muted),
                        ),
                      ),
                    ],
                    if (showTranslation) ...[
                      const SizedBox(height: 8),
                      const Text(
                        'Thời tiết có ảnh hưởng rất lớn đến tâm trạng cô ấy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _muted,
                          fontSize: 12,
                          height: 1.35,
                        ),
                      ),
                    ],
                    const SizedBox(height: 111),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        const gap = 16.0;
                        final optionWidth = (constraints.maxWidth - gap) / 2;
                        return Wrap(
                          spacing: gap,
                          runSpacing: 10,
                          children: List.generate(
                            4,
                            (index) => _option(index, optionWidth),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            _BottomActions(
              onSkip: () => setState(() {
                _selected = null;
                _revealed = false;
              }),
              onHint: () => setState(() => _revealed = !_revealed),
              onSpeak: _speak,
              hintRevealed: _revealed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _option(int index, double width) {
    final selected = _selected == index;
    final correct = index == 0;
    final border = selected
        ? (correct ? const Color(0xFF22C55E) : const Color(0xFFEF4444))
        : const Color(0xFFE5E7EB);
    return InkWell(
      onTap: () => setState(() => _selected = index),
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: width,
        height: 120,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: index == 0 ? const Color(0xFF485C6C) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: border, width: selected ? 2 : 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: index == 0
                ? const _YinYangOption()
                : Image.asset(_optionImages[index - 1], fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class _YinYangOption extends StatelessWidget {
  const _YinYangOption();

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      width: 86,
      height: 86,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xFF2B3945)],
          stops: [.5, .5],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 10,
            offset: Offset(4, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: _dot(Colors.white, const Color(0xFF2B3945)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _dot(const Color(0xFF2B3945), Colors.white),
          ),
        ],
      ),
    ),
  );

  static Widget _dot(Color fill, Color dot) => Container(
    width: 43,
    height: 43,
    decoration: BoxDecoration(shape: BoxShape.circle, color: fill),
    child: Center(
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(shape: BoxShape.circle, color: dot),
      ),
    ),
  );
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 32,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text(
            '18:17',
            style: TextStyle(
              fontSize: 13,
              color: _Page1PictureQuestionScreenState._ink,
            ),
          ),
          const Spacer(),
          const Text(
            'Vo LTE',
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF374151),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.wifi, size: 14, color: Color(0xFF374151)),
          const SizedBox(width: 5),
          const Icon(
            Icons.signal_cellular_alt,
            size: 12,
            color: Color(0xFF374151),
          ),
          const SizedBox(width: 6),
          Container(
            width: 20,
            height: 14,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF6B7280)),
              borderRadius: BorderRadius.circular(3),
            ),
            child: const Text(
              '61',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 7,
                height: 1.1,
                color: Color(0xFF374151),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({
    required this.onSkip,
    required this.onHint,
    required this.onSpeak,
    required this.hintRevealed,
  });
  final VoidCallback onSkip;
  final VoidCallback onHint;
  final VoidCallback onSpeak;
  final bool hintRevealed;

  @override
  Widget build(BuildContext context) => Container(
    height: 72,
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
    ),
    padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onSkip,
          child: const Column(
            children: [
              Text(
                'Thuộc',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4B5563),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Bỏ qua từ',
                style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
              ),
            ],
          ),
        ),
        _ActionButton(
          icon: Icons.lightbulb_outline,
          label: hintRevealed ? 'Ẩn gợi ý' : 'Gợi ý',
          onTap: onHint,
        ),
        _ActionButton(
          icon: Icons.volume_up_outlined,
          label: 'Phát âm',
          onTap: onSpeak,
        ),
      ],
    ),
  );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF6B7280)),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
        ),
      ],
    ),
  );
}
