import 'package:flutter/material.dart';

const _ink = Color(0xFF1F2937);
const _muted = Color(0xFF98A2B3);
const _blue = Color(0xFF165DFF);
const _serif = 'Noto Serif';

/// Dashboard variation shown in the Page 1 chat modal flow (1170:3772).
class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({
    super.key,
    this.onTabSelected,
    this.onFeatureSelected,
    this.onTaskSelected,
    this.onCatalogSelected,
    this.onRankSelected,
    this.onInboxSelected,
    this.onConversationSelected,
    this.onConversationActionSelected,
    this.onStudySelected,
    this.onReviewSelected,
    this.onEditPlanSelected,
    this.onBuyBooksSelected,
  });

  final ValueChanged<int>? onTabSelected;
  final ValueChanged<int>? onFeatureSelected;
  final VoidCallback? onTaskSelected;
  final VoidCallback? onCatalogSelected;
  final VoidCallback? onRankSelected;
  final VoidCallback? onInboxSelected;
  final ValueChanged<int>? onConversationSelected;
  final void Function(int category, int action)? onConversationActionSelected;
  final VoidCallback? onStudySelected;
  final VoidCallback? onReviewSelected;
  final VoidCallback? onEditPlanSelected;
  final VoidCallback? onBuyBooksSelected;

  @override
  Widget build(BuildContext context) => _ChatHome(
    onTabSelected: onTabSelected,
    onFeatureSelected: onFeatureSelected,
    onTaskSelected: onTaskSelected,
    onCatalogSelected: onCatalogSelected,
    onRankSelected: onRankSelected,
    onInboxSelected: onInboxSelected,
    onConversationSelected: onConversationSelected,
    onConversationActionSelected: onConversationActionSelected,
    onStudySelected: onStudySelected,
    onReviewSelected: onReviewSelected,
    onEditPlanSelected: onEditPlanSelected,
    onBuyBooksSelected: onBuyBooksSelected,
  );
}

class _ChatHome extends StatelessWidget {
  const _ChatHome({
    this.onTabSelected,
    this.onFeatureSelected,
    this.onTaskSelected,
    this.onCatalogSelected,
    this.onRankSelected,
    this.onInboxSelected,
    this.onConversationSelected,
    this.onConversationActionSelected,
    this.onStudySelected,
    this.onReviewSelected,
    this.onEditPlanSelected,
    this.onBuyBooksSelected,
  });
  final ValueChanged<int>? onTabSelected;
  final ValueChanged<int>? onFeatureSelected;
  final VoidCallback? onTaskSelected;
  final VoidCallback? onCatalogSelected;
  final VoidCallback? onRankSelected;
  final VoidCallback? onInboxSelected;
  final ValueChanged<int>? onConversationSelected;
  final void Function(int category, int action)? onConversationActionSelected;
  final VoidCallback? onStudySelected;
  final VoidCallback? onReviewSelected;
  final VoidCallback? onEditPlanSelected;
  final VoidCallback? onBuyBooksSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          const Page1FigmaStatusBar(),
          _HomeTopBar(
            onTaskSelected: onTaskSelected,
            onCatalogSelected: onCatalogSelected,
            onRankSelected: onRankSelected,
            onInboxSelected: onInboxSelected,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(14, 25, 14, 14),
              child: Column(
                children: [
                  _StudyPlanCard(
                    onStudy: onStudySelected,
                    onReview: onReviewSelected,
                    onEdit: onEditPlanSelected,
                    onBuyBooks: onBuyBooksSelected,
                  ),
                  const SizedBox(height: 14),
                  _FeatureGrid(onFeatureSelected: onFeatureSelected),
                  const SizedBox(height: 14),
                  _ConversationCard(
                    title: 'Nghe',
                    description:
                        'Cải thiện kỹ năng hiểu và tốc độ nghe của bạn',
                    imageAsset: 'assets/figma/page1_home/77b792d1bf46df4a788350ee66951709f0fab255.png',
                    actions: const ['YouTube', 'Gọi điện', 'Nhập vai'],
                    onTap: () => onConversationSelected?.call(0),
                    onActionSelected: (action) =>
                        onConversationActionSelected?.call(0, action),
                  ),
                  const SizedBox(height: 10),
                  _ConversationCard(
                    title: 'Nói',
                    description: 'Nói tự nhiên và tự tin hơn',
                    imageAsset: 'assets/figma/page1_home/28805b5ce76303433b272a3623043408f470bf49.png',
                    actions: const ['Phát âm', 'Hội thoại', 'Nhập vai'],
                    onTap: () => onConversationSelected?.call(1),
                    onActionSelected: (action) =>
                        onConversationActionSelected?.call(1, action),
                  ),
                  const SizedBox(height: 10),
                  _ConversationCard(
                    title: 'Đọc',
                    description: 'Mở rộng vốn từ thông qua việc đọc',
                    imageAsset: 'assets/figma/page1_home/0b53c4bb3e9e7895c4668e65b3e4aa0dbb3eec05.png',
                    actions: const ['Sách', 'Tin tức'],
                    onTap: () => onConversationSelected?.call(2),
                    onActionSelected: (action) =>
                        onConversationActionSelected?.call(2, action),
                  ),
                  const SizedBox(height: 10),
                  _ConversationCard(
                    title: 'Viết',
                    description: 'Luyện ngữ pháp và cách xây dựng câu',
                    imageAsset: 'assets/figma/page1_home/60b65c56c0e9150223b7453a69ea74f04e3affa3.png',
                    actions: const ['Nhật ký', 'Chat'],
                    onTap: () => onConversationSelected?.call(3),
                    onActionSelected: (action) =>
                        onConversationActionSelected?.call(3, action),
                  ),
                ],
              ),
            ),
          ),
          Page1BottomNavigationBar(
            selectedIndex: 0,
            onTabSelected: onTabSelected,
            labels: const [
              'Từ vựng',
              'Học tập',
              'Cùng học',
              'Đổi xu',
              'Cá nhân',
            ],
          ),
        ],
      ),
    );
  }
}

