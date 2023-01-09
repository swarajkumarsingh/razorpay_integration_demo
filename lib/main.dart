import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_integration/my_app.dart';
import 'package:razorpay_integration/utils/utils.dart';

void main() => init();

init() async {
  PlatformDispatcher.instance.onError = (error, stack) {
    return RazorpayUtils.showCustomToast();
  };
  runApp(const MyApp());
}
