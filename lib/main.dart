import 'package:flutter/material.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_puzzle/themes/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'layout/responsive_layout.dart';
import 'screens/screens.dart';

void main() {
  print('heyyyy');
  runApp(PuzzleApp());
}

class PuzzleApp extends StatefulWidget {
  PuzzleApp({Key? key}) : super(key: key);

  @override
  State<PuzzleApp> createState() => _PuzzleAppState();
}

class _PuzzleAppState extends State<PuzzleApp> {
  final _appStateManager = PuzzleStateManager();
  final _timerStateManager = TimerStateManager();
  @override
  void initState() {
    super.initState();
    _appStateManager.initilizePuzzle();
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => _appStateManager,
          ),
          ChangeNotifierProvider(
            create: (context) => _timerStateManager,
          ),
        ],
        child: Consumer<PuzzleStateManager>(
          builder: (context, appStateManager, child) {
            ThemeData theme;
            if (appStateManager.darkMode) {
              print("Dark mode");
              theme = PuzzleTheme.dark();
            } else {
              theme = PuzzleTheme.light();
            }
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: ' Challenge',
                theme: theme,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                ],
                home: child);
          },
          child: const PuzzleScreen(),
        ));
  }

 }
