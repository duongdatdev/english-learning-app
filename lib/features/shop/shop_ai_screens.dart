import 'package:flutter/material.dart';

/// Local-only implementations for Page 1 commerce and AI/media flows.
/// Actions are intentionally simulated until a backend is added.
final Map<String, WidgetBuilder> page1ShopAiBuilders = {
  for (final id in _shopAiTitles.keys)
    id: (_) => Page1ShopAiScreen(frameId: id),
};

const Map<String, String> _shopAiTitles = {
  '593:18674': 'Tìm kiếm sản phẩm',
  '593:19206': 'Chi tiết sản phẩm',
  '593:19575': 'Kết quả tìm kiếm',
  '593:19840': 'Đơn hàng · Chờ thanh toán',
  '593:19953': 'Đơn hàng · Chờ thanh toán',
  '593:20046': 'Đơn hàng · Chờ thanh toán',
  '593:20179': 'Giỏ hàng',
  '593:20265': 'Ưu đãi của tôi',
  '593:20383': 'Sản phẩm yêu thích',
  '593:20476': 'Chăm sóc khách hàng',
  '593:20678': 'Quản lý địa chỉ',
  '593:20771': 'Đơn hàng của tôi',
  '593:20988': 'Chọn quy cách',
  '672:3111': 'Chăm sóc khách hàng',
  '683:3282': 'Cửa hàng',
  '686:2130': 'Nhận thưởng 5 xu',
  '692:3110': 'Đổi quà thành công',
  '692:3226': 'Xác nhận đổi quà',
  '802:11945': 'Tiệm đổi quà',
  '958:10144': 'Video và lời thoại song ngữ',
  '958:10255': 'Lịch sử video',
  '958:10311': 'Nguồn phụ đề',
  '958:10726': 'Video · Lời thoại chi tiết',
  '958:10843': 'Tìm video',
  '958:11027': 'Danh mục video',
  '958:11421': 'Tìm kiếm video',
  '958:11423': 'Danh sách tập phim',
  '958:11638': 'Luyện nghe qua video',
  '958:11752': 'Kết quả tìm kiếm video',
  '958:11896': 'Cho phép nhận dạng giọng nói',
  '958:11913': 'Xác nhận quyền micro',
  '958:11953': 'Cho phép nhận dạng giọng nói',
  '958:12002': 'Cho phép nhận dạng giọng nói',
  '958:12067': 'Cho phép nhận dạng giọng nói',
  '958:12133': 'Lịch sử cuộc gọi',
  '958:12184': 'Lịch sử cuộc gọi',
  '958:12261': 'Luyện nói qua cuộc gọi',
  '958:12304': 'Báo cáo cuộc gọi',
  '958:12413': 'Lịch sử hội thoại',
  '964:12549': 'Khám phá tình huống',
  '964:12688': 'Chi tiết tình huống',
  '964:12771': 'Chi tiết tình huống',
  '964:12868': 'Tạo nhập vai với AI',
  '964:13012': 'Cuộc gọi · Đang kết nối',
  '964:13111': 'Cuộc gọi · Đang kết nối',
  '964:13223': 'Cuộc gọi · Đang kết nối',
  '964:13345': 'Cuộc gọi · Đang kết nối',
  '964:13460': 'Tình huống đã tạo',
  '964:13491': 'Kết quả nhập vai',
  '964:13776': 'Luyện phát âm',
  '964:13855': 'Khẩu hình phát âm',
  '964:13913': 'Hướng dẫn phát âm',
  '964:13968': 'Hướng dẫn phát âm',
  '964:14021': 'Luyện âm i dài',
  '964:14055': 'Chi tiết bài luyện phát âm',
};

class Page1ShopAiScreen extends StatefulWidget {
  const Page1ShopAiScreen({super.key, required this.frameId});

  final String frameId;

  @override
  State<Page1ShopAiScreen> createState() => _Page1ShopAiScreenState();
}

