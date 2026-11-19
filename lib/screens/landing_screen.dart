import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../services/app_state.dart';
import '../services/demo_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../widgets/charts.dart';
import '../widgets/dw.dart';
import 'auth_screens.dart';

/// The DayWise website (Figma "DayWise · Website"), shown to signed-out
/// visitors on wide screens. Phones go straight to the Welcome screen.
class LandingScreen extends StatefulWidget {
  final bool firebaseReady;
  const LandingScreen({super.key, this.firebaseReady = true});
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _howKey = GlobalKey();
  final _madeKey = GlobalKey();
  final _privacyKey = GlobalKey();
  final _faqKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 450), curve: Curves.easeInOut);
    }
  }

  void _startFree() => Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => WelcomeScreen(firebaseReady: widget.firebaseReady)));

  void _demo() => context.read<AppState>().startDemo();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _NavBar(
              onHow: () => _scrollTo(_howKey),
              onMade: () => _scrollTo(_madeKey),
              onPrivacy: () => _scrollTo(_privacyKey),
              onDemo: _demo,
              onStart: _startFree,
            ),
            _Hero(onStart: _startFree, onDemo: _demo),
            _Band(
              color: AppColors.sand,
              child: _TwoCol(
                left: _Heading(eyebrow: t.lpBusyEyebrow, title: t.lpBusyTitle, size: 36),
                right: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.lpBusyBody, style: AppTheme.sans(context, size: 16, height: 1.7)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            t.lpBusyPoint,
                            style: AppTheme.sans(
                              context,
                              size: 15,
                              color: AppColors.primary,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            KeyedSubtree(key: _howKey, child: const _Loop()),
            _Perspective(onDemo: _demo),
            KeyedSubtree(key: _madeKey, child: const _Nudges()),
            const _Egypt(),
            KeyedSubtree(key: _privacyKey, child: const _Privacy()),
            KeyedSubtree(
              key: _faqKey,
              child: _Faq(onSupport: _demo),
            ),
            _FinalCta(onStart: _startFree, onDemo: _demo),
            _Footer(
              onPrivacy: () => _scrollTo(_privacyKey),
              onSupport: () => _scrollTo(_faqKey),
              onAccount: () => _scrollTo(_privacyKey),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Layout helpers ─────────────────────────

bool _narrow(BuildContext c) => MediaQuery.sizeOf(c).width < 900;

/// Full-width colored band with centered 1200px content.
class _Band extends StatelessWidget {
  final Color color;
  final Widget child;
  final double vertical;
  const _Band({required this.child, this.color = AppColors.bg, this.vertical = 64});
  @override
  Widget build(BuildContext context) => Container(
    color: color,
    padding: EdgeInsets.symmetric(horizontal: _narrow(context) ? 20 : 48, vertical: vertical),
    child: Center(
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1200), child: child),
    ),
  );
}

/// Two columns on wide screens, stacked on narrow ones.
class _TwoCol extends StatelessWidget {
  final Widget left;
  final Widget right;
  final int leftFlex;
  final int rightFlex;
  final double gap;
  final CrossAxisAlignment align;
  const _TwoCol({
    required this.left,
    required this.right,
    this.leftFlex = 1,
    this.rightFlex = 1,
    this.gap = 64,
    this.align = CrossAxisAlignment.start,
  });
  @override
  Widget build(BuildContext context) {
    if (_narrow(context)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [left, const SizedBox(height: 32), right],
      );
    }
    return Row(
      crossAxisAlignment: align,
      children: [
        Expanded(flex: leftFlex, child: left),
        SizedBox(width: gap),
        Expanded(flex: rightFlex, child: right),
      ],
    );
  }
}

/// Three equal cards in a row (stacked on narrow screens).
class _Three extends StatelessWidget {
  final List<Widget> children;
  const _Three(this.children);
  @override
  Widget build(BuildContext context) {
    if (_narrow(context)) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: spaced(children, 16));
    }
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(width: 16),
            Expanded(child: children[i]),
          ],
        ],
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  final String eyebrow;
  final String title;
  final double size;
  final Color color;
  final Color eyebrowColor;
  const _Heading({
    required this.eyebrow,
    required this.title,
    this.size = 44,
    this.color = AppColors.ink,
    this.eyebrowColor = AppColors.primary,
  });
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Eyebrow(eyebrow, color: eyebrowColor),
      const SizedBox(height: 14),
      Text(
        title,
        style: AppTheme.serif(
          context,
          size: _narrow(context) ? size * 0.75 : size,
          color: color,
          height: 1.15,
        ),
      ),
    ],
  );
}

