import 'package:flutter/material.dart';

const _serif = 'Noto Serif';
const _ink = Color(0xFF1F2937);
const _paper = Color(0xFFFEFDF6);
const _charcoal = Color(0xFF292524);

String _asset(String fileName) => 'assets/figma/page1_classroom/$fileName';

class ClassIntroScreen extends StatefulWidget {
  const ClassIntroScreen({super.key});

  @override
  State<ClassIntroScreen> createState() => _ClassIntroScreenState();
}

class _ClassIntroScreenState extends State<ClassIntroScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _controller
      ..removeListener(_onChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFFDFBF7),
    body: Column(
      children: [
        const _ClassStatusBar(),
        SizedBox(
          height: 54,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(width: 24),
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.chevron_left, color: _ink, size: 22),
                ),
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        _asset('696-3693.png'),
                        width: 28,
                        height: 28,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Unique',
                      style: TextStyle(
                        fontFamily: _serif,
                        fontSize: 25,
                        height: 1,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: _publish,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(79, 34),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    backgroundColor: const Color(0xFFA6E1FA),
                    side: const BorderSide(color: Color(0xFF8FA7BC)),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Đăng',
                    style: TextStyle(
                      fontFamily: _serif,
                      fontSize: 14,
                      color: _ink,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const _ClassStepper(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Giới thiệu lớp học của bạn đến với mọi người!',
                  style: TextStyle(
                    fontFamily: _serif,
                    fontSize: 17,
                    height: 1.5,
                    color: _ink,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 220,
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          maxLength: 150,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          style: const TextStyle(
                            fontFamily: _serif,
                            fontSize: 14,
                            height: 1.55,
                            color: _ink,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                            contentPadding: EdgeInsets.zero,
                            hintText: 'Chào mừng bạn đến với nhóm "Tìm hiểu mọi sự vật để mở rộng kiến thức"! 📚 Cùng nhau học tiếng Anh, chia sẻ kiến thức và tiến bộ mỗi ngày nhé!',
                            hintStyle: TextStyle(
                              fontFamily: _serif,
                              fontSize: 14,
                              height: 1.55,
                              color: _ink,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${_controller.text.length}/150',
                          style: const TextStyle(
                            fontFamily: _serif,
                            fontSize: 13,
                            color: _ink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 7),
                const Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontFamily: _serif,
                      fontSize: 11,
                      height: 1.65,
                      color: Color(0xFF6B7280),
                    ),
                    children: [
                      TextSpan(
                        text: '*Bài đăng sẽ được xét duyệt trước khi hiển thị tại, Góc tím lớp học\n',
                      ),
                      TextSpan(
                        text: '《Quy định đăng bài》.《Quy tắc cộng đồng》',
                        style: TextStyle(
                          color: Color(0xFFD98E2E),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const _AndroidNavigationBar(),
      ],
    ),
  );

  void _publish() {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hãy viết lời giới thiệu cho lớp.')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã lưu lời giới thiệu nháp.')),
    );
  }
}

class _ClassStepper extends StatelessWidget {
  const _ClassStepper();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 40,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            left: 16,
            right: 16,
            child: Divider(height: 2, color: Color(0xFFC8C7C0)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [1, 2, 3]
                .map(
                  (n) => Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB2E6B4),
                      border: Border.all(color: const Color(0xFF000000)),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$n',
                      style: const TextStyle(
                        fontFamily: _serif,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _ink,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ),
  );
}

class ClassLeaderboardScreen extends StatelessWidget {
  const ClassLeaderboardScreen({super.key});

  static const _entries = <(String, String, String, String)>[
    ('Minh Anh', '110', '13:44', '593-10099.png'),
    ('Anh Quân', '100', 'Chưa xong', '593-10111.png'),
    ('Nguyễn Huyền', '100', '21:27', '593-10123.png'),
    ('Văn Tài', '99', '19:13', '593-10135.png'),
    ('Thanh Vy', '59', '19:33', '593-10146.png'),
    ('Đỗ Ngọc Hà', '46', '21:28', '593-10157.png'),
    ('Trần Gia Bảo', '25', '21:25', '593-10168.png'),
    ('Phạm Thảo', '15', '20:08', '593-10179.png'),
    ('Hương Giang', '0', 'Chưa xong', '593-10190.png'),
    ('Thời Thiên', '0', 'Chưa xong', '593-10201.png'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF3E8CE),
    body: Column(
      children: [
        const _ClassStatusBar(background: Color(0xFFF3E8CE)),
        _leaderboardHeader(context),
        _blackboard(),
        _leaderboardTabs(context),
        Expanded(child: _leaderboardTable()),
        _settingsFooter(),
      ],
    ),
  );

  Widget _leaderboardHeader(BuildContext context) => SizedBox(
    height: 57,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(Icons.chevron_left, color: _charcoal),
          ),
          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SloganBadge('HỌC TỐT HỌC\nCHĂM'),
                SizedBox(width: 8),
                _SloganBadge('NGÀY NGÀY\nTIẾN BỘ'),
              ],
            ),
          ),
          const Icon(Icons.more_horiz, color: _charcoal),
        ],
      ),
    ),
  );

  Widget _blackboard() => Padding(
    padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
    child: Container(
      height: 79,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFC99863),
        border: Border.all(color: const Color(0xFF291F1A), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF698888),
          border: Border.all(color: const Color(0xFF243535), width: 1.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                _asset('593-10033.png'),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 9),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Unique',
                    style: TextStyle(
                      fontFamily: _serif,
                      color: Colors.white,
                      fontSize: 17,
                      height: 1.05,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Lớp trưởng: Nguyễn Hoàng Nam',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: _serif,
                      color: Color(0xFFF5F5F5),
                      fontSize: 10,
                      height: 1.25,
                    ),
                  ),
                  Text(
                    'Sĩ số: 10/12  Tỷ lệ hoàn thành 83.3%',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: _serif,
                      color: Color(0xFFF5F5F5),
                      fontSize: 8,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 24,
              height: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFE9D6B2),
                border: Border.all(color: _charcoal),
                borderRadius: BorderRadius.circular(3),
              ),
              child: const RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'Lớp Đồng',
                  style: TextStyle(
                    fontFamily: _serif,
                    fontSize: 8,
                    color: Color(0xFFAC7F5E),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Container(
              width: 40,
              height: 52,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFF404040)),
              ),
              child: const Column(
                children: [
                  Icon(Icons.circle, size: 6, color: Color(0xFFF87171)),
                  SizedBox(height: 2),
                  Text(
                    'Thông\nbáo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: _serif,
                      fontSize: 9,
                      height: 1.25,
                      color: Color(0xFF404040),
                    ),
                  ),
                  Spacer(),
                  Divider(height: 2, color: Color(0xFFD4D4D4)),
                  Divider(height: 2, color: Color(0xFFD4D4D4)),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _leaderboardTabs(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
    child: SizedBox(
      height: 51,
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              icon: Icons.person_outline,
              label: 'Danh sách',
              active: false,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => const ClassMembersScreen(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: _TabButton(
              icon: Icons.leaderboard_outlined,
              label: 'Bảng xếp hạng',
              active: true,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _leaderboardTable() => Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF9EF),
        border: Border.all(color: const Color(0xFF29231E), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const _LeaderboardColumnHeader(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: _entries.length,
              separatorBuilder: (_, _) =>
                  const Divider(height: 1, color: Color(0xFFEBD7BE)),
              itemBuilder: (context, index) {
                final e = _entries[index];
                final rank = index + 1;
                final badge = switch (rank) {
                  1 => const Color(0xFFF66A74),
                  2 => const Color(0xFFFBA85F),
                  3 => const Color(0xFFFCD45C),
                  _ => null,
                };
                return SizedBox(
                  height: 44,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 45,
                        child: Center(
                          child: badge == null
                              ? Text(
                                  '$rank',
                                  style: const TextStyle(
                                    fontFamily: _serif,
                                    fontSize: 12,
                                    color: Color(0xFF63574C),
                                  ),
                                )
                              : Container(
                                  width: 24,
                                  height: 24,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: badge,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF29231E),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Text(
                                    '$rank',
                                    style: const TextStyle(
                                      fontFamily: _serif,
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                _asset(e.$4),
                                width: 28,
                                height: 28,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Text(
                                e.$1,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: _serif,
                                  fontSize: 12,
                                  color: Color(0xFF2A241E),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          e.$2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: _serif,
                            fontSize: 12,
                            color: Color(0xFF2A241E),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          e.$3,
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: _serif,
                            fontSize: 11,
                            color: e.$3 == 'Chưa xong'
                                ? const Color(0xFF786C62)
                                : const Color(0xFF463D35),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );

  Widget _settingsFooter() => Container(
    height: 56,
    padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
    decoration: const BoxDecoration(
      color: Color(0xFFF3E8CE),
      border: Border(top: BorderSide(color: Color(0xFFD6D3D1))),
    ),
    child: const Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings_outlined, size: 20, color: Color(0xFF3A352B)),
          Text(
            'Cài đặt',
            style: TextStyle(
              fontFamily: _serif,
              fontSize: 10,
              color: Color(0xFF3A352B),
            ),
          ),
        ],
      ),
    ),
  );
}

class _SloganBadge extends StatelessWidget {
  const _SloganBadge(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    width: 120,
    height: 49,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: const Color(0xFFF8F1E2),
      border: Border.all(color: const Color(0xFF2B2520)),
      borderRadius: BorderRadius.circular(4),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0D000000),
          offset: Offset(0, 1),
          blurRadius: 2,
        ),
      ],
    ),
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: _serif,
        fontSize: 12,
        height: 1.5,
        letterSpacing: 1,
        color: Color(0xFF844329),
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.icon,
    required this.label,
    required this.active,
    this.onTap,
  });
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(7),
    child: Container(
      height: 51,
      decoration: BoxDecoration(
        color: active ? const Color(0xFFC6E6FA) : const Color(0xFFD9EDF8),
        border: Border.all(
          color: active ? const Color(0xFF222222) : const Color(0xFF2D2F33),
          width: active ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF2563EB)),
          Text(
            label,
            style: const TextStyle(
              fontFamily: _serif,
              fontSize: 11,
              height: 1.5,
              color: Color(0xFF171717),
            ),
          ),
        ],
      ),
    ),
  );
}

