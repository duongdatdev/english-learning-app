import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _ink = Color(0xFF1F2937);
const _softInk = Color(0xFF374151);

/// Page 1 · Ngữ âm — lộ trình bài học.
class PhoneticsRoadmapScreen extends StatelessWidget {
  const PhoneticsRoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFCFBFF), Color(0xFFF9F8FE), Color(0xFFF6F5FB)],
        ),
      ),
      child: Column(
        children: [
          const _LearningStatusBar(),
          SizedBox(
            height: 56,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 32,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.chevron_left, size: 24),
                      onPressed: () => Navigator.maybePop(context),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Ngữ âm',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: _ink),
                    ),
                  ),
                  const SizedBox(width: 32),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFEBDFFF).withValues(alpha: .8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFDFCBFC)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Unit 1: Nguyên tắc cơ bản',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF373145),
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFFB588FC),
                          minimumSize: const Size(76, 24),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () => showDialog<void>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Unit 1: Nguyên tắc cơ bản'),
                            content: const Text(
                              'Nguyên âm u, e, o, a, i và phụ âm cơ bản',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Đóng'),
                              ),
                            ],
                          ),
                        ),
                        child: const Text(
                          'Chi tiết  ›',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Nguyên âm u,e,o,a,i và phụ âm cơ bản',
                    style: TextStyle(fontSize: 12, color: Color(0xFF6E6382)),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(child: _Roadmap()),
        ],
      ),
    ),
  );
}

