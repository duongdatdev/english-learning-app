import 'package:flutter/material.dart';

import '../home/home_screens.dart';

class StudyDiscoveryScreen extends StatelessWidget {
  const StudyDiscoveryScreen({super.key, this.onTabSelected});

  final ValueChanged<int>? onTabSelected;

  static const _ink = Color(0xFF1F2937);
  static const _muted = Color(0xFF9CA3AF);
  static const _blue = Color(0xFF3B82F6);
  static const _categories = <(String, IconData)>[
    ('TOEIC', Icons.workspace_premium_outlined),
    ('Đại học', Icons.school_outlined),
    ('Du học', Icons.flight_takeoff),
    ('Thực tế', Icons.coffee_outlined),
    ('4 KN', Icons.headphones_outlined),
    ('Lý lịch', Icons.trending_up),
    ('Ngữ pháp', Icons.spellcheck),
    ('1 câu/ngày', Icons.calendar_today_outlined),
    ('IELTS', Icons.edit_note),
    ('Giảng đường', Icons.menu_book_outlined),
    ('Nâng cao', Icons.auto_awesome_outlined),
    ('Tiểu thuyết', Icons.book_outlined),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF7F8FA),
    body: Column(
      children: [
        const _StudyStatusBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                _categoryPanel(),
                const SizedBox(height: 27),
                _sectionTitle('Đột phá tiếng Anh chuyên đề'),
                const SizedBox(height: 9),
                _courseCards(),
                const SizedBox(height: 20),
                _sectionTitle('Chủ đề đặc biệt'),
                const SizedBox(height: 9),
                _featuredTopic(),
              ],
            ),
          ),
        ),
      ],
    ),
    bottomNavigationBar: Page1BottomNavigationBar(
      selectedIndex: 1,
      labels: const ['Từ vựng', 'Học tập', 'Cùng học', 'Đổi xu', 'Cá nhân'],
      onTabSelected: onTabSelected,
    ),
  );

  Widget _header() => SizedBox(
    height: 53,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 1, 16, 5),
      child: Row(
        children: [
          const Text(
            'Trực tuyến',
            style: TextStyle(
              color: _ink,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 16),
          const Text('Của tôi', style: TextStyle(color: _muted, fontSize: 13)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.face_6_outlined, size: 15, color: _muted),
                SizedBox(width: 5),
                Text(
                  'Bản thiếu nhi',
                  style: TextStyle(fontSize: 10, color: _ink),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _categoryPanel() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Color(0x08000000),
          blurRadius: 12,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        GridView.builder(
          itemCount: _categories.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisExtent: 67,
            crossAxisSpacing: 2,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            final (label, icon) = _categories[index];
            return Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F6FB),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(icon, color: const Color(0xFF4B5563), size: 21),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 8.5,
                    height: 1.2,
                  ),
                ),
              ],
            );
          },
        ),
        Container(
          width: 20,
          height: 3,
          decoration: BoxDecoration(
            color: _blue,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    ),
  );

  Widget _sectionTitle(String value) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: Text(
      value,
      style: const TextStyle(
        color: _ink,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.35,
      ),
    ),
  );

  Widget _courseCards() => SizedBox(
    height: 141,
    child: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      scrollDirection: Axis.horizontal,
      children: const [
        _CourseCard(),
        SizedBox(width: 10),
        _CourseCard(),
        SizedBox(width: 10),
        _CourseCard(),
      ],
    ),
  );

  Widget _featuredTopic() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x10000000),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          height: 138,
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4B5563), Color(0xFF64748B)],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              const _BookCover(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tiếng anh thực tế',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white70,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const _LearnerAvatars(),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text(
                            '2.8 nghìn người đang học',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFFF1F5F9),
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 149 / 62,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              _MiniTopicCard(),
              _MiniTopicCard(),
              _MiniTopicCard(),
              _MiniTopicCard(),
            ],
          ),
        ),
      ],
    ),
  );
}

class _CourseCard extends StatelessWidget {
  const _CourseCard();

  @override
  Widget build(BuildContext context) => Container(
    width: 110,
    height: 141,
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFF1F5F9)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _CourseCover(),
        const SizedBox(height: 6),
        const Text(
          'Bí kíp 800',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
      ],
    ),
  );
}

class _CourseCover extends StatelessWidget {
  const _CourseCover();

