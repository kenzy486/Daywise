// Shared DayWise UI building blocks, matched to the Figma components
// (Brand mark, Language choice, Page introduction, Demo disclosure,
// cards, Context badge, Action buttons, rating/stepper/slider inputs…).
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../services/locale_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

// ───────────────────────── Layout helpers ─────────────────────────

/// Vertical list with a fixed gap between children.
class Gap extends StatelessWidget {
  final double size;
  const Gap(this.size, {super.key});
  @override
  Widget build(BuildContext context) => SizedBox(width: size, height: size);
}

List<Widget> spaced(List<Widget> children, double gap) => [
  for (var i = 0; i < children.length; i++) ...[if (i > 0) SizedBox(height: gap), children[i]],
];

/// Scrollable page body: 20px padding on phones, centered max width on wide screens.
class PageBody extends StatelessWidget {
  final List<Widget> children;
  final double gap;
  final double maxWidth;
  const PageBody({super.key, required this.children, this.gap = 20, this.maxWidth = 720});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 1024;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: wide ? 36 : 20, vertical: 20),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: spaced(children, gap)),
        ),
      ),
    );
  }
}

// ───────────────────────── Brand ─────────────────────────

class BrandMark extends StatelessWidget {
  final double size;
  const BrandMark({super.key, this.size = 34});
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
    child: Icon(LucideIcons.sprout, color: Colors.white, size: size * 0.68),
  );
}

/// Logo + "DayWise" wordmark.
class DayWiseIdentity extends StatelessWidget {
  final double markSize;
  final double fontSize;
  const DayWiseIdentity({super.key, this.markSize = 34, this.fontSize = 23});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    textDirection: TextDirection.ltr,
    children: [
      BrandMark(size: markSize),
      const SizedBox(width: 9),
      Text(
        'DayWise',
        style: AppTheme.sans(context, size: fontSize, color: AppColors.ink).copyWith(fontSize: fontSize),
      ),
    ],
  );
}

/// "EN · العربية" pill. Tapping toggles the app language.
class LanguageChoice extends StatelessWidget {
  const LanguageChoice({super.key});
  @override
  Widget build(BuildContext context) {
    final lp = context.watch<LocaleProvider>();
    final t = AppLocalizations.of(context);
    return Semantics(
      button: true,
      label: t.switchLanguage,
      child: Material(
        color: Colors.transparent,
        shape: const StadiumBorder(side: BorderSide(color: AppColors.border)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => lp.setLocale(lp.isArabic ? 'en' : 'ar'),
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(LucideIcons.languages, size: 16, color: AppColors.primary),
                const SizedBox(width: 7),
                Text(
                  lp.isArabic ? 'العربية · EN' : 'EN · العربية',
                  style: AppTheme.sans(context, size: 12, color: AppColors.primary, weight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Round "N" avatar that opens account settings.
class AvatarButton extends StatelessWidget {
  final String initial;
  final VoidCallback onTap;
  final double size;
  const AvatarButton({super.key, required this.initial, required this.onTap, this.size = 36});
  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: AppLocalizations.of(context).accountTitle,
    child: Material(
      color: AppColors.avatar,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Text(
              initial,
              style: AppTheme.sans(context, size: size * 0.4, color: AppColors.ink, weight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ),
  );
}

/// Mobile app header: identity on the start side, language (+ optional avatar) on the end.
class AppHeader extends StatelessWidget {
  final Widget? trailing;
  final Widget? leading;
  const AppHeader({super.key, this.trailing, this.leading});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: Row(
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: 4)],
        const DayWiseIdentity(),
        const Spacer(),
        const LanguageChoice(),
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
      ],
    ),
  );
}

// ───────────────────────── Text blocks ─────────────────────────

class Eyebrow extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  const Eyebrow(this.text, {super.key, this.color = AppColors.primary, this.size = 11});
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: AppTheme.sans(context, size: size, color: color, weight: FontWeight.w600),
  );
}

/// Eyebrow + big serif title + supporting copy.
class PageIntro extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? body;
  final double titleSize;
  const PageIntro({super.key, required this.eyebrow, required this.title, this.body, this.titleSize = 30});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Eyebrow(eyebrow),
      const SizedBox(height: 9),
      Text(title, style: AppTheme.serif(context, size: titleSize, height: 1.16)),
      if (body != null) ...[
        const SizedBox(height: 9),
        Text(body!, style: AppTheme.sans(context, size: 13, height: 1.6)),
      ],
    ],
  );
}

