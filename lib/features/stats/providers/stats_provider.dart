import 'package:flutter/foundation.dart';
import '../models/user_stats.dart';
import '../services/stats_service.dart';

/// 통계 상태 관리 Provider
class StatsProvider with ChangeNotifier {
  final StatsService _service;

  UserStats? _myStats;
  GlobalStats? _globalStats;
  bool _isLoading = false;
  String? _errorMessage;

  StatsProvider(this._service);

  // Getters
  UserStats? get myStats => _myStats;
  GlobalStats? get globalStats => _globalStats;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// 내 통계 가져오기
  Future<void> fetchMyStats() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _myStats = await _service.getMyStats();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      print('[StatsProvider] Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 전역 통계 가져오기
  Future<void> fetchGlobalStats() async {
    try {
      _globalStats = await _service.getGlobalStats();
      notifyListeners();
    } catch (e) {
      print('[StatsProvider] Error fetching global stats: $e');
    }
  }

  /// 통계 새로고침
  Future<void> refresh() async {
    await Future.wait([
      fetchMyStats(),
      fetchGlobalStats(),
    ]);
  }
}
