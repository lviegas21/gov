import 'package:flutter_appauth/flutter_appauth.dart';

class AuthTokens {
  final String accessToken;
  final String? refreshToken;
  final String? idToken;
  final DateTime? accessTokenExpirationDateTime;

  AuthTokens({
    required this.accessToken,
    this.refreshToken,
    this.idToken,
    this.accessTokenExpirationDateTime,
  });
}

class AuthService {
  static const String clientId = 'flutter-app';
  static const String redirectUrl = 'br.com.lucas.authlab://callback';
  static const String issuer =
      'https://treat-motor-phantom-seemed.trycloudflare.com/realms/lab-realm';
  static const List<String> scopes = ['openid', 'profile', 'email'];

  final FlutterAppAuth _appAuth = const FlutterAppAuth();

  Future<AuthTokens?> login() async {
    final AuthorizationTokenResponse? result =
        await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        clientId,
        redirectUrl,
        issuer: issuer,
        scopes: scopes,
      ),
    );

    if (result == null || result.accessToken == null) {
      return null;
    }

    return AuthTokens(
      accessToken: result.accessToken!,
      refreshToken: result.refreshToken,
      idToken: result.idToken,
      accessTokenExpirationDateTime: result.accessTokenExpirationDateTime,
    );
  }

  Future<AuthTokens?> refresh(String refreshToken) async {
    final TokenResponse? result = await _appAuth.token(
      TokenRequest(
        clientId,
        redirectUrl,
        issuer: issuer,
        refreshToken: refreshToken,
        scopes: scopes,
      ),
    );

    if (result == null || result.accessToken == null) {
      return null;
    }

    return AuthTokens(
      accessToken: result.accessToken!,
      refreshToken: result.refreshToken ?? refreshToken,
      idToken: result.idToken,
      accessTokenExpirationDateTime: result.accessTokenExpirationDateTime,
    );
  }

  Future<void> logout({String? idTokenHint}) async {
    await _appAuth.endSession(
      EndSessionRequest(
        idTokenHint: idTokenHint,
        postLogoutRedirectUrl: redirectUrl,
        issuer: issuer,
      ),
    );
  }
}
