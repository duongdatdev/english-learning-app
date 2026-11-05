import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'design/generated/figma_context_data.dart';
import 'design/figma_catalog.dart';
import 'design/figma_frames.dart';
import 'features/home/home_screens.dart';
import 'features/community/community_screens.dart';
import 'features/learning/learning_screens.dart';
import 'features/reading/reading_screens.dart';
import 'features/shop/shop_ai_screens.dart';
import 'features/study/study_screens.dart';
import 'features/study/study_discovery_screen.dart';

const _ink = Color(0xFF1F2937);
const _muted = Color(0xFF9CA3AF);
const _line = Color(0xFFD1D5DB);
const _lime = Color(0xFF84CC16);
const _orange = Color(0xFFFF8200);
const _serif = 'Noto Serif';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const ReadingLibraryApp());
}

class ReadingLibraryApp extends StatelessWidget {
  const ReadingLibraryApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Thư viện truyện',
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(seedColor: _orange),
      useMaterial3: true,
      fontFamily: _serif,
    ),
    home: const _Page1Home(),
  );
}

class _Page1Home extends StatelessWidget {
  const _Page1Home();

  void _open(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  }

  Widget _homeFeaturePage(BuildContext context, int index) => switch (index) {
    // No prototype reaction for Tác phẩm; the library is the useful local route.
    0 => const LibraryScreen(),
    1 => _figmaFrame(context, '593:15236'),
    2 => _figmaFrame(context, '593:16737'),
    _ => _figmaFrame(context, '593:15403'),
  };

  Widget _figmaFrame(BuildContext context, String id) {
    final tabBuilder = _primaryTabBuilders(context)[id];
    if (tabBuilder != null) return tabBuilder(context);
    return Page1FigmaRouteScreen.fromId(
      id: id,
      frames: page1Frames,
      customFrameBuilders: _primaryTabBuilders(context),
    );
  }

  Map<String, WidgetBuilder> _primaryTabBuilders(BuildContext context) => {
    ...page1VocabularyExerciseBuilders,
    for (final id in [
      '593:3297',
      '593:3230',
      '593:3425',
      '593:3495',
      '593:3563',
      '593:3374',
    ])
      id: (_) => id == '593:3374'
          ? Page1VocabularyInputScreen(
              onBackToHome: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
              onNavigateFrame: (nextId) =>
                  _open(context, _figmaFrame(context, nextId)),
            )
          : Page1VocabularyExerciseScreen(
              frameId: id,
              onNavigateFrame: (nextId) =>
                  _open(context, _figmaFrame(context, nextId)),
              onBackToHome: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
            ),
    '593:21095': (_) => StudyDiscoveryScreen(
      onTabSelected: (index) => _openTab(context, index, currentIndex: 1),
    ),
    '1170:3772': (_) => _homeScreen(context),
    '593:7916': (_) => Page1TownMapScreen(
      onTabSelected: (index) => _openTab(context, index, currentIndex: 2),
    ),
    '785:1148': (_) => Page1ProfileScreen(
      onTabSelected: (index) => _openTab(context, index, currentIndex: 4),
    ),
    '593:18778': (_) => SopHomeScreen(
      onTabSelected: (index) => _openTab(context, index, currentIndex: 3),
    ),
  };

