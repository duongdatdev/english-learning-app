import 'package:flutter/material.dart';

import '../home/home_screens.dart';

class Page1TownMapScreen extends StatelessWidget {
  const Page1TownMapScreen({super.key, required this.onTabSelected});
  final ValueChanged<int> onTabSelected;
  static const _labels = [
    'Từ vựng',
    'Học tập',
    'Cùng học',
    'Đổi xu',
    'Cá nhân',
  ];
  static const _art = <(String, double, double, double, double)>[
    (
      'assets/figma/page1_all/f7eabdd402b68cbbfe0a73697e023f7f2c5b3f44.png',
      -25,
      510,
      123,
      114,
    ),
    (
      'assets/figma/page1_all/2563d6e54f29e80c90a425bbdb8581225ff47bbd.png',
      14,
      190,
      98,
      131,
    ),
    (
      'assets/figma/page1_all/02276202545bbf8f9a1a688cd79e022ba13bfdd2.png',
      220,
      240,
      76,
      116,
    ),
    (
      'assets/figma/page1_all/8eb36eac393060bdef8b3ddb206f78d054cd4a7f.png',
      118,
      50,
      70,
      102,
    ),
    (
      'assets/figma/page1_all/e6f3bb7fd609b2a01cf6fc04a70560fb5d94022d.png',
      175,
      470,
      70,
      89,
    ),
    (
      'assets/figma/page1_all/bedfbfcb8f3837363e31e69d06944aab582cbad9.png',
      27,
      350,
      48,
      49,
    ),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        const SizedBox(height: 32),
        Expanded(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: 360,
              height: 680,
              child: Stack(
                children: [
                  const Positioned.fill(
                    child: CustomPaint(painter: _TownMapPainter()),
                  ),
                  for (final (asset, x, y, w, h) in _art)
                    Positioned(
                      left: x,
                      top: y,
                      width: w,
                      height: h,
                      child: Image.asset(asset, fit: BoxFit.contain),
                    ),
                  const Positioned(
                    left: 25,
                    right: 25,
                    top: 8,
                    child: _MapBanner(),
                  ),
                  const Positioned(
                    left: 185,
                    top: 50,
                    child: Icon(
                      Icons.cloud_rounded,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  const Positioned(
                    left: 273,
                    top: 42,
                    child: Icon(
                      Icons.cloud_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const Positioned(
                    left: 246,
                    top: 102,
                    child: Icon(
                      Icons.park_rounded,
                      size: 40,
                      color: Color(0xff3d982d),
                    ),
                  ),
                  const Positioned(
                    left: 180,
                    top: 395,
                    child: Icon(
                      Icons.park_rounded,
                      size: 38,
                      color: Color(0xff3d982d),
                    ),
                  ),
                  const Positioned(
                    left: 292,
                    top: 590,
                    child: Icon(
                      Icons.park_rounded,
                      size: 38,
                      color: Color(0xff3d982d),
                    ),
                  ),
                  const Positioned(
                    right: 12,
                    top: 80,
                    child: _MapAction(
                      icon: Icons.account_box_outlined,
                      label: 'Thị trường',
                    ),
                  ),
                  const Positioned(
                    right: 12,
                    top: 147,
                    child: _MapAction(
                      icon: Icons.mail_outline_rounded,
                      label: 'Bạn bè',
                    ),
                  ),
                  const Positioned(
                    right: 12,
                    top: 214,
                    child: _MapAction(
                      icon: Icons.inventory_2_outlined,
                      label: 'Ba lô',
                    ),
                  ),
                  const Positioned(
                    left: 178,
                    top: 179,
                    child: _MapCoin(label: 'x?'),
                  ),
                  const Positioned(
                    left: 142,
                    top: 240,
                    child: _MapCoin(label: 'x?'),
                  ),
                  const Positioned(
                    left: 156,
                    top: 357,
                    child: _MapCoin(label: 'x?'),
                  ),
                  Positioned(
                    left: 20,
                    top: 560,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Nhiệm vụ hôm nay  2/3',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xff365d3d),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Page1BottomNavigationBar(
          selectedIndex: 2,
          labels: _labels,
          onTabSelected: onTabSelected,
        ),
      ],
    ),
  );
}

class _MapBanner extends StatelessWidget {
  const _MapBanner();
  @override
  Widget build(BuildContext context) => Container(
    height: 42,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: const Color(0xfffffdf2),
      border: Border.all(color: const Color(0xff263b2b), width: 2),
      borderRadius: BorderRadius.circular(13),
    ),
    child: const Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 13, color: Color(0xff272727)),
        children: [
          TextSpan(text: 'Hôm nay  '),
          TextSpan(
            text: '879531 người',
            style: TextStyle(
              color: Color(0xffe88820),
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(text: '  đang cùng học'),
        ],
      ),
    ),
  );
}

class _MapAction extends StatelessWidget {
  const _MapAction({required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 62,
    child: Column(
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xfffffff6),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xff384134), width: 2),
          ),
          child: Icon(icon, size: 19, color: const Color(0xff3f473d)),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: const TextStyle(fontSize: 9, color: Color(0xff202820)),
        ),
      ],
    ),
  );
}

