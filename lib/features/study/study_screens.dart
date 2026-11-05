import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home/home_screens.dart';

final Map<String, WidgetBuilder> page1VocabularyExerciseBuilders = {
  for (final id in ['593:3297', '593:3230', '593:3425', '593:3495', '593:3563'])
    id: (_) => Page1VocabularyExerciseScreen(frameId: id),
  '593:3374': (_) => const Page1VocabularyInputScreen(),
  '593:3630': (_) => const Page1VocabularyCuteScreen(),
};

class Page1VocabularyCuteScreen extends StatelessWidget {
  const Page1VocabularyCuteScreen({super.key});

  void _goHome(BuildContext context) =>
      Navigator.of(context).popUntil((route) => route.isFirst);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xfff7f8fa),
    body: SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.fill,
        child: SizedBox(
          width: 360,
          height: 807,
          child: Stack(
            children: [
              const Page1FigmaStatusBar(),
              Positioned(
                top: 45,
                left: 0,
                right: 0,
                height: 44,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => _goHome(context),
                        child: const SizedBox(
                          width: 20,
                          height: 36,
                          child: Icon(
                            Icons.chevron_left,
                            size: 20,
                            color: Color(0xff334155),
                          ),
                        ),
                      ),
                      const SizedBox(width: 1),
                      const Text(
                        'Số từ cần học 8',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff94a3b8),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Container(
                        width: 1,
                        height: 14,
                        color: const Color(0xffcbd5e1),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.style_outlined,
                        size: 18,
                        color: Color(0xff334155),
                      ),
                      const SizedBox(width: 25),
                      const Icon(
                        Icons.settings_outlined,
                        size: 18,
                        color: Color(0xff334155),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 101,
                left: 95,
                width: 170,
                height: 170,
                child: Image.asset(
                  'assets/figma/page1_all/3d7ddb9ed17333c94e3a733d8b7365c29af14853.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                top: 301,
                left: 0,
                right: 0,
                child: Text(
                  'Cute',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0f172a),
                  ),
                ),
              ),
              const Positioned(
                top: 357,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.volume_up, size: 14, color: Color(0xff94a3b8)),
                    SizedBox(width: 10),
                    Text(
                      '/kjuːt/',
                      style: TextStyle(fontSize: 12, color: Color(0xff94a3b8)),
                    ),
                  ],
                ),
              ),
              const Positioned(
                top: 391,
                left: 20,
                right: 20,
                child: Text(
                  '“You think you’re cute? You’re right!”',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Color(0xff1e293b)),
                ),
              ),
              const Positioned(
                top: 413,
                left: 24,
                right: 24,
                child: Text(
                  'Bạn nghĩ mình dễ thương lắm hả? đúng gòi đó 😏.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.25,
                    color: Color(0xff94a3b8),
                  ),
                ),
              ),
              for (var i = 0; i < 4; i++)
                Positioned(
                  left: i.isEven ? 32 : 187,
                  top: i < 2 ? 481 : 585,
                  width: 141,
                  height: 90,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    elevation: 2,
                    shadowColor: const Color(0x08000000),
                    child: InkWell(
                      onTap: i == 3 ? () => _goHome(context) : null,
                      borderRadius: BorderRadius.circular(6),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            const [
                              '(n): Xinh đẹp',
                              '(n): Ảnh hưởng',
                              '(n): Cố gắng',
                              '(adj): Dễ thương',
                            ][i],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff0f172a),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 14,
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _CuteFooterAction(
                      icon: Icons.check,
                      title: 'Thuộc',
                      subtitle: 'Bỏ qua từ',
                    ),
                    _CuteFooterAction(
                      icon: Icons.lightbulb_outline,
                      title: 'Gợi ý',
                    ),
                    _CuteFooterAction(
                      icon: Icons.volume_up_outlined,
                      title: 'Phát âm',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _CuteFooterAction extends StatelessWidget {
  const _CuteFooterAction({
    required this.icon,
    required this.title,
    this.subtitle,
  });
  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 96,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(icon, size: 18, color: const Color(0xff64748b)),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xff64748b),
            fontWeight: FontWeight.w600,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            style: const TextStyle(fontSize: 9, color: Color(0xff94a3b8)),
          ),
      ],
    ),
  );
}