  void _openConversationOverlay(BuildContext context, int category) {
    const ids = <int, String>{
      0: '844:12181',
      1: '964:15016',
      2: '1148:11260',
      3: '1148:11193',
    };
    final id = ids[category];
    if (id == null) return;
    if (!page1FigmaContexts.containsKey(id)) {
      // The prototype has no Dart context for the Reading / Writing sheets;
      // fall back to the matching custom pages for those categories.
      if (category == 2) {
        _open(context, const ReadingNewsScreen());
      } else if (category == 3) {
        _open(context, WritingPracticeScreen(chatMode: true));
      }
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => FractionallySizedBox(
        heightFactor: category == 0 ? .44 : .58,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: _figmaFrame(sheetContext, id),
        ),
      ),
    );
  }

  Widget _conversationPage(BuildContext context, int category, [int? action]) {
    Widget aiPage(String id) => page1ShopAiBuilders[id]!(context);
    return switch (category) {
      0 =>
        action == 1
            ? aiPage('958:12261')
            : action == 2
            ? aiPage('964:12549')
            : const StoryPlayerScreen(),
      1 =>
        action == 1
            ? aiPage('958:12261')
            : action == 2
            ? aiPage('964:12549')
            : const PhoneticsRoadmapScreen(),
      2 => action == 1 ? const ReadingNewsScreen() : const LibraryScreen(),
      3 => WritingPracticeScreen(chatMode: action == 1),
      _ => const LibraryScreen(),
    };
  }

  void _openTab(BuildContext context, int index, {int currentIndex = 0}) {
    if (index == currentIndex) return;
    if (index == 0) {
      _open(context, _homeScreen(context));
      return;
    }
    const destinations = <int, String>{
      1: '593:21095', // Học tập → Khám phá khóa học
      2: '593:7916', // Cùng học → Bản đồ thị trấn
      3: '593:18778', // Đổi xu → Cửa hàng
      4: '785:1148', // Cá nhân → Hồ sơ
    };
    final id = destinations[index];
    if (id == null) return;
    _open(context, _figmaFrame(context, id));
  }

  Widget _homeScreen(BuildContext context) => ChatHomeScreen(
    onTabSelected: (index) {
      _openTab(context, index, currentIndex: 0);
    },
    onCatalogSelected: () => _open(context, _figmaFrame(context, '593:7393')),
    onFeatureSelected: (index) =>
        _open(context, _homeFeaturePage(context, index)),
    onTaskSelected: () => _open(context, _figmaFrame(context, '593:3878')),
    onRankSelected: () => _open(context, _figmaFrame(context, '593:3710')),
    onInboxSelected: () => _open(context, _figmaFrame(context, '593:4010')),
    // Figma: both Học and Ôn tập navigate to the same frame.
    onStudySelected: () => _open(context, _figmaFrame(context, '593:3297')),
    onReviewSelected: () => _open(context, _figmaFrame(context, '593:3297')),
    onEditPlanSelected: () =>
        _open(context, page1StudyBuilders['593:1664']!(context)),
    onBuyBooksSelected: () => _open(context, const LibraryScreen()),
    onConversationSelected: (index) => _openConversationOverlay(context, index),
    onConversationActionSelected: (category, action) =>
        _open(context, _conversationPage(context, category, action)),
  );

  @override
  Widget build(BuildContext context) => _homeScreen(context);
}

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _level = 1;
  int _selectedBook = 0;
  String _filter = 'Sắp xếp mặc định';

  void _showHelp() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const _LevelGuideScreen()));
  }

  void _showFilters() {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Đóng bộ lọc',
      barrierColor: Colors.transparent,
      pageBuilder: (_, _, _) => SafeArea(
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 142),
            child: Material(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              child: SizedBox(
                width: 176,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _filterOption(
                        'Ưu tiên chưa lồng tiếng',
                        height: 36,
                        icon: Icons.mic_none,
                        iconColor: const Color(0xFFD8B4FE),
                        iconBackground: const Color(0xFFFAF5FF),
                        selected: _filter == 'Ưu tiên chưa lồng tiếng',
                      ),
                      const SizedBox(height: 10),
                      _filterOption(
                        'Ưu tiên chưa đọc',
                        height: 20,
                        icon: Icons.menu_book_outlined,
                        iconColor: const Color(0xFFFDBA74),
                        iconBackground: const Color(0xFFFFF7ED),
                        selected: _filter == 'Ưu tiên chưa đọc',
                      ),
                      const SizedBox(height: 10),
                      _filterOption(
                        'Sắp xếp mặc định',
                        height: 20,
                        icon: Icons.calendar_month_outlined,
                        selected: _filter == 'Sắp xếp mặc định',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterOption(
    String value, {
    required double height,
    required IconData icon,
    Color iconColor = Colors.white,
    Color? iconBackground,
    bool selected = false,
  }) => InkWell(
    onTap: () {
      setState(() => _filter = value);
      Navigator.pop(context);
    },
    child: SizedBox(
      height: height,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF3B82F6) : iconBackground,
              borderRadius: BorderRadius.circular(selected ? 4 : 999),
            ),
            child: Icon(
              icon,
              size: 14,
              color: selected ? Colors.white : iconColor,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontFamily: _serif,
                fontSize: 12,
                height: 1.5,
                color: selected ? _ink : _muted,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const _StatusBar(),
          _header(),
          _toolbar(),
          Expanded(child: _bookGrid()),
          _readingFooter(),
        ],
      ),
    );
  }

  Widget _header() => SizedBox(
    height: 100,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        children: [
          SizedBox(
            height: 28,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text(
                  'Mở rộng đọc',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints.tightFor(
                      width: 24,
                      height: 28,
                    ),
                    icon: const Icon(Icons.chevron_left, size: 22, color: _ink),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) {
              final level = index + 1;
              final active = _level == level;
              return InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: () => setState(() => _level = level),
                child: Container(
                  width: active ? 48 : 50,
                  height: active ? 26 : 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: active ? _orange : Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    border: active ? null : Border.all(color: _line),
                  ),
                  child: Text(
                    'R$level',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                      color: active ? Colors.white : _muted,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    ),
  );

  Widget _toolbar() => Container(
    height: 45,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 24, height: 28),
          icon: const Icon(Icons.filter_list, size: 20, color: _ink),
          onPressed: _showFilters,
          tooltip: 'Lọc truyện',
        ),
        InkWell(
          onTap: _showHelp,
          child: const Row(
            children: [
              Text(
                'Giải thích cấp độ',
                style: TextStyle(
                  color: _muted,
                  fontSize: 10,
                  height: 1.5,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.help_outline, size: 14, color: _muted),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _bookGrid() => GridView.builder(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
    itemCount: 7,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 16,
      childAspectRatio: 103.33 / 123.08,
    ),
    itemBuilder: (context, index) => _BookCard(
      selected: _selectedBook == index,
      onTap: () => setState(() => _selectedBook = index),
    ),
  );

  Widget _readingFooter() => Container(
    height: 65,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: const BoxDecoration(
      color: Color(0xFF4A3427),
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            'assets/figma/630-5032.png',
            width: 40,
            height: 44,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My little dog',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                _selectedBook == 0
                    ? 'Đang đọc tới trang 2'
                    : 'Sẵn sàng tiếp tục',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFFFDE68A),
                  fontSize: 10,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const StoryPlayerScreen()),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: _orange,
            foregroundColor: Colors.white,
            minimumSize: const Size(120, 30),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            shape: const StadiumBorder(),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tiếp tục đọc',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 16),
            ],
          ),
        ),
      ],
    ),
  );
}