  @override
  Widget build(BuildContext context) => Container(
    height: 96,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF38BDF8), Color(0xFF60A5FA)],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Stack(
      children: [
        Align(
          alignment: const Alignment(0, -.48),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'ez for exam',
              style: TextStyle(color: Colors.white, fontSize: 7, height: 1),
            ),
          ),
        ),
        const Center(child: _ToeicArtwork()),
      ],
    ),
  );
}

class _ToeicArtwork extends StatelessWidget {
  const _ToeicArtwork();

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 64,
    height: 56,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        const Positioned(
          left: 17,
          top: 10,
          child: _PaintDot(Color(0xFFFB923C)),
        ),
        const Positioned(left: 28, top: 7, child: _PaintDot(Color(0xFF4ADE80))),
        const Positioned(
          left: 39,
          top: 10,
          child: _PaintDot(Color(0xFF818CF8)),
        ),
        Positioned(
          left: 14,
          top: 18,
          child: Container(
            width: 38,
            height: 29,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFFDA4AF),
              border: Border.all(color: const Color(0xFF1E293B), width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              'Toeic',
              style: TextStyle(
                color: Color(0xFFF43F5E),
                fontFamily: 'Noto Serif',
                fontSize: 8,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        Positioned(
          left: 5,
          top: 36,
          child: Transform.rotate(
            angle: -.78,
            child: Container(
              width: 23,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFF38BDF8),
                border: Border.all(color: const Color(0xFF1E293B), width: 1.4),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _PaintDot extends StatelessWidget {
  const _PaintDot(this.color);
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: 8,
    height: 8,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

class _BookCover extends StatelessWidget {
  const _BookCover();

  @override
  Widget build(BuildContext context) => Container(
    width: 80,
    height: 104,
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, .42, .43, 1],
                colors: [
                  Color(0xFF7DD3FC),
                  Color(0xFFFEF3C7),
                  Color(0xFFFDE68A),
                  Color(0xFFFDE68A),
                ],
              ),
            ),
            child: SizedBox.expand(),
          ),
          Positioned(
            left: 7,
            right: 7,
            top: 20,
            child: Container(
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                border: Border.all(color: const Color(0xFFFCD34D), width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text.rich(
                TextSpan(
                  text: 'See\n',
                  style: TextStyle(color: Color(0xFF78350F), fontSize: 7),
                  children: [
                    TextSpan(
                      text: 'the\n',
                      style: TextStyle(
                        color: Color(0xFFBE123C),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(text: 'world'),
                  ],
                ),
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.05),
              ),
            ),
          ),
          Positioned(
            bottom: 7,
            left: 25,
            child: Container(
              width: 28,
              height: 25,
              color: const Color(0xFF92400E),
            ),
          ),
        ],
      ),
    ),
  );
}

class _LearnerAvatars extends StatelessWidget {
  const _LearnerAvatars();

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 57,
    height: 20,
    child: Stack(
      children: [
        _avatar(0, const Color(0xFFF59E0B), 'V'),
        _avatar(11, const Color(0xFF14B8A6), 'K'),
        _avatar(22, const Color(0xFF6366F1), 'T'),
        _avatar(33, const Color(0xFFEA580C), 'D'),
      ],
    ),
  );

  Widget _avatar(double x, Color color, String letter) => Positioned(
    left: x,
    child: Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Text(
        letter,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 7,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

class _MiniTopicCard extends StatelessWidget {
  const _MiniTopicCard();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    child: Row(
      children: [
        Container(
          width: 46,
          height: 50,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF3B82F6),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  '0 - 450',
                  style: TextStyle(color: Colors.white, fontSize: 5, height: 1),
                ),
              ),
              const Spacer(),
              Container(
                height: 16,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Text(
                  'TOEIC',
                  style: TextStyle(
                    color: Color(0xFF7E22CE),
                    fontSize: 6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nghe trải nghiệm',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Mọi người đều nên học',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 7),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _StudyStatusBar extends StatelessWidget {
  const _StudyStatusBar();

  @override
  Widget build(BuildContext context) => const SizedBox(
    height: 32,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            '18:17',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFF1F2937),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Icon(Icons.signal_cellular_alt, size: 13, color: Color(0xFF1F2937)),
          SizedBox(width: 6),
          Icon(Icons.wifi, size: 14, color: Color(0xFF1F2937)),
          SizedBox(width: 6),
          Icon(Icons.battery_5_bar, size: 18, color: Color(0xFF1F2937)),
        ],
      ),
    ),
  );
}
