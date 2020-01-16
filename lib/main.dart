import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:ne_music/application.dart';
import 'package:ne_music/pages/bootstrap.dart' show BootstrapPage;
import 'package:ne_music/routes/routes.dart';
import 'package:ne_music/providers/user_model.dart';
import 'package:ne_music/providers/song_list.dart';

void main() {
  final Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SongListModel(),
        ),
      ],
      child: new CupertinoApp(
        theme: CupertinoThemeData(
          primaryColor: Application.themeColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
              color: Colors.black,
            ),
            navActionTextStyle: TextStyle(
              color: Colors.white,
            ),
            navTitleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),
            tabLabelTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 9
            )
          )
        ),
        onGenerateRoute: Application.router.generator,
        home: BootstrapPage()
        // home: MainBoard()
        // home: LoginPage(), 
        // home: PasswordPage(),
        // home: PhonePage(),
      )   
    );
  }
}