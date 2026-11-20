import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/navigation/main_shell.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/view/login_screen.dart';
import 'data/local/app_database.dart';
import 'features/auth/viewmodel/auth_viewmodel.dart';
import 'features/machines/repository/pr_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const FitPulseApp());
}

class FitPulseApp extends StatelessWidget {
  const FitPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        // Tek yerel veritabanı bağlantısı; uygulama kapanınca kapatılır.
        Provider<PrRepository>(
          create: (_) => PrRepository(AppDatabase()),
          dispose: (_, repo) => repo.close(),
        ),
      ],
      child: Consumer<AuthViewModel>(
        builder: (context, vm, _) => MaterialApp(
          title: 'FitPulse QR',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          home: StreamBuilder<User?>(
            stream: vm.authState,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              }
              return snapshot.hasData ? const MainShell() : const LoginScreen();
            },
          ),
        ),
      ),
    );
  }
}