class _Roadmap extends StatelessWidget {
  const _Roadmap();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final scale = (constraints.maxWidth / 358).clamp(.72, 1.15);
      return ClipRect(
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: _RoadPathPainter(scale)),
            ),
            _lessonNode(
              left: 64 * scale,
              top: 16 * scale,
              text: 'a, i, p, t',
              active: true,
            ),
            _lessonNode(
              left: 118 * scale,
              top: 128 * scale,
              text: 'e, o, f, d',
              locked: true,
              leftPill: true,
            ),
            _lessonNode(
              left: 64 * scale,
              top: 256 * scale,
              text: 'u, h, g, b',
              locked: true,
            ),
            _lessonNode(
              left: 111 * scale,
              top: 384 * scale,
              text: 'v, s, m, n',
              locked: true,
              leftPill: true,
            ),
            _lessonNode(
              left: 64 * scale,
              top: 499.5 * scale,
              text: 'm, n, ng',
              locked: true,
            ),
            Positioned(
              right: 18 * scale,
              top: 8 * scale,
              child: Column(
                children: [
                  Container(
                    width: 40 * scale,
                    height: 30 * scale,
                    decoration: BoxDecoration(
                      color: const Color(0xFF86EFAC),
                      border: Border.all(
                        color: const Color(0xFF4ADE80),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'W',
                        style: TextStyle(
                          color: const Color(0xFF15803D),
                          fontSize: 12 * scale,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4 * scale),
                  Text(
                    'Bài học',
                    style: TextStyle(
                      fontSize: 11 * scale,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );

  Widget _lessonNode({
    required double left,
    required double top,
    required String text,
    bool active = false,
    bool locked = false,
    bool leftPill = false,
  }) {
    final node = Container(
      width: 74,
      height: 74,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? const Color(0xFFF97316) : const Color(0xFFF1F5F9),
        border: Border.all(
          color: active ? const Color(0xFFFDBA74) : const Color(0xFFE2E8F0),
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: active ? const Color(0x40EA580C) : const Color(0xFFE2E8F0),
            blurRadius: active ? 14 : 0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Icon(
        active ? Icons.location_on : Icons.lock,
        color: active ? Colors.white : const Color(0xFFD1D5DB),
        size: active ? 30 : 22,
      ),
    );
    final pill = Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: _softInk,
        ),
      ),
    );

    return Positioned(
      left: left,
      top: top,
      child: SizedBox(
        width: 220,
        height: 74,
        child: Row(
          children: leftPill
              ? [pill, const Spacer(), node]
              : [node, const SizedBox(width: 14), pill],
        ),
      ),
    );
  }
}

class _RoadPathPainter extends CustomPainter {
  const _RoadPathPainter(this.scale);
  final double scale;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(142 * scale, 48 * scale)
      ..cubicTo(
        231 * scale,
        66 * scale,
        225 * scale,
        120 * scale,
        184 * scale,
        180 * scale,
      )
      ..cubicTo(
        146 * scale,
        236 * scale,
        103 * scale,
        278 * scale,
        165 * scale,
        326 * scale,
      )
      ..cubicTo(
        211 * scale,
        361 * scale,
        284 * scale,
        374 * scale,
        229 * scale,
        425 * scale,
      )
      ..cubicTo(
        172 * scale,
        473 * scale,
        121 * scale,
        492 * scale,
        128 * scale,
        530 * scale,
      );
    final paint = Paint()
      ..color = const Color(0xFFCFC6E8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = (distance + 7).clamp(0, metric.length).toDouble();
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += 13;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _RoadPathPainter oldDelegate) =>
      oldDelegate.scale != scale;
}

/// Page 1 · Thử thách từ vựng, designed as a landscape panel.
class VocabularyChallengeScreen extends StatefulWidget {
  const VocabularyChallengeScreen({super.key});

  @override
  State<VocabularyChallengeScreen> createState() =>
      _VocabularyChallengeScreenState();
}

class _VocabularyChallengeScreenState extends State<VocabularyChallengeScreen> {
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _setLandscape();
  }

  Future<void> _setLandscape() async {
    await SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF556EE6),
    body: LayoutBuilder(
      builder: (context, constraints) => Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: 800,
            height: 360,
            child: _challengeCanvas(context),
          ),
        ),
      ),
    ),
  );

  Widget _challengeCanvas(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF6079F0), Color(0xFF556EE6), Color(0xFF465ED8)],
            ),
          ),
        ),
        Image.asset(
          'assets/figma/page1_learning/651-6967.png',
          fit: BoxFit.fill,
        ),
        Positioned(
          left: 20,
          top: 16,
          child: _glassButton(
            Icons.chevron_left,
            () => Navigator.maybePop(context),
          ),
        ),
        Positioned(
          left: 70,
          top: 82,
          width: 224,
          height: 224,
          child: Image.asset(
            'assets/figma/page1_learning/651-6897.png',
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          right: 32,
          top: 105,
          width: 430,
          height: 82,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFC8A27A), width: 3),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 12,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.volume_up,
                    size: 15,
                    color: Color(0xFFA8A29E),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Chào mừng bạn đến với thử thách từ vựng! Thử thách kéo dài 5 - 10 phút. Bỏ cuộc sẽ bắt đầu lại.',
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.62,
                      color: Color(0xFF4A3D36),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 32,
          top: 208,
          width: 430,
          height: 48,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF8726), Color(0xFFFF6B1A)],
              ),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFFE65E0A), width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextButton(
              onPressed: () => setState(() => _started = !_started),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
              ),
              child: Text(
                _started ? 'Đang chuẩn bị…' : 'Bắt đầu',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 220,
          top: 268,
          child: const Text(
            'Thời gian: 5-10min',
            style: TextStyle(color: Color(0xFFE8E3E0), fontSize: 12),
          ),
        ),
        Positioned(
          left: -74,
          bottom: -80,
          width: 950,
          height: 192,
          child: Image.asset(
            'assets/figma/page1_learning/651-6981.png',
            fit: BoxFit.fill,
          ),
        ),
      ],
    ),
  );

  Widget _glassButton(IconData icon, VoidCallback onPressed) => Material(
    color: const Color(0x66FFFFFF),
    shape: const CircleBorder(side: BorderSide(color: Color(0x55FFFFFF))),
    child: InkWell(
      onTap: onPressed,
      customBorder: const CircleBorder(),
      child: SizedBox(
        width: 32,
        height: 32,
        child: Icon(icon, size: 18, color: const Color(0xFFFFA23B)),
      ),
    ),
  );
}

/// Page 1 · Trình phát truyện.
class StoryPlayerScreen extends StatefulWidget {
  const StoryPlayerScreen({super.key});

  @override
  State<StoryPlayerScreen> createState() => _StoryPlayerScreenState();
}