/// Heading on the start side, a short note on the end side.
class _SectionHead extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String note;
  const _SectionHead({required this.eyebrow, required this.title, required this.note});
  @override
  Widget build(BuildContext context) => _TwoCol(
    leftFlex: 3,
    rightFlex: 2,
    align: CrossAxisAlignment.end,
    left: _Heading(eyebrow: eyebrow, title: title),
    right: Text(note, style: AppTheme.sans(context, size: 14, height: 1.6)),
  );
}

class _Button extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool primary;
  final bool arrow;
  final bool external;
  const _Button(
    this.label, {
    required this.onTap,
    this.primary = true,
    this.arrow = false,
    this.external = false,
  });
  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    var text = label;
    if (arrow) text = rtl ? '← $label' : '$label →';
    if (external) text = '$label ↗';
    final fg = primary ? Colors.white : AppColors.primary;
    return Material(
      color: primary ? AppColors.primary : AppColors.surface,
      shape: StadiumBorder(side: BorderSide(color: primary ? Colors.transparent : AppColors.border)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          constraints: const BoxConstraints(minWidth: 140),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: AppTheme.sans(context, size: 14, color: fg, weight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── Sections ─────────────────────────

class _NavBar extends StatelessWidget {
  final VoidCallback onHow, onMade, onPrivacy, onDemo, onStart;
  const _NavBar({
    required this.onHow,
    required this.onMade,
    required this.onPrivacy,
    required this.onDemo,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final narrow = _narrow(context);
    Widget link(String s, VoidCallback f) => TextButton(
      onPressed: f,
      style: TextButton.styleFrom(foregroundColor: AppColors.ink, minimumSize: const Size(44, 44)),
      child: Text(s, style: AppTheme.sans(context, size: 13, color: AppColors.ink)),
    );
    return _Band(
      vertical: 20,
      child: Row(
        children: [
          const DayWiseIdentity(),
          const Spacer(),
          if (!narrow) ...[
            link(t.lpNavHow, onHow),
            const SizedBox(width: 8),
            link(t.lpNavMade, onMade),
            const SizedBox(width: 8),
            link(t.lpNavPrivacy, onPrivacy),
            const Spacer(),
          ],
          const LanguageChoice(),
          if (!narrow) ...[
            const SizedBox(width: 12),
            TextAction(t.lpExploreDemo, external: true, size: 13, weight: FontWeight.w400, onTap: onDemo),
          ],
          const SizedBox(width: 16),
          SizedBox(
            width: narrow ? 120 : 150,
            child: ActionButton(t.lpStartDay, height: 44, onPressed: onStart),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  final VoidCallback onStart, onDemo;
  const _Hero({required this.onStart, required this.onDemo});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final narrow = _narrow(context);
    return _Band(
      vertical: narrow ? 32 : 48,
      child: _TwoCol(
        gap: 48,
        align: CrossAxisAlignment.center,
        left: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContextBadge(t.lpHeroBadge, background: AppColors.sage),
            const SizedBox(height: 24),
            Text(t.lpHeroTitle, style: AppTheme.serif(context, size: narrow ? 44 : 68, height: 1.05)),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Text(t.lpHeroBody, style: AppTheme.sans(context, size: 17, height: 1.6)),
            ),
            const SizedBox(height: 28),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _Button(t.lpStartFree, arrow: true, onTap: onStart),
                _Button(t.lpExploreNour, primary: false, onTap: onDemo),
              ],
            ),
            const SizedBox(height: 20),
            Text(t.lpHeroMeta, style: AppTheme.sans(context, size: 12)),
          ],
        ),
        right: AspectRatio(
          aspectRatio: 1152 / 928,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset('assets/images/hero_moment.jpg', fit: BoxFit.cover),
              ),
              PositionedDirectional(
                start: 20,
                bottom: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.bg.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(LucideIcons.sun, size: 18, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            t.lpHeroNoteTitle,
                            style: AppTheme.sans(
                              context,
                              size: 13,
                              color: AppColors.ink,
                              weight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(t.lpHeroNoteBody, style: AppTheme.sans(context, size: 11)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Loop extends StatelessWidget {
  const _Loop();
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    Widget step(IconData icon, String n, String title, String body, String tag) => DwCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24, color: AppColors.primary),
              const Spacer(),
              Text(Fmt.digits(context, n), style: AppTheme.serif(context, size: 25, color: AppColors.body)),
            ],
          ),
          const SizedBox(height: 28),
          Text(title, style: AppTheme.serif(context, size: 27)),
          const SizedBox(height: 14),
          Text(body, style: AppTheme.sans(context, size: 14, height: 1.6)),
          const SizedBox(height: 18),
          Text(
            tag,
            style: AppTheme.sans(context, size: 11, color: AppColors.primary, weight: FontWeight.w600),
          ),
        ],
      ),
    );
    return _Band(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionHead(eyebrow: t.lpLoopEyebrow, title: t.lpLoopTitle, note: t.lpLoopNote),
          const SizedBox(height: 36),
          _Three([
            step(LucideIcons.smile, '01', t.lpStep1Title, t.lpStep1Body, t.lpStep1Tag),
            step(LucideIcons.chartNoAxesCombined, '02', t.lpStep2Title, t.lpStep2Body, t.lpStep2Tag),
            step(LucideIcons.sprout, '03', t.lpStep3Title, t.lpStep3Body, t.lpStep3Tag),
          ]),
        ],
      ),
    );
  }
}

class _Perspective extends StatelessWidget {
  final VoidCallback onDemo;
  const _Perspective({required this.onDemo});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final week = DemoData.nour().sublist(7);
    final latest = week.last;
    final days = week.map((c) => c.day).toList();

    final card = DwCard(
      padding: const EdgeInsets.all(28),
      radius: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Text(t.lpDemoCardTitle, style: AppTheme.serif(context, size: 27))),
              ContextBadge(t.lpIllustrativeDemo, background: AppColors.sand),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              WellbeingRing(score: latest.wellbeingScore, size: 110, stroke: 9),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.lpWellbeingLine(Fmt.number(context, latest.wellbeingScore)),
                      style: AppTheme.sans(context, size: 16, color: AppColors.ink, weight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.lpLatestCheckin(Fmt.weekdayDayMonth(context, latest.day)),
                      style: AppTheme.sans(context, size: 12),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${t.mood} ${Fmt.number(context, latest.mood)} · ${t.energy} ${Fmt.number(context, latest.energy)} · ${t.stress} ${Fmt.number(context, latest.stress)}\n${t.lpSnapshot}',
                      style: AppTheme.sans(context, size: 13, height: 1.6),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          DwCard(
            padding: const EdgeInsets.all(18),
            radius: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  t.lpLast7,
                  style: AppTheme.sans(context, size: 14, color: AppColors.ink, weight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                TrendChart(
                  days: days,
                  series: [
                    TrendSeries(
                      t.mood,
                      AppColors.chartMood,
                      LineStyle.solid,
                      week.map((c) => c.mood.toDouble()).toList(),
                    ),
                    TrendSeries(
                      t.energy,
                      AppColors.chartEnergy,
                      LineStyle.dashed,
                      week.map((c) => c.energy.toDouble()).toList(),
                    ),
                    TrendSeries(
                      t.stress,
                      AppColors.chartStress,
                      LineStyle.dotted,
                      week.map((c) => c.stress.toDouble()).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  t.feelingCaption(Fmt.range(context, days.first, days.last)),
                  style: AppTheme.sans(context, size: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.mint, borderRadius: BorderRadius.circular(14)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(LucideIcons.sparkles, size: 18, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.insMoveTitle,
                        style: AppTheme.sans(
                          context,
                          size: 14,
                          color: AppColors.ink,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(t.lpDemoInsightBody, style: AppTheme.sans(context, size: 12, height: 1.5)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return _Band(
      color: AppColors.sage,
      vertical: 72,
      child: _TwoCol(
        leftFlex: 4,
        rightFlex: 6,
        align: CrossAxisAlignment.center,
        left: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Heading(eyebrow: t.lpPerspEyebrow, title: t.lpPerspTitle, size: 48),
            const SizedBox(height: 24),
            Text(t.lpPerspBody, style: AppTheme.sans(context, size: 16, height: 1.7)),
            const SizedBox(height: 20),
            Text(t.lpPerspNote, style: AppTheme.sans(context, size: 14, height: 1.6)),
            const SizedBox(height: 28),
            _Button(t.lpMeetNour, primary: false, external: true, onTap: onDemo),
          ],
        ),
        right: card,
      ),
    );
  }
}

class _Nudges extends StatelessWidget {
  const _Nudges();
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final ar = AppTheme.isArabic(context);
    Widget nudge(CardTone tone, IconData icon, String label, String titleEn, String titleAr) => DwCard(
      tone: tone,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: AppColors.primary),
          const SizedBox(height: 28),
          Eyebrow(label),
          const SizedBox(height: 10),
          Text(ar ? titleAr : titleEn, style: AppTheme.serif(context, size: 25)),
          const SizedBox(height: 16),
          Text(t.lpNudgeTry, style: AppTheme.sans(context, size: 12)),
        ],
      ),
    );
    return _Band(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionHead(eyebrow: t.lpNudgeEyebrow, title: t.lpNudgeTitle, note: t.lpNudgeNote),
          const SizedBox(height: 36),
          _Three([
            nudge(
              CardTone.sage,
              LucideIcons.footprints,
              t.lpNudge1,
              'Take a 10-minute walk after your 2pm lecture',
              'اتمشى ١٠ دقايق بعد محاضرة الساعة ٢',
            ),
            nudge(
              CardTone.sand,
              LucideIcons.moon,
              t.lpNudge2,
              'Put your phone away 30 minutes before bed',
              'ابعد موبايلك قبل النوم بنص ساعة',
            ),
            nudge(
              CardTone.sage,
              LucideIcons.coffee,
              t.lpNudge3,
              'Take a 5-minute break every 50 minutes of study',
              'خد بريك ٥ دقايق كل ٥٠ دقيقة مذاكرة',
            ),
          ]),
        ],
      ),
    );
  }
}

class _Egypt extends StatelessWidget {
  const _Egypt();
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    Widget chip(String s) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: AppColors.sage, borderRadius: BorderRadius.circular(100)),
      child: Text(
        s,
        style: AppTheme.sans(context, size: 12, color: AppColors.primary, weight: FontWeight.w600),
      ),
    );
    return _Band(
      vertical: 72,
      child: _TwoCol(
        align: CrossAxisAlignment.center,
        left: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: AspectRatio(
            aspectRatio: 1200 / 896,
            child: Image.asset('assets/images/everyday_cairo.jpg', fit: BoxFit.cover),
          ),
        ),
        right: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Eyebrow(t.lpEgyptEyebrow),
            const SizedBox(height: 16),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                t.lpEgyptArabic,
                style: AppTheme.sans(context, size: 36, color: AppColors.ink).copyWith(fontSize: 38),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              t.lpEgyptTitle,
              style: AppTheme.serif(context, size: _narrow(context) ? 28 : 36, height: 1.2),
            ),
            const SizedBox(height: 20),
            Text(t.lpEgyptBody, style: AppTheme.sans(context, size: 15, height: 1.7)),
            const SizedBox(height: 24),
            Wrap(spacing: 10, runSpacing: 10, children: [chip(t.lpArabicFirst), chip(t.lpPhoneOnly)]),
          ],
        ),
      ),
    );
  }
}

