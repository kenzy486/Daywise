import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';

// ───────────────────────── Well-being ring ─────────────────────────

class WellbeingRing extends StatelessWidget {
  final int score;
  final double size;
  final double stroke;
  const WellbeingRing({super.key, required this.score, this.size = 126, this.stroke = 10});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Semantics(
      label: '${t.wellbeingTitle}: ${t.outOf100(Fmt.number(context, score))}',
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: _RingPainter(score / 100, stroke),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Fmt.number(context, score),
                  style: AppTheme.serif(
                    context,
                    size: size * 0.29,
                    height: 1.1,
                  ).copyWith(fontFamily: AppTheme.serif(context).fontFamily),
                ),
                Text(t.outOf100Short, style: AppTheme.sans(context, size: math.max(11, size * 0.075))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final double stroke;
  _RingPainter(this.progress, this.stroke);
  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = (size.width - stroke) / 2 - 4;
    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    canvas.drawCircle(c, r, base..color = const Color(0xFFCFE0D2));
    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: c, radius: r),
        -math.pi / 2,
        2 * math.pi * progress.clamp(0, 1),
        false,
        base..color = AppColors.primary,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter o) => o.progress != progress;
}

// ───────────────────────── Mood / energy / stress trend ─────────────────────────

enum LineStyle { solid, dashed, dotted }

class TrendSeries {
  final String label;
  final Color color;
  final LineStyle style;
  final List<double?> values; // one per day, null = no check-in
  const TrendSeries(this.label, this.color, this.style, this.values);
}

class LegendDot extends StatelessWidget {
  final String label;
  final Color color;
  const LegendDot(this.label, this.color, {super.key});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 5),
      Text(label, style: AppTheme.sans(context, size: 11)),
    ],
  );
}

/// Line chart on a 1–5 scale, one point per day.
class TrendChart extends StatelessWidget {
  final List<TrendSeries> series;
  final List<DateTime> days;
  final double height;
  const TrendChart({super.key, required this.series, required this.days, this.height = 120});

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    final scale = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final n in [5, 3, 1]) Text(Fmt.number(context, n), style: AppTheme.sans(context, size: 10)),
      ],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(spacing: 14, runSpacing: 6, children: [for (final s in series) LegendDot(s.label, s.color)]),
        const SizedBox(height: 10),
        SizedBox(
          height: height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: height - 4, child: scale),
              const SizedBox(width: 8),
              Expanded(child: CustomPaint(painter: _TrendPainter(series, rtl))),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 16),
          child: _DateAxis(days: days),
        ),
      ],
    );
  }
}

class _TrendPainter extends CustomPainter {
  final List<TrendSeries> series;
  final bool rtl;
  _TrendPainter(this.series, this.rtl);

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1;
    final plotH = size.height - 8;
    for (final f in [0.0, 0.5, 1.0]) {
      final y = 4 + plotH * f;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    for (final s in series) {
      final n = s.values.length;
      if (n == 0) continue;
      double x(int i) {
        final p = n == 1 ? 0.5 : i / (n - 1);
        return (rtl ? 1 - p : p) * size.width;
      }

      double y(double v) => 4 + plotH * (1 - (v - 1) / 4);
      final paint = Paint()
        ..color = s.color
        ..strokeWidth = 1.6
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      // Draw segments between consecutive logged days.
      Path? path;
      for (var i = 0; i < n; i++) {
        final v = s.values[i];
        if (v == null) {
          if (path != null) _stroke(canvas, path, paint, s.style);
          path = null;
          continue;
        }
        final p = Offset(x(i), y(v));
        if (path == null) {
          path = Path()..moveTo(p.dx, p.dy);
          canvas.drawCircle(p, 1.4, Paint()..color = s.color);
        } else {
          path.lineTo(p.dx, p.dy);
        }
      }
      if (path != null) _stroke(canvas, path, paint, s.style);
    }
  }

