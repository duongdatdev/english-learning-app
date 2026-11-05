import 'package:flutter/material.dart';

import '../home/home_screens.dart';

/// Locally interactive Flutter implementations for the unclaimed Page 1
/// reading, dictionary, account and privacy roots.
final Map<String, WidgetBuilder> page1ReadingMiscBuilders = {
  for (final id in _ids) id: (_) => _Page1ReadingMiscScreen(frameId: id),
};

const _ids = <String>[
  '785:1148',
  '593:20586',
  '766:3279',
  '776:4385',
  '593:7393',
  '630:4800',
  '621:2304',
  '621:2591',
  '622:3015',
  '622:3142',
  '630:5105',
  '630:5140',
  '630:5183',
  '630:5325',
  '653:7571',
  '653:7699',
];

const _ink = Color(0xff22283a);
const _muted = Color(0xff8790a2);
const _blue = Color(0xff5575f7);
const _paper = Color(0xfff7f8fb);
const _line = Color(0xffedf0f5);

class _Page1ReadingMiscScreen extends StatefulWidget {
  const _Page1ReadingMiscScreen({required this.frameId, this.onTabSelected});
  final String frameId;
  final ValueChanged<int>? onTabSelected;

  @override
  State<_Page1ReadingMiscScreen> createState() =>
      _Page1ReadingMiscScreenState();
}

/// Profile screen with the same primary navigation as the Page 1 prototype.
class Page1ProfileScreen extends StatelessWidget {
  const Page1ProfileScreen({super.key, required this.onTabSelected});
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) => _Page1ReadingMiscScreen(
    frameId: '785:1148',
    onTabSelected: onTabSelected,
  );
}

class _Page1ReadingMiscScreenState extends State<_Page1ReadingMiscScreen> {
  bool _favorite = false;
  bool _showTranslation = true;
  bool _playing = false;
  bool _hideDeskMate = false;
  bool _hideSmallGroup = false;
  bool _hideTeam = false;
  bool _publicClass = true;
  int _page = 0;
  int _selectedLevel = 0;
  int _selectedAlbum = 0;
  final _search = TextEditingController(text: 'hello');