class _HomeTopBar extends StatelessWidget {
  const _HomeTopBar({
    this.onTaskSelected,
    this.onCatalogSelected,
    this.onRankSelected,
    this.onInboxSelected,
  });
  final VoidCallback? onTaskSelected;
  final VoidCallback? onCatalogSelected;
  final VoidCallback? onRankSelected;
  final VoidCallback? onInboxSelected;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 48,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _TopPill(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.bolt, size: 14, color: const Color(0xFF9333EA)),
                const Text(
                  ' 1',
                  style: TextStyle(
                    fontFamily: _serif,
                    fontSize: 11,
                    color: _muted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 44,
            child: InkWell(
              onTap: onRankSelected,
              borderRadius: BorderRadius.circular(20),
              child: const _TopPill(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.emoji_events_outlined,
                      size: 14,
                      color: Color(0xFFB7791F),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Rank',
                      style: TextStyle(
                        fontFamily: _serif,
                        fontSize: 10,
                        color: _muted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 44,
            child: InkWell(
              onTap: onTaskSelected,
              borderRadius: BorderRadius.circular(20),
              child: const _TopPill(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.task_alt_rounded, size: 13, color: _muted),
                    SizedBox(width: 4),
                    Text(
                      'Task',
                      style: TextStyle(
                        fontFamily: _serif,
                        fontSize: 10,
                        color: _muted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onCatalogSelected,
            customBorder: const CircleBorder(),
            child: const SizedBox(
              width: 44,
              height: 44,
              child: Icon(Icons.search_rounded, size: 22, color: _ink),
            ),
          ),
          const SizedBox(width: 8),
          Semantics(
            button: true,
            label: 'Thông báo, có thông báo mới',
            child: IconButton(
              tooltip: 'Thông báo',
              onPressed: onInboxSelected,
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.mail_outline, size: 19, color: _ink),
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF04452),
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _TopPill extends StatelessWidget {
  const _TopPill({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Container(
    height: 30,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
    ),
    child: child,
  );
}

class _StudyPlanCard extends StatelessWidget {
  const _StudyPlanCard({
    this.onStudy,
    this.onReview,
    this.onEdit,
    this.onBuyBooks,
  });

  final VoidCallback? onStudy;
  final VoidCallback? onReview;
  final VoidCallback? onEdit;
  final VoidCallback? onBuyBooks;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 311),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
            child: Row(
              children: [
                SizedBox(width: 65, height: 80, child: const _GreenBookCover()),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Bộ tiếng anh 1',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: _serif,
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: onEdit,
                            style: TextButton.styleFrom(
                              minimumSize: const Size(44, 44),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              tapTargetSize: MaterialTapTargetSize.padded,
                            ),
                            child: const Text(
                              'Sửa đổi',
                              style: TextStyle(
                                fontFamily: _serif,
                                fontSize: 9,
                                color: _muted,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            size: 16,
                            color: _muted,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: 4 / 20,
                          minHeight: 4,
                          backgroundColor: const Color(0xFFF3F4F6),
                          color: _blue,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 6,
                            color: const Color(0xFF60A5FA),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '4 / 4440',
                            style: TextStyle(
                              fontFamily: _serif,
                              fontSize: 9,
                              color: _muted,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            'Còn lại 222 ngày',
                            style: TextStyle(
                              fontFamily: _serif,
                              fontSize: 9,
                              color: _muted,
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: Color(0xFFE5E7EB)),
          ),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Kế hoạch hôm nay',
                  style: TextStyle(
                    fontFamily: _serif,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: onBuyBooks,
                child: const Text(
                  'Mua sách',
                  style: TextStyle(
                    fontFamily: _serif,
                    fontSize: 10,
                    color: _blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: const _StudyStat(
                  label: 'Đã học',
                  value: '0',
                  suffix: '/ 5',
                ),
              ),
              Expanded(
                child: const _StudyStat(
                  label: 'Ôn tập',
                  value: '0',
                  suffix: '/ 1',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _StudyButton(
                  label: 'Học',
                  color: _blue,
                  onPressed: onStudy,
                ),
              ),
              const SizedBox(width: 22),
              Expanded(
                child: _StudyButton(
                  label: 'Ôn tập',
                  color: _blue,
                  onPressed: onReview,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StudyStat extends StatelessWidget {
  const _StudyStat({
    required this.label,
    required this.value,
    required this.suffix,
  });
  final String label, value, suffix;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontFamily: _serif, fontSize: 12, color: _muted),
      ),
      const SizedBox(height: 4),
      Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontFamily: _serif,
              fontSize: 28,
              height: 1.1,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            suffix,
            style: const TextStyle(
              fontFamily: _serif,
              fontSize: 11,
              color: _ink,
            ),
          ),
        ],
      ),
    ],
  );
}

class _StudyButton extends StatelessWidget {
  const _StudyButton({
    required this.label,
    required this.color,
    this.onPressed,
  });
  final String label;
  final Color color;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 48,
    child: FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: _serif,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    ),
  );
}

class _GreenBookCover extends StatelessWidget {
  const _GreenBookCover();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: const Color(0xFF18A957),
      borderRadius: BorderRadius.circular(3),
      boxShadow: const [
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 5,
          offset: Offset(1, 2),
        ),
      ],
      border: const Border(
        left: BorderSide(color: Color(0xFF087C37), width: 3),
      ),
    ),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF087C37),
              borderRadius: BorderRadius.circular(2),
            ),
            child: const Text(
              'CET-4',
              style: TextStyle(
                fontFamily: _serif,
                color: Colors.white,
                fontSize: 7,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.bottomRight,
          child: Text(
            '4',
            style: TextStyle(
              fontFamily: _serif,
              color: Color(0x5577D89C),
              fontSize: 44,
              height: .9,
            ),
          ),
        ),
      ],
    ),
  );
}

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid({this.onFeatureSelected});
  final ValueChanged<int>? onFeatureSelected;
  @override
  Widget build(BuildContext context) {
    const labels = ['Tác phẩm', 'Luyện từ', 'Sách từ vựng', 'Kiểm tra từ'];
    const icons = [
      Icons.menu_book_outlined,
      Icons.edit_outlined,
      Icons.bookmark_border,
      Icons.event_available_outlined,
    ];
    return Row(
      children: List.generate(
        labels.length,
        (i) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i == labels.length - 1 ? 0 : 10),
            child: InkWell(
              onTap: () => onFeatureSelected?.call(i),
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icons[i], size: 22, color: _ink),
                          const SizedBox(height: 6),
                          Text(
                            labels[i],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: _serif,
                              fontSize: 9,
                              color: _ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (i == 0)
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: const Text(
                            'NEW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 6,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ConversationCard extends StatelessWidget {
  const _ConversationCard({
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.actions,
    this.onTap,
    this.onActionSelected,
  });
  final String title, description, imageAsset;
  final List<String> actions;
  final VoidCallback? onTap;
  final ValueChanged<int>? onActionSelected;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 16, 14, 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: _serif,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(
                          fontFamily: _serif,
                          fontSize: 12,
                          height: 1.35,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  imageAsset,
                  width: 72,
                  height: 52,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 0,
              children: [
                for (var i = 0; i < actions.length; i++)
                  ActionChip(
                    avatar: const Icon(Icons.arrow_forward_rounded, size: 13),
                    label: Text(actions[i]),
                    tooltip: 'Mở ${actions[i]}',
                    onPressed: onActionSelected == null
                        ? null
                        : () => onActionSelected!(i),
                    labelStyle: const TextStyle(
                      fontFamily: _serif,
                      fontSize: 9,
                      color: _ink,
                    ),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class Page1BottomNavigationBar extends StatelessWidget {
  const Page1BottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.labels,
    this.onTabSelected,
  });
  final int selectedIndex;
  final List<String> labels;
  final ValueChanged<int>? onTabSelected;
  static const icons = [
    Icons.text_fields,
    Icons.smart_display_outlined,
    Icons.language,
    Icons.radio_button_checked,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) => Container(
    height: 59,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: const BoxDecoration(
      color: Color(0xF2FFFFFF),
      border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
      boxShadow: [
        BoxShadow(
          color: Color(0x08000000),
          blurRadius: 8,
          offset: Offset(0, -2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        labels.length,
        (i) => InkWell(
          onTap: () => onTabSelected?.call(i),
          child: SizedBox(
            width: 54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icons[i],
                  size: 20,
                  color: i == selectedIndex ? const Color(0xFF111827) : _muted,
                ),
                const SizedBox(height: 1),
                Text(
                  labels[i],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: _serif,
                    fontSize: 9,
                    height: 1.2,
                    fontWeight: i == selectedIndex
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: i == selectedIndex
                        ? const Color(0xFF111827)
                        : _muted,
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

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  State<NotificationCenterScreen> createState() =>
      _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
  final Set<int> _read = {};
  bool _unreadOnly = false;

  static const _items = <(IconData, String, String, String)>[
    (
      Icons.flag_outlined,
      'Mục tiêu hôm nay',
      'Bạn còn 3 từ cần ôn tập.',
      'Hôm nay',
    ),
    (
      Icons.groups_outlined,
      'Lớp học Unique',
      'Lớp vừa có hoạt động mới.',
      'Hôm qua',
    ),
    (
      Icons.auto_stories_outlined,
      'Sách mới trong thư viện',
      'Khám phá bộ truyện phù hợp cấp độ của bạn.',
      '2 ngày trước',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final visible = [
      for (var i = 0; i < _items.length; i++)
        if (!_unreadOnly || !_read.contains(i)) i,
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        title: const Text('Thông báo'),
        actions: [
          TextButton(
            onPressed: () => setState(
              () => _read.addAll(List.generate(_items.length, (i) => i)),
            ),
            child: const Text('Đánh dấu đã đọc'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('Tất cả')),
                ButtonSegment(value: true, label: Text('Chưa đọc')),
              ],
              selected: {_unreadOnly},
              onSelectionChanged: (value) =>
                  setState(() => _unreadOnly = value.first),
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? const Center(child: Text('Bạn đã xem hết thông báo.'))
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    itemCount: visible.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, row) {
                      final index = visible[row];
                      final item = _items[index];
                      final isRead = _read.contains(index);
                      return Card(
                        color: isRead ? Colors.white : const Color(0xFFEFF6FF),
                        elevation: 0,
                        child: ListTile(
                          minLeadingWidth: 44,
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(item.$1, color: _blue),
                          ),
                          title: Text(
                            item.$2,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text('${item.$3}\n${item.$4}'),
                          isThreeLine: true,
                          trailing: isRead
                              ? null
                              : const Icon(
                                  Icons.circle,
                                  size: 9,
                                  color: Color(0xFFEF4444),
                                ),
                          onTap: () => setState(() => _read.add(index)),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class WritingPracticeScreen extends StatefulWidget {
  const WritingPracticeScreen({super.key, this.chatMode = false});

  final bool chatMode;

  @override
  State<WritingPracticeScreen> createState() => _WritingPracticeScreenState();
}

class _WritingPracticeScreenState extends State<WritingPracticeScreen> {
  final _controller = TextEditingController();
  final List<String> _sentMessages = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    if (widget.chatMode) {
      setState(() {
        _sentMessages.add(text);
        _controller.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã ghi nhận bản nháp trong phiên này.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF8FAFC),
    appBar: AppBar(
      backgroundColor: const Color(0xFFF8FAFC),
      title: Text(widget.chatMode ? 'Chat tiếng Anh' : 'Nhật ký học tập'),
    ),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          widget.chatMode
              ? 'Luyện viết qua hội thoại'
              : 'Ghi lại một điều bạn đã học hôm nay',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: _ink,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.chatMode
              ? 'Chế độ thực hành ngoại tuyến. Tin nhắn được giữ trong phiên này.'
              : 'Bản nháp được lưu trên thiết bị; chưa đồng bộ lên tài khoản.',
          style: const TextStyle(color: _muted),
        ),
        const SizedBox(height: 20),
        if (widget.chatMode)
          for (final message in _sentMessages)
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(message),
              ),
            )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final prompt in [
                'Hôm nay tôi đã…',
                'Từ mới của tôi là…',
                'Ngày mai tôi sẽ…',
              ])
                ActionChip(
                  label: Text(prompt),
                  onPressed: () => setState(() => _controller.text = prompt),
                ),
            ],
          ),
        const SizedBox(height: 12),
        TextField(
          controller: _controller,
          minLines: widget.chatMode ? 2 : 7,
          maxLines: widget.chatMode ? 4 : 12,
          maxLength: widget.chatMode ? 300 : 500,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: widget.chatMode
                ? 'Viết tin nhắn bằng tiếng Anh'
                : 'Nội dung nhật ký',
            alignLabelWithHint: true,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: _submit,
          icon: Icon(
            widget.chatMode ? Icons.send_rounded : Icons.save_outlined,
          ),
          label: Text(widget.chatMode ? 'Gửi thử' : 'Lưu bản nháp'),
        ),
      ],
    ),
  );
}

class ReadingNewsScreen extends StatelessWidget {
  const ReadingNewsScreen({super.key});

  static const _articles = <(String, String)>[
    (
      'A small habit that changes your morning',
      'Thói quen nhỏ giúp buổi sáng dễ bắt đầu hơn.',
    ),
    (
      'How city parks help wildlife',
      'Công viên trong thành phố hỗ trợ động vật hoang dã.',
    ),
    (
      'The science of learning a new language',
      'Khoa học đằng sau việc học một ngôn ngữ mới.',
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF8FAFC),
    appBar: AppBar(
      backgroundColor: const Color(0xFFF8FAFC),
      title: const Text('Tin tức dễ đọc'),
    ),
    body: ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _articles.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) => Card(
        elevation: 0,
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.article_outlined)),
          title: Text(_articles[index].$1),
          subtitle: Text(_articles[index].$2),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => _ReadingArticleScreen(
                title: _articles[index].$1,
                summary: _articles[index].$2,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _ReadingArticleScreen extends StatelessWidget {
  const _ReadingArticleScreen({required this.title, required this.summary});

  final String title;
  final String summary;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF8FAFC),
    appBar: AppBar(
      backgroundColor: const Color(0xFFF8FAFC),
      title: const Text('Bài đọc'),
    ),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: _ink,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Đọc chậm và chạm vào từ bạn muốn tra cứu.',
          style: TextStyle(color: _muted),
        ),
        const Divider(height: 32),
        Text(
          '$summary\n\nRead the passage at your own pace. Notice the new words and use the bookmark to review them later.',
          style: const TextStyle(fontSize: 17, height: 1.6),
        ),
      ],
    ),
  );
}

class Page1FigmaStatusBar extends StatelessWidget {
  const Page1FigmaStatusBar({super.key});
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 32,
    child: Padding(
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
              border: Border.all(color: _ink, width: .8),
              borderRadius: BorderRadius.circular(2),
            ),
            child: const Text(
              'Vo\nLTE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: _serif,
                color: _ink,
                fontSize: 6,
                height: .9,
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
              style: TextStyle(fontFamily: _serif, color: _ink, fontSize: 8),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Coin and product home screen from Page 1 (Figma node 593:18778).
class SopHomeScreen extends StatelessWidget {
  const SopHomeScreen({super.key, this.onTabSelected});
  final ValueChanged<int>? onTabSelected;
  static const _images = [
    'assets/figma/page1_home/ee6411d0f6662e72a0ac1108a08af0bbc0407843.png',
    'assets/figma/page1_home/2279177c95dac4a4a6c11b48689df95e05a29d51.png',
    'assets/figma/page1_home/ed21d98356f7611db32b054a0c57fd5e92946892.jpg',
    'assets/figma/page1_home/e3a31846368bb0c9e10443e53199b104a8c5ec14.png',
    'assets/figma/page1_home/6779b83dd16dfc983a4913167f2e0b00295f8b76.png',
    'assets/figma/page1_home/537547aed3de68008841b582915d7a7ae17a15f2.png',
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF8FAFC),
    body: Stack(
      children: [
        const Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: 230,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFD2F0FF), Color(0xFFF8FAFC)],
              ),
            ),
          ),
        ),
        Column(
          children: [
            const Page1FigmaStatusBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
                child: Column(
                  children: [
                    const _ShopHeader(),
                    const SizedBox(height: 10),
                    const _CouponBanner(),
                    const SizedBox(height: 12),
                    const _QuickCategories(),
                    const SizedBox(height: 12),
                    _ShopDeals(images: _images),
                    const SizedBox(height: 10),
                    _ShopProducts(images: _images),
                    const SizedBox(height: 10),
                    _FeaturedProducts(images: _images),
                  ],
                ),
              ),
            ),
            Page1BottomNavigationBar(
              selectedIndex: 3,
              onTabSelected: onTabSelected,
              labels: const [
                'Từ vựng',
                'Học tập',
                'Cùng học',
                'Đổi xu',
                'Cá nhân',
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

class _ShopHeader extends StatelessWidget {
  const _ShopHeader();
  @override
  Widget build(BuildContext context) => Column(
    children: [
      SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(Icons.search, size: 20, color: _ink),
            SizedBox(width: 18),
            Icon(Icons.headphones_outlined, size: 20, color: _ink),
            SizedBox(width: 18),
            Icon(Icons.person_outline, size: 20, color: _ink),
            SizedBox(width: 18),
            Icon(Icons.shopping_cart_outlined, size: 20, color: _ink),
          ],
        ),
      ),
      SizedBox(
        height: 52,
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFB300), width: 4),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD54F), Color(0xFFFF9800)],
                ),
                boxShadow: const [
                  BoxShadow(color: Color(0x33FF9800), blurRadius: 7),
                ],
              ),
              child: const Icon(
                Icons.monetization_on_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontFamily: _serif, color: _ink),
                      children: [
                        TextSpan(
                          text: '55 ',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'đồng xu',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Học tập tích xu, đồng xu đổi quà tặng ~~',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: _serif,
                      fontSize: 9,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text(
                'Kiếm thêm xu  ›',
                style: TextStyle(fontFamily: _serif, fontSize: 10, color: _ink),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class _CouponBanner extends StatelessWidget {
  const _CouponBanner();
  @override
  Widget build(BuildContext context) => Container(
    height: 113,
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFFEEEDE), Color(0xFFFCE4CB)],
      ),
      borderRadius: BorderRadius.circular(17),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Trợ cấp giới hạn cho bạn mới',
                style: TextStyle(
                  fontFamily: _serif,
                  fontSize: 12,
                  color: Color(0xFF743505),
                ),
              ),
            ),
            const Text(
              'Còn lại 3 ngày 0 giờ 23 phút',
              style: TextStyle(
                fontFamily: _serif,
                fontSize: 7,
                color: Color(0xFF9A5323),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Text(
                  '300',
                  style: TextStyle(
                    fontFamily: _serif,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFF84300),
                  ),
                ),
                const SizedBox(width: 3),
                const Text(
                  'đồng xu',
                  style: TextStyle(
                    fontFamily: _serif,
                    fontSize: 11,
                    color: Color(0xFFF84300),
                  ),
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF8233), Color(0xFFFF5214)],
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Text(
                        'Nhận ngay',
                        style: TextStyle(
                          fontFamily: _serif,
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Chỉ 1 lần/tài khoản',
                      style: TextStyle(
                        fontFamily: _serif,
                        fontSize: 8,
                        color: Color(0xFFFB923C),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _QuickCategories extends StatelessWidget {
  const _QuickCategories();
  static const items = [
    ('✏️', 'Văn phòng', Color(0xFFFFF7ED)),
    ('ĐH', 'Đại học', Color(0xFF3B82F6)),
    ('C2', 'Cấp 2', Color(0xFF10B981)),
    ('TH', 'Tiểu học', Color(0xFFFBBF24)),
    ('📅', 'Lịch', Color(0xFFFFF1F2)),
    ('🎁', 'Quà tặng', Color(0xFF0D9488)),
  ];
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 65,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items
          .map(
            (item) => SizedBox(
              width: 48,
              child: Column(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: item.$3,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      item.$1,
                      style: TextStyle(
                        fontFamily: _serif,
                        fontSize: item.$1.length > 1 ? 11 : 17,
                        color:
                            item.$1 == '✏️' ||
                                item.$1 == '📅' ||
                                item.$1 == '🎁'
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.$2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: _serif,
                      fontSize: 8,
                      color: Color(0xFF374151),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    ),
  );
}

class _ShopDeals extends StatelessWidget {
  const _ShopDeals({required this.images});
  final List<String> images;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 166,
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF7E42), Color(0xFFFF472E)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1 đồng xu',
                      style: TextStyle(
                        fontFamily: _serif,
                        color: Color(0xFFFF5A1F),
                        fontSize: 9,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Cào nhận văn phòng phẩm',
                      style: TextStyle(
                        fontFamily: _serif,
                        color: Colors.white,
                        fontSize: 11,
                        height: 1.7,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: Transform.rotate(
                    angle: -.45,
                    child: Row(
                      children: [
                        for (var i = 0; i < 2; i++)
                          Container(
                            width: 40,
                            height: 23,
                            margin: const EdgeInsets.only(right: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFF73CBBF),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: const Center(
                              child: Text(
                                'oops!',
                                style: TextStyle(
                                  fontFamily: _serif,
                                  fontSize: 6,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFEFF3), Color(0xFFFFF6F8)],
              ),
              border: Border.all(color: const Color(0xFFFFE4E6)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      '⚡ Siêu tiết kiệm',
                      style: TextStyle(
                        fontFamily: _serif,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE11D48),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Còn 1h',
                      style: TextStyle(
                        fontFamily: _serif,
                        fontSize: 7,
                        color: Colors.white,
                        backgroundColor: Color(0xFFFF4D4F),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Row(
                    children: [
                      for (var i = 0; i < 2; i++)
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: i == 0 ? 5 : 0),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      images[i],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  i == 0 ? '25.000 vnđ' : '35.000 vnđ',
                                  style: const TextStyle(
                                    fontFamily: _serif,
                                    fontSize: 6,
                                    decoration: TextDecoration.lineThrough,
                                    color: _muted,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF5A1F),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    i == 0 ? 'Chỉ 7.000 vnđ' : 'Chỉ 11.000 vnđ',
                                    style: const TextStyle(
                                      fontFamily: _serif,
                                      fontSize: 6,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
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
}

class _ShopProducts extends StatelessWidget {
  const _ShopProducts({required this.images});
  final List<String> images;
  static const labels = ['Máy đẹp mắt', 'Màn hình màu', 'Máy siêu cấp'];
  @override
  Widget build(BuildContext context) => Row(
    children: List.generate(
      3,
      (i) => Expanded(
        child: Container(
          height: 103,
          margin: EdgeInsets.only(right: i == 2 ? 0 : 6),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F4F7),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Text(
                labels[i],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: _serif,
                  fontSize: 10,
                  color: _ink,
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    images[i + 2],
                    fit: BoxFit.cover,
                    width: 80,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF43F5E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Tiết kiệm 5.000 vnđ',
                  style: TextStyle(
                    fontFamily: _serif,
                    fontSize: 5,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _FeaturedProducts extends StatelessWidget {
  const _FeaturedProducts({required this.images});
  final List<String> images;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 176,
    child: Row(
      children: [
        for (var i = 0; i < 2; i++)
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: i == 0 ? 8 : 0),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFF3F4F6)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    i == 0 ? 'Máy từ vựng  MAX' : 'Máy từ vựng 1S',
                    style: const TextStyle(
                      fontFamily: _serif,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    i == 0
                        ? 'Học mọi lúc mọi nơi,\nkhông cần mạng'
                        : 'Bản nâng cấp thế hệ mới',
                    style: const TextStyle(
                      fontFamily: _serif,
                      fontSize: 8,
                      height: 1.3,
                      color: _muted,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        images[i + 4],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
  );
}
