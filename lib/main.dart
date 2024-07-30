import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zegocloud_uikit/core/core.dart';
import 'package:zegocloud_uikit/src/auth/services/auth_service.dart';
import 'package:zegocloud_uikit/src/auth/views/login_view.dart';
import 'package:zegocloud_uikit/src/home/views/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorage.init();
  await AuthService.getUserLoginSession();

  /// 1/8: Define a navigator key
  final navigatorKey = GlobalKey<NavigatorState>();

  /// 2/8: Set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  /// 3/8: call ZegoUIKit().initLog()
  ZegoUIKit().initLog().then((value) {
    /// 4/8: Use System Calling UI with ZegoUIKitSignalingPlugin to ZegoUIKitPrebuiltCallInvitationService
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(MyApp(navigatorKey: navigatorKey));
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({required this.navigatorKey, super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    log('${Session.currentUser?.id}');
    if (Session.currentUser != null) {
      AuthService.onUserLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRouter.routes,
      initialRoute: Session.currentUser?.id.isNotEmpty == true ? HomePage.routeName : LoginPage.routeName,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),

      /// 5/5: Register the navigator key to MaterialApp
      navigatorKey: widget.navigatorKey,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            child!,

            /// 6/8: Add Support minimizing overlay page
            ZegoUIKitPrebuiltCallMiniOverlayPage(
              contextQuery: () {
                return widget.navigatorKey.currentState!.context;
              },
            ),
          ],
        );
      },
    );
  }
}