class _Privacy extends StatelessWidget {
  const _Privacy();
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    const light = Color(0xFFCFE0D2);
    Widget item(IconData icon, String title, String body) => Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: Colors.white),
          const SizedBox(height: 20),
          Text(
            title,
            style: AppTheme.sans(context, size: 18, color: Colors.white, weight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Text(body, style: AppTheme.sans(context, size: 14, color: light, height: 1.6)),
        ],
      ),
    );
    return _Band(
      color: const Color(0xFF1D4C3F),
      vertical: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TwoCol(
            left: _Heading(
              eyebrow: t.lpPrivEyebrow,
              title: t.lpPrivTitle,
              color: Colors.white,
              eyebrowColor: light,
              size: 44,
            ),
            right: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(t.lpPrivBody, style: AppTheme.sans(context, size: 16, color: light, height: 1.7)),
            ),
          ),
          const SizedBox(height: 40),
          _Three([
            item(LucideIcons.lockKeyhole, t.lpPriv1Title, t.lpPriv1Body),
            item(LucideIcons.download, t.lpPriv2Title, t.lpPriv2Body),
            item(LucideIcons.heartHandshake, t.lpPriv3Title, t.lpPriv3Body),
          ]),
        ],
      ),
    );
  }
}

class _Faq extends StatelessWidget {
  final VoidCallback onSupport;
  const _Faq({required this.onSupport});
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final qa = [(t.lpQ1, t.lpA1), (t.lpQ2, t.lpA2), (t.lpQ3, t.lpA3), (t.lpQ4, t.lpA4), (t.lpQ5, t.lpA5)];
    return _Band(
      vertical: 80,
      child: _TwoCol(
        leftFlex: 2,
        rightFlex: 3,
        left: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Heading(eyebrow: t.lpFaqEyebrow, title: t.lpFaqTitle, size: 44),
            const SizedBox(height: 20),
            TextAction(t.lpExploreSupport, size: 14, weight: FontWeight.w400, onTap: onSupport),
          ],
        ),
        right: Column(
          children: [for (final (q, a) in qa) _FaqItem(q: q, a: a)],
        ),
      ),
    );
  }
}