class Disclaimer extends StatelessWidget {
  final TextAlign align;
  const Disclaimer({super.key, this.align = TextAlign.start});
  @override
  Widget build(BuildContext context) => Text(
    AppLocalizations.of(context).notMedicalAdvice,
    textAlign: align,
    style: AppTheme.sans(context, size: 11, height: 1.6),
  );
}

/// "Nour's illustrative demo · not real health data"
class DemoDisclosure extends StatelessWidget {
  const DemoDisclosure({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        const Icon(LucideIcons.flaskConical, size: 14, color: AppColors.primary),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            AppLocalizations.of(context).demoDisclosure,
            style: AppTheme.sans(context, size: 11, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

/// Inline green text link with arrow, e.g. "Explore insights →".
class TextAction extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool external;
  final double size;
  final bool center;
  final FontWeight weight;
  const TextAction(
    this.label, {
    super.key,
    this.onTap,
    this.external = false,
    this.size = 12,
    this.center = false,
    this.weight = FontWeight.w600,
  });
  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    final arrow = external ? '↗' : (rtl ? '←' : '→');
    final text = Text(
      rtl && !external ? '$arrow $label' : '$label $arrow',
      textAlign: center ? TextAlign.center : TextAlign.start,
      style: AppTheme.sans(context, size: size, color: AppColors.primary, weight: weight),
    );
    return Semantics(
      link: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: center ? Center(child: text) : text,
        ),
      ),
    );
  }
}

// ───────────────────────── Cards & badges ─────────────────────────

enum CardTone { white, sage, mint, sand }

class DwCard extends StatelessWidget {
  final Widget child;
  final CardTone tone;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color? borderColor;
  const DwCard({
    super.key,
    required this.child,
    this.tone = CardTone.white,
    this.padding = const EdgeInsets.all(20),
    this.radius = AppTheme.cardRadius,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = switch (tone) {
      CardTone.white => AppColors.surface,
      CardTone.sage => AppColors.sage,
      CardTone.mint => AppColors.mint,
      CardTone.sand => AppColors.sand,
    };
    final border = borderColor ?? (tone == CardTone.white ? AppColors.border : null);
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: border != null ? Border.all(color: border) : null,
      ),
      child: child,
    );
  }
}

/// Small pill label, e.g. "Moderate confidence", "Pending · 1 of 3 done".
class ContextBadge extends StatelessWidget {
  final String label;
  final Color background;
  const ContextBadge(this.label, {super.key, this.background = AppColors.surface});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(100)),
    child: Text(
      label,
      style: AppTheme.sans(context, size: 11, color: AppColors.primary, weight: FontWeight.w600),
    ),
  );
}

// ───────────────────────── Buttons ─────────────────────────

