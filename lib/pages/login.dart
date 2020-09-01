import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ne_music/application.dart';
import 'package:ne_music/providers/user_model.dart';
import 'package:provider/provider.dart';

import 'package:ne_music/widgets/iconfont.dart';
import 'package:ne_music/utils/constant.dart';
import 'package:ne_music/widgets/button.dart';
import 'package:ne_music/utils/navigator_util.dart';
import 'package:ne_music/utils/util.dart';

// 登录方式选择页面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Constant.color['primaryColor'],
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Positioned(
              top: 240.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Constant.color['brightenColor'],
                    ),
                    child: Icon(NeMusicIcon.netease_music,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ),
            Positioned(
              bottom: 180.0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 50.0,
                  right: 50.0
                ),
                child: NeCustomButton(
                  onPressed: () {
                    NavigatorUtil.goPhonePage(context);
                  },
                  color: Colors.white,
                  height: 40.0,
                  text: '手机号登录',
                  fontSize: 16,
                  textColor: Constant.color['primaryColor'],
                )
              )
            )
          ],
        ),
      )
    );
  }
}


// 手机号登录页面
class PhonePage extends StatefulWidget {
  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  bool textInputStatus = false;
  final TextEditingController _phoneController = TextEditingController();
  void _handleTextFieldChange(String value) {
    if (value.isNotEmpty) {
      setState(() {
        textInputStatus = true;
      });
    }
  }

  void _nextStep() {
    String value = _phoneController.text;
    if (value.length != 11) {
      Util.showToast('手机号长度应该11位长度数字');
    } else {
      NavigatorUtil.goPasswordPage(context, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Application.themeColor,
        middle: Text('手机号登录'),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 40.0,
          left: 15.0,
          right: 15.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('未注册手机号登录后将自动创建账号', 
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 12
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.0
              ),
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  primaryColor: Colors.grey,
                  textTheme: CupertinoTextThemeData(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ),
                child: SizedBox(
                  height: 36.0,
                  child: CupertinoTextField(
                    onChanged: _handleTextFieldChange,
                    controller: _phoneController,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    decoration: BoxDecoration(
                      border: Border(),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    suffix: GestureDetector(
                      onTap: () {
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 14.0,
                        height: 14.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey
                        ),
                        child: Icon(
                          Icons.close,
                          size: 12,
                          color: Colors.white
                        ),
                      ),
                    ),
                    suffixMode: OverlayVisibilityMode.editing,
                    placeholder: '输入手机号',
                    placeholderStyle: TextStyle(
                      color: Colors.black.withOpacity(.4)
                    ),
                    prefix: Text('+86', 
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 5,
                bottom: 30,
              ),
              child: Divider(),
            ),
            NeCustomButton.opacity(
              onPressed: _nextStep,
              text: '下一步',
              textColor: Colors.white,
              fontSize: 16,
              height: 36,
              opacity: textInputStatus ? 1 : 0.5,
              color: Constant.color['primaryColor'],
            )
          ],
        ),
      ),
    );
  }
}

// 输入密码页面
class PasswordPage extends StatefulWidget {
  PasswordPage({
    Key key,
    this.previewPhone
  }): super(key: key);

  final String previewPhone;
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  bool passwordInputStatus = false;
  final TextEditingController _passwordController = TextEditingController();
  void _passwordChanged(String value) {
    if (value.isNotEmpty) {
      setState(() {
        passwordInputStatus = true;
      });
    }
  }

  void _goMainBoard(UserModel value) {
    if (_passwordController.text.isEmpty) {
      Util.showToast('请输入密码');
    } else {
      // 调用登录接口
      value
        .login(context, widget.previewPhone, _passwordController.text)
        .then((_) {
          NavigatorUtil.goMainBoardPage(context);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Application.themeColor,
        middle: Text('手机号登录'),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 15.0,
          right: 15.0,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 20.0,
              ),
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  primaryColor: Colors.grey,
                  textTheme: CupertinoTextThemeData(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ),
                child: CupertinoTextField(
                  onChanged: _passwordChanged,
                  controller: _passwordController,
                  autofocus: false,
                  decoration: BoxDecoration(
                    border: Border(),
                  ),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  suffix: GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 14.0,
                      height: 14.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey
                      ),
                      child: Icon(
                        Icons.close,
                        size: 12,
                        color: Colors.white
                      ),
                    ),
                  ),
                  suffixMode: OverlayVisibilityMode.editing,
                  placeholder: '输入密码',
                  placeholderStyle: TextStyle(
                    color: Colors.black.withOpacity(.4)
                  ),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: Divider(),
            ),
            Consumer<UserModel>(
              builder: (BuildContext context, UserModel value, Widget child) {
                return NeCustomButton.opacity(
                  onPressed: () {
                    _goMainBoard(value);
                  },
                  textColor: Colors.white,
                  text: '立即登录',
                  height: 36,
                  fontSize: 16,
                  opacity: passwordInputStatus ? 1 : .5,
                  color: Constant.color['primaryColor'],
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text('重设密码>',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    )
                  )
                )
              ],
            )
          ],
        )
      ),
    );
  }
}