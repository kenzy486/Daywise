import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show BuildContext, Localizations, StringCharacters;

import '../models/checkin.dart';
import 'checkin_service.dart';
import 'demo_data.dart';
import 'suggestions_service.dart';
import 'user_service.dart';

/// Single source of truth for the signed-in experience.
///
/// Two modes:
///  * [isDemo] — "Explore Nour's demo": illustrative data kept in memory only.
///  * signed in — check-ins, profile and suggestion progress live in Firestore.
class AppState extends ChangeNotifier {
  AppState({CheckinService? checkins, UserService? users}) : _checkinService = checkins, _userService = users;

  CheckinService? _checkinService;
  UserService? _userService;
  CheckinService get _checkinsApi => _checkinService ??= CheckinService();
  UserService get _usersApi => _userService ??= UserService();

  bool _isDemo = false;
  bool _ready = false;
  String? _uid;
  List<CheckIn> _checkins = [];
  String _nickname = '';
  String _city = 'Cairo';
  List<Goal> _goals = [];
  bool _onboarded = false;
  bool _demoName = false;
  Map<String, SuggestionState> _suggestionStates = {};
  StreamSubscription<List<CheckIn>>? _sub;

  bool get isDemo => _isDemo;
  bool get ready => _ready;
  bool get onboarded => _onboarded;
  List<CheckIn> get checkins => List.unmodifiable(_checkins);
  String get nickname => _nickname;
  String get city => _city;
  List<Goal> get goals => List.unmodifiable(_goals);

  /// Nickname for display. Nour's demo name follows the app language (Nour / نور).
  String name(BuildContext context) =>
      _demoName && Localizations.localeOf(context).languageCode == 'ar' ? 'نور' : _nickname;

  String initial(BuildContext context) {
    final n = name(context);
    return n.isEmpty ? '·' : n.characters.first.toUpperCase();
  }