/// Pill-shaped action. Primary = filled green; secondary = white with border.
class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool primary;
  final bool arrow;
  final bool external;
  final double height;
  final bool loading;
  const ActionButton(
    this.label, {
    super.key,
    this.onPressed,
    this.primary = true,
    this.arrow = false,
    this.external = false,
    this.height = 52,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    var text = label;
    if (arrow) text = rtl ? '← $label' : '$label →';
    if (external) text = '$label ↗';
    final fg = primary ? Colors.white : AppColors.primary;
    final disabled = onPressed == null && !loading;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Material(
        color: primary
            ? (disabled ? AppColors.primary.withValues(alpha: 0.45) : AppColors.primary)
            : AppColors.surface,
        shape: StadiumBorder(side: BorderSide(color: primary ? Colors.transparent : AppColors.border)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: loading ? null : onPressed,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: loading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: fg),
                    )
                  : Text(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.sans(context, size: 14, color: fg, weight: FontWeight.w600),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 44×44 rounded square icon button (stepper +/-, thumbs up/down).
class SquareIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool selected;
  final String semanticLabel;
  final double iconSize;
  const SquareIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.semanticLabel,
    this.selected = false,
    this.iconSize = 18,
  });
  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    label: semanticLabel,
    child: Material(
      color: selected ? AppColors.primary : AppColors.sageLight,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(
            icon,
            size: iconSize,
            color: onTap == null
                ? AppColors.body.withValues(alpha: 0.4)
                : (selected ? Colors.white : AppColors.primary),
          ),
        ),
      ),
    ),
  );
}

/// Two-option pill toggle ("7 days" / "30 days").
class RangeToggle extends StatelessWidget {
  final List<String> options;
  final int selected;
  final ValueChanged<int> onChanged;
  const RangeToggle({super.key, required this.options, required this.selected, required this.onChanged});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(color: AppColors.sage, borderRadius: BorderRadius.circular(100)),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < options.length; i++) ...[
          if (i > 0) const SizedBox(width: 4),
          Semantics(
            button: true,
            selected: i == selected,
            child: Material(
              color: i == selected ? AppColors.surface : Colors.transparent,
              shape: const StadiumBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => onChanged(i),
                child: Container(
                  height: 44,
                  constraints: const BoxConstraints(minWidth: 72),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  child: Text(
                    options[i],
                    style: AppTheme.sans(
                      context,
                      size: 12,
                      color: AppColors.primary,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

// ───────────────────────── Inputs ─────────────────────────

/// Label + value header used by sliders and ratings.
class _InputHeader extends StatelessWidget {
  final String label;
  final String value;
  final double valueSize;
  const _InputHeader(this.label, this.value, {this.valueSize = 12});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: AppTheme.sans(context, size: 13, color: AppColors.ink, weight: FontWeight.w600),
        ),
      ),
      Text(
        value,
        style: AppTheme.sans(context, size: valueSize, color: AppColors.primary, weight: FontWeight.w600),
      ),
    ],
  );
}

/// 1–5 rating tiles, optionally with face icons.
class RatingInput extends StatelessWidget {
  final String label;
  final String valueLabel;
  final int value;
  final ValueChanged<int> onChanged;
  final String lowLabel;
  final String highLabel;
  final bool faces;
  final String Function(int) numberLabel;
  const RatingInput({
    super.key,
    required this.label,
    required this.valueLabel,
    required this.value,
    required this.onChanged,
    required this.lowLabel,
    required this.highLabel,
    required this.numberLabel,
    this.faces = false,
  });

  static const _faceIcons = [
    LucideIcons.frown,
    LucideIcons.frown,
    LucideIcons.meh,
    LucideIcons.smile,
    LucideIcons.laugh,
  ];

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _InputHeader(label, valueLabel),
      const SizedBox(height: 10),
      Row(
        children: [
          for (var i = 1; i <= 5; i++) ...[
            if (i > 1) const SizedBox(width: 7),
            Expanded(child: _tile(context, i)),
          ],
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Expanded(child: Text(lowLabel, style: AppTheme.sans(context, size: 10))),
          Text(highLabel, style: AppTheme.sans(context, size: 10)),
        ],
      ),
    ],
  );

  Widget _tile(BuildContext context, int i) {
    final sel = i == value;
    final fg = sel ? Colors.white : AppColors.primary;
    return Semantics(
      button: true,
      selected: sel,
      label: '$label ${numberLabel(i)}',
      child: Material(
        color: sel ? AppColors.primary : AppColors.sageLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: sel ? AppColors.primary : AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => onChanged(i),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: faces ? 64 : 48),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (faces) ...[Icon(_faceIcons[i - 1], size: 23, color: fg), const SizedBox(height: 5)],
                  Text(
                    numberLabel(i),
                    style: AppTheme.sans(context, size: 12, color: fg, weight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Slider with label/value header and a helper line ("0–12 hours · half-hour steps").
class SliderInput extends StatelessWidget {
  final String label;
  final String valueLabel;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String helper;
  final ValueChanged<double> onChanged;
  const SliderInput({
    super.key,
    required this.label,
    required this.valueLabel,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.helper,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _InputHeader(label, valueLabel, valueSize: 14),
      SizedBox(
        height: 44,
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackShape: const RoundedRectSliderTrackShape(),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              divisions: divisions,
              semanticFormatterCallback: (_) => valueLabel,
              padding: const EdgeInsets.symmetric(horizontal: 11),
              onChanged: onChanged,
            ),
          ),
        ),
      ),
      Text(helper, style: AppTheme.sans(context, size: 10)),
    ],
  );
}

/// Label on the start side, − value + stepper on the end side, optional helper text.
class StepperInput extends StatelessWidget {
  final String label;
  final String valueLabel;
  final String unit;
  final String? helper;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;
  const StepperInput({
    super.key,
    required this.label,
    required this.valueLabel,
    required this.unit,
    this.helper,
    this.onDecrease,
    this.onIncrease,
  });
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTheme.sans(context, size: 13, color: AppColors.ink, weight: FontWeight.w600),
              ),
            ),
            SquareIconButton(
              icon: LucideIcons.minus,
              onTap: onDecrease,
              semanticLabel: '${t.decrease} $label',
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 62,
              child: Column(
                children: [
                  Text(
                    valueLabel,
                    style: AppTheme.sans(context, size: 17, color: AppColors.ink, weight: FontWeight.w600),
                  ),
                  const SizedBox(height: 3),
                  Text(unit, style: AppTheme.sans(context, size: 9)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SquareIconButton(
              icon: LucideIcons.plus,
              onTap: onIncrease,
              semanticLabel: '${t.increase} $label',
            ),
          ],
        ),
        if (helper != null) ...[
          const SizedBox(height: 10),
          Text(helper!, style: AppTheme.sans(context, size: 11, height: 1.5)),
        ],
      ],
    );
  }
}