class Page1VocabularyInputScreen extends StatefulWidget {
  const Page1VocabularyInputScreen({
    super.key,
    this.onBackToHome,
    this.onNavigateFrame,
  });
  final VoidCallback? onBackToHome;
  final ValueChanged<String>? onNavigateFrame;

  @override
  State<Page1VocabularyInputScreen> createState() =>
      _Page1VocabularyInputScreenState();
}

class _Page1VocabularyInputScreenState
    extends State<Page1VocabularyInputScreen> {
  final _answer = TextEditingController();
  final _answerFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: const [SystemUiOverlay.bottom],
    ).then((_) {
      if (mounted) FocusScope.of(context).requestFocus(_answerFocus);
    });
  }

  @override
  void dispose() {
    _answer.dispose();
    _answerFocus.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.dispose();
  }

  Future<void> _submitAnswer(String value) async {
    FocusScope.of(context).unfocus();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    if (mounted) widget.onNavigateFrame?.call('593:3630');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xfff7f8fa),
    resizeToAvoidBottomInset: true,
    body: LayoutBuilder(
      builder: (context, _) => Align(
        alignment: Alignment.topCenter,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 360,
            height: 490,
            child: Column(
              children: [
                const Page1FigmaStatusBar(),
                const SizedBox(height: 13),
                SizedBox(
                  height: 44,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        InkWell(
                          onTap:
                              widget.onBackToHome ??
                              () => Navigator.maybePop(context),
                          child: const SizedBox(
                            width: 17,
                            height: 30,
                            child: Icon(
                              Icons.chevron_left,
                              size: 20,
                              color: Color(0xff334155),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Số từ cần học 9',
                          style: TextStyle(
                            fontFamily: 'Noto Serif',
                            fontSize: 12,
                            color: Color(0xff94a3b8),
                          ),
                        ),
                        const SizedBox(width: 9),
                        Container(
                          width: 1,
                          height: 14,
                          color: const Color(0xffcbd5e1),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.style_outlined,
                          size: 18,
                          color: Color(0xff334155),
                        ),
                        const SizedBox(width: 25),
                        const Icon(
                          Icons.settings_outlined,
                          size: 18,
                          color: Color(0xff334155),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 389,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 170,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/figma/page1_all/47f33a0beae5bdb465208a9820a57f590ef9ca34.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: _answer,
                            focusNode: _answerFocus,
                            textAlign: TextAlign.center,
                            textInputAction: TextInputAction.done,
                            onSubmitted: _submitAnswer,
                            cursorColor: const Color(0xff2563eb),
                            style: const TextStyle(
                              fontFamily: 'Noto Serif',
                              fontSize: 18,
                              color: Color(0xff0f172a),
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              isCollapsed: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(
                          height: 32,
                          child: Center(
                            child: Text(
                              '(v): Ảnh hưởng; kết quả',
                              style: TextStyle(
                                fontFamily: 'Noto Serif',
                                fontSize: 12,
                                color: Color(0xff94a3b8),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class Page1VocabularyExerciseScreen extends StatefulWidget {
  const Page1VocabularyExerciseScreen({
    super.key,
    required this.frameId,
    this.onNavigateFrame,
    this.onBackToHome,
  });
  final String frameId;
  final ValueChanged<String>? onNavigateFrame;
  final VoidCallback? onBackToHome;

  @override
  State<Page1VocabularyExerciseScreen> createState() =>
      _Page1VocabularyExerciseScreenState();
}

class _Page1VocabularyExerciseScreenState
    extends State<Page1VocabularyExerciseScreen> {
  static const _paper = Color(0xfff7f8fa);
  static const _ink = Color(0xff0f172a);
  static const _muted = Color(0xff94a3b8);
  static const _blue = Color(0xff2563eb);
  int? _selected;
  bool _spellWords = true;
  bool _disableAudio = false;

  bool get _listening => widget.frameId == '593:3425';
  bool get _hint => widget.frameId == '593:3230';
  bool get _translation =>
      widget.frameId == '593:3563' || widget.frameId == '593:3495';
  bool get _showImage => widget.frameId != '593:3563';
  double get _questionHeight => switch (widget.frameId) {
    '593:3425' => 546,
    '593:3495' => 594.94,
    '593:3563' => 412.94,
    _ => 558.94,
  };

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: _paper,
    body: SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.fill,
        child: SizedBox(
          width: 360,
          height: 807,
          child: Column(
            children: [
              const Page1FigmaStatusBar(),
              const SizedBox(height: 13),
              _header(),
              const SizedBox(height: 12),
              SizedBox(height: _questionHeight, child: _question()),
              const Spacer(),
              _actions(),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _header() => SizedBox(
    height: 44,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          InkWell(
            onTap: widget.onBackToHome ?? () => Navigator.maybePop(context),
            child: const SizedBox(
              width: 17,
              height: 30,
              child: Icon(
                Icons.chevron_left,
                size: 20,
                color: Color(0xff334155),
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            'Số từ cần học 9',
            style: TextStyle(fontSize: 12, color: _muted),
          ),
          const SizedBox(width: 9),
          Container(width: 1, height: 14, color: const Color(0xffcbd5e1)),
          const Spacer(),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 28, height: 32),
            onPressed: () =>
                _open(widget.frameId == '593:3563' ? '593:3230' : '593:3563'),
            icon: const Icon(
              Icons.style_outlined,
              size: 18,
              color: Color(0xff334155),
            ),
          ),
          const SizedBox(width: 9),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 24, height: 32),
            onPressed: _showSettings,
            icon: const Icon(
              Icons.settings_outlined,
              size: 18,
              color: Color(0xff334155),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _question() {
    if (_listening) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _image(),
            const SizedBox(height: 50),
            _audioPrompt(),
            const SizedBox(height: 50),
            SizedBox(height: 236, child: _choices()),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (_showImage) _image(),
          if (_showImage) const SizedBox(height: 12),
          SizedBox(
            height: 62,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 6),
              child: Text(
                'effect',
                style: const TextStyle(
                  fontFamily: 'Noto Serif',
                  fontSize: 30,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                  letterSpacing: -.75,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 22,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: 24,
                    height: 20,
                  ),
                  onPressed: () => _speak('effect'),
                  icon: const Icon(
                    Icons.volume_up_rounded,
                    size: 14,
                    color: _muted,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  "/ɪ'fekt/",
                  style: TextStyle(
                    fontFamily: 'Noto Serif',
                    fontSize: 12,
                    color: _muted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: _translation ? 56.94 : 20.94,
            child: Column(
              children: [
                SizedBox(
                  height: 20.94,
                  child: Center(
                    child: _hint || _translation
                        ? const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'The weather has a big '),
                                TextSpan(
                                  text: 'effect',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                TextSpan(text: ' on her mood.'),
                              ],
                            ),
                            style: TextStyle(
                              fontFamily: 'Noto Serif',
                              fontSize: 12,
                              color: _ink,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
                if (_translation) ...[
                  const SizedBox(height: 4),
                  const SizedBox(
                    width: 240,
                    height: 32,
                    child: Center(
                      child: Text(
                        'Thời tiết có ảnh hưởng rất lớn đến tâm trạng cô ấy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Noto Serif',
                          fontSize: 12,
                          height: 1.25,
                          color: _muted,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(height: 236, child: _choices()),
        ],
      ),
    );
  }

  Widget _image() => SizedBox(
    height: 170,
    width: double.infinity,
    child: Image.asset(
      'assets/figma/page1_all/47f33a0beae5bdb465208a9820a57f590ef9ca34.png',
      fit: BoxFit.contain,
    ),
  );

  Widget _audioPrompt() => InkWell(
    onTap: () => _speak('effect map safe have'),
    borderRadius: BorderRadius.circular(24),
    child: Container(
      width: 266,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xffe4efff),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Icon(Icons.volume_up_rounded, size: 30, color: _blue),
    ),
  );

  Widget _choices() {
    final options = _listening
        ? const ['effect', 'map', 'safe', 'have']
        : const [
            '(n): Khuyết điểm, lỗi lầm, sai sót',
            '(v): Lây nhiễm',
            '(n): Cố gắng',
            '(n): Ảnh hưởng, kết quả',
          ];
    final correct = _listening ? 0 : 3;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        _selected == null ? 16 : 0,
        20,
        _selected == null ? 16 : 0,
        20,
      ),
      itemCount: options.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: 92,
      ),
      itemBuilder: (context, index) {
        final selected = _selected == index;
        final isCorrect = index == correct;
        final color = !selected
            ? Colors.white
            : isCorrect
            ? const Color(0xffdef3e6)
            : const Color(0xfff9d9dc);
        return Material(
          color: color,
          borderRadius: BorderRadius.circular(5),
          elevation: selected ? 0 : 1,
          shadowColor: const Color(0x140f172a),
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () => _selectAnswer(index),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text.rich(
                    _selected == 0 && index == 0 && !_listening
                        ? const TextSpan(
                            children: [
                              TextSpan(
                                text: 'defect\n',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                text: 'n. Khuyết điểm, lỗi lầm, sai sót',
                              ),
                            ],
                          )
                        : TextSpan(text: options[index]),
                    style: const TextStyle(
                      fontFamily: 'Noto Serif',
                      fontSize: 12,
                      height: 1.55,
                      color: Color(0xff1e293b),
                    ),
                  ),
                ),
                if (selected)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 30,
                      height: 28,
                      decoration: BoxDecoration(
                        color: isCorrect
                            ? const Color(0xff22b573)
                            : const Color(0xffef4444),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                          topRight: Radius.circular(5),
                        ),
                      ),
                      child: Icon(
                        isCorrect ? Icons.check_rounded : Icons.close_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _actions() => SizedBox(
    height: 71,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 7, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _action(Icons.check_circle_outline, 'Thuộc', 'Bỏ qua từ', _next),
          _action(Icons.lightbulb_outline, 'Gợi ý', '', () {
            if (widget.frameId == '593:3297') _open('593:3230');
          }),
          _action(
            Icons.volume_up_outlined,
            'Phát âm',
            '',
            () => _speak(_listening ? 'effect map safe have' : 'effect'),
          ),
        ],
      ),
    ),
  );

  void _selectAnswer(int index) {
    if (_listening) {
      if (index == 0) widget.onNavigateFrame?.call('593:3374');
      return;
    }
    if (index == 1 || index == 2) return;
    setState(() => _selected = index);
    if (index == 3) {
      Future<void>.delayed(const Duration(milliseconds: 300), () {
        if (!mounted || _selected != 3) return;
        final next =
            widget.frameId == '593:3495' || widget.frameId == '593:3563'
            ? '593:3297'
            : '593:3425';
        widget.onNavigateFrame?.call(next);
      });
    }
  }

  Widget _action(
    IconData icon,
    String label,
    String detail,
    VoidCallback onTap,
  ) => InkWell(
    onTap: onTap,
    child: SizedBox(
      height: 56,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (label == 'Thuộc') ...[
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Noto Serif',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xff475569),
              ),
            ),
            Text(
              detail,
              style: const TextStyle(
                fontFamily: 'Noto Serif',
                fontSize: 9,
                color: _muted,
              ),
            ),
          ] else ...[
            Icon(icon, size: 18, color: const Color(0xff64748b)),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Noto Serif',
                fontSize: 10,
                color: _muted,
              ),
            ),
          ],
        ],
      ),
    ),
  );

  void _next() {
    if (widget.frameId == '593:3297' || widget.frameId == '593:3230') {
      _open('593:3425');
    }
  }

  void _open(String id) => widget.onNavigateFrame?.call(id);

  Future<void> _speak(String text) async {
    try {
      await const MethodChannel('page1.local_tts')
          .invokeMethod<bool>('speak', {'text': text});
    } on PlatformException {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Không tìm thấy giọng đọc tiếng Anh trên thiết bị.'),
          ),
        );
    }
  }

  void _showSettings() => showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
    ),
    builder: (context) => StatefulBuilder(
      builder: (context, setSheetState) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xffcbd5e1),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Cài đặt học tập',
              style: TextStyle(
                fontFamily: 'Noto Serif',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _ink,
              ),
            ),
            SwitchListTile(
              title: const Text('Đánh vần từ'),
              subtitle: const Text('Học và chiến đấu, tăng cường trí nhớ'),
              value: _spellWords,
              onChanged: (value) {
                setState(() => _spellWords = value);
                setSheetState(() {});
              },
            ),
            SwitchListTile(
              title: const Text('Bất tiện nghe âm thanh'),
              subtitle: const Text('Tắt các câu hỏi nghe'),
              value: _disableAudio,
              onChanged: (value) {
                setState(() => _disableAudio = value);
                setSheetState(() {});
              },
            ),
          ],
        ),
      ),
    ),
  );
}

/// Interactive local-only implementations for Page 1 study and vocabulary flows.
/// Routes are keyed by the original Figma root node IDs.
final Map<String, WidgetBuilder> page1StudyBuilders = {
  for (final id in _studyFrameIds) id: (_) => StudyFlowScreen(frameId: id),
};

const _studyFrameIds = <String>[
  '593:1664',
  '593:1768',
  '593:1854',
  '593:1914',
  '593:2065',
  '593:2189',
  '593:2317',
  '593:2423',
  '593:2517',
  '593:2601',
  '593:2695',
  '593:2781',
  '593:2807',
  '593:2887',
  '593:2968',
  '593:3051',
  '593:3140',
  '593:3230',
  '593:3297',
  '593:3374',
  '593:3425',
  '593:3495',
  '593:3563',
  '593:3630',
  '593:4143',
  '593:4230',
  '593:4389',
  '593:4550',
  '593:14017',
  '593:14113',
  '593:14346',
  '593:14404',
  '593:14462',
  '593:14525',
  '593:14585',
  '593:14646',
  '593:14704',
  '593:15236',
  '593:15403',
  '593:15461',
  '593:15518',
  '593:15575',
  '593:15706',
  '593:15859',
  '593:15922',
  '593:15983',
  '593:16070',
  '593:16173',
  '593:16314',
  '593:16465',
  '593:16539',
  '593:16737',
  '593:16812',
  '593:16845',
  '593:17069',
  '593:17156',
  '593:17230',
  '593:17347',
  '593:14346',
  '593:14404',
  '593:15403',
  '593:15461',
  '593:15518',
  '593:15575',
  '593:15706',
  '593:15859',
  '593:15922',
  '593:15983',
  '593:16070',
];

const _blue = Color(0xff2563eb);
const _ink = Color(0xff172033);
const _muted = Color(0xff64748b);

String _title(String id) {
  if (id == '593:1664' || id == '593:14017')
    return 'Thiết lập kế hoạch học từ vựng';
  if (id == '593:14113' || id == '593:14704' || id == '593:15236')
    return 'Học từ vựng';
  if (id == '593:16173') return 'Video học từ vựng';
  if (id == '593:16314') return 'Chi tiết video';
  if (id == '593:16465' || id == '593:16539') return 'Tạo sổ từ vựng';
  if (id == '593:16737' || id == '593:17230') return 'Sổ từ vựng của tôi';
  if (id == '593:16812' || id == '593:16845' || id == '593:17069')
    return 'Thêm từ vựng';
  if (id == '593:17156') return 'Chia sẻ sổ từ vựng';
  if (id == '593:17347') return 'Nhập mã chia sẻ';
  if (id == '593:15403') return 'Ôn tập bằng Flashcard';
  if (id == '593:15461') return 'Chọn từ tiếng Anh';
  if (id == '593:15518') return 'Luyện phát âm';
  if (id == '593:15575') return 'Điền từ theo hình ảnh';
  if (id == '593:15706') return 'Chọn nghĩa từ vựng';
  if (id == '593:15859') return 'Ghép âm tạo từ';
  if (id == '593:15922') return 'Luyện nghe';
  if (id == '593:15983') return 'Nghe và ghi nhớ';
  if (id == '593:16070') return 'Điền chữ còn thiếu';
  if (id == '593:14346' ||
      id == '593:14462' ||
      id == '593:14525' ||
      id == '593:14585' ||
      id == '593:14646')
    return 'Chọn nghĩa từ vựng';
  if (id == '593:14404') return 'Chọn từ tiếng Anh theo nghĩa';
  return 'Kế hoạch học từ vựng';
}

bool _isExercise(String id) =>
    int.tryParse(id.split(':').last) != null &&
    (int.parse(id.split(':').last) >= 2887 &&
            int.parse(id.split(':').last) <= 4550 ||
        int.parse(id.split(':').last) >= 14346 &&
            int.parse(id.split(':').last) <= 16070);

class StudyFlowScreen extends StatefulWidget {
  const StudyFlowScreen({super.key, required this.frameId});
  final String frameId;

  @override
  State<StudyFlowScreen> createState() => _StudyFlowScreenState();
}

class _StudyFlowScreenState extends State<StudyFlowScreen> {
  int selected = -1;
  int card = 0;
  bool flipped = false;
  bool saved = false;
  final answer = TextEditingController();
  String get id => widget.frameId;
  bool get exercise => _isExercise(id);
  bool get bookFlow =>
      int.parse(id.split(':').last) >= 16465 &&
      int.parse(id.split(':').last) <= 17347;
  bool get videoFlow => id == '593:16173' || id == '593:16314';
  bool get flashcard => id == '593:15403';

  @override
  void dispose() {
    answer.dispose();
    super.dispose();
  }

  void open(String next) => Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (_) => StudyFlowScreen(frameId: next)),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xfff8faff),
    appBar: AppBar(
      backgroundColor: const Color(0xfff8faff),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: _ink),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: Text(
        _title(id),
        style: const TextStyle(
          color: _ink,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => setState(() => saved = !saved),
          icon: Icon(
            saved ? Icons.bookmark : Icons.bookmark_border,
            color: _blue,
          ),
        ),
      ],
    ),
    body: SafeArea(
      child: exercise
          ? _exerciseBody()
          : flashcard
          ? _flashcards()
          : bookFlow
          ? _bookBody()
          : videoFlow
          ? _videoBody()
          : _isHome
          ? _homeBody()
          : _planBody(),
    ),
  );

  bool get _isHome =>
      id == '593:14113' || id == '593:14704' || id == '593:15236';

  Widget _homeBody() => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      _welcomeCard(
        'Chào buổi học mới!',
        'Bạn đã học 12 từ trong tuần này. Tiếp tục nhé!',
        Icons.waving_hand_outlined,
      ),
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xffe8edf4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mục tiêu hôm nay',
              style: TextStyle(fontWeight: FontWeight.w700, color: _ink),
            ),
            const SizedBox(height: 12),
            const LinearProgressIndicator(
              value: .6,
              minHeight: 8,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            const SizedBox(height: 8),
            const Text(
              '6 / 10 từ đã ôn',
              style: TextStyle(color: _muted, fontSize: 12),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      const Text(
        'Tiếp tục học',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: _ink,
          fontSize: 18,
        ),
      ),
      const SizedBox(height: 10),
      _bookTile(
        'Ôn tập từ đã học',
        '8 thẻ đang chờ ôn',
        Icons.style_outlined,
        () => open('593:15403'),
      ),
      _bookTile(
        'Luyện tập nhanh',
        '5 câu · Khoảng 3 phút',
        Icons.bolt,
        () => open('593:14346'),
      ),
      const SizedBox(height: 12),
      const Text(
        'Khám phá',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: _ink,
          fontSize: 18,
        ),
      ),
      const SizedBox(height: 10),
      _bookTile(
        'Video học từ vựng',
        'Học theo tình huống thực tế',
        Icons.ondemand_video,
        () => open('593:16173'),
      ),
      _bookTile(
        'Sổ từ vựng của tôi',
        'Tạo và quản lý các bộ từ',
        Icons.menu_book_outlined,
        () => open('593:16737'),
      ),
      _bookTile(
        'Thiết lập kế hoạch học',
        'Chọn mục tiêu hàng ngày',
        Icons.tune,
        () => open('593:1664'),
      ),
    ],
  );

  Widget _planBody() => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      _welcomeCard(
        'Học đều mỗi ngày, nhớ lâu hơn',
        'Tạo lộ trình phù hợp với thời gian của bạn.',
        Icons.auto_awesome,
      ),
      const SizedBox(height: 18),
      const Text(
        'Mục tiêu học tập',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: _ink,
        ),
      ),
      const SizedBox(height: 12),
      _choice('Từ mới mỗi ngày', '10 từ · khoảng 15 phút', Icons.bolt, 0),
      _choice(
        'Ôn tập thông minh',
        'Ưu tiên từ sắp quên',
        Icons.psychology_alt,
        1,
      ),
      _choice(
        'Học theo chủ đề',
        'Chọn bộ từ phù hợp',
        Icons.category_outlined,
        2,
      ),
      const SizedBox(height: 14),
      const Text(
        'Bộ từ gợi ý',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: _ink,
        ),
      ),
      const SizedBox(height: 10),
      _bookTile(
        'Giao tiếp hằng ngày',
        '48 từ · Cơ bản',
        Icons.chat_bubble_outline,
        () => open('593:14113'),
      ),
      _bookTile(
        'Du lịch và khám phá',
        '36 từ · Sơ cấp',
        Icons.flight_takeoff,
        () => open('593:14113'),
      ),
      const SizedBox(height: 24),
      FilledButton(
        onPressed: () => open('593:14113'),
        style: _buttonStyle(),
        child: const Text('Lưu kế hoạch học'),
      ),
    ],
  );

  Widget _exerciseBody() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      Row(
        children: [
          const Expanded(
            child: LinearProgressIndicator(
              value: .45,
              minHeight: 7,
              borderRadius: BorderRadius.all(Radius.circular(9)),
            ),
          ),
          const SizedBox(width: 12),
          const Text('5 / 12', style: TextStyle(color: _muted)),
        ],
      ),
      const SizedBox(height: 26),
      const Text(
        'Chọn đáp án đúng',
        style: TextStyle(color: _muted, fontSize: 14),
      ),
      const SizedBox(height: 12),
      _welcomeCard(
        _prompt(),
        'Chạm loa để nghe phát âm',
        Icons.volume_up_rounded,
      ),
      const SizedBox(height: 24),
      ..._answers().asMap().entries.map(
        (e) => _choice(e.value, ' ', Icons.circle_outlined, e.key),
      ),
      const SizedBox(height: 20),
      FilledButton(
        onPressed: selected < 0
            ? null
            : () => setState(() {
                selected = -1;
                card++;
              }),
        style: _buttonStyle(),
        child: Text(card > 0 ? 'Tiếp tục' : 'Kiểm tra đáp án'),
      ),
      TextButton(
        onPressed: () => showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Gợi ý'),
            content: Text('Đáp án liên quan đến “${_prompt()}”.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đã hiểu'),
              ),
            ],
          ),
        ),
        child: const Text('Xem gợi ý'),
      ),
    ],
  );

  String _prompt() => id == '593:14404'
      ? 'Một chuyến đi'
      : id == '593:15575'
      ? 'What is in the picture?'
      : 'Serendipity';
  List<String> _answers() => id == '593:14404'
      ? ['Journey', 'Window', 'Morning', 'Garden']
      : ['Tình cờ may mắn', 'Thất vọng', 'Chăm chỉ', 'Ồn ào'];

  Widget _flashcards() => Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        child: Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: (card + 1) / 8,
                minHeight: 6,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
            ),
            const SizedBox(width: 12),
            Text('${card + 1}/8', style: const TextStyle(color: _muted)),
          ],
        ),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () => setState(() => flipped = !flipped),
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xffedf4ff), Colors.white],
              ),
              borderRadius: BorderRadius.circular(26),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x160b3163),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    flipped ? Icons.check_circle_outline : Icons.style_outlined,
                    color: _blue,
                    size: 38,
                  ),
                  const SizedBox(height: 22),
                  Text(
                    flipped
                        ? ['Sự tình cờ may mắn', 'Kiên trì', 'Khám phá'][card %
                              3]
                        : ['serendipity', 'resilient', 'discover'][card % 3],
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      color: _ink,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    flipped ? 'Nhấn để xem từ tiếp theo' : 'Chạm để lật thẻ',
                    style: const TextStyle(color: _muted),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => setState(() {
                  flipped = false;
                  card = (card + 1) % 8;
                }),
                icon: const Icon(Icons.refresh),
                label: const Text('Ôn lại'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: () => setState(() {
                  flipped = false;
                  card = (card + 1) % 8;
                }),
                style: _buttonStyle(),
                icon: const Icon(Icons.check),
                label: const Text('Đã nhớ'),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _bookBody() {
    if (id == '593:16737' || id == '593:17230') {
      return ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _welcomeCard(
            'Bộ sưu tập của bạn',
            'Các sổ từ vựng được lưu trên thiết bị.',
            Icons.menu_book_rounded,
          ),
          const SizedBox(height: 18),
          _bookTile(
            'Từ vựng của tôi',
            '24 từ · Cập nhật hôm nay',
            Icons.book,
            () => open('593:16812'),
          ),
          _bookTile(
            'Tiếng Anh du lịch',
            '38 từ · Đã chia sẻ',
            Icons.public,
            () => open('593:16845'),
          ),
          OutlinedButton.icon(
            onPressed: () => open('593:16465'),
            icon: const Icon(Icons.add),
            label: const Text('Tạo sổ mới'),
          ),
        ],
      );
    }
    if (id == '593:17156' || id == '593:17347') {
      return ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _welcomeCard(
            id == '593:17156' ? 'Chia sẻ kiến thức' : 'Nhập mã sổ từ vựng',
            'Chia sẻ bộ từ để cùng nhau học tập.',
            Icons.ios_share,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: answer,
            decoration: InputDecoration(
              labelText: id == '593:17156'
                  ? 'Tên người nhận hoặc liên kết'
                  : 'Mã chia sẻ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _savedToast,
            style: _buttonStyle(),
            child: Text(
              id == '593:17156' ? 'Tạo liên kết chia sẻ' : 'Thêm sổ từ vựng',
            ),
          ),
        ],
      );
    }
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _welcomeCard(
          id == '593:16465' ? 'Tạo bộ từ của riêng bạn' : 'Thêm từ mới vào sổ',
          'Nội dung được lưu cục bộ để bạn có thể bắt đầu học ngay.',
          Icons.library_add_outlined,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: answer,
          decoration: InputDecoration(
            labelText: id == '593:16465' || id == '593:16539'
                ? 'Tên sổ từ vựng'
                : 'Từ tiếng Anh',
            hintText: 'Ví dụ: curious',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        if (id != '593:16465' && id != '593:16539') ...[
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: 'Nghĩa tiếng Việt',
              hintText: 'Tò mò',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: 'Câu ví dụ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
        const SizedBox(height: 20),
        FilledButton(
          onPressed: _savedToast,
          style: _buttonStyle(),
          child: const Text('Lưu'),
        ),
      ],
    );
  }

  Widget _videoBody() => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      if (id == '593:16314') ...[
        _welcomeCard(
          'Video: Từ vựng giao tiếp',
          'Bài học ngắn · 08:24 · Sơ cấp',
          Icons.play_circle_fill,
        ),
        const SizedBox(height: 18),
        const Text(
          'Trong bài học này',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _ink,
          ),
        ),
        const SizedBox(height: 12),
        _bookTile(
          'Chào hỏi và giới thiệu',
          '6 từ mới',
          Icons.check_circle_outline,
          () {},
        ),
        _bookTile(
          'Hỏi đường',
          '8 từ mới',
          Icons.lock_open_outlined,
          () => open('593:15403'),
        ),
        FilledButton(
          onPressed: () => open('593:15403'),
          style: _buttonStyle(),
          child: const Text('Học từ trong video'),
        ),
      ] else ...[
        _welcomeCard(
          'Học qua video ngắn',
          'Chọn chủ đề yêu thích để khám phá từ mới.',
          Icons.ondemand_video,
        ),
        const SizedBox(height: 14),
        ...[
          'Giao tiếp hằng ngày',
          'Du lịch vòng quanh thế giới',
          'Tiếng Anh nơi công sở',
          'Phát âm tự nhiên',
        ].map(
          (v) => _bookTile(
            v,
            'Video · Từ vựng theo ngữ cảnh',
            Icons.play_circle_outline,
            () => open('593:16314'),
          ),
        ),
      ],
    ],
  );

  Widget _choice(String label, String subtitle, IconData icon, int index) =>
      InkWell(
        onTap: () => setState(() => selected = index),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected == index ? const Color(0xffeff6ff) : Colors.white,
            border: Border.all(
              color: selected == index ? _blue : const Color(0xffe4eaf2),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(icon, color: _blue),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: _ink,
                      ),
                    ),
                    if (subtitle.trim().isNotEmpty)
                      Text(
                        subtitle,
                        style: const TextStyle(fontSize: 12, color: _muted),
                      ),
                  ],
                ),
              ),
              Icon(
                selected == index ? Icons.check_circle : Icons.circle_outlined,
                color: selected == index ? _blue : _muted,
              ),
            ],
          ),
        ),
      );
  Widget _bookTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) => Card(
    color: Colors.white,
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: Color(0xffe8edf4)),
    ),
    child: ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: const Color(0xffedf4ff),
        child: Icon(icon, color: _blue),
      ),
      title: Text(
        title,
        style: const TextStyle(color: _ink, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: _muted, fontSize: 12),
      ),
      trailing: const Icon(Icons.chevron_right, color: _muted),
    ),
  );
  Widget _welcomeCard(String title, String subtitle, IconData icon) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xffeaf2ff),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: _blue, size: 32),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: _ink,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: _muted, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  ButtonStyle _buttonStyle() => FilledButton.styleFrom(
    backgroundColor: _blue,
    minimumSize: const Size.fromHeight(50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  );
  void _savedToast() {
    setState(() => saved = true);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Đã lưu trên thiết bị')));
  }
}