class _FaqItem extends StatefulWidget {
  final String q;
  final String a;
  const _FaqItem({required this.q, required this.a});
  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  bool _open = true;
  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.border)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          button: true,
          expanded: _open,
          child: InkWell(
            onTap: () => setState(() => _open = !_open),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.q,
                      style: AppTheme.sans(context, size: 16, color: AppColors.ink, weight: FontWeight.w600),
                    ),
                  ),
                  Icon(_open ? LucideIcons.minus : LucideIcons.plus, size: 18, color: AppColors.primary),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: _open
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Text(widget.a, style: AppTheme.sans(context, size: 14, height: 1.6)),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    ),
  );
}

class _FinalCta extends StatelessWidget {
  final VoidCallback onStart, onDemo;
  const _FinalCta({required this.onStart, required this.onDemo});
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return _Band(
      color: AppColors.mint,
      vertical: 88,
      child: Column(
        children: [
          const Icon(LucideIcons.sprout, size: 30, color: AppColors.primary),
          const SizedBox(height: 24),
          Text(
            t.lpCtaTitle,
            textAlign: TextAlign.center,
            style: AppTheme.serif(context, size: _narrow(context) ? 36 : 52, height: 1.15),
          ),
          const SizedBox(height: 18),
          Text(
            t.lpCtaBody,
            textAlign: TextAlign.center,
            style: AppTheme.sans(context, size: 16, height: 1.6),
          ),
          const SizedBox(height: 28),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              _Button(t.lpStartFree, arrow: true, onTap: onStart),
              _Button(t.lpExploreTheDemo, primary: false, onTap: onDemo),
            ],
          ),
          const SizedBox(height: 20),
          Text(t.tagline, style: AppTheme.sans(context, size: 12, color: AppColors.primary)),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPrivacy, onSupport, onAccount;
  const _Footer({required this.onPrivacy, required this.onSupport, required this.onAccount});
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    Widget link(String s, VoidCallback f) => InkWell(
      onTap: f,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(s, style: AppTheme.sans(context, size: 12)),
      ),
    );
    final small = AppTheme.sans(context, size: 11, height: 1.7);
    return _Band(
      vertical: 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 12,
            children: [
              const DayWiseIdentity(),
              Wrap(
                spacing: 28,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  link(t.lpNavPrivacy, onPrivacy),
                  link(t.lpFooterSupport, onSupport),
                  link(t.lpFooterAccount, onAccount),
                  const LanguageChoice(),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _TwoCol(
            gap: 32,
            left: Text(t.lpFooterSdg, style: small),
            right: Text(
              '${t.notMedicalAdvice}\n${t.lpFooterCopy}',
              style: small,
              textAlign: _narrow(context) ? TextAlign.start : TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
