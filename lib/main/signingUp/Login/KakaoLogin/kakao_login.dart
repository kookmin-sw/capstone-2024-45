import 'package:suntown/main/signingUp/Login/KakaoLogin/login_out.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:flutter/services.dart';
class KakaoLogin implements SocialLogin {


  @override
  Future<bool> login() async {
    try{
      // 카카오톡 설치 여부 확인
      bool isInstalled = await kakao.isKakaoTalkInstalled();

      if (isInstalled){
        // 카카오톡 설치 되어 있으면 진행
        try {
          await kakao.UserApi.instance.loginWithKakaoTalk();
          return true;
        } catch(e) {
          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
          if (e is PlatformException && e.code == 'CANCELED') {
            print('카카오톡으로 로그인 실패 $e');
          }
        }
      } else {
        // 카톡 설치 안되어있으면 카카오 계정으로 진행
        try {
          // kakao.OAuthToken token =
           await kakao.UserApi.instance.loginWithKakaoAccount();
          // var provider = OAuthProvider('oidc.kakao'); // 제공 업체 id
          // print(provider);
          // var credential = provider.credential(
          //   idToken: token.idToken,
          //   // 카카오 로그인에서 발급된 idToken
          //   accessToken: token.accessToken, // 카카오 로그인에서 발급된 accessToken
          // );
          return true;
        } catch(e){
          return false;
        }

      }
      return true;
    }catch(e){
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await kakao.UserApi.instance.unlink();
      return true;
    }catch (error){
      return false;
    }
  }
}