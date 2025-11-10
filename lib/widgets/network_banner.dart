import 'package:flutter/material.dart';
import 'dart:async';

/// v2.4: 네트워크 상태 배너
class NetworkBanner extends StatefulWidget {
  final Widget child;

  const NetworkBanner({super.key, required this.child});

  @override
  State<NetworkBanner> createState() => _NetworkBannerState();
}

class _NetworkBannerState extends State<NetworkBanner> {
  bool _isOnline = true;
  Timer? _checkTimer;

  @override
  void initState() {
    super.initState();
    _startNetworkCheck();
  }

  @override
  void dispose() {
    _checkTimer?.cancel();
    super.dispose();
  }

  void _startNetworkCheck() {
    // 간단한 네트워크 체크 (실제로는 connectivity_plus 패키지 사용 권장)
    _checkTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _checkNetworkStatus();
    });
  }

  Future<void> _checkNetworkStatus() async {
    // TODO: 실제 네트워크 체크 로직
    // final connectivityResult = await Connectivity().checkConnectivity();
    // final isOnline = connectivityResult != ConnectivityResult.none;

    // 현재는 항상 온라인으로 가정
    final isOnline = true;

    if (isOnline != _isOnline) {
      setState(() {
        _isOnline = isOnline;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!_isOnline)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.red[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                const Text(
                  '오프라인 모드 - 일부 기능이 제한됩니다',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        Expanded(child: widget.child),
      ],
    );
  }
}

/// 네트워크 상태 체크 유틸리티
class NetworkStatus {
  static bool _isOnline = true;

  static bool get isOnline => _isOnline;

  static Future<bool> checkConnection() async {
    // TODO: 실제 네트워크 체크
    return true;
  }

  static void setOnline(bool value) {
    _isOnline = value;
  }
}