class ClassMembersScreen extends StatelessWidget {
  const ClassMembersScreen({super.key});

  static const _members = <(String, String, String, String, String, String)>[
    (
      'Hương Giang',
      'Năm 4 | 1306 ngày luyện tập liên tục | Từ vựng thi IELTS',
      'Quy mô từ vựng: 8.232',
      'Tỷ lệ hoàn thành 93,8%',
      'Chắc chắn là không bỏ cuộc đâu.   Bệnh ung thư',
      '765-2767.png',
    ),
    (
      'Văn Tài',
      'Năm 4 | 2.292 ngày học tập bền bỉ | Từ vựng IELTS',
      'Quy mô từ vựng 6325',
      'Tỷ lệ hoàn thành 100%',
      'Bọ Cạp   Cố gắng từng ngày',
      '765-2808.png',
    ),
    (
      'Thời Thiên',
      'Năm thứ ba đại học | Chuỗi 40 ngày học tập liên tục | Danh mục từ vựng CET-6 toàn diện',
      'Quy mô từ vựng: 5.311 từ',
      'Tỷ lệ hoàn thành: 92,9%',
      '',
      '765-2792.png',
    ),
    (
      'Anh Quân',
      'Lớp 10 | 268 ngày học | Tiếng Anh Trung học phổ thông (Phiên bản FLTRP) – Chương trình bắt buộc...',
      'Quy mô từ vựng: 4.065',
      'Tỷ lệ hoàn thành 100%',
      'Học bài đến khuya dưới ánh đèn   Sư tử',
      '765-2742.png',
    ),
    (
      'Phạm Thảo',
      'Lớp 10 | 268 ngày học | Tiếng Anh Trung học phổ thông (Phiên bản FLTRP) – Chương trình bắt buộc...',
      'Quy mô từ vựng: 4.065',
      'Tỷ lệ hoàn thành 100%',
      'Học bài đến khuya dưới ánh đèn   Sư tử',
      '765-2833.png',
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFAAD3E2),
    body: Column(
      children: [
        const _ClassStatusBar(background: Color(0xFFAAD3E2)),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 40, 8, 0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEABD7E),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(22),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 66, 16, 0),
                  decoration: BoxDecoration(
                    color: _paper,
                    border: Border.all(
                      color: const Color(0xFF231F20),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 36, 14, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            const Text(
                              'Danh sách',
                              style: TextStyle(
                                fontFamily: _serif,
                                fontSize: 18,
                                letterSpacing: .4,
                                color: _ink,
                              ),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '(10/12)',
                              style: TextStyle(
                                fontFamily: _serif,
                                fontSize: 14,
                                color: _ink.withValues(alpha: .75),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.only(bottom: 16),
                            itemCount: _members.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) => _MemberCard(
                              member: _members[index],
                              index: index,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 208,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      border: Border.all(
                        color: const Color(0xFF231F20),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33000000),
                          offset: Offset(0, 5),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 9),
                        Container(
                          width: 192,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: const Center(
                            child: SizedBox(
                              width: 24,
                              child: Divider(
                                height: 2,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 4,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF94A3B8),
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 0,
                child: IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.chevron_left, color: _ink, size: 24),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member, required this.index});
  final (String, String, String, String, String, String) member;
  final int index;

  @override
  Widget build(BuildContext context) {
    final title = member.$1;
    final isLeader = index == 1;
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF221F20), width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBEB),
                      shape: BoxShape.circle,
                      border: Border.all(color: _ink),
                    ),
                    child: ClipOval(
                      child: Image.asset(_asset(member.$6), fit: BoxFit.cover),
                    ),
                  ),
                  if (isLeader)
                    Positioned(
                      bottom: -3,
                      left: -2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE496),
                          border: Border.all(color: _charcoal, width: .6),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: const Text(
                          'Lớp trưởng',
                          style: TextStyle(
                            fontFamily: _serif,
                            fontSize: 6,
                            color: _charcoal,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: _serif,
                        fontSize: 12,
                        height: 1.35,
                        fontWeight: FontWeight.w700,
                        color: _ink,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      member.$2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: _serif,
                        fontSize: 9,
                        height: 1.4,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              _Tag(
                member.$3,
                color: const Color(0xFFE1F3D8),
                textColor: const Color(0xFF558641),
              ),
              _Tag(
                member.$4,
                color: const Color(0xFFE1F3D8),
                textColor: const Color(0xFF558641),
              ),
            ],
          ),
          if (member.$5.isNotEmpty) ...[
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Text(
                    member.$5,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: _serif,
                      fontSize: 9,
                      color: Color(0xFF926A32),
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 17,
                  color: Color(0xFF475569),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.text, {required this.color, required this.textColor});
  final String text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: _serif,
        fontSize: 9,
        height: 1.45,
        color: textColor,
      ),
    ),
  );
}