class _StoryPlayerScreenState extends State<StoryPlayerScreen> {
  bool _playing = false;
  double _progress = .38;
  double _rate = 1;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF7F7F7),
    body: Column(
      children: [
        const _LearningStatusBar(),
        SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => Navigator.maybePop(context),
                  customBorder: const CircleBorder(),
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.chevron_left,
                      color: Color(0xFFFF7A22),
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 208,
                  height: 208,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xD9DCE0E6),
                        blurRadius: 30,
                        offset: Offset(0, 12),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/figma/page1_learning/128d1875bbab5d5aa801b45f10c385618e5ca3c1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Love is an open door',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF383838),
                    fontSize: 26,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Đang phát Sách tranh tiếng anh R1',
                  style: TextStyle(color: Color(0xFFF48E59), fontSize: 13),
                ),
                const Spacer(),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 4,
                    activeTrackColor: const Color(0xFFFF7A22),
                    inactiveTrackColor: const Color(0xFFECECEC),
                    thumbColor: const Color(0xFFFF7A22),
                    overlayColor: const Color(0x22FF7A22),
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                  ),
                  child: Slider(
                    value: _progress,
                    onChanged: (value) => setState(() => _progress = value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        '00:03',
                        style: TextStyle(
                          color: Color(0xFF9B9B9B),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '00:09',
                        style: TextStyle(
                          color: Color(0xFF9B9B9B),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => setState(() => _progress = 0),
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Color(0xFFFF7A22),
                      ),
                    ),
                    Container(
                      width: 78,
                      height: 78,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF7A22),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x59FF7A22),
                            blurRadius: 24,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () => setState(() => _playing = !_playing),
                        icon: Icon(
                          _playing ? Icons.pause : Icons.play_arrow,
                          size: 34,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => setState(() => _progress = 1),
                      icon: const Icon(
                        Icons.skip_next,
                        color: Color(0xFFFF7A22),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.repeat,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _showPlaylist,
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFEBEBEB),
                          foregroundColor: const Color(0xFF757575),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.queue_music, size: 16),
                        label: const Text(
                          'Danh sách phát',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      TextButton(
                        onPressed: () => setState(
                          () => _rate = _rate >= 2 ? .8 : _rate + .2,
                        ),
                        style: TextButton.styleFrom(
                          minimumSize: const Size(37, 30),
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          _rate.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF8C8C8C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  void _showPlaylist() => showModalBottomSheet<void>(
    context: context,
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Danh sách phát',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 14),
            ListTile(
              leading: const Icon(Icons.menu_book_outlined),
              title: const Text('Love is an open door'),
              subtitle: const Text('Sách tranh tiếng anh R1'),
              trailing: const Icon(Icons.equalizer, color: Color(0xFFFF7A22)),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Page 1 · Trung tâm nhiệm vụ.
class MissionCenterScreen extends StatefulWidget {
  const MissionCenterScreen({super.key});

  @override
  State<MissionCenterScreen> createState() => _MissionCenterScreenState();
}

class _MissionCenterScreenState extends State<MissionCenterScreen> {
  final Set<int> _claimed = {};

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFB3CFE2),
    body: Column(
      children: [
        const _LearningStatusBar(background: Color(0xFFB3CFE2)),
        SizedBox(
          height: 56,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                SizedBox(
                  width: 32,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.chevron_left, color: _ink),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Trung tâm nhiệm vụ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _ink,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 32),
              ],
            ),
          ),
        ),
        _missionPromo(),
        Expanded(child: _missionBoard()),
      ],
    ),
  );

  Widget _missionPromo() => Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
    child: Container(
      width: double.infinity,
      height: 116,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF232B35), width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            const Positioned.fill(child: ColoredBox(color: Color(0xFF6B6E9B))),
            Positioned.fill(
              child: Image.asset(
                'assets/figma/page1_learning/593-13962.png',
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(.45),
              ),
            ),
            Positioned(
              left: 4,
              top: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _badge(
                    'Nhiệm vụ gần đây:',
                    const Color(0xFFFFF7F7),
                    const Color(0xFFFF6262),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF282643),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x55000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Vũ điệu đường phố ⚡',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 2,
              bottom: 0,
              width: 118,
              height: 73,
              child: Image.asset(
                'assets/figma/page1_learning/4d6075154e9c62b53377f277aacdb50ec4dcc393.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _badge(String text, Color background, Color foreground) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFCCD5DE)),
    ),
    child: Text(text, style: TextStyle(fontSize: 10, color: foreground)),
  );

  Widget _missionBoard() => Padding(
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
    child: Column(
      children: [
        SizedBox(
          height: 28,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: Container(
                  color: const Color(0xFFE2BA8C),
                  foregroundDecoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF23272E),
                      width: 1,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 12,
                bottom: 0,
                width: 180,
                height: 36,
                child: Image.asset(
                  'assets/figma/page1_learning/593-13936.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF475D6B),
              border: Border.symmetric(
                vertical: BorderSide(color: const Color(0xFF232B35), width: 2),
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
              children: [
                _missionCard(
                  0,
                  'Ghép bạn cùng bàn nhận đồng phục phong cách Anh',
                  '1/1',
                  'Đồng phục',
                  true,
                  'Nhận',
                ),
                _missionCard(
                  1,
                  'Gia nhập lớp học bất kỳ (Hạng ≥ Hoàng kim)',
                  '0/1',
                  'x30',
                  false,
                  'Đi ngay',
                ),
                _missionCard(
                  2,
                  'Gia nhập lớp Đồng ≥ 7 ngày',
                  '0/1',
                  'x66',
                  false,
                  'Đi ngay',
                ),
                _missionCard(
                  3,
                  'Mua 1 vật phẩm trang trí bàn học',
                  '0/1',
                  'x10',
                  false,
                  'Đi ngay',
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: Container(
                  color: const Color(0xFFE2BA8C),
                  foregroundDecoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF23272E),
                      width: 1,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 6,
                right: 6,
                top: 2,
                height: 19,
                child: Image.asset(
                  'assets/figma/page1_learning/593-13952.png',
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _missionCard(
    int index,
    String title,
    String progress,
    String reward,
    bool rewardClothing,
    String action,
  ) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFF23272E)),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x18000000),
          blurRadius: 2,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 6),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ),
              Container(
                width: 46,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  border: Border.all(color: const Color(0xFF344454)),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  progress,
                  style: const TextStyle(fontSize: 10, color: _ink),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Color(0xFFE5E7EB)),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rewardIcon(reward, rewardClothing),
              SizedBox(
                width: rewardClothing ? 84 : 84,
                height: 34,
                child: OutlinedButton(
                  onPressed: () {
                    if (rewardClothing && !_claimed.contains(index)) {
                      setState(() => _claimed.add(index));
                    }
                    if (!rewardClothing) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(title),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1F2937),
                    backgroundColor: rewardClothing
                        ? const Color(0xFFFFF08A)
                        : const Color(0xFF9DE7F5),
                    side: const BorderSide(color: Color(0xFF23272E)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    _claimed.contains(index) ? 'Đã nhận' : action,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _rewardIcon(String label, bool clothing) => Container(
    width: 50,
    height: 54,
    decoration: BoxDecoration(
      color: const Color(0xFFFFFCF4),
      border: Border.all(color: const Color(0xFF4B5563)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          clothing ? Icons.checkroom : Icons.monetization_on,
          color: const Color(0xFFF5A623),
          size: 24,
        ),
        Text(label, style: const TextStyle(fontSize: 9, color: _ink)),
      ],
    ),
  );
}

class _LearningStatusBar extends StatelessWidget {
  const _LearningStatusBar({this.background = Colors.white});
  final Color background;

  @override
  Widget build(BuildContext context) => Container(
    color: background,
    height: 32,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        const Text(
          '18:17',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 12,
            color: _ink,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Container(
          width: 20,
          height: 18,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: _ink, width: .8),
            borderRadius: BorderRadius.circular(2),
          ),
          child: const Text(
            'Vo\nLTE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 6,
              height: .9,
              color: _ink,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 7),
        const Icon(Icons.wifi, size: 14, color: _ink),
        const SizedBox(width: 6),
        const Icon(Icons.signal_cellular_alt, size: 13, color: _ink),
        const SizedBox(width: 6),
        Container(
          width: 19,
          height: 14,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: _ink, width: .8),
            borderRadius: BorderRadius.circular(3),
          ),
          child: const Text(
            '61',
            style: TextStyle(fontFamily: 'Roboto', fontSize: 8, color: _ink),
          ),
        ),
      ],
    ),
  );
}