class _Page1ShopAiScreenState extends State<Page1ShopAiScreen> {
  static const _ink = Color(0xFF26354A);
  static const _cream = Color(0xFFF7F4EC);
  static const _green = Color(0xFF68B89B);
  final _search = TextEditingController();
  final _message = TextEditingController();
  final Set<String> _selected = {};
  String _activeTab = 'Tất cả';
  String _selectedSize = 'M';
  bool _playing = false;
  bool _recording = false;
  bool _showTranslation = true;
  bool _recordPermission = false;
  int _quantity = 1;

  String get _title => _shopAiTitles[widget.frameId] ?? 'Học cùng nhau';
  String get _group {
    if (widget.frameId == '958:11896' ||
        widget.frameId == '958:11913' ||
        widget.frameId == '958:11953' ||
        widget.frameId == '958:12002' ||
        widget.frameId == '958:12067') {
      return 'voice';
    }
    if (widget.frameId.startsWith('958:')) return 'video';
    if (widget.frameId.startsWith('964:')) return 'voice';
    if (widget.frameId.startsWith('686:') ||
        widget.frameId.startsWith('692:') ||
        widget.frameId.startsWith('802:')) {
      return 'coins';
    }
    if (widget.frameId == '593:20476' || widget.frameId == '672:3111') {
      return 'support';
    }
    return 'shop';
  }

  @override
  void dispose() {
    _search.dispose();
    _message.dispose();
    super.dispose();
  }