/// Label + white rounded text field with trailing icon (Welcome / Sign in forms).
class DwTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final Widget? suffix;
  final bool obscure;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? helper;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  const DwTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.suffix,
    this.obscure = false,
    this.keyboardType,
    this.validator,
    this.helper,
    this.autofillHints,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder b(Color c) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: c),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.sans(context, size: 12, color: AppColors.ink, weight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          validator: validator,
          autofillHints: autofillHints,
          textInputAction: textInputAction,
          onFieldSubmitted: onSubmitted,
          style: AppTheme.sans(context, size: 13, color: AppColors.ink),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTheme.sans(context, size: 13),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: suffix,
            suffixIconColor: AppColors.primary,
            border: b(AppColors.border),
            enabledBorder: b(AppColors.border),
            focusedBorder: b(AppColors.primary),
            errorBorder: b(AppColors.danger),
            focusedErrorBorder: b(AppColors.danger),
            errorStyle: AppTheme.sans(context, size: 11, color: AppColors.danger),
          ),
        ),
        if (helper != null) ...[
          const SizedBox(height: 8),
          Text(helper!, style: AppTheme.sans(context, size: 11)),
        ],
      ],
    );
  }
}

/// Inline error message (auth forms).
class ErrorNote extends StatelessWidget {
  final String message;
  const ErrorNote(this.message, {super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.sand,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.danger),
    ),
    child: Text(message, style: AppTheme.sans(context, size: 12, color: AppColors.ink)),
  );
}