class _ClassStatusBar extends StatelessWidget {
  const _ClassStatusBar({this.background = const Color(0xFFFDFBF7)});
  final Color background;

  @override
  Widget build(BuildContext context) => Container(
    height: 32,
    color: background,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        const Text(
          '18:17',
          style: TextStyle(fontFamily: _serif, color: _ink, fontSize: 12),
        ),
        const Spacer(),
        Container(
          width: 20,
          height: 18,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF4B5563), width: .8),
            borderRadius: BorderRadius.circular(2),
          ),
          child: const Text(
            'Vo\nLTE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: _serif,
              color: Color(0xFF374151),
              fontSize: 6,
              height: .9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 7),
        const Icon(Icons.wifi, size: 14, color: Color(0xFF374151)),
        const SizedBox(width: 6),
        const Icon(
          Icons.signal_cellular_alt,
          size: 13,
          color: Color(0xFF374151),
        ),
        const SizedBox(width: 6),
        Container(
          width: 19,
          height: 14,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF4B5563), width: .8),
            borderRadius: BorderRadius.circular(3),
          ),
          child: const Text(
            '61',
            style: TextStyle(
              fontFamily: _serif,
              color: Color(0xFF374151),
              fontSize: 8,
            ),
          ),
        ),
      ],
    ),
  );
}

class _LeaderboardColumnHeader extends StatelessWidget {
  const _LeaderboardColumnHeader();

  @override
  Widget build(BuildContext context) => const SizedBox(
    height: 29,
    child: Row(
      children: [
        SizedBox(
          width: 45,
          child: Text(
            'Hạng',
            style: TextStyle(
              fontFamily: _serif,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF31271F),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            'Thành viên',
            style: TextStyle(
              fontFamily: _serif,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF31271F),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Đã học',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: _serif,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF31271F),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Thời gian',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: _serif,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF31271F),
            ),
          ),
        ),
      ],
    ),
  );
}

class _AndroidNavigationBar extends StatelessWidget {
  const _AndroidNavigationBar();

  @override
  Widget build(BuildContext context) => Container(
    height: 36,
    color: const Color(0xFFF2F4F8),
    padding: const EdgeInsets.symmetric(horizontal: 72),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.menu, size: 16, color: Color(0xFF64748B)),
        Icon(Icons.crop_square, size: 16, color: Color(0xFF64748B)),
        Icon(Icons.chevron_left, size: 16, color: Color(0xFF64748B)),
      ],
    ),
  );
}
