import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:suntown/main/mainAccount.dart';

import '../../../utils/screenSizeUtil.dart';

/*
미완_api 요청 실패했을 경우, 띄워야 하는 alert
 */

class ApiRequestFailAlert {
  static Future<void> showExpiredCodeDialog(
      BuildContext context, Widget retryWidget) async {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return showDialog(
        context: context,
        barrierDismissible: false, // 다이얼로그 외부 터치로 닫히지 않도록 설정
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false; // true를 반환하여 AlertDialog가 닫히도록 함
            },
            child: AlertDialog(
              backgroundColor: Color(0xFFFFF6F6),
              contentPadding: EdgeInsets.all(20),
              title: Center(
                child: SizedBox(
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                  child: Image(
                    image: AssetImage('assets/images/knot.png'),
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    '서버와의 연결이 끊어졌습니다.\n다시 시도 해주세요!',
                    style: TextStyle(
                      color: Color(0xFF7D303D8),
                      fontSize: screenWidth * 0.045,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    ElevatedButton(
                      child: Text(
                        '홈으로',
                        style: TextStyle(
                          color: Color(0xFF2C533C),
                          fontSize: screenWidth * 0.045,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                        // 메인 화면으로 이동
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainAccount()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenWidth * 0.3, screenHeight * 0.07),
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Color(0xFFDDE9E2),
                      ),
                    ),
                    ElevatedButton(
                      child: Text(
                        '다시시도',
                        style: TextStyle(
                          color: Color(0xFFDDE9E2),
                          fontSize: screenWidth * 0.045,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                        // 메인 화면으로 이동
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => retryWidget),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenWidth * 0.3, screenHeight * 0.07),
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Color(0xFF2C533C),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}