  void _stroke(Canvas canvas, Path path, Paint paint, LineStyle style) {
    if (style == LineStyle.solid) {
      canvas.drawPath(path, paint);
      return;
    }
    final dash = style == LineStyle.dashed ? 5.0 : 1.5;
    final gap = style == LineStyle.dashed ? 3.5 : 3.0;
    for (final ui.PathMetric m in path.computeMetrics()) {
      var d = 0.0;
      while (d < m.length) {
        canvas.drawPath(m.extractPath(d, math.min(d + dash, m.length)), paint);
        d += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(_TrendPainter o) => true;
}

/// Day-of-month labels under a chart; thins out labels for long ranges.
class _DateAxis extends StatelessWidget {
  final List<DateTime> days;
  const _DateAxis({required this.days});
  @override
  Widget build(BuildContext context) {
    final step = days.length <= 10 ? 1 : (days.length / 6).ceil();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var i = 0; i < days.length; i++)
          if (i % step == 0 || i == days.length - 1)
            Text(Fmt.dayOfMonth(context, days[i]), style: AppTheme.sans(context, size: 10)),
      ],
    );
  }
}

// ───────────────────────── Sleep / activity bars ─────────────────────────

class BarSeries extends StatelessWidget {
  final String title;
  final String scaleLabel;
  final List<double?> values;
  final double max;
  final Color color;
  final double height;
  const BarSeries({
    super.key,
    required this.title,
    required this.scaleLabel,
    required this.values,
    required this.max,
    required this.color,
    this.height = 54,
  });

  @override
  Widget build(BuildContext context) {
    final many = values.length > 10;
    final gap = many ? 3.0 : 12.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: AppTheme.sans(context, size: 12))),
            Text(scaleLabel, style: AppTheme.sans(context, size: 10)),
          ],
        ),
        const SizedBox(height: 7),
        SizedBox(
          height: height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var i = 0; i < values.length; i++) ...[
                if (i > 0) SizedBox(width: gap),
                Expanded(child: _bar(context, values[i], many)),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _bar(BuildContext context, double? v, bool many) {
    if (v == null) return const SizedBox.shrink();
    final labelH = many ? 0.0 : 15.0;
    final h = ((height - labelH) * (v / max)).clamp(2.0, height - labelH);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!many) ...[
          Text(Fmt.number(context, v), style: AppTheme.sans(context, size: 10), maxLines: 1),
          const SizedBox(height: 3),
        ],
        Container(
          height: h,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
      ],
    );
  }
}

/// Day labels row for bar charts.
class DateAxis extends StatelessWidget {
  final List<DateTime> days;
  const DateAxis({super.key, required this.days});
  @override
  Widget build(BuildContext context) => _DateAxis(days: days);
}

// ───────────────────────── Comparison bars (Insights) ─────────────────────────

class ComparisonGroup extends StatelessWidget {
  final String label;
  final double value;
  final double max;
  final String caption;
  final bool highlight;
  const ComparisonGroup({
    super.key,
    required this.label,
    required this.value,
    required this.max,
    required this.caption,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label, style: AppTheme.sans(context, size: 10, height: 1.4))),
          Text(
            Fmt.number(context, value),
            style: AppTheme.sans(context, size: 13, color: AppColors.ink, weight: FontWeight.w600),
          ),
        ],
      ),
      const SizedBox(height: 7),
      LayoutBuilder(
        builder: (context, c) {
          return Container(
            height: 12,
            width: double.infinity,
            alignment: AlignmentDirectional.centerStart,
            decoration: BoxDecoration(color: AppColors.sageLight, borderRadius: BorderRadius.circular(6)),
            child: Container(
              width: c.maxWidth * (value / max).clamp(0.02, 1.0),
              decoration: BoxDecoration(
                color: highlight ? AppColors.primary : AppColors.sleepBar,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          );
        },
      ),
      const SizedBox(height: 7),
      Text(caption, style: AppTheme.sans(context, size: 9)),
    ],
  );
}