  @override
  void initState() {
    super.initState();
    if (const {'622:3142', '630:5183'}.contains(widget.frameId)) _page = 1;
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _openBookFrame(String frameId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _Page1ReadingMiscScreen(frameId: frameId),
      ),
    );
  }

  String get _title => switch (widget.frameId) {
    '785:1148' => 'Cá nhân',
    '593:20586' => 'Cài đặt',
    '766:3279' => 'Cài đặt lớp học',
    '776:4385' => 'Cài đặt quyền riêng tư',
    '593:7393' => 'Lịch sử tìm kiếm từ vựng',
    '630:4800' => 'Giải thích cấp độ',
    '621:2304' => 'Đọc sách tranh',
    '621:2591' => 'My Little Dog',
    '622:3015' || '630:5140' => 'My Little Dog · 1 / 2',
    '622:3142' || '630:5183' => 'My Little Dog · 2 / 2',
    '630:5105' => 'My Little Dog',
    '630:5325' => 'Đọc truyện tranh',
    '653:7571' => 'Danh sách album',
    '653:7699' => 'Danh sách phát',
    _ => '',
  };

  @override
  Widget build(BuildContext context) {
    final wide =
        widget.frameId.startsWith('621:') ||
        widget.frameId.startsWith('622:') ||
        (widget.frameId == '630:5105' ||
            widget.frameId == '630:5140' ||
            widget.frameId == '630:5183' ||
            widget.frameId == '630:5325');
    return Scaffold(
      backgroundColor: _paper,
      appBar: AppBar(
        backgroundColor: _paper,
        foregroundColor: _ink,
        elevation: 0,
        toolbarHeight: widget.frameId == '785:1148' ? 48 : null,
        automaticallyImplyLeading: widget.frameId != '785:1148',
        titleSpacing: widget.frameId == '785:1148' ? 16 : null,
        centerTitle: widget.frameId == '653:7699',
        title: Text(
          _title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        actions: [
          if (widget.frameId == '785:1148')
            IconButton(
              onPressed: () => _toast('Thông báo'),
              icon: const Icon(Icons.notifications_none_rounded),
            ),
          if (widget.frameId == '593:7393')
            TextButton(
              onPressed: () => setState(_search.clear),
              child: const Text('Hủy'),
            ),
          if (_isBookPage)
            IconButton(
              onPressed: () => setState(() => _favorite = !_favorite),
              icon: Icon(
                _favorite ? Icons.favorite : Icons.favorite_border,
                color: _favorite ? Colors.pink : _ink,
              ),
            ),
          if (widget.frameId == '653:7699')
            IconButton(
              onPressed: _chooseAlbum,
              icon: const Icon(Icons.more_horiz),
            ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: wide
            ? _wideBody()
            : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: _phoneBody(),
                ),
              ),
      ),
      bottomNavigationBar: widget.frameId == '785:1148'
          ? Page1BottomNavigationBar(
              selectedIndex: 4,
              onTabSelected: widget.onTabSelected,
              labels: const [
                'Từ vựng',
                'Học tập',
                'Cùng học',
                'Đổi xu',
                'Cá nhân',
              ],
            )
          : null,
    );
  }

  bool get _isBookPage => const {
    '621:2591',
    '622:3015',
    '622:3142',
    '630:5140',
    '630:5183',
  }.contains(widget.frameId);

  Widget _phoneBody() => switch (widget.frameId) {
    '785:1148' => _profileBody(),
    '593:20586' => _storeSettingsBody(),
    '766:3279' => _classSettingsBody(),
    '776:4385' => _privacyBody(),
    '593:7393' => _dictionaryBody(),
    '630:4800' => _levelsBody(),
    '653:7571' => _albumsBody(),
    '653:7699' => _playlistBody(),
    _ => _wideBody(),
  };

  Widget _wideBody() => LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth < 600) return _compactWideBody();
      final max = constraints.maxWidth > 900 ? 980.0 : constraints.maxWidth;
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: max),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
            child: switch (widget.frameId) {
              '621:2304' => _bookIntroduction(),
              '621:2591' => _bookIntroduction(),
              '630:5105' => _modeChooser(),
              '630:5325' => _completionBody(),
              _ => _readerBody(),
            },
          ),
        ),
      );
    },
  );

  Widget _compactWideBody() {
    final intro = const {'621:2304', '621:2591'}.contains(widget.frameId);
    final mode = widget.frameId == '630:5105';
    final completed = widget.frameId == '630:5325';
    final second = _page == 1;
    final english = second
        ? 'Max is small and cute. He has brown fur and big eyes.'
        : 'My name is Anna. I have a little dog. His name is Max.';
    final vietnamese = second
        ? 'Max nhỏ nhắn và dễ thương. Nó có bộ lông màu nâu và đôi mắt to.'
        : 'Tên tôi là Anna. Tôi có một chú chó nhỏ. Tên nó là Max.';

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
      children: [
        if (!completed)
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/figma/630-4908.png',
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),
          ),
        const SizedBox(height: 20),
        if (intro) ...[
          const Text(
            'My Little Dog',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text('Đọc sách tranh', style: TextStyle(color: _muted)),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: () => _openBookFrame('630:5105'),
            icon: const Icon(Icons.menu_book_rounded),
            label: const Text('Bắt đầu đọc'),
          ),
        ] else if (mode) ...[
          const Text(
            'My little dog',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 18),
          _modeCard('Đọc', Icons.menu_book_rounded),
          const SizedBox(height: 12),
          _modeCard('Lồng tiếng', Icons.mic_rounded),
        ] else if (completed) ...[
          const Center(
            child: Icon(Icons.celebration_rounded, size: 72, color: _blue),
          ),
          const SizedBox(height: 18),
          const Text(
            'Tuyệt vời quá!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            'Đây là cuốn truyện tranh thứ 1 bé đã đọc trên Cake English~',
            textAlign: TextAlign.center,
            style: TextStyle(color: _muted, height: 1.45),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => _openBookFrame('621:2304'),
            icon: const Icon(Icons.menu_book),
            label: const Text('Đọc truyện tranh'),
          ),
          FilledButton.icon(
            onPressed: () => _openBookFrame('630:5183'),
            icon: const Icon(Icons.mic),
            label: const Text('Lồng tiếng'),
          ),
        ] else ...[
          const Text(
            'My Little Dog',
            style: TextStyle(
              color: _blue,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            english,
            style: const TextStyle(
              color: _ink,
              fontSize: 21,
              height: 1.45,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (_showTranslation) ...[
            const SizedBox(height: 10),
            Text(
              vietnamese,
              style: const TextStyle(color: _muted, height: 1.5),
            ),
          ],
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              IconButton.filledTonal(
                onPressed: () => setState(() => _playing = !_playing),
                icon: Icon(_playing ? Icons.pause : Icons.volume_up),
              ),
              TextButton(
                onPressed: () =>
                    setState(() => _showTranslation = !_showTranslation),
                child: Text(_showTranslation ? 'Ẩn bản dịch' : 'Hiện bản dịch'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: _page == 0 ? null : () => setState(() => _page = 0),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Trước'),
              ),
              Text(second ? '2 / 2' : '1 / 2'),
              FilledButton.icon(
                onPressed: second
                    ? () => _openBookFrame('630:5325')
                    : () => setState(() => _page = 1),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Tiếp'),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _profileBody() => ListView(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    children: [
      SizedBox(
        height: 90,
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/figma/page1_all/89cfb30c06d03240c9ef55863d4f64ec88c21adc.png',
                width: 58,
                height: 58,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DOGITA',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: _ink,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'BczID: 1797406218',
                    style: TextStyle(color: _muted, fontSize: 10),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Đà Nẵng · Năm 4 · Từ vựng cấp 6',
                    style: TextStyle(color: _muted, fontSize: 10),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: _muted),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: _cardDecoration(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hành trình học tập',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
                TextButton(
                  onPressed: () => _toast('Hành trình học tập'),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                  ),
                  child: const Text(
                    'Xem chi tiết',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                _profileStat('24', 'Học hôm nay'),
                _profileStat('32', 'Tổng từ đã học'),
                _profileStat('1 ngày', 'Đã điểm danh'),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 14),
      _sectionLabel('Học tập của tôi'),
      _profileGroup([
        (Icons.menu_book_rounded, 'Sổ từ vựng của tôi', '32 từ'),
        (Icons.school_outlined, 'Khóa học của tôi', ''),
        (Icons.event_available_outlined, 'Kế hoạch học tập', 'Hằng ngày'),
        (Icons.emoji_events_outlined, 'Thành tích và phần thưởng', ''),
      ]),
      const SizedBox(height: 14),
      _sectionLabel('Tài khoản và hỗ trợ'),
      _profileGroup([
        (Icons.person_outline, 'Thông tin tài khoản', ''),
        (Icons.tune_rounded, 'Cài đặt học tập', ''),
        (Icons.help_outline, 'Trợ giúp và góp ý', ''),
      ]),
      Center(
        child: TextButton.icon(
          onPressed: () => _toast('Đăng xuất'),
          icon: const Icon(Icons.logout_rounded, size: 14),
          label: const Text('Đăng xuất', style: TextStyle(fontSize: 10)),
        ),
      ),
    ],
  );

  Widget _profileStat(String value, String label) => Expanded(
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: _ink,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 9, color: _muted),
        ),
      ],
    ),
  );

  Widget _profileGroup(List<(IconData, String, String)> rows) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: _cardDecoration(),
    child: Column(
      children: [
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0) const Divider(height: 1, indent: 28),
          SizedBox(
            height: 46,
            child: InkWell(
              onTap: () => _toast(rows[i].$2),
              child: Row(
                children: [
                  Icon(rows[i].$1, size: 16, color: _blue),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      rows[i].$2,
                      style: const TextStyle(fontSize: 11, color: _ink),
                    ),
                  ),
                  if (rows[i].$3.isNotEmpty)
                    Text(
                      rows[i].$3,
                      style: const TextStyle(fontSize: 9, color: _muted),
                    ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 16,
                    color: _muted,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    ),
  );

  Widget _storeSettingsBody() => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      _menuTile(
        Icons.location_on_outlined,
        'Quản lý địa chỉ',
        onTap: () => _toast('Địa chỉ đã lưu'),
      ),
      _menuTile(
        Icons.description_outlined,
        'Thỏa thuận người dùng',
        onTap: () =>
            _showInfo('Thỏa thuận người dùng', 'Điều khoản sử dụng dịch vụ.'),
      ),
      _menuTile(
        Icons.shield_outlined,
        'Chính sách bảo mật của cửa hàng',
        onTap: () => _showInfo(
          'Chính sách bảo mật',
          'Thông tin về cách dữ liệu được sử dụng.',
        ),
      ),
    ],
  );

  Widget _classSettingsBody() => ListView(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
    children: [
      Container(
        padding: const EdgeInsets.all(18),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.groups_rounded, color: _blue),
                SizedBox(width: 9),
                Text(
                  'Class File',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _ink,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _detail('Tên lớp học:', 'Nghiện học từ vựng ^3^'),
            _detail('Biệt danh nhóm của tôi:', 'DOGITA'),
            _detail('Phân hạng lớp:', 'Lớp Hoàng Kim'),
            _detail('Sĩ số nhóm:', '46'),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Cài đặt quyền riêng tư'),
              subtitle: Text(_publicClass ? 'Công khai' : 'Riêng tư'),
              value: _publicClass,
              onChanged: (value) => setState(() => _publicClass = value),
            ),
            _detail('Mã QR nhóm:', 'Chưa có'),
            _detail('Mã mời:', 'secret'),
            const SizedBox(height: 6),
            const Text(
              'Giới thiệu nhóm',
              style: TextStyle(fontWeight: FontWeight.w700, color: _ink),
            ),
            const SizedBox(height: 6),
            const Text(
              'Chỉ dành cho bạn chăm chỉ! ⭐ Lớp học giao lưu ôn luyện cho học sinh cấp 3 / sinh viên ⭐',
              style: TextStyle(height: 1.45, color: _muted),
            ),
            const SizedBox(height: 14),
            const Text(
              'Ngày tạo 22/02/2025',
              style: TextStyle(fontSize: 12, color: _muted),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      _menuTile(
        Icons.ios_share,
        'Chia sẻ mã mời',
        onTap: () => _toast('Đã sao chép mã mời'),
      ),
    ],
  );

  Widget _privacyBody() => ListView(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Trang cá nhân',
              style: TextStyle(fontSize: 13, color: _muted),
            ),
            const SizedBox(height: 12),
            const Text(
              'Nhóm hiển thị hiện tại',
              style: TextStyle(fontWeight: FontWeight.w600, color: _ink),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Nghiện từ vựng ^3^',
                    style: TextStyle(color: _ink),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => _publicClass = !_publicClass),
                  child: Text(_publicClass ? 'Công khai' : 'Riêng tư'),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      _privacyToggle(
        'Không hiển thị 「Bạn cùng bàn」 của tôi',
        _hideDeskMate,
        (v) => setState(() => _hideDeskMate = v),
      ),
      _privacyToggle(
        'Không hiển thị 「Nhóm nhỏ」 của tôi',
        _hideSmallGroup,
        (v) => setState(() => _hideSmallGroup = v),
      ),
      _privacyToggle(
        'Không hiển thị 「Đội nhóm」 của tôi',
        _hideTeam,
        (v) => setState(() => _hideTeam = v),
      ),
    ],
  );

  Widget _dictionaryBody() => ListView(
    padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
    children: [
      TextField(
        controller: _search,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: 'Tìm từ vựng',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            onPressed: () {
              _search.clear();
              setState(() {});
            },
            icon: const Icon(Icons.close),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      const SizedBox(height: 20),
      _sectionLabel('lịch sử tìm kiếm'),
      if ('hello'.contains(_search.text.toLowerCase()) || _search.text.isEmpty)
        Container(
          padding: const EdgeInsets.all(18),
          decoration: _cardDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'hello',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: _ink,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _playing = !_playing),
                    icon: Icon(
                      _playing ? Icons.volume_up : Icons.volume_up_outlined,
                      color: _blue,
                    ),
                  ),
                ],
              ),
              const Text("/hə'ləʊ/", style: TextStyle(color: _muted)),
              const SizedBox(height: 14),
              const Text(
                '(v): Xin chào\n(n): Lời chào hỏi',
                style: TextStyle(color: _ink, height: 1.6),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => setState(() => _favorite = !_favorite),
                  icon: Icon(
                    _favorite ? Icons.bookmark : Icons.bookmark_border,
                  ),
                  label: Text(_favorite ? 'Đã lưu' : 'Lưu từ'),
                ),
              ),
            ],
          ),
        )
      else
        const Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Không tìm thấy từ trong lịch sử.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _muted),
          ),
        ),
    ],
  );

  Widget _levelsBody() {
    const levels = [
      ('A1', 'Đề xuất đọc truyện tranh R1–R2'),
      ('A2', 'Đề xuất đọc truyện tranh R3–R4'),
      ('B1', 'Đề xuất đọc truyện tranh R5–R6'),
      ('B2', 'Đề xuất đọc truyện tranh R7–R8'),
      ('C1', 'Đề xuất đọc truyện tranh R9–R10'),
      ('C2', 'Đề xuất đọc truyện tranh R11–R16'),
    ];
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        ...List.generate(
          levels.length,
          (i) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => setState(() => _selectedLevel = i),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(selected: _selectedLevel == i),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: _selectedLevel == i
                          ? _blue
                          : const Color(0xffeef1ff),
                      foregroundColor: _selectedLevel == i
                          ? Colors.white
                          : _blue,
                      child: Text(
                        levels[i].$1,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        levels[i].$2,
                        style: const TextStyle(
                          color: _ink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      _selectedLevel == i
                          ? Icons.check_circle
                          : Icons.chevron_right,
                      color: _selectedLevel == i ? _blue : _muted,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Hãy cùng bé khám phá thế giới truyện tranh, tận hưởng niềm vui đọc sách!',
          textAlign: TextAlign.center,
          style: TextStyle(height: 1.5, color: _muted),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () =>
              _toast('Đã chọn cấp độ ${levels[_selectedLevel].$1}'),
          child: const Text('Chọn cấp độ'),
        ),
      ],
    );
  }

  Widget _bookIntroduction() => Row(
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.asset(
            'assets/figma/630-4908.png',
            fit: BoxFit.cover,
            height: 280,
          ),
        ),
      ),
      const SizedBox(width: 26),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.frameId == '621:2304' ? 'Phần 4' : 'My Little Dog',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: _ink,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Đọc sách tranh',
              style: TextStyle(fontSize: 16, color: _muted),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => _openBookFrame('630:5105'),
              icon: const Icon(Icons.menu_book_rounded),
              label: const Text('Bắt đầu đọc'),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _readerBody() {
    final second = _page == 1;
    final english = second
        ? 'Max is small and cute. He has brown fur and big eyes.'
        : 'My name is Anna. I have a little dog. His name is Max.';
    final vietnamese = second
        ? 'Max nhỏ nhắn và dễ thương. Nó có bộ lông màu nâu và đôi mắt to.'
        : 'Tên tôi là Anna. Tôi có một chú chó nhỏ. Tên nó là Max.';
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/figma/630-4908.png',
              fit: BoxFit.cover,
              height: 300,
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My Little Dog',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _blue,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                english,
                style: const TextStyle(
                  fontSize: 21,
                  height: 1.45,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
              if (_showTranslation) ...[
                const SizedBox(height: 10),
                Text(
                  vietnamese,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: _muted,
                  ),
                ),
              ],
              const SizedBox(height: 18),
              Row(
                children: [
                  IconButton.filledTonal(
                    onPressed: () => setState(() => _playing = !_playing),
                    icon: Icon(_playing ? Icons.pause : Icons.volume_up),
                  ),
                  TextButton(
                    onPressed: () =>
                        setState(() => _showTranslation = !_showTranslation),
                    child: Text(
                      _showTranslation ? 'Ẩn bản dịch' : 'Hiện bản dịch',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: _page == 0
                        ? null
                        : () => setState(() => _page = 0),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Trước'),
                  ),
                  const Spacer(),
                  Text(
                    second ? '2 / 2' : '1 / 2',
                    style: const TextStyle(color: _muted),
                  ),
                  const SizedBox(width: 14),
                  FilledButton.icon(
                    onPressed: second
                        ? () => _openBookFrame('630:5325')
                        : () => setState(() => _page = 1),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Tiếp'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _modeChooser() => Row(
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.asset(
            'assets/figma/630-4908.png',
            fit: BoxFit.cover,
            height: 280,
          ),
        ),
      ),
      const SizedBox(width: 24),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'My little dog',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: _ink,
              ),
            ),
            const SizedBox(height: 18),
            _modeCard('Đọc', Icons.menu_book_rounded),
            const SizedBox(height: 12),
            _modeCard('Lồng tiếng', Icons.mic_rounded),
          ],
        ),
      ),
    ],
  );

  Widget _modeCard(String label, IconData icon) => InkWell(
    onTap: () => _openBookFrame(label == 'Đọc' ? '630:5140' : '630:5183'),
    borderRadius: BorderRadius.circular(16),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Icon(icon, color: _blue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700, color: _ink),
            ),
          ),
          const Icon(Icons.arrow_forward, color: _blue),
        ],
      ),
    ),
  );

  Widget _completionBody() => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Container(
        padding: const EdgeInsets.all(26),
        decoration: _cardDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xfffff0c2),
              child: Icon(
                Icons.celebration_rounded,
                size: 42,
                color: Color(0xffe9a92f),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Tuyệt vời quá!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: _ink,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Đây là cuốn truyện tranh thứ 1 bé đã đọc trên Cake English~',
              textAlign: TextAlign.center,
              style: TextStyle(color: _muted, height: 1.45),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _openBookFrame('621:2304'),
                    icon: const Icon(Icons.menu_book),
                    label: const Text('Đọc truyện tranh'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _openBookFrame('630:5183'),
                    icon: const Icon(Icons.mic),
                    label: const Text('Lồng tiếng'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Widget _albumsBody() => ListView(
    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text('16 albums', style: TextStyle(color: _muted)),
      ),
      ...List.generate(
        16,
        (i) => ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 3,
          ),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color.lerp(
                const Color(0xffe6ecff),
                const Color(0xffffe8d4),
                (i % 4) / 4,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.auto_stories_rounded, color: _blue),
          ),
          title: Text(
            'Truyện mở rộng R${i + 1}',
            style: const TextStyle(color: _ink, fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            '${[90, 83, 86, 76, 85, 100, 92, 78, 93, 72, 110, 130, 79, 87, 96, 80][i]} bài',
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => setState(() => _selectedAlbum = i),
        ),
      ),
    ],
  );

  Widget _playlistBody() => ListView(
    padding: const EdgeInsets.fromLTRB(18, 6, 18, 24),
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: Color(0xffe8edff),
              child: Icon(Icons.library_music_rounded, color: _blue),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Truyện mở rộng R1',
                    style: TextStyle(fontWeight: FontWeight.w700, color: _ink),
                  ),
                  Text('83 bài', style: TextStyle(color: _muted)),
                ],
              ),
            ),
            TextButton(onPressed: _chooseAlbum, child: const Text('Đổi album')),
          ],
        ),
      ),
      const SizedBox(height: 14),
      _track('Wheels on the Bus', '02:14', false),
      _track('Love is an open door', '01:45', true),
      _track('A little dog named Max', '03:02', false),
      _track('The clever fox', '02:38', false),
      const SizedBox(height: 14),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: _cardDecoration(),
        child: Row(
          children: [
            IconButton(
              onPressed: () => _toast('Bài trước'),
              icon: const Icon(Icons.skip_previous_rounded),
            ),
            Expanded(
              child: Slider(
                value: _playing ? .45 : .21,
                onChanged: (v) => setState(() => _playing = true),
              ),
            ),
            IconButton.filled(
              onPressed: () => setState(() => _playing = !_playing),
              icon: Icon(
                _playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
              ),
            ),
            IconButton(
              onPressed: () => _toast('Bài tiếp theo'),
              icon: const Icon(Icons.skip_next_rounded),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _track(String title, String duration, bool playing) => ListTile(
    leading: IconButton(
      onPressed: () => setState(() => _playing = !_playing),
      icon: Icon(
        (_playing || playing) ? Icons.pause_circle : Icons.play_circle,
        color: _blue,
        size: 32,
      ),
    ),
    title: Text(
      title,
      style: TextStyle(
        color: _ink,
        fontWeight: playing ? FontWeight.w700 : FontWeight.w500,
      ),
    ),
    subtitle: Text(
      playing || _playing ? 'Đang phát • $duration' : duration,
      style: TextStyle(color: playing || _playing ? _blue : _muted),
    ),
    trailing: playing ? const Icon(Icons.graphic_eq, color: _blue) : null,
    onTap: () => setState(() => _playing = !_playing),
  );

  void _chooseAlbum() => showModalBottomSheet<void>(
    context: context,
    builder: (context) => SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          const ListTile(
            title: Text(
              'Chọn album',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          ...List.generate(
            5,
            (i) => ListTile(
              title: Text('Truyện mở rộng R${i + 1}'),
              trailing: i == _selectedAlbum
                  ? const Icon(Icons.check, color: _blue)
                  : null,
              onTap: () {
                setState(() => _selectedAlbum = i);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    ),
  );

  Widget _sectionLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: _ink,
      ),
    ),
  );
  Widget _menuTile(
    IconData icon,
    String title, {
    String? detail,
    VoidCallback? onTap,
  }) => Card(
    color: Colors.white,
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 7),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    child: ListTile(
      leading: Icon(icon, color: _blue),
      title: Text(title, style: const TextStyle(fontSize: 14, color: _ink)),
      subtitle: detail == null ? null : Text(detail),
      trailing: const Icon(Icons.chevron_right, color: _muted),
      onTap: onTap ?? () => _toast(title),
    ),
  );
  Widget _detail(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 154,
          child: Text(label, style: const TextStyle(color: _muted)),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: _ink, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
  Widget _privacyToggle(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) => Card(
    color: Colors.white,
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 7),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    child: SwitchListTile(
      title: Text(title, style: const TextStyle(fontSize: 13, color: _ink)),
      value: value,
      onChanged: onChanged,
      activeThumbColor: _blue,
    ),
  );
  BoxDecoration _cardDecoration({bool selected = false}) => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: selected ? _blue : _line,
      width: selected ? 1.5 : 1,
    ),
  );
  void _toast(String text) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
    ),
  );
  void _showInfo(String title, String message) => showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Đóng'),
        ),
      ],
    ),
  );
}