class _MapCoin extends StatelessWidget {
  const _MapCoin({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 27,
        height: 27,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xffffdf69),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xffc18a10), width: 2),
        ),
        child: const Icon(
          Icons.monetization_on,
          size: 22,
          color: Color(0xffe6a91c),
        ),
      ),
      Text(
        label,
        style: const TextStyle(
          fontSize: 8,
          height: 1,
          color: Color(0xff263626),
        ),
      ),
    ],
  );
}

class _TownMapPainter extends CustomPainter {
  const _TownMapPainter();
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(const Color(0xffa3d086), BlendMode.src);
    final road = Paint()
      ..color = const Color(0xfffff2c8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 35
      ..strokeCap = StrokeCap.round;
    final route = Path()
      ..moveTo(180, 115)
      ..cubicTo(310, 180, 35, 210, 185, 315)
      ..cubicTo(330, 415, 60, 420, 182, 535)
      ..cubicTo(220, 580, 225, 620, 200, 665);
    canvas.drawPath(route, road);
    final dash = Paint()
      ..color = const Color(0xffddb968)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(route, dash);
    for (var i = 0; i < 17; i++) {
      final x = (i * 79 + 23) % size.width;
      final y = (i * 113 + 37) % size.height;
      if ((x - 180).abs() < 35) continue;
      canvas.drawCircle(
        Offset(x, y),
        5 + (i % 3) * 2,
        Paint()..color = const Color(0xff76b867),
      );
      canvas.drawCircle(
        Offset(x - 5, y - 6),
        4,
        Paint()..color = const Color(0xff8bc878),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Offline-first community, classroom and achievement screens for Page 1.
/// All controls keep their state locally until a backend is added.
final Map<String, WidgetBuilder> page1CommunityBuilders = {
  '593:7769': (_) =>
      const _CommunityScreen(config: _CommunityConfig.studentCard),
  '593:7916': (_) => const _CommunityScreen(config: _CommunityConfig.town),
  '593:8427': (_) => const _CommunityScreen(config: _CommunityConfig.cardStyle),
  '593:9121': (_) => const _CommunityScreen(config: _CommunityConfig.recruit),
  '593:9544': (_) => const _CommunityScreen(config: _CommunityConfig.member),
  '593:11463': (_) => const _CommunityScreen(config: _CommunityConfig.poster),
  '593:11623': (_) => const _CommunityScreen(config: _CommunityConfig.poster),
  '593:11787': (_) =>
      const _CommunityScreen(config: _CommunityConfig.promoteClass),
  '692:3304': (_) =>
      const _CommunityScreen(config: _CommunityConfig.promoteClass),
  '593:11895': (_) => const _CommunityScreen(config: _CommunityConfig.posts),
  '593:15019': (_) =>
      const _CommunityScreen(config: _CommunityConfig.achievementCard),
  '696:4059': (_) => const _CommunityScreen(config: _CommunityConfig.myClass),
  '727:4892': (_) => const _CommunityScreen(config: _CommunityConfig.honors),
  '727:5374': (_) =>
      const _CommunityScreen(config: _CommunityConfig.createClass),
  '727:5575': (_) => const _CommunityScreen(config: _CommunityConfig.joinClass),
  '757:637': (_) =>
      const _CommunityScreen(config: _CommunityConfig.weeklyAchievement),
  '776:4459': (_) => const _CommunityScreen(config: _CommunityConfig.friends),
  '776:4666': (_) =>
      const _CommunityScreen(config: _CommunityConfig.findFriends),
  '777:5891': (_) =>
      const _CommunityScreen(config: _CommunityConfig.posterDetail),
  '777:6268': (_) => const _CommunityScreen(config: _CommunityConfig.honors),
  '777:7254': (_) =>
      const _CommunityScreen(config: _CommunityConfig.suggestClass),
};

enum _CommunityKind {
  studentCard,
  town,
  cardStyle,
  recruit,
  member,
  poster,
  promoteClass,
  posts,
  achievementCard,
  myClass,
  honors,
  createClass,
  joinClass,
  weeklyAchievement,
  friends,
  findFriends,
  posterDetail,
  suggestClass,
}

class _CommunityConfig {
  const _CommunityConfig(
    this.title,
    this.subtitle,
    this.kind,
    this.items, {
    this.action = 'Lưu thay đổi',
    this.icon = Icons.groups_rounded,
  });

  final String title;
  final String subtitle;
  final _CommunityKind kind;
  final List<String> items;
  final String action;
  final IconData icon;

  static const studentCard = _CommunityConfig(
    'Thẻ học sinh',
    'Hồ sơ học tập Study Together',
    _CommunityKind.studentCard,
    ['Người học chăm chỉ', 'Đang học tiếng Anh', 'Chuỗi 7 ngày'],
    action: 'Chỉnh sửa thẻ',
    icon: Icons.badge_rounded,
  );
  static const town = _CommunityConfig(
    'Thị trấn học tập',
    'Cùng học và mở khóa các khu vực mới',
    _CommunityKind.town,
    ['Thư viện', 'Quảng trường', 'Khu vườn từ vựng', 'Phòng học'],
    action: 'Khám phá khu vực',
    icon: Icons.map_rounded,
  );
  static const cardStyle = _CommunityConfig(
    'Tùy chỉnh thẻ học sinh',
    'Chọn phong cách hồ sơ của bạn',
    _CommunityKind.cardStyle,
    ['Màu kem', 'Màu xanh', 'Màu hồng', 'Màu tím'],
  );
  static const recruit = _CommunityConfig(
    'Quảng trường chiêu mộ',
    'Tìm bạn học cùng mục tiêu',
    _CommunityKind.recruit,
    ['Luyện giao tiếp mỗi ngày', 'Cùng ôn TOEIC', 'Thử thách từ vựng 7 ngày'],
    action: 'Tạo lời mời',
    icon: Icons.campaign_rounded,
  );
  static const member = _CommunityConfig(
    'Thông tin thành viên',
    'Hồ sơ và hoạt động học tập',
    _CommunityKind.member,
    ['Tiến độ học tập', 'Thành tích', 'Lớp đang tham gia'],
    action: 'Theo dõi',
    icon: Icons.person_rounded,
  );
  static const poster = _CommunityConfig(
    'Chọn kiểu áp phích',
    'Chọn mẫu để chia sẻ lời mời',
    _CommunityKind.poster,
    ['Mẫu học tập', 'Mẫu vui nhộn', 'Mẫu tối giản'],
    action: 'Dùng mẫu này',
    icon: Icons.dashboard_customize_rounded,
  );
  static const promoteClass = _CommunityConfig(
    'Chọn lớp để quảng bá',
    'Chia sẻ lớp học tới người học khác',
    _CommunityKind.promoteClass,
    ['English Daily Club', 'TOEIC 500+', 'Luyện phát âm'],
    action: 'Tiếp tục',
    icon: Icons.school_rounded,
  );
  static const posts = _CommunityConfig(
    'Bài đăng',
    'Chia sẻ hành trình học tập của bạn',
    _CommunityKind.posts,
    ['Chưa có bài đăng', 'Chia sẻ mục tiêu đầu tiên của bạn'],
    action: 'Tạo bài đăng',
    icon: Icons.edit_note_rounded,
  );
  static const achievementCard = _CommunityConfig(
    'Thẻ thành tích cá nhân',
    'Những dấu mốc bạn đã đạt được',
    _CommunityKind.achievementCard,
    ['Hoàn thành 7 ngày học', 'Học 120 từ mới', 'Đạt 85% chính xác'],
    action: 'Chia sẻ thành tích',
    icon: Icons.emoji_events_rounded,
  );
  static const myClass = _CommunityConfig(
    'Lớp học của tôi',
    'Quản lý lớp và hoạt động học tập',
    _CommunityKind.myClass,
    ['English Daily Club', 'TOEIC 500+'],
    action: 'Tạo lớp học',
    icon: Icons.class_rounded,
  );
  static const honors = _CommunityConfig(
    'Bảng vinh danh lớp học',
    'Thành viên nổi bật tuần này',
    _CommunityKind.honors,
    ['Minh Anh · 1.240 điểm', 'Hoàng Nam · 980 điểm', 'Ngọc Hà · 860 điểm'],
    action: 'Xem bảng xếp hạng',
    icon: Icons.military_tech_rounded,
  );
  static const createClass = _CommunityConfig(
    'Tạo thông tin lớp học',
    'Đặt tên và mô tả lớp của bạn',
    _CommunityKind.createClass,
    ['Tên lớp học', 'Mục tiêu học tập', 'Mô tả ngắn'],
    action: 'Tạo lớp học',
    icon: Icons.add_home_work_rounded,
  );
  static const joinClass = _CommunityConfig(
    'Gia nhập lớp học',
    'Nhập mã lớp hoặc chọn lớp gợi ý',
    _CommunityKind.joinClass,
    ['Lớp học được đề xuất', 'Nhập mã lớp'],
    action: 'Gia nhập lớp',
    icon: Icons.meeting_room_rounded,
  );
  static const weeklyAchievement = _CommunityConfig(
    'Thành tích tuần trước',
    'Bạn đã duy trì nhịp học rất tốt',
    _CommunityKind.weeklyAchievement,
    ['5 ngày học liên tiếp', '4 giờ luyện tập', '72 từ đã ghi nhớ'],
    action: 'Xem chi tiết',
    icon: Icons.local_fire_department_rounded,
  );
  static const friends = _CommunityConfig(
    'Bạn bè & gợi ý kết bạn',
    'Cùng nhau học tập mỗi ngày',
    _CommunityKind.friends,
    ['Gợi ý kết bạn', 'Bạn bè của tôi', 'Mời bạn học'],
    action: 'Tìm bạn bè',
    icon: Icons.diversity_3_rounded,
  );
  static const findFriends = _CommunityConfig(
    'Tìm kiếm & thêm bạn bè',
    'Tìm theo tên hoặc mã người dùng',
    _CommunityKind.findFriends,
    ['Mai Linh', 'Đức Anh', 'Tuệ Nhi'],
    action: 'Thêm bạn',
    icon: Icons.person_add_alt_1_rounded,
  );
  static const posterDetail = _CommunityConfig(
    'Áp phích chiêu mộ',
    'Xem trước nội dung sẽ chia sẻ',
    _CommunityKind.posterDetail,
    [
      'Cùng học tiếng Anh nhé!',
      'Mục tiêu: 15 phút mỗi ngày',
      'Lớp học: English Daily Club',
    ],
    action: 'Chia sẻ áp phích',
    icon: Icons.share_rounded,
  );
  static const suggestClass = _CommunityConfig(
    'Lớp học đề xuất',
    'Chọn lớp phù hợp với mục tiêu của bạn',
    _CommunityKind.suggestClass,
    ['English Daily Club', 'Học từ vựng cùng nhau', 'Luyện nghe cơ bản'],
    action: 'Xem lớp học',
    icon: Icons.lightbulb_rounded,
  );
}

class _CommunityScreen extends StatefulWidget {
  const _CommunityScreen({required this.config});
  final _CommunityConfig config;

  @override
  State<_CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<_CommunityScreen> {
  final _search = TextEditingController();
  final _name = TextEditingController();
  int _selected = 0;
  final Set<int> _selectedItems = {};
  final Set<int> _joined = {};
  bool _saved = false;

  @override
  void dispose() {
    _search.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.config;
    final isSearch = c.kind == _CommunityKind.findFriends;
    final isForm =
        c.kind == _CommunityKind.createClass ||
        c.kind == _CommunityKind.joinClass;
    final isTown = c.kind == _CommunityKind.town;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFCF5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          c.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF263547),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _toast('Các thao tác đã sẵn sàng dùng offline'),
            icon: const Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                children: [
                  _hero(c, isTown),
                  const SizedBox(height: 22),
                  if (isSearch) _searchField(),
                  if (isSearch) const SizedBox(height: 16),
                  if (isForm) ..._formFields(c),
                  if (isForm) const SizedBox(height: 12),
                  if (c.kind == _CommunityKind.cardStyle ||
                      c.kind == _CommunityKind.poster)
                    _stylePicker(c),
                  if (c.kind == _CommunityKind.cardStyle ||
                      c.kind == _CommunityKind.poster)
                    const SizedBox(height: 18),
                  if (c.kind == _CommunityKind.honors ||
                      c.kind == _CommunityKind.weeklyAchievement ||
                      c.kind == _CommunityKind.achievementCard)
                    _statsCard(c),
                  if (c.kind == _CommunityKind.honors ||
                      c.kind == _CommunityKind.weeklyAchievement ||
                      c.kind == _CommunityKind.achievementCard)
                    const SizedBox(height: 18),
                  _sectionTitle(_sectionName(c)),
                  const SizedBox(height: 10),
                  ..._filteredItems(c)
                      .asMap()
                      .entries
                      .map((entry) => _itemCard(c, entry.key, entry.value)),
                  if (c.kind == _CommunityKind.studentCard ||
                      c.kind == _CommunityKind.member) ...[
                    const SizedBox(height: 14),
                    _progressCard(),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  onPressed: _primaryAction,
                  icon: Icon(
                    _saved ? Icons.check_rounded : Icons.arrow_forward_rounded,
                  ),
                  label: Text(
                    _saved ? 'Đã lưu' : c.action,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF315B50),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hero(_CommunityConfig c, bool isTown) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      gradient: const LinearGradient(
        colors: [Color(0xFFE6F0E6), Color(0xFFFFF0D8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .82),
            borderRadius: BorderRadius.circular(19),
          ),
          child: Icon(c.icon, color: const Color(0xFF315B50), size: 30),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c.title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF263547),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                c.subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.35,
                  color: Color(0xFF61706B),
                ),
              ),
              if (isTown) ...[
                const SizedBox(height: 12),
                const _MiniProgress(),
              ],
            ],
          ),
        ),
      ],
    ),
  );

  Widget _searchField() => TextField(
    controller: _search,
    onChanged: (_) => setState(() {}),
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.search_rounded),
      hintText: 'Tìm bạn học',
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE7E9E3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE7E9E3)),
      ),
    ),
  );

  List<Widget> _formFields(_CommunityConfig c) {
    final labels = c.kind == _CommunityKind.joinClass
        ? ['Mã lớp học']
        : ['Tên lớp học', 'Mô tả lớp học'];
    return labels
        .map(
          (label) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TextField(
              controller: _name,
              decoration: InputDecoration(
                labelText: label,
                hintText: label == 'Mã lớp học'
                    ? 'Ví dụ: ENG2026'
                    : 'Nhập $label',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xFFE7E9E3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xFFE7E9E3)),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  Widget _stylePicker(_CommunityConfig c) {
    final colors = [
      const Color(0xFFFFE5A5),
      const Color(0xFFCAE8D2),
      const Color(0xFFF8CFD2),
      const Color(0xFFD9D4F3),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          c.kind == _CommunityKind.poster ? 'Mẫu áp phích' : 'Màu thẻ',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          children: List.generate(
            colors.length,
            (i) => GestureDetector(
              onTap: () => setState(() => _selected = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  color: colors[i],
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: _selected == i
                        ? const Color(0xFF315B50)
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: Icon(
                  _selected == i
                      ? Icons.check_rounded
                      : Icons.auto_awesome_rounded,
                  color: const Color(0xFF315B50),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _statsCard(_CommunityConfig c) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFEDECE5)),
    ),
    child: Row(
      children: [
        _stat('7', 'ngày học'),
        _stat('120', 'từ mới'),
        _stat('85%', 'chính xác'),
      ],
    ),
  );

  Widget _stat(String value, String label) => Expanded(
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF315B50),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF79827C)),
        ),
      ],
    ),
  );

  Widget _itemCard(_CommunityConfig c, int i, String title) {
    final searchable = c.kind == _CommunityKind.findFriends;
    final isEmpty = c.kind == _CommunityKind.posts && i == 0;
    final active = _selectedItems.contains(i) || _joined.contains(i);
    final glyphs = [
      Icons.menu_book_rounded,
      Icons.groups_rounded,
      Icons.emoji_events_rounded,
      Icons.auto_stories_rounded,
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => setState(() => _selected = i),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: _selected == i
                    ? const Color(0xFFB6D0C1)
                    : const Color(0xFFEDECE5),
                width: _selected == i ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isEmpty
                        ? const Color(0xFFFFF2D7)
                        : const Color(0xFFF0F4EC),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    isEmpty
                        ? Icons.auto_awesome_rounded
                        : glyphs[i % glyphs.length],
                    color: const Color(0xFF477567),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF293A48),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _detail(c, i),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF7B8580),
                        ),
                      ),
                    ],
                  ),
                ),
                if (searchable)
                  TextButton(
                    onPressed: () => setState(() => _joined.add(i)),
                    child: Text(_joined.contains(i) ? 'Đã gửi' : 'Thêm'),
                  )
                else if (c.kind == _CommunityKind.joinClass ||
                    c.kind == _CommunityKind.promoteClass ||
                    c.kind == _CommunityKind.suggestClass)
                  Icon(
                    active
                        ? Icons.check_circle_rounded
                        : Icons.chevron_right_rounded,
                    color: active
                        ? const Color(0xFF477567)
                        : const Color(0xFFA0A8A1),
                  )
                else if (c.kind == _CommunityKind.cardStyle ||
                    c.kind == _CommunityKind.poster)
                  Icon(
                    active
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: const Color(0xFF477567),
                  )
                else
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFA0A8A1),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _detail(_CommunityConfig c, int i) {
    switch (c.kind) {
      case _CommunityKind.friends:
      case _CommunityKind.findFriends:
        return 'Học cùng nhau · Hoạt động gần đây';
      case _CommunityKind.honors:
        return 'Tuần này · Tiến độ rất tốt';
      case _CommunityKind.weeklyAchievement:
      case _CommunityKind.achievementCard:
        return 'Thành tích đã ghi nhận';
      case _CommunityKind.posts:
        return i == 0
            ? 'Bắt đầu chia sẻ với lớp học'
            : 'Mọi người trong lớp sẽ thấy bài đăng';
      case _CommunityKind.createClass:
        return 'Có thể chỉnh sửa sau khi tạo';
      default:
        return 'Chạm để xem chi tiết';
    }
  }

  List<String> _filteredItems(_CommunityConfig c) {
    final query = _search.text.trim().toLowerCase();
    if (query.isEmpty) return c.items;
    return c.items.where((s) => s.toLowerCase().contains(query)).toList();
  }

  Widget _progressCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF315B50),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tiến độ học tập',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const LinearProgressIndicator(
            value: .72,
            minHeight: 8,
            backgroundColor: Color(0x665B8075),
            color: Color(0xFFFFD788),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '72% mục tiêu tuần này',
          style: TextStyle(color: Color(0xFFE4EFE6), fontSize: 12),
        ),
      ],
    ),
  );

  String _sectionName(_CommunityConfig c) => switch (c.kind) {
    _CommunityKind.findFriends => 'Người học gợi ý',
    _CommunityKind.friends => 'Khám phá',
    _CommunityKind.town => 'Các địa điểm',
    _CommunityKind.poster || _CommunityKind.cardStyle => 'Tùy chọn',
    _CommunityKind.posts => 'Bảng tin',
    _CommunityKind.honors => 'Top học viên',
    _ => 'Nội dung',
  };

  Widget _sectionTitle(String title) => Text(
    title,
    style: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w800,
      color: Color(0xFF263547),
    ),
  );

  void _primaryAction() {
    final c = widget.config;
    if (c.kind == _CommunityKind.createClass && _name.text.trim().isEmpty) {
      _toast('Nhập tên lớp học trước nhé');
      return;
    }
    if (c.kind == _CommunityKind.joinClass && _name.text.trim().isEmpty) {
      _toast('Nhập mã lớp để tiếp tục');
      return;
    }
    if (c.kind == _CommunityKind.posts) {
      _toast('Bản nháp bài đăng đã sẵn sàng');
      return;
    }
    if (c.kind == _CommunityKind.friends) {
      _toast('Bạn có thể tìm và thêm bạn học tại đây');
      return;
    }
    if (c.kind == _CommunityKind.recruit ||
        c.kind == _CommunityKind.posterDetail) {
      _toast('Đã chuẩn bị nội dung chia sẻ');
      return;
    }
    setState(() => _saved = true);
    _toast('Đã lưu trên thiết bị');
  }

  void _toast(String message) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
  );
}

class _MiniProgress extends StatelessWidget {
  const _MiniProgress();
  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Icon(
        Icons.local_fire_department_rounded,
        color: Color(0xFFE89255),
        size: 17,
      ),
      const SizedBox(width: 5),
      const Text(
        '7 ngày liên tiếp',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 11,
          color: Color(0xFF52675E),
        ),
      ),
    ],
  );
}