  void _toast(String text) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
    );

  @override
  Widget build(BuildContext context) {
    final group = _group;
    return Scaffold(
      backgroundColor: _cream,
      appBar: AppBar(
        backgroundColor: _cream,
        foregroundColor: _ink,
        elevation: 0,
        title: Text(
          _title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        actions: [
          if (group == 'shop')
            IconButton(
              onPressed: () => _toast('Giỏ hàng: $_quantity sản phẩm'),
              icon: const Icon(Icons.shopping_bag_outlined),
            ),
        ],
      ),
      body: SafeArea(child: _bodyFor(group)),
    );
  }

  Widget _bodyFor(String group) {
    switch (group) {
      case 'video':
        return _videoBody();
      case 'voice':
        return _voiceBody();
      case 'coins':
        return _coinsBody();
      case 'support':
        return _supportBody();
      default:
        return _shopBody();
    }
  }

  Widget _shopBody() {
    if (widget.frameId == '593:19840' ||
        widget.frameId == '593:19953' ||
        widget.frameId == '593:20046' ||
        widget.frameId == '593:20771') {
      return _ordersBody();
    }
    if (widget.frameId == '593:20678') return _addressBody();
    if (widget.frameId == '593:20988' || widget.frameId == '593:19206') {
      return _productDetail();
    }
    if (widget.frameId == '593:20179') return _cartBody();
    if (widget.frameId == '593:20265' || widget.frameId == '593:20383') {
      return _emptyCollection();
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
      children: [
        _searchBox(
          'Tìm sách, đồ dùng học tập...',
          controller: _search,
          onSubmitted: (_) => _toast('Đã lọc sản phẩm theo từ khóa'),
        ),
        const SizedBox(height: 18),
        _banner(
          'Góc học tập của bạn',
          'Sách và dụng cụ giúp việc học thú vị hơn.',
          Icons.auto_stories_rounded,
          const Color(0xFFFFDF8F),
        ),
        const SizedBox(height: 22),
        _sectionTitle('Danh mục', trailing: 'Xem tất cả'),
        const SizedBox(height: 12),
        Row(
          children: [
            _categoryChip('Sách', Icons.menu_book_outlined),
            const SizedBox(width: 8),
            _categoryChip('Từ điển', Icons.translate),
            const SizedBox(width: 8),
            _categoryChip('Đồ dùng', Icons.backpack_outlined),
          ],
        ),
        const SizedBox(height: 24),
        _sectionTitle('Đề xuất dành cho bạn', trailing: 'Xem tất cả'),
        const SizedBox(height: 12),
        _productCard(
          'Sổ tay luyện tập bản nháp khổ A4',
          '12.000đ',
          '4.9',
          Icons.edit_note_rounded,
        ),
        _productCard(
          'Từ điển bỏ túi Anh – Việt',
          '89.000đ',
          '4.8',
          Icons.book_rounded,
        ),
        _productCard(
          'Bộ thẻ ghi nhớ từ vựng',
          '45.000đ',
          '4.7',
          Icons.style_rounded,
        ),
      ],
    );
  }

  Widget _productDetail() => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      Container(
        height: 230,
        decoration: BoxDecoration(
          color: const Color(0xFFE3EAF0),
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Icon(
          Icons.menu_book_rounded,
          size: 100,
          color: Color(0xFF69809A),
        ),
      ),
      const SizedBox(height: 18),
      const Text(
        'Sổ tay luyện tập bản nháp khổ A4',
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w800,
          color: _ink,
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        '12.000đ  ·  ★ 4.9  ·  3,4 nghìn lượt mua',
        style: TextStyle(color: Color(0xFF617083)),
      ),
      const SizedBox(height: 16),
      const Text(
        'Chất giấy dày, phù hợp ghi chú và sắp xếp kế hoạch học tập mỗi ngày.',
        style: TextStyle(height: 1.45, color: _ink),
      ),
      const SizedBox(height: 22),
      _sectionTitle('Chọn quy cách'),
      const SizedBox(height: 10),
      Wrap(
        spacing: 9,
        children: ['S', 'M', 'L']
            .map(
              (size) => ChoiceChip(
                label: Text(size),
                selected: _selectedSize == size,
                onSelected: (_) => setState(() => _selectedSize = size),
              ),
            )
            .toList(),
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          const Text('Số lượng', style: TextStyle(fontWeight: FontWeight.w700)),
          const Spacer(),
          IconButton(
            onPressed: () =>
                setState(() => _quantity = (_quantity - 1).clamp(1, 99)),
            icon: const Icon(Icons.remove_circle_outline),
          ),
          Text('$_quantity'),
          IconButton(
            onPressed: () => setState(() => _quantity++),
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => _toast('Đã thêm $_quantity sản phẩm vào giỏ'),
              child: const Text('Thêm vào giỏ'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: FilledButton(
              onPressed: () => _toast('Đã lưu đơn hàng nháp trên thiết bị'),
              child: const Text('Mua ngay'),
            ),
          ),
        ],
      ),
    ],
  );

  Widget _ordersBody() => Column(
    children: [
      SizedBox(
        height: 56,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: [
            for (final tab in [
              'Tất cả',
              'Chờ thanh toán',
              'Chờ nhận',
              'Đang giao',
              'Đã giao',
            ])
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(tab),
                  selected: _activeTab == tab,
                  onSelected: (_) => setState(() => _activeTab = tab),
                ),
              ),
          ],
        ),
      ),
      Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.inventory_2_outlined,
                  size: 74,
                  color: Color(0xFF9AA8B5),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Bạn chưa có đơn hàng nào',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'Đơn hàng ở mục “$_activeTab” sẽ hiển thị tại đây.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 18),
                FilledButton(
                  onPressed: () => Navigator.maybePop(context),
                  child: const Text('Tiếp tục mua sắm'),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );

  Widget _cartBody() => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      _sectionTitle('Sản phẩm trong giỏ'),
      const SizedBox(height: 14),
      _productCard(
        'Sổ tay luyện tập bản nháp khổ A4',
        '12.000đ',
        '4.9',
        Icons.edit_note_rounded,
      ),
      CheckboxListTile(
        value: _selected.contains('all'),
        onChanged: (v) =>
            setState(() => v! ? _selected.add('all') : _selected.remove('all')),
        title: const Text('Chọn tất cả'),
        contentPadding: EdgeInsets.zero,
      ),
      Row(
        children: [
          const Text(
            'Tổng cộng',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          const Text(
            '12.000đ',
            style: TextStyle(fontWeight: FontWeight.w800, color: _ink),
          ),
        ],
      ),
      const SizedBox(height: 14),
      FilledButton(
        onPressed: () => _toast('Đã tạo đơn hàng nháp, chưa thanh toán'),
        child: const Text('Tiến hành đặt hàng'),
      ),
    ],
  );

  Widget _addressBody() => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      const Text(
        'Địa chỉ nhận hàng',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 14),
      _field('Họ và tên', 'Nguyễn Minh Anh'),
      _field('Số điện thoại', '09xx xxx xxx'),
      _field('Địa chỉ', 'Số nhà, đường, phường/xã'),
      const SizedBox(height: 12),
      FilledButton(
        onPressed: () => _toast('Địa chỉ đã lưu trên thiết bị'),
        child: const Text('Lưu địa chỉ'),
      ),
    ],
  );

  Widget _emptyCollection() => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.frameId == '593:20265'
                ? Icons.confirmation_number_outlined
                : Icons.favorite_border,
            size: 70,
            color: _green,
          ),
          const SizedBox(height: 14),
          Text(
            widget.frameId == '593:20265'
                ? 'Chưa có ưu đãi nào'
                : 'Danh sách yêu thích đang trống',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 8),
          const Text(
            'Sản phẩm bạn lưu sẽ xuất hiện tại đây.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    ),
  );

  Widget _coinsBody() {
    if (widget.frameId == '692:3226') {
      return ListView(
        padding: const EdgeInsets.all(22),
        children: [
          _banner(
            'Xác nhận đổi quà',
            'Đổi vật phẩm với 2.000 xu?',
            Icons.redeem_rounded,
            const Color(0xFFFFE5A9),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => _toast('Đã ghi nhận đổi quà thử nghiệm'),
            child: const Text('Xác nhận'),
          ),
          TextButton(
            onPressed: () => Navigator.maybePop(context),
            child: const Text('Suy nghĩ lại'),
          ),
        ],
      );
    }
    if (widget.frameId == '692:3110' || widget.frameId == '686:2130') {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 42,
                backgroundColor: Color(0xFFFFE5A9),
                child: Icon(
                  Icons.stars_rounded,
                  size: 44,
                  color: Color(0xFFCA8B26),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.frameId == '686:2130'
                    ? 'Bạn nhận được 5 xu!'
                    : 'Đổi quà thành công!',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: () => Navigator.maybePop(context),
                child: Text(
                  widget.frameId == '686:2130' ? 'Đã hiểu' : 'Xem ngay',
                ),
              ),
            ],
          ),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _banner(
          'Tiệm đổi quà',
          'Xu bạn kiếm được có thể đổi vật phẩm học tập.',
          Icons.redeem_rounded,
          const Color(0xFFFFE5A9),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: _cardDecoration(),
          child: const Row(
            children: [
              Icon(Icons.stars_rounded, color: Color(0xFFCC9828)),
              SizedBox(width: 8),
              Text(
                'Số dư: 2.450 xu',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              Spacer(),
              Text('Lịch sử'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _sectionTitle('Vật phẩm nổi bật'),
        const SizedBox(height: 10),
        _rewardCard('Váy dạ nguyệt quế thỏ', '2.000 xu'),
        _rewardCard('Cẩm y vệ quế ảnh', '1.500 xu'),
        _rewardCard('Bộ thẻ học từ mới', '800 xu'),
      ],
    );
  }

  Widget _videoBody() {
    if (widget.frameId == '958:10311') {
      return ListView(
        padding: const EdgeInsets.all(18),
        children: [
          for (final value in [
            'Tự động dịch',
            'Tiếng Anh',
            'Tiếng Anh (MyWords)',
            'Phụ đề song ngữ',
          ])
            ListTile(
              title: Text(value),
              trailing: _activeTab == value
                  ? const Icon(Icons.check_circle, color: _green)
                  : const Icon(Icons.circle_outlined),
              onTap: () => setState(() => _activeTab = value),
            ),
        ],
      );
    }
    if (widget.frameId == '958:10255' ||
        widget.frameId == '958:12133' ||
        widget.frameId == '958:12184' ||
        widget.frameId == '958:12413') {
      return _historyBody();
    }
    if (widget.frameId == '958:12261') {
      return _callBody();
    }
    final player =
        widget.frameId == '958:10144' ||
        widget.frameId == '958:10726' ||
        widget.frameId == '958:11638';
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 26),
      children: [
        if (!player)
          _searchBox(
            'Tìm video hoặc chủ đề...',
            controller: _search,
            onSubmitted: (_) => _toast('Đã lọc danh sách video'),
          ),
        if (!player) const SizedBox(height: 18),
        if (player) _playerCard(),
        if (player) const SizedBox(height: 18),
        if (player)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _modeChip('Nghe'),
              _modeChip('Chép chính tả'),
              _modeChip('Shadowing'),
            ],
          ),
        const SizedBox(height: 18),
        _sectionTitle(
          player ? 'Lời thoại' : 'Chủ đề nổi bật',
          trailing: player ? 'Dịch' : 'Xem tất cả',
        ),
        if (player)
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _showTranslation,
            title: const Text('Hiện bản dịch'),
            onChanged: (v) => setState(() => _showTranslation = v),
          ),
        if (player) ...[
          _dialogueLine(
            'It is raining today, so Peppa and George cannot play outside.',
            'Hôm nay trời mưa nên Peppa và George không thể chơi ngoài trời.',
          ),
          _dialogueLine(
            'Daddy, can we go out to play?',
            'Bố ơi, chúng con ra ngoài chơi được không?',
          ),
        ] else ...[
          _videoRow('Daily English Conversation · Bài 1', '05:10'),
          _videoRow('Peppa Pig · Muddy Puddles', '05:56'),
          _videoRow('We Bare Bears · Everyday English', '01:19'),
        ],
      ],
    );
  }

  Widget _playerCard() => Container(
    height: 205,
    decoration: BoxDecoration(
      color: const Color(0xFF273749),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        const Icon(
          Icons.ondemand_video_rounded,
          color: Colors.white24,
          size: 92,
        ),
        IconButton.filled(
          onPressed: () => setState(() => _playing = !_playing),
          iconSize: 34,
          icon: Icon(_playing ? Icons.pause_rounded : Icons.play_arrow_rounded),
        ),
        Positioned(
          left: 14,
          right: 14,
          bottom: 12,
          child: Row(
            children: [
              Text(
                _playing ? 'Đang phát' : '00:00',
                style: const TextStyle(color: Colors.white),
              ),
              Expanded(
                child: Slider(value: _playing ? .38 : .08, onChanged: null),
              ),
              const Text('05:10', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _historyBody() => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      _sectionTitle(
        'Gần đây',
        trailing: 'Xóa lịch sử',
        onTrailing: () => _toast('Đã xóa lịch sử trên thiết bị'),
      ),
      const SizedBox(height: 12),
      _videoRow('Peppa Pig · Muddy Puddles', '05:10'),
      _videoRow('Listening Time · A2', '05:56'),
      if (widget.frameId == '958:12133' || widget.frameId == '958:12184')
        const Padding(
          padding: EdgeInsets.only(top: 18),
          child: Text(
            'Chưa có cuộc gọi nào. Bắt đầu luyện nói để lưu lịch sử tại đây.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
        ),
    ],
  );

  Widget _callBody() => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 52,
            backgroundColor: Color(0xFFDDECE4),
            child: Icon(Icons.support_agent_rounded, size: 58, color: _green),
          ),
          const SizedBox(height: 16),
          const Text(
            'Luyện hội thoại tiếng Anh',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            'Cuộc gọi mô phỏng, không kết nối ra ngoài.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => setState(() => _playing = !_playing),
            icon: Icon(_playing ? Icons.call_end : Icons.call),
            label: Text(_playing ? 'Kết thúc luyện tập' : 'Bắt đầu luyện tập'),
          ),
        ],
      ),
    ),
  );

  Widget _voiceBody() {
    final roleplay =
        widget.frameId.startsWith('964:12') ||
        widget.frameId.startsWith('964:13');
    if (widget.frameId == '964:13491') {
      return ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _banner(
            'Hoàn thành nhập vai',
            'Bạn đã hoàn thành cuộc hội thoại thử nghiệm.',
            Icons.celebration_rounded,
            const Color(0xFFFFE5A9),
          ),
          const SizedBox(height: 18),
          _dialogueLine(
            'Great effort! Try using “book” in your next conversation.',
            'Tiến bộ tốt! Hãy thử dùng từ mới trong lần tới.',
          ),
          FilledButton(
            onPressed: () => _toast('Đã bắt đầu lượt luyện mới'),
            child: const Text('Thử lại'),
          ),
        ],
      );
    }
    if (widget.frameId == '964:13012' ||
        widget.frameId == '964:13111' ||
        widget.frameId == '964:13223' ||
        widget.frameId == '964:13345') {
      return _callBody();
    }
    if (widget.frameId == '964:12868') {
      return ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _field('Tên tình huống', 'Gặp bạn mới ở trường'),
          _field('Vai trò của bạn', 'Học sinh mới'),
          _field('Mục tiêu hội thoại', 'Làm quen và hỏi về lớp học'),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => _toast('Đã lưu tình huống trên thiết bị'),
            child: const Text('Tạo tình huống'),
          ),
          const SizedBox(height: 20),
          _sectionTitle('Hoặc chọn tình huống'),
          _scenarioCard('Làm quen ngày đầu đến trường', 'Cơ bản'),
          _scenarioCard('Mua vé tàu điện', 'Trung bình'),
        ],
      );
    }
    if (widget.frameId == '964:12549' ||
        widget.frameId == '964:12688' ||
        widget.frameId == '964:12771' ||
        widget.frameId == '964:13460') {
      return ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _searchBox(
            'Tìm tình huống...',
            controller: _search,
            onSubmitted: (_) => _toast('Đã lọc tình huống'),
          ),
          _scenarioCard('Gặp bạn mới ở trường', 'Cơ bản'),
          _scenarioCard('Mua vé tàu điện', 'Trung bình'),
          _scenarioCard('Phỏng vấn thực tập', 'Nâng cao'),
          if (roleplay)
            FilledButton(
              onPressed: () => _toast('Đã bắt đầu hội thoại mô phỏng'),
              child: const Text('Bắt đầu nhập vai'),
            ),
        ],
      );
    }
    final permission =
        widget.frameId == '958:11896' ||
        widget.frameId == '958:11913' ||
        widget.frameId == '958:11953' ||
        widget.frameId == '958:12002' ||
        widget.frameId == '958:12067';
    if (permission) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mic_none_rounded, size: 64, color: _green),
              const SizedBox(height: 14),
              const Text(
                'Cho phép dùng micro?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              const Text(
                'Micro chỉ dùng để mô phỏng thao tác ghi âm trong giao diện này.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: () => setState(() => _recordPermission = true),
                child: Text(
                  _recordPermission ? 'Đã cho phép trên thiết bị' : 'Cho phép',
                ),
              ),
              TextButton(
                onPressed: () => Navigator.maybePop(context),
                child: const Text('Để sau'),
              ),
            ],
          ),
        ),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 52,
              backgroundColor: Color(0xFFDDECE4),
              child: Icon(
                Icons.record_voice_over_rounded,
                size: 54,
                color: _green,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _recording
                  ? 'Đang ghi âm thử nghiệm…'
                  : 'Nghe mẫu và luyện phát âm',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Audio và nhận dạng giọng nói chưa kết nối; các nút đang chạy mô phỏng.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              children: [
                OutlinedButton.icon(
                  onPressed: () => setState(() => _playing = !_playing),
                  icon: Icon(_playing ? Icons.pause : Icons.play_arrow),
                  label: Text(_playing ? 'Tạm dừng' : 'Nghe mẫu'),
                ),
                FilledButton.icon(
                  onPressed: () => setState(() => _recording = !_recording),
                  icon: Icon(_recording ? Icons.stop : Icons.mic),
                  label: Text(_recording ? 'Dừng' : 'Ghi âm'),
                ),
              ],
            ),
            if (!_recording)
              TextButton(
                onPressed: () =>
                    _toast('Kết quả phát âm: tốt, hãy luyện thêm ngữ điệu'),
                child: const Text('Xem kết quả'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _supportBody() => Column(
    children: [
      Expanded(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text(
              'Bộ phận chăm sóc khách hàng',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
            ),
            const SizedBox(height: 5),
            const Text(
              'Thường phản hồi trong giờ làm việc',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 18),
            for (final q in [
              'Làm thế nào để sử dụng máy học từ vựng?',
              'Tôi nên sử dụng dịch vụ chuyển phát nào?',
              'Khi nào hàng sẽ được giao?',
            ])
              Card(
                color: Colors.white,
                child: ExpansionTile(
                  title: Text(q),
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Text(
                        'Thông tin sẽ được cập nhật tại đây. Bạn có thể gửi câu hỏi để lưu vào hộp hỗ trợ cục bộ.',
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _message,
                  decoration: const InputDecoration(
                    hintText: 'Nhập câu hỏi...',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              IconButton.filled(
                onPressed: () {
                  if (_message.text.trim().isNotEmpty) {
                    _toast('Đã lưu câu hỏi trên thiết bị');
                    _message.clear();
                  }
                },
                icon: const Icon(Icons.send_rounded),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  Widget _scenarioCard(String title, String level) => Card(
    color: Colors.white,
    child: ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color(0xFFE4F1E9),
        child: Icon(Icons.forum_outlined, color: _green),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(level),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _toast('Đã chọn: $title'),
    ),
  );
  Widget _videoRow(String title, String duration) => Card(
    color: Colors.white,
    margin: const EdgeInsets.only(bottom: 9),
    child: ListTile(
      leading: const Icon(
        Icons.play_circle_fill_rounded,
        color: _green,
        size: 38,
      ),
      title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text(duration),
      onTap: () => setState(() => _playing = true),
    ),
  );
  Widget _dialogueLine(String english, String vietnamese) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: _cardDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          english,
          style: const TextStyle(fontWeight: FontWeight.w700, height: 1.35),
        ),
        if (_showTranslation) ...[
          const SizedBox(height: 6),
          Text(
            vietnamese,
            style: const TextStyle(color: Colors.black54, height: 1.35),
          ),
        ],
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () => _toast('Đang phát âm mẫu mô phỏng'),
            icon: const Icon(Icons.volume_up_outlined),
          ),
        ),
      ],
    ),
  );
  Widget _field(String label, String hint) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
  Widget _searchBox(
    String hint, {
    required TextEditingController controller,
    required ValueChanged<String> onSubmitted,
  }) => TextField(
    controller: controller,
    onSubmitted: onSubmitted,
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.search),
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    ),
  );
  Widget _banner(String title, String subtitle, IconData icon, Color color) =>
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(color: _ink, height: 1.35),
                  ),
                ],
              ),
            ),
            Icon(icon, size: 52, color: _ink),
          ],
        ),
      );
  Widget _sectionTitle(
    String title, {
    String? trailing,
    VoidCallback? onTrailing,
  }) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 17,
            color: _ink,
          ),
        ),
      ),
      if (trailing != null)
        TextButton(
          onPressed: onTrailing ?? () => _toast('$trailing: cục bộ'),
          child: Text(trailing),
        ),
    ],
  );
  Widget _categoryChip(String title, IconData icon) => Expanded(
    child: InkWell(
      onTap: () => setState(() => _activeTab = title),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        decoration: _cardDecoration(),
        child: Column(
          children: [
            Icon(icon, color: _green),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    ),
  );
  Widget _productCard(
    String name,
    String price,
    String rating,
    IconData icon,
  ) => Card(
    color: Colors.white,
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      leading: Container(
        width: 54,
        height: 58,
        decoration: BoxDecoration(
          color: const Color(0xFFEAF0F4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: _ink),
      ),
      title: Text(
        name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text('$price   ·   ★ $rating'),
      trailing: IconButton(
        onPressed: () => _toast('Đã thêm vào giỏ'),
        icon: const Icon(Icons.add_shopping_cart_outlined),
      ),
      onTap: () => _toast('Đã mở chi tiết sản phẩm'),
    ),
  );
  Widget _rewardCard(String title, String cost) => Card(
    color: Colors.white,
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color(0xFFFFEBC1),
        child: Icon(Icons.card_giftcard, color: Color(0xFFB87E15)),
      ),
      title: Text(title),
      subtitle: Text(cost),
      trailing: FilledButton.tonal(
        onPressed: () => _toast('Đang xem xác nhận đổi $title'),
        child: const Text('Đổi'),
      ),
    ),
  );
  Widget _modeChip(String label) => FilterChip(
    label: Text(label),
    selected: _activeTab == label,
    onSelected: (_) => setState(() => _activeTab = label),
  );
  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    boxShadow: const [
      BoxShadow(color: Color(0x10000000), blurRadius: 12, offset: Offset(0, 4)),
    ],
  );
}
