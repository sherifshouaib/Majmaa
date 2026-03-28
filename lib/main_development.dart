import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/core/utils/globals.dart';
import 'package:merhaba/core/utils/providers/app_settings_provider.dart';
import 'package:merhaba/core/utils/providers/bottom_navbar_view_provider.dart';
import 'package:merhaba/core/utils/providers/login_provider.dart';
import 'package:merhaba/core/utils/providers/create_account_provider.dart';
import 'package:merhaba/core/utils/providers/profile_tab_provider.dart';
import 'package:merhaba/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print(e.toString());
  }

  try {
    await Supabase.initialize(
      url: dotenv.env["SUPABASE_URL"].toString(),
      anonKey: dotenv.env["SUPABASE_KEY"].toString(),
    );
  } catch (e) {
    print(e.toString());
  }

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print(e.toString());
  }

  try {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode != null) {
      if (savedThemeMode == AdaptiveThemeMode.light) {
        Globals.theme = "Light";
      } else {
        Globals.theme = "Dark";
      }
    }
  } catch (e) {
    print(e.toString());
  }
  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => CreateAccountProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavBarViewProvider()),
        ChangeNotifierProvider(create: (_) => ProfileTabProvider()),
        ChangeNotifierProvider(create: (_) => AppSettingsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => ScreenUtilInit(
        designSize: const Size(375, 812), // مقاس التصميم من Figma
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return FluentApp.router(
            routerConfig: AppRouter.router,

            title: 'Merhaba App',
            theme: theme == ThemeData.light(useMaterial3: true)
                ? FluentThemeData.light()
                : FluentThemeData.dark(),
            darkTheme: darkTheme == ThemeData.dark(useMaterial3: true)
                ? FluentThemeData.dark()
                : FluentThemeData.light(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
