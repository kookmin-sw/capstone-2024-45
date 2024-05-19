import 'package:suntown/main/mainAccount.dart';
import 'package:suntown/main/manage/accountInfoManage.dart';
import 'package:suntown/main/manage/userInfoManage.dart';
import 'package:suntown/main/signingUp/Login/KakaoLogin/main_view.dart';
import 'package:suntown/main/signingUp/Login/KakaoLogin/kakao_login.dart';

import 'package:suntown/main/defaultAccount.dart';
import 'package:flutter/material.dart';

import '../../utils/screenSizeUtil.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'Login/GoogleLogin/google_login.dart';


class signingUP extends StatefulWidget {
  const signingUP({super.key});

  @override
  State<signingUP> createState() => _signingUPState();
}


class _signingUPState extends State<signingUP> {

  // final viewModel = MainViewModel(KakaoLogin());

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user)  {
      if (user != null) { // 회원가입된 유저가 있다면
          Navigator.push(context, MaterialPageRoute(builder: (context) => defaultAccount()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);
    return Scaffold(
      backgroundColor: const Color(0xffFFFDF3),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                      child : StreamBuilder<User?>(
                        // login 되고 안되고에 따라 새로운 stream이 들어옴.
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (context, snapshot) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.09,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.85,
                                  height : screenHeight * 0.09,
                                  child: Text(
                                    '로그인하고\n시간은행 시작하기.',
                                    style: TextStyle(
                                      color: Color(0xFF4B4A48),
                                      fontSize: 25,
                                      fontFamily: 'Noto Sans KR',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.27,
                                ),
                                // InkWell(
                                //   onTap: () async {
                                //      await KakaoLogin().signInWithKakao();
                                //     // await KakaoLogin.initiateLogin(context);
                                //     // viewModel.login();
                                //     print("카카오 로그인");
                                //   },
                                //   child: Image.asset("assets/images/kakao_login_large_wide.png"),
                                // ),
                                SizedBox(
                                  height: screenHeight * 0.024,
                                ),
                                InkWell(
                                  onTap: () {
                                    signInWithGoogle();
                                    print("구글 로그인");
                                  },
                                  child: Image.asset('assets/images/google_login_wide.png')
                                ),
                              ]
                          );
                        }
                      )
                  )
              ),
              // ElevatedButton(
              //   child: const Text(
              //     '다음',
              //   ),
              //   onPressed: () {
              //     setState(() {
              //       Navigator.of(context).push(
              //           MaterialPageRoute(builder: (context) => defaultAccount()));
              //     });
              //   },
              // ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
