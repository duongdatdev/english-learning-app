# Page 1 navigation audit

Figma source: Page 1, read through Figwright on 2026-11-06. The five bottom tabs and their destination frame IDs remain in the prototype order; Flutter routing follows those destinations.

## Bottom bar flow

| Tab | Home node → frame | Course node → frame | Town node → frame | Shop node → frame | Profile node → frame |
|---|---|---|---|---|---|
| Từ vựng | active / no action | `788:7895` → `1170:3772` | `788:8013` → `1170:3772` | `788:8131` → `1170:3772` | `1167:11365` → `1170:3772` |
| Học tập | `1170:3995` → `593:21095` | active / no action | `788:8019` → `593:21095` | `788:8137` → `593:21095` | `1167:11371` → `593:21095` |
| Cùng học | `1170:4001` → `593:7916` | `788:7907` → `593:7916` | active / no action | `788:8143` → `593:7916` | `1167:11377` → `593:7916` |
| Đổi xu | `1170:4009` → `593:18778` | `788:7915` → `593:18778` | `788:8033` → `593:18778` | active / no action | `1167:11385` → `593:18778` |
| Cá nhân | `1170:4016` → `785:1148` | `788:7922` → `785:1148` | `788:8040` → `785:1148` | `788:8158` → `785:1148` | active / no action |

The generated interaction table was missing Town, Shop, Profile and Home bottom-bar instance reactions. Added those source-node mappings in `lib/design/figma_interactions.dart`. Active-tab taps remain no-ops. The Home implementation routes tab 1 to Home only when a different tab is active. I exercised the tab chain on the emulator in prototype order: Từ vựng → Học tập → Cùng học → Đổi xu → Cá nhân → Từ vựng; each destination rendered with the matching selected tab.

## Home links checked against Figma

- Rank → `593:3710` (Bảng xếp hạng từ vựng).
- Task → `593:3878` (Nhiệm vụ học tập hằng ngày).
- Search → `593:7393` (Lịch sử tìm kiếm từ vựng).
- Messages → `593:4010` (Thông báo nhiệm vụ học tập).
- Edit plan → `593:1664` (Thiết lập kế hoạch học từ vựng).
- Feature cards: Luyện từ → `593:15236`; Sách từ vựng → `593:16737`; Kiểm tra từ → `593:15403`.
- Tác phẩm has no Figma reaction; the Flutter screen opens the reading library as a local, useful action.
- In Figma, both Học and Ôn tập currently lead to `593:3297`; the app currently follows that same prototype destination for both buttons. If the intended actions differ, update the Figma reactions first and then mirror those destinations in Flutter.
- Each conversation banner opens its Figma overlay frame. The visible chips (YouTube, Gọi điện, Nhập vai, Phát âm, Hội thoại, Sách, Tin tức, Nhật ký, Chat) have no prototype reactions of their own; Flutter keeps their local interactions. Recommended Figma update: add explicit reactions for each chip so prototype tests can follow those same paths.
- Mua sách has no prototype reaction; Flutter keeps its local Library route. Add the route in Figma if that behavior is intended there.

## Rendering corrections

- `Page1FigmaRouteScreen` now routes destinations through the same Page 1 context and interactions, with custom Flutter renderers for Shop and Profile where the generated renderer produced a blank/unfinished screen. The destination IDs and bottom-bar transitions are unchanged.
- Profile now includes the five-tab bar, and tapping the selected Shop/Profile tab does not push a duplicate screen.
- The Figma renderer now honors `layoutWrap: WRAP`, horizontally scrolls the course-card strip, scrolls frames named Scrollable/ScrollArea, clips the frame viewport, and safely reads string `strokeWeight` values.