  DateTime get today {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day);
  }

  CheckIn? get todayCheckin {
    final id = CheckIn.dateId(today);
    for (final c in _checkins) {
      if (c.date == id) return c;
    }
    return null;
  }

  CheckIn? get latest => _checkins.isEmpty ? null : _checkins.last;

  /// Check-ins within the last [days] days (including today), oldest first.
  List<CheckIn> lastDays(int days) {
    final start = CheckIn.dateId(today.subtract(Duration(days: days - 1)));
    return _checkins.where((c) => c.date.compareTo(start) >= 0).toList();
  }

  /// The calendar days a chart covers: ends today if logged, otherwise yesterday.
  List<DateTime> chartDays(int days) {
    final end = todayCheckin != null ? today : today.subtract(const Duration(days: 1));
    return [for (var i = days - 1; i >= 0; i--) end.subtract(Duration(days: i))];
  }

  CheckIn? checkinOn(DateTime d) {
    final id = CheckIn.dateId(d);
    for (final c in _checkins) {
      if (c.date == id) return c;
    }
    return null;
  }

  // ───────── Suggestions ─────────

  List<Suggestion> get todaysSuggestions => _isDemo
      ? SuggestionsService.demoIds.map(SuggestionsService.byId).toList()
      : SuggestionsService.forDate(today, _goals);

  SuggestionState stateOf(String id) => _suggestionStates[id] ?? const SuggestionState();

  int get suggestionsDone =>
      todaysSuggestions.where((s) => stateOf(s.id).status == SuggestionStatus.done).length;

  /// First suggestion that is still pending (shown on Today), if any.
  Suggestion? get nextSuggestion {
    for (final s in todaysSuggestions) {
      if (stateOf(s.id).status == SuggestionStatus.pending) return s;
    }
    return null;
  }

  Future<void> setSuggestionStatus(String id, SuggestionStatus status) async {
    _suggestionStates[id] = stateOf(id).copyWith(status: status);
    notifyListeners();
    await _persistSuggestions();
  }

  Future<void> setSuggestionFeedback(String id, bool helpful) async {
    final current = stateOf(id);
    _suggestionStates[id] = current.helpful == helpful
        ? current.copyWith(clearHelpful: true) // tap again to clear
        : current.copyWith(helpful: helpful);
    notifyListeners();
    await _persistSuggestions();
  }

  Future<void> _persistSuggestions() async {
    if (_isDemo || _uid == null) return;
    await _usersApi.saveSuggestionStates(
      CheckIn.dateId(today),
      _suggestionStates.map((k, v) => MapEntry(k, v.toMap())),
    );
  }

  // ───────── Sessions ─────────

  /// Start the illustrative demo without an account.
  void startDemo() {
    _sub?.cancel();
    _isDemo = true;
    _uid = null;
    _checkins = DemoData.nour();
    _nickname = 'Nour';
    _demoName = true;
    _city = 'Cairo';
    _goals = [Goal.sleep, Goal.stress];
    _onboarded = true;
    _suggestionStates = {'activity_walk': const SuggestionState(status: SuggestionStatus.done)};
    _ready = true;
    notifyListeners();
  }

  void exitDemo() {
    _isDemo = false;
    _reset();
    notifyListeners();
  }

  /// Load everything for a signed-in user.
  Future<void> attachUser(String uid) async {
    if (_uid == uid && _ready) return;
    _isDemo = false;
    _uid = uid;
    _ready = false;
    notifyListeners();

    try {
      final profile = await _usersApi.getProfile() ?? {};
      _nickname = (profile['nickname'] as String?) ?? '';
      _city = (profile['city'] as String?) ?? 'Cairo';
      _goals = ((profile['goals'] as List?) ?? [])
          .map((g) => Goal.values.where((x) => x.name == g).firstOrNull)
          .whereType<Goal>()
          .toList();
      _onboarded = profile['onboarded'] == true;
      final states = await _usersApi.getSuggestionStates(CheckIn.dateId(today));
      _suggestionStates = states.map(
        (k, v) => MapEntry(k, SuggestionState.fromMap(Map<String, dynamic>.from(v as Map))),
      );
    } catch (e) {
      debugPrint('DayWise: could not load profile: $e');
    }

    _sub?.cancel();
    _sub = _checkinsApi
        .watchLastDays(90)
        .listen(
          (list) {
            _checkins = list;
            _ready = true;
            notifyListeners();
          },
          onError: (Object e) {
            debugPrint('DayWise: could not load check-ins: $e');
            _ready = true;
            notifyListeners();
          },
        );
  }

  void detachUser() {
    _reset();
    notifyListeners();
  }

  void _reset() {
    _sub?.cancel();
    _sub = null;
    _uid = null;
    _ready = false;
    _checkins = [];
    _nickname = '';
    _demoName = false;
    _goals = [];
    _onboarded = false;
    _suggestionStates = {};
  }

  // ───────── Writes ─────────

  Future<void> saveCheckin(CheckIn c) async {
    final now = DateTime.now();
    final withTimes = c.copyWith(createdAt: c.createdAt ?? now, updatedAt: now);
    if (_isDemo) {
      _checkins = [..._checkins.where((x) => x.date != c.date), withTimes]
        ..sort((a, b) => a.date.compareTo(b.date));
      notifyListeners();
      return;
    }
    await _checkinsApi.save(withTimes);
  }

  Future<void> saveOnboarding({required List<Goal> goals, required String nickname}) async {
    _goals = goals;
    if (nickname.trim().isNotEmpty) _nickname = nickname.trim();
    _onboarded = true;
    notifyListeners();
    if (_isDemo) return;
    await _usersApi.saveProfile({
      'goals': goals.map((g) => g.name).toList(),
      'nickname': _nickname,
      'onboarded': true,
    });
  }

  Future<void> setGoals(List<Goal> goals) async {
    _goals = goals;
    notifyListeners();
    if (!_isDemo) await _usersApi.saveProfile({'goals': goals.map((g) => g.name).toList()});
  }

  Future<void> setNickname(String name) async {
    _nickname = name.trim();
    _demoName = false;
    notifyListeners();
    if (!_isDemo) await _usersApi.saveProfile({'nickname': _nickname});
  }

  /// JSON export of every check-in.
  Future<String> exportJson() async {
    if (_isDemo) {
      return const JsonEncoder.withIndent('  ').convert(_checkins.map((c) => c.toMap()).toList());
    }
    return _usersApi.exportCheckinsJson();
  }

  Future<void> deleteAllData() async {
    if (_isDemo) {
      _checkins = [];
      _suggestionStates = {};
      notifyListeners();
      return;
    }
    await _usersApi.deleteAllData();
    _suggestionStates = {};
    _goals = [];
    _onboarded = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
