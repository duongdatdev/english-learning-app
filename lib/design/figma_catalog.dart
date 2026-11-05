import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'generated/figma_context_data.dart';
import 'figma_interactions.dart';

/// Lightweight catalog for the Page 1 Flutter screens exported from Figwright.
/// Frame layouts and style data are compiled into Dart constants; this widget
/// builds their Flutter UI without loading design JSON at runtime.
class Page1FigmaFrame {
  const Page1FigmaFrame({
    required this.id,
    required this.name,
    this.width = 360,
    this.height = 800,
  });

  final String id;
  final String name;
  final double width;
  final double height;
}

/// Supply every non-low Page 1 frame here. The generated list is kept outside
/// this renderer so the inventory can be refreshed without code edits.
class Page1FigmaCatalog extends StatefulWidget {
  const Page1FigmaCatalog({
    super.key,
    required this.frames,
    this.customFrameBuilders = const {},
  });

  final List<Page1FigmaFrame> frames;
  final Map<String, WidgetBuilder> customFrameBuilders;

  @override
  State<Page1FigmaCatalog> createState() => _Page1FigmaCatalogState();
}

class _Page1FigmaCatalogState extends State<Page1FigmaCatalog> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Page1FigmaFrame? _frameById(String id) {
    for (final frame in widget.frames) {
      if (frame.id == id) return frame;
    }
    return null;
  }

  Widget? _destinationPage(BuildContext context, String id) {
    final customBuilder = widget.customFrameBuilders[id];
    if (customBuilder != null) return customBuilder(context);

    final frame = _frameById(id);
    if (frame != null) {
      return FigmaContextScreen(
        frame: frame,
        onInteraction: _handleInteraction,
      );
    }

    final located = _findFigmaNode(id);
    if (located == null) return null;
    return FigmaContextScreen(
      frame: Page1FigmaFrame(
        id: id,
        name: located.node['name'] as String? ?? 'Page 1',
        width: (located.node['width'] as num?)?.toDouble() ?? 360,
        height: (located.node['height'] as num?)?.toDouble() ?? 800,
      ),
      contextFrameId: located.contextFrameId,
      nodeId: id,
      onInteraction: _handleInteraction,
    );
  }

  void _openFrame(BuildContext context, String id) {
    final page = _destinationPage(context, id);
    if (page == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Chưa tìm thấy màn hình đích trong Page 1.'),
        ),
      );
      return;
    }
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  }

  void _handleInteraction(
    BuildContext context,
    Page1FigmaInteraction interaction,
    String sourceNodeId,
  ) {
    if (interaction.action == 'BACK' || interaction.action == 'CLOSE') {
      Navigator.of(context).maybePop();
      return;
    }
    final destinationId = interaction.destinationId;
    if (destinationId == null) return;
    if ((interaction.navigation == 'CHANGE_TO' ||
            interaction.navigation == 'SWAP') &&
        _tryInstanceVariantSwap(context, sourceNodeId, destinationId)) {
      return;
    }
    final page = _destinationPage(context, destinationId);
    if (page == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Màn hình đích chưa được xuất từ Page 1.'),
        ),
      );
      return;
    }
    switch (interaction.navigation) {
      case 'OVERLAY':
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (dialogContext) {
            final size = MediaQuery.sizeOf(dialogContext);
            return Dialog(
              insetPadding: const EdgeInsets.all(16),
              child: SizedBox(
                width: math.min(360, size.width - 32),
                height: math.min(560, size.height - 48),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: page,
                ),
              ),
            );
          },
        );
      case 'CHANGE_TO':
      case 'SWAP':
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute<void>(builder: (_) => page));
      default:
        Navigator.of(context)
            .push(MaterialPageRoute<void>(builder: (_) => page));
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = _query.trim().toLowerCase();
    final frames = widget.frames.where((frame) {
      return query.isEmpty ||
          frame.name.toLowerCase().contains(query) ||
          frame.id.toLowerCase().contains(query);
    }).toList();
    return Scaffold(
      appBar: AppBar(title: Text('Page 1 · ${frames.length} giao diện')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Tìm màn hình theo tên hoặc ID',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                        icon: const Icon(Icons.close),
                      ),
                border: const OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: frames.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final frame = frames[index];
                return ListTile(
                  title: Text(frame.name),
                  subtitle: Text(frame.id),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _openFrame(context, frame.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FigmaContextScreen extends StatelessWidget {
  const FigmaContextScreen({
    super.key,
    required this.frame,
    this.contextFrameId,
    this.nodeId,
    this.onInteraction,
    this.showHeader = true,
  });

  final Page1FigmaFrame frame;
  final String? contextFrameId;
  final String? nodeId;
  final void Function(BuildContext, Page1FigmaInteraction, String)?
  onInteraction;
  final bool showHeader;

  @override
  Widget build(BuildContext context) {
    final data =
        page1FigmaContexts[contextFrameId ?? frame.id] as Map<String, dynamic>?;
    if (data == null) {
      return Scaffold(
        appBar: showHeader ? AppBar(title: Text(frame.name)) : null,
        body: const Center(child: Text('Chưa có màn Dart cho frame này.')),
      );
    }
    final nodes = data['nodes'] as List<dynamic>? ?? const [];
    final root = nodeId == null
        ? nodes.cast<Map<String, dynamic>>().firstWhere(
            (n) => n['id'] == frame.id,
            orElse: () => nodes.isEmpty
                ? <String, dynamic>{}
                : Map<String, dynamic>.from(nodes.first as Map),
          )
        : _findNodeInTree(nodes, nodeId!) ?? <String, dynamic>{};
    final styles =
        ((data['globalVars'] as Map?)?['styles'] as Map?)
            ?.cast<String, dynamic>() ??
        const {};
    final localImageAssets =
        ((data['imageAssets'] as Map?) ??
                ((data['globalVars'] as Map?)?['imageAssets'] as Map?))
            ?.cast<String, String>() ??
        const <String, String>{};
    final imageAssets = {...page1ImageAssets, ...localImageAssets};
    if (root.isEmpty) {
      return Scaffold(
        appBar: showHeader ? AppBar(title: Text(frame.name)) : null,
        body: const Center(child: Text('Frame data missing')),
      );
    }
    final hasSectionPlan = data['sectionPlan'] is Map;
    final sectionNames =
        ((data['sectionPlan'] as Map?)?['sections'] as List? ?? const [])
            .whereType<Map>()
            .map(
              (section) =>
                  section['name'] as String? ??
                  section['nodeId'] as String? ??
                  'Section',
            )
            .toList();
    return Scaffold(
      appBar: showHeader
          ? AppBar(
              title: Text(frame.name),
              leading: BackButton(onPressed: () => Navigator.pop(context)),
            )
          : null,
      body: Column(
        children: [
          if (hasSectionPlan)
            MaterialBanner(
              content: Text(
                'Frame được chia thành các phần: ${sectionNames.join(', ')}. Hãy bổ sung context từng section để hoàn chỉnh.',
              ),
              actions: const [SizedBox.shrink()],
            ),
          Expanded(
            child: _InstanceVariantHost(
              child: ClipRect(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 40,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: SizedBox(
                        width:
                            (root['width'] as num?)?.toDouble() ?? frame.width,
                        height:
                            (root['height'] as num?)?.toDouble() ??
                            frame.height,
                        child: ClipRect(
                          child: _FigmaNode(
                            node: root,
                            styles: styles,
                            imageAssets: imageAssets,
                            onInteraction: onInteraction,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Opens a Page 1 Figma frame directly and keeps its prototype links live.
/// Used by the app's primary bottom navigation instead of the frame catalog.
class Page1FigmaRouteScreen extends StatelessWidget {
  const Page1FigmaRouteScreen({
    super.key,
    required this.frame,
    required this.frames,
    this.customFrameBuilders = const {},
    this.contextFrameId,
    this.nodeId,
  });

  final Page1FigmaFrame frame;
  final List<Page1FigmaFrame> frames;
  final Map<String, WidgetBuilder> customFrameBuilders;
  final String? contextFrameId;
  final String? nodeId;

  factory Page1FigmaRouteScreen.fromId({
    required String id,
    required List<Page1FigmaFrame> frames,
    Map<String, WidgetBuilder> customFrameBuilders = const {},
  }) {
    for (final candidate in frames) {
      if (candidate.id == id) {
        return Page1FigmaRouteScreen(
          frame: candidate,
          frames: frames,
          customFrameBuilders: customFrameBuilders,
        );
      }
    }
    final located = _findFigmaNode(id);
    return Page1FigmaRouteScreen(
      frame: Page1FigmaFrame(
        id: id,
        name: located?.node['name'] as String? ?? 'Page 1',
        width: (located?.node['width'] as num?)?.toDouble() ?? 360,
        height: (located?.node['height'] as num?)?.toDouble() ?? 800,
      ),
      frames: frames,
      customFrameBuilders: customFrameBuilders,
      contextFrameId: located?.contextFrameId,
      nodeId: located == null ? null : id,
    );
  }

  Page1FigmaFrame? _frameById(String id) {
    for (final candidate in frames) {
      if (candidate.id == id) return candidate;
    }
    return null;
  }

  Widget? _destination(BuildContext context, String id) {
    final custom = customFrameBuilders[id];
    if (custom != null) return custom(context);
    final frame = _frameById(id);
    if (frame != null) {
      return Page1FigmaRouteScreen(
        frame: frame,
        frames: frames,
        customFrameBuilders: customFrameBuilders,
      );
    }
    final located = _findFigmaNode(id);
    if (located == null) return null;
    return FigmaContextScreen(
      frame: Page1FigmaFrame(
        id: id,
        name: located.node['name'] as String? ?? 'Page 1',
        width: (located.node['width'] as num?)?.toDouble() ?? 360,
        height: (located.node['height'] as num?)?.toDouble() ?? 800,
      ),
      contextFrameId: located.contextFrameId,
      nodeId: id,
      onInteraction: _handleInteraction,
      showHeader: false,
    );
  }

  void _handleInteraction(
    BuildContext context,
    Page1FigmaInteraction interaction,
    String sourceNodeId,
  ) {
    if (interaction.action == 'BACK' || interaction.action == 'CLOSE') {
      Navigator.of(context).maybePop();
      return;
    }
    final id = interaction.destinationId;
    if (id == null) return;
    if ((interaction.navigation == 'CHANGE_TO' ||
            interaction.navigation == 'SWAP') &&
        _tryInstanceVariantSwap(context, sourceNodeId, id)) {
      return;
    }
    final page = _destination(context, id);
    if (page == null) return;
    if (interaction.navigation == 'OVERLAY') {
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (_) => Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 360,
            height: 560,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: page,
            ),
          ),
        ),
      );
    } else if (interaction.navigation == 'CHANGE_TO' ||
        interaction.navigation == 'SWAP') {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute<void>(builder: (_) => page));
    } else {
      Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
    }
  }

  @override
  Widget build(BuildContext context) => FigmaContextScreen(
    frame: frame,
    contextFrameId: contextFrameId,
    nodeId: nodeId,
    onInteraction: _handleInteraction,
    showHeader: false,
  );
}

class _LocatedFigmaNode {
  const _LocatedFigmaNode({required this.contextFrameId, required this.node});

  final String contextFrameId;
  final Map<String, dynamic> node;
}

_LocatedFigmaNode? _findFigmaNode(String id) {
  for (final entry in page1FigmaContexts.entries) {
    final data = entry.value as Map<String, dynamic>;
    final node = _findNodeInTree(
      data['nodes'] as List<dynamic>? ?? const [],
      id,
    );
    if (node != null) {
      return _LocatedFigmaNode(contextFrameId: entry.key, node: node);
    }
  }
  return null;
}

Map<String, dynamic>? _findNodeInTree(List<dynamic> nodes, String id) {
  for (final item in nodes) {
    if (item is! Map) continue;
    final node = Map<String, dynamic>.from(item);
    if (node['id'] == id) return node;
    final child = _findNodeInTree(
      node['children'] as List<dynamic>? ?? const [],
      id,
    );
    if (child != null) return child;
  }
  return null;
}

class _FigmaNode extends StatelessWidget {
  const _FigmaNode({
    required this.node,
    required this.styles,
    required this.imageAssets,
    this.inheritedIcon,
    this.onInteraction,
    this.isOverride = false,
  });
  final Map<String, dynamic> node;
  final Map<String, dynamic> styles;
  final Map<String, String> imageAssets;
  final IconData? inheritedIcon;
  final void Function(BuildContext, Page1FigmaInteraction, String)?
  onInteraction;
  final bool isOverride;

  double _num(String key, [double fallback = 0]) =>
      (node[key] as num?)?.toDouble() ?? fallback;
  List<dynamic> _paint(String? key) {
    if (key == null) return const [];
    final v = styles[key];
    return v is List ? v : const [];
  }

  Color? _color(String? key) {
    for (final paint in _paint(key)) {
      if (paint is Map && paint['type'] == 'SOLID') {
        final value = paint['color'];
        if (value is String) return _parseColor(value);
      }
    }
    return null;
  }

  Color? _nodeColor(Map<String, dynamic> candidate) {
    final own =
        _color(candidate['fill'] as String?) ??
        _color(candidate['stroke'] as String?);
    if (own != null) return own;
    for (final child in (candidate['children'] as List<dynamic>? ?? const [])) {
      if (child is Map) {
        final color = _nodeColor(Map<String, dynamic>.from(child));
        if (color != null) return color;
      }
    }
    return null;
  }

  IconData? _semanticIcon(String rawName) {
    final name = rawName.toLowerCase();
    if (name.contains('search')) return Icons.search;
    if (name.contains('wifi')) return Icons.wifi;
    if (name.contains('signal')) return Icons.signal_cellular_alt;
    if (name.contains('battery')) return Icons.battery_6_bar;
    if (name.contains('back') || name.contains('left arrow')) {
      return Icons.arrow_back;
    }
    if (name.contains('chevron left')) return Icons.chevron_left;
    if (name.contains('chevron right')) return Icons.chevron_right;
    if (name.contains('next') || name.contains('right arrow')) {
      return Icons.arrow_forward;
    }
    if (name.contains('close') || name.contains('dismiss')) return Icons.close;
    if (name.contains('play')) return Icons.play_arrow;
    if (name.contains('pause')) return Icons.pause;
    if (name.contains('microphone') || name.contains('mic')) {
      return Icons.mic;
    }
    if (name.contains('volume') || name.contains('speaker')) {
      return Icons.volume_up;
    }
    if (name.contains('setting') || name.contains('gear')) {
      return Icons.settings_outlined;
    }
    if (name.contains('profile') || name.contains('avatar')) {
      return Icons.person_outline;
    }
    if (name.contains('cart') || name.contains('shopping')) {
      return Icons.shopping_cart_outlined;
    }
    if (name.contains('heart') || name.contains('favorite')) {
      return Icons.favorite_border;
    }
    if (name.contains('star')) return Icons.star_border;
    if (name.contains('bookmark')) return Icons.bookmark_border;
    if (name.contains('calendar')) return Icons.calendar_month_outlined;
    if (name.contains('clock') || name.contains('timer')) return Icons.schedule;
    if (name.contains('notification') || name.contains('bell')) {
      return Icons.notifications_none;
    }
    if (name.contains('help') || name.contains('question')) {
      return Icons.help_outline;
    }
    if (name.contains('check') || name.contains('success')) {
      return Icons.check_circle_outline;
    }
    if (name.contains('lock') || name.contains('privacy')) {
      return Icons.lock_outline;
    }
    if (name.contains('camera')) return Icons.camera_alt_outlined;
    if (name.contains('filter')) return Icons.filter_list;
    if (name.contains('menu')) return Icons.menu;
    if (name.contains('send')) return Icons.send_outlined;
    if (name.contains('more')) return Icons.more_horiz;
    return null;
  }

  bool _containsOnlyVectors(List<Map<String, dynamic>> children) =>
      children.isNotEmpty &&
      children.every((child) {
        final type = child['type'];
        if (type == 'VECTOR' || type == 'LINE') return true;
        final nested = (child['children'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
        return nested.isNotEmpty && _containsOnlyVectors(nested);
      });

  Gradient? _gradient(String? key) {
    for (final paint in _paint(key)) {
      if (paint is! Map || paint['type'] != 'GRADIENT_LINEAR') continue;
      final stops = (paint['gradientStops'] as List? ?? const [])
          .whereType<Map>()
          .map((s) => (s['position'] as num? ?? 0).toDouble())
          .toList();
      final colors = (paint['gradientStops'] as List? ?? const [])
          .whereType<Map>()
          .map((s) => _parseColor(s['color'] as String? ?? '#FFFFFFFF'))
          .toList();
      if (colors.isEmpty) continue;
      final angle =
          ((paint['cssAngle'] as num?)?.toDouble() ?? 180) * math.pi / 180;
      final dx = 0.5 * math.cos(angle);
      final dy = 0.5 * math.sin(angle);
      return LinearGradient(
        begin: Alignment(-dx, -dy),
        end: Alignment(dx, dy),
        colors: colors,
        stops: stops.length == colors.length ? stops : null,
      );
    }
    return null;
  }

  Color _parseColor(String value) {
    final hex = value.replaceFirst('#', '');
    final parsed = int.tryParse(hex, radix: 16) ?? 0xFFFFFFFF;
    final argb = hex.length == 8
        ? ((parsed & 0xFF) << 24) | (parsed >> 8)
        : 0xFF000000 | parsed;
    return Color(argb);
  }

  BorderRadius _radius() {
    if (node['type'] == 'ELLIPSE') {
      return BorderRadius.circular(math.min(_num('width'), _num('height')) / 2);
    }
    final r = node['cornerRadius'];
    if (r is num) return BorderRadius.circular(r.toDouble());
    final corners = node['cornerRadii'];
    if (corners is Map) {
      return BorderRadius.only(
        topLeft: Radius.circular((corners['topLeft'] as num?)?.toDouble() ?? 0),
        topRight: Radius.circular(
          (corners['topRight'] as num?)?.toDouble() ?? 0,
        ),
        bottomRight: Radius.circular(
          (corners['bottomRight'] as num?)?.toDouble() ?? 0,
        ),
        bottomLeft: Radius.circular(
          (corners['bottomLeft'] as num?)?.toDouble() ?? 0,
        ),
      );
    }
    return BorderRadius.zero;
  }

  @override
  Widget build(BuildContext context) {
    final type = node['type'];
    final instanceNodeId = node['id'] as String?;
    if (type == 'INSTANCE' && instanceNodeId != null && !isOverride) {
      final override = _hostFor(context)?.overrideFor(instanceNodeId);
      if (override != null) {
        return _FigmaNode(
          node: override.node,
          styles: override.styles,
          imageAssets: override.imageAssets,
          inheritedIcon: inheritedIcon,
          onInteraction: onInteraction,
          isOverride: true,
        );
      }
    }
    final children = (node['children'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    final fill = _color(node['fill'] as String?);
    final gradient = _gradient(node['fill'] as String?);
    final textStyleMap = styles[node['textStyle']];
    final textStyle = textStyleMap is Map
        ? textStyleMap
        : const <String, dynamic>{};
    Widget content;
    if (type == 'TEXT') {
      final isCompactLabel = _num('width') < 48 || _num('height') < 24;
      final label = Text(
        node['characters'] as String? ?? '',
        textAlign: _textAlign(node['textAlignHorizontal'] as String?),
        maxLines: (node['textTruncation'] == 'ENDING') ? 1 : null,
        overflow: node['textTruncation'] == 'ENDING'
            ? TextOverflow.ellipsis
            : TextOverflow.visible,
        style: TextStyle(
          color: fill ?? const Color(0xFF222222),
          fontFamily: textStyle['fontFamily'] as String?,
          fontSize: (textStyle['fontSize'] as num?)?.toDouble() ?? 14,
          fontWeight: _fontWeight(textStyle['fontStyle'] as String?),
          letterSpacing:
              ((textStyle['letterSpacing'] as Map?)?['value'] as num?)
                  ?.toDouble(),
          height: _lineHeight(
            textStyle['lineHeight'] as Map?,
            (textStyle['fontSize'] as num?)?.toDouble() ?? 14,
          ),
        ),
      );
      content = Align(
        alignment: _textAlignment(node['textAlignHorizontal'] as String?),
        child: isCompactLabel
            ? FittedBox(fit: BoxFit.scaleDown, child: label)
            : label,
      );
    } else if (type == 'VECTOR' || type == 'LINE') {
      content = const SizedBox.shrink();
    } else {
      final nodeName = node['name'] as String? ?? '';
      final semanticIcon = _semanticIcon(nodeName) ?? inheritedIcon;
      final namedIconGroup =
          (nodeName.toLowerCase().contains('svg') ||
                  nodeName.toLowerCase().contains('icon')) &&
              semanticIcon != null &&
              _containsOnlyVectors(children) ||
          inheritedIcon != null && _containsOnlyVectors(children);
      final imageAsset = imageAssets[node['id'] as String?];
      final imagePaint = _paint(node['fill'] as String?)
          .whereType<Map>()
          .firstWhere(
            (paint) => paint['type'] == 'IMAGE',
            orElse: () => const <String, dynamic>{},
          );
      final imageFit = switch (imagePaint['scaleMode']) {
        'FIT' => BoxFit.contain,
        'FILL' => BoxFit.fill,
        _ => BoxFit.cover,
      };
      final background = imageAsset == null
          ? null
          : Image.asset(
              imageAsset,
              fit: imageFit,
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            );
      final layout = node['layout'] as Map?;
      final mode = layout?['mode'];
      final auto = mode == 'HORIZONTAL' || mode == 'VERTICAL';
      final wrapLayout = layout?['layoutWrap'] == 'WRAP';
      final horizontalScroll =
          mode == 'HORIZONTAL' &&
          (nodeName.toLowerCase().contains('cuộn ngang') ||
              nodeName.toLowerCase().contains('horizontal scroll'));
      final verticalScroll =
          mode == 'VERTICAL' &&
          (nodeName.toLowerCase().contains('scrollable') ||
              nodeName.toLowerCase().contains('scrollarea'));
      final flowChildren = children
          .where((c) => c['layoutPositioning'] != 'ABSOLUTE')
          .toList();
      final absoluteChildren = children
          .where((c) => c['layoutPositioning'] == 'ABSOLUTE')
          .toList();
      Widget base;
      if (namedIconGroup) {
        base = Center(
          child: Icon(
            semanticIcon,
            size: math.min(_num('width'), _num('height')),
            color: _nodeColor(node) ?? const Color(0xFF374151),
          ),
        );
      } else if (auto) {
        final row = mode == 'HORIZONTAL';
        final padding = EdgeInsets.fromLTRB(
          (layout?['paddingLeft'] as num?)?.toDouble() ?? 0,
          (layout?['paddingTop'] as num?)?.toDouble() ?? 0,
          (layout?['paddingRight'] as num?)?.toDouble() ?? 0,
          (layout?['paddingBottom'] as num?)?.toDouble() ?? 0,
        );
        final gap = (layout?['itemSpacing'] as num?)?.toDouble() ?? 0;
        final compactAutoLayout = _num('width') < 48 || _num('height') < 24;
        final hasFillChild = flowChildren.any(
          (child) => row
              ? child['layoutSizingHorizontal'] == 'FILL'
              : child['layoutSizingVertical'] == 'FILL',
        );
        final widgets = <Widget>[];
        for (var i = 0; i < flowChildren.length; i++) {
          final child = flowChildren[i];
          Widget item = _FigmaNode(
            node: child,
            styles: styles,
            imageAssets: imageAssets,
            inheritedIcon: semanticIcon,
            onInteraction: onInteraction,
          );
          final fills =
              !wrapLayout &&
              !horizontalScroll &&
              !verticalScroll &&
              (row
                  ? child['layoutSizingHorizontal'] == 'FILL'
                  : child['layoutSizingVertical'] == 'FILL');
          if (fills) item = Expanded(child: item);
          widgets.add(item);
          if (i < flowChildren.length - 1 &&
              gap > 0 &&
              layout?['primaryAxisAlignItems'] != 'SPACE_BETWEEN') {
            widgets.add(SizedBox(width: row ? gap : 0, height: row ? 0 : gap));
          }
        }
        final mainAlign = _mainAlignment(
          layout?['primaryAxisAlignItems'] as String?,
        );
        final crossAlign = _crossAlignment(
          layout?['counterAxisAlignItems'] as String?,
        );
        final wrappedChildren = flowChildren
            .map(
              (child) => _FigmaNode(
                node: child,
                styles: styles,
                imageAssets: imageAssets,
                inheritedIcon: semanticIcon,
                onInteraction: onInteraction,
              ),
            )
            .toList();
        final autoLayoutContent = Padding(
          padding: padding,
          child: wrapLayout
              ? Wrap(
                  spacing: gap,
                  runSpacing:
                      (layout?['counterAxisSpacing'] as num?)?.toDouble() ?? 0,
                  alignment: switch (mainAlign) {
                    MainAxisAlignment.center => WrapAlignment.center,
                    MainAxisAlignment.end => WrapAlignment.end,
                    _ => WrapAlignment.start,
                  },
                  crossAxisAlignment: crossAlign == CrossAxisAlignment.center
                      ? WrapCrossAlignment.center
                      : WrapCrossAlignment.start,
                  children: wrappedChildren,
                )
              : row
              ? Row(
                  mainAxisSize: compactAutoLayout || horizontalScroll
                      ? MainAxisSize.min
                      : MainAxisSize.max,
                  mainAxisAlignment: mainAlign,
                  crossAxisAlignment: crossAlign,
                  children: widgets,
                )
              : Column(
                  mainAxisSize: compactAutoLayout || verticalScroll
                      ? MainAxisSize.min
                      : MainAxisSize.max,
                  mainAxisAlignment: mainAlign,
                  crossAxisAlignment: crossAlign,
                  children: widgets,
                ),
        );
        final requiredExtent =
            (row ? padding.horizontal : padding.vertical) +
            flowChildren.fold<double>(0, (sum, child) {
              final dimension =
                  (child[row ? 'width' : 'height'] as num?)?.toDouble() ?? 0;
              return sum + dimension;
            }) +
            math.max(0, flowChildren.length - 1) * gap;
        final availableExtent = _num(row ? 'width' : 'height');
        final needsCompression =
            !wrapLayout &&
            !(row && horizontalScroll) &&
            !(verticalScroll && !row) &&
            requiredExtent > availableExtent + 0.1;
        base =
            compactAutoLayout &&
                !hasFillChild &&
                !wrapLayout &&
                !horizontalScroll &&
                !verticalScroll
            ? FittedBox(fit: BoxFit.scaleDown, child: autoLayoutContent)
            : autoLayoutContent;
        if (needsCompression) {
          base = FittedBox(
            fit: BoxFit.scaleDown,
            alignment: row ? Alignment.centerLeft : Alignment.topCenter,
            child: base,
          );
        }
        if (horizontalScroll) {
          base = SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: base,
          );
        } else if (verticalScroll) {
          base = SingleChildScrollView(child: base);
        }
      } else {
        base = Stack(
          clipBehavior: node['clipsContent'] == true
              ? Clip.hardEdge
              : Clip.none,
          children: [
            for (final child in children)
              Positioned(
                left: (child['x'] as num?)?.toDouble() ?? 0,
                top: (child['y'] as num?)?.toDouble() ?? 0,
                width: (child['width'] as num?)?.toDouble(),
                height: (child['height'] as num?)?.toDouble(),
                child: _FigmaNode(
                  node: child,
                  styles: styles,
                  imageAssets: imageAssets,
                  inheritedIcon: semanticIcon,
                  onInteraction: onInteraction,
                ),
              ),
          ],
        );
      }
      content = Stack(
        clipBehavior: node['clipsContent'] == true ? Clip.hardEdge : Clip.none,
        children: [
          if (fill != null || gradient != null || background != null)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: _radius(),
                child:
                    background ??
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: fill,
                        gradient: gradient,
                      ),
                    ),
              ),
            ),
          if (children.isNotEmpty)
            auto && absoluteChildren.isEmpty
                ? base
                : Positioned.fill(child: base),
          for (final child
              in (auto ? absoluteChildren : const <Map<String, dynamic>>[]))
            Positioned(
              left: (child['x'] as num?)?.toDouble() ?? 0,
              top: (child['y'] as num?)?.toDouble() ?? 0,
              width: (child['width'] as num?)?.toDouble(),
              height: (child['height'] as num?)?.toDouble(),
              child: _FigmaNode(
                node: child,
                styles: styles,
                imageAssets: imageAssets,
                inheritedIcon: semanticIcon,
                onInteraction: onInteraction,
              ),
            ),
        ],
      );
    }

    final w = _num('width');
    final h = _num('height');
    final borderColor = _color(node['stroke'] as String?);
    final rendered = SizedBox(
      width: w > 0 ? w : null,
      height: h > 0 ? h : null,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: _radius(),
          border: borderColor == null
              ? null
              : Border.all(
                  color: borderColor,
                  width: _numericValue(node['strokeWeight']) ?? 1,
                ),
        ),
        child: content,
      ),
    );
    final clippedRendered = node['clipsContent'] == true
        ? ClipRect(child: rendered)
        : rendered;
    Page1FigmaInteraction? interaction;
    if (instanceNodeId != null) {
      interaction = page1FigmaInteractions[instanceNodeId];
      if (interaction == null && instanceNodeId.contains(';')) {
        interaction = page1FigmaInteractions[instanceNodeId.split(';').last];
      }
    }
    if (interaction == null || onInteraction == null) return clippedRendered;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onInteraction!(context, interaction!, instanceNodeId ?? ''),
      child: clippedRendered,
    );
  }

  static TextAlign _textAlign(String? value) => switch (value) {
    'CENTER' => TextAlign.center,
    'RIGHT' => TextAlign.right,
    'JUSTIFIED' => TextAlign.justify,
    _ => TextAlign.left,
  };
  static MainAxisAlignment _mainAlignment(String? value) => switch (value) {
    'CENTER' => MainAxisAlignment.center,
    'MAX' => MainAxisAlignment.end,
    'SPACE_BETWEEN' => MainAxisAlignment.spaceBetween,
    'SPACE_AROUND' => MainAxisAlignment.spaceAround,
    'SPACE_EVENLY' => MainAxisAlignment.spaceEvenly,
    _ => MainAxisAlignment.start,
  };
  static CrossAxisAlignment _crossAlignment(String? value) => switch (value) {
    'CENTER' => CrossAxisAlignment.center,
    'MAX' => CrossAxisAlignment.end,
    'STRETCH' => CrossAxisAlignment.stretch,
    _ => CrossAxisAlignment.start,
  };
  static Alignment _textAlignment(String? value) => switch (value) {
    'CENTER' => Alignment.center,
    'RIGHT' => Alignment.centerRight,
    _ => Alignment.centerLeft,
  };
  static FontWeight _fontWeight(String? value) {
    final match = RegExp(r'([1-9]00)').firstMatch(value ?? '');
    final number = match == null ? 400 : int.parse(match.group(1)!);
    return FontWeight.values[(number ~/ 100 - 1).clamp(0, 8)];
  }

  static double? _lineHeight(Map? value, double fontSize) {
    final line = (value?['value'] as num?)?.toDouble();
    return line == null || value?['unit'] != 'PIXELS' ? null : line / fontSize;
  }
}

double? _numericValue(Object? value) => value is num
    ? value.toDouble()
    : value is String
    ? double.tryParse(value)
    : null;

/// Figma prototype swaps a component-set variant inside its own instance
/// (answer highlight states). We render that in place instead of pushing the
/// bare component to the top of the stack.
class _InstanceVariantOverride {
  const _InstanceVariantOverride({
    required this.node,
    required this.styles,
    required this.imageAssets,
  });

  final Map<String, dynamic> node;
  final Map<String, dynamic> styles;
  final Map<String, String> imageAssets;
}

class _InstanceVariantHost extends StatefulWidget {
  const _InstanceVariantHost({required this.child});

  final Widget child;

  @override
  State<_InstanceVariantHost> createState() => _InstanceVariantHostState();
}

class _InstanceVariantHostState extends State<_InstanceVariantHost> {
  final _overrides = <String, _InstanceVariantOverride>{};
  int _revision = 0;

  bool applyInstanceVariant(String instanceNodeId, String destinationId) {
    final instance = _findFigmaNode(instanceNodeId);
    final target = _findFigmaNode(destinationId);
    if (instance == null ||
        target == null ||
        instance.node['type'] != 'INSTANCE' ||
        target.node['type'] != 'COMPONENT') {
      return false;
    }
    final mainComponentId =
        instance.node['mainComponentId'] as String? ??
        ((instance.node['mainComponent'] as Map?)?['id'] as String?);
    if (mainComponentId == null) return false;
    final mainComponent = _findFigmaNode(mainComponentId);
    final instanceSetId = mainComponent?.node['parentId'] as String?;
    final targetSetId = target.node['parentId'] as String?;
    final sameSetOrUnknown =
        instanceSetId == null ||
        targetSetId == null ||
        instanceSetId == targetSetId;
    if (!sameSetOrUnknown) {
      return false;
    }
    setState(() {
      _overrides[instanceNodeId] = _buildInstanceVariantOverride(
        instance: instance,
        target: target,
      );
      _revision++;
    });
    return true;
  }

  _InstanceVariantOverride _buildInstanceVariantOverride({
    required _LocatedFigmaNode instance,
    required _LocatedFigmaNode target,
  }) {
    final instLayout =
        (instance.node['layout'] as Map?)?.cast<String, dynamic>() ??
        const <String, dynamic>{};
    final targetLayout =
        (target.node['layout'] as Map?)?.cast<String, dynamic>() ??
        const <String, dynamic>{};
    double pad(Map layout, String key) =>
        (layout[key] as num?)?.toDouble() ?? 0;
    final instWidth = (instance.node['width'] as num?)?.toDouble() ?? 0;
    final compWidth = (target.node['width'] as num?)?.toDouble() ?? 0;
    final instPaddingTop = pad(instLayout, 'paddingTop');
    final compPaddingTop = pad(targetLayout, 'paddingTop');
    final instInnerWidth =
        instWidth -
        pad(instLayout, 'paddingLeft') -
        pad(instLayout, 'paddingRight');
    final compInnerWidth =
        compWidth -
        pad(targetLayout, 'paddingLeft') -
        pad(targetLayout, 'paddingRight');
    final scaleX = compInnerWidth > 0 && instInnerWidth > 0
        ? instInnerWidth / compInnerWidth
        : 1.0;

    Map<String, dynamic> clone(Map item) {
      final copy = Map<String, dynamic>.from(item);
      final children = copy['children'] as List?;
      if (children != null) {
        copy['children'] = [
          for (final c in children) c is Map ? Map<String, dynamic>.from(c) : c,
        ];
      }
      return copy;
    }

    var remapped = <Map<String, dynamic>>[];
    for (final child in (target.node['children'] as List? ?? const [])) {
      if (child is! Map) continue;
      final copy = clone(child);
      copy['x'] =
          pad(instLayout, 'paddingLeft') +
          (((child['x'] as num?)?.toDouble() ?? 0) -
                  pad(targetLayout, 'paddingLeft')) *
              scaleX;
      copy['y'] =
          instPaddingTop +
          (((child['y'] as num?)?.toDouble() ?? 0) - compPaddingTop);
      final oldWidth = (child['width'] as num?)?.toDouble() ?? 0;
      copy['width'] = oldWidth * scaleX;
      _rescaleAbsoluteDescendants(copy, oldWidth * (scaleX - 1));
      remapped.add(copy);
    }

    final mergedNode = Map<String, dynamic>.from(instance.node);
    mergedNode['children'] = remapped;

    Map<String, dynamic> stylesOf(String? contextFrameId) {
      final data =
          page1FigmaContexts[contextFrameId ?? ''] as Map<String, dynamic>?;
      return ((data?['globalVars'] as Map?)?['styles'] as Map?)
              ?.cast<String, dynamic>() ??
          const <String, dynamic>{};
    }

    Map<String, String> imagesOf(String? contextFrameId) {
      final data =
          page1FigmaContexts[contextFrameId ?? ''] as Map<String, dynamic>?;
      return ((data?['imageAssets'] as Map?) ??
                  ((data?['globalVars'] as Map?)?['imageAssets'] as Map?))
              ?.cast<String, String>() ??
          const <String, String>{};
    }

    return _InstanceVariantOverride(
      node: mergedNode,
      styles: {
        ...stylesOf(instance.contextFrameId),
        ...stylesOf(target.contextFrameId),
      },
      imageAssets: {
        ...page1ImageAssets,
        ...imagesOf(instance.contextFrameId),
        ...imagesOf(target.contextFrameId),
      },
    );
  }

  void _rescaleAbsoluteDescendants(
    Map<String, dynamic> node,
    double deltaWidth,
  ) {
    final children = node['children'] as List?;
    if (children == null || deltaWidth == 0) return;
    node['children'] = [
      for (final child in children)
        child is Map ? Map<String, dynamic>.from(child) : child,
    ];
    for (final child in node['children']!) {
      if (child is! Map<String, dynamic>) continue;
      if (child['layoutPositioning'] == 'ABSOLUTE') {
        child['x'] = ((child['x'] as num?)?.toDouble() ?? 0) + deltaWidth;
      }
      _rescaleAbsoluteDescendants(child, 0);
    }
  }

  _InstanceVariantOverride? overrideFor(String instanceNodeId) =>
      _overrides[instanceNodeId];

  @override
  Widget build(BuildContext context) =>
      KeyedSubtree(key: ValueKey<int>(_revision), child: widget.child);
}

_InstanceVariantHostState? _hostFor(BuildContext context) =>
    context.findAncestorStateOfType<_InstanceVariantHostState>();

bool _tryInstanceVariantSwap(
  BuildContext context,
  String sourceNodeId,
  String destinationId,
) {
  if (destinationId.isEmpty) return false;
  final parts = sourceNodeId.split(';');
  if (parts.length < 2) return false;
  final instanceNodeId = parts.first.replaceFirst(RegExp(r'^[A-Z]'), '');
  final host = _hostFor(context);
  if (host == null) return false;
  return host.applyInstanceVariant(instanceNodeId, destinationId);
}