class _BookCard extends StatelessWidget {
  const _BookCard({required this.selected, required this.onTap});

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Column(
      children: [
        Container(
          height: 103.33,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: const Color(0xFFE2F0D9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _lime, width: 3),
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    'assets/figma/630-4908.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Container(
                height: 6,
                alignment: Alignment.centerLeft,
                color: Colors.white,
                child: FractionallySizedBox(
                  widthFactor: .77,
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: _lime,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const SizedBox(
          height: 14,
          child: Center(
            child: Text(
              'My Little Dog',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: _ink,
                fontSize: 10,
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
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
              fontFamily: 'Roboto',
              color: _ink,
              fontSize: 12,
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
                color: _ink,
                fontSize: 6,
                height: .9,
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
              style: TextStyle(fontFamily: 'Roboto', color: _ink, fontSize: 8),
            ),
          ),
        ],
      ),
    ),
  );
}

class _LevelGuideScreen extends StatelessWidget {
  const _LevelGuideScreen();

  static const _levels = [
    ('A1', 'R1-R2', Color(0xFF8BC34A)),
    ('A2', 'R3-R4', Color(0xFFFF9800)),
    ('B1', 'R5-R6', Color(0xFFFF6E6E)),
    ('B2', 'R7-R8', Color(0xFF9C6ADE)),
    ('C1', 'R9-R10', Color(0xFFF48FB1)),
    ('C2', 'R11-R16', Color(0xFF26C6DA)),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF8F9FA),
    body: Column(
      children: [
        const ColoredBox(color: Colors.white, child: _StatusBar()),
        SizedBox(
          height: 56,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Text(
                'Giải thích cấp độ',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .325,
                  height: 1.5,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: 32,
                    height: 32,
                  ),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Color(0xFF222222),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              SizedBox(
                height: 350,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFF0F0F0)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      for (var i = 0; i < _levels.length; i++)
                        Expanded(
                          child: Row(
                            children: [
                              Container(width: 6, color: _levels[i].$3),
                              Container(
                                width: 78,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Color(0xFFF0F0F0)),
                                  ),
                                ),
                                child: Text(
                                  _levels[i].$1,
                                  style: const TextStyle(
                                    fontFamily: _serif,
                                    color: Color(0xFF666666),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: i < _levels.length - 1
                                        ? const Border(
                                            bottom: BorderSide(
                                              color: Color(0xFFF0F0F0),
                                            ),
                                          )
                                        : null,
                                  ),
                                  child: Text(
                                    'Đề xuất đọc truyện tranh ${_levels[i].$2}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: _serif,
                                      color: Color(0xFF333333),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
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
              const SizedBox(height: 48),
              const Text(
                'Hãy cùng bé khám phá thế giới truyện tranh,',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: _serif,
                  color: Color(0xFF777777),
                  fontSize: 12,
                  height: 1.625,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tận hưởng niềm vui đọc sách!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: _serif,
                  color: Color(0xFF888888),
                  fontSize: 10,
                  height: 1.625,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
