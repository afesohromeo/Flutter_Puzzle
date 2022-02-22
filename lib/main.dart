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

  @override
  Widget build(BuildContext context) {
    print('heyyyy');

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => _appStateManager,),
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

  Widget myapp() {
    return Scaffold(
      body: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: ResponsiveLayout(
              mobile: (context, child) => Image.asset(
                Provider.of<PuzzleStateManager>(context, listen: false)
                    .assetName,
                height: 24,
              ),
              tablet: (context, child) => Image.asset(
                Provider.of<PuzzleStateManager>(context, listen: false)
                    .assetName,
                height: 29,
              ),
              desktop: (context, child) => Image.asset(
                Provider.of<PuzzleStateManager>(context, listen: false)
                    .assetName,
                height: 32,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Switch(
                value: Provider.of<PuzzleStateManager>(context, listen: false)
                    .darkMode,
                onChanged: (value) {
                  print('value $value');
                  Provider.of<PuzzleStateManager>(context, listen: false)
                      .darkMode = value;
                },
              ))
        ],
      ),
    );
  }
}
