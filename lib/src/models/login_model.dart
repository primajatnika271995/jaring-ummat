class AccessToken {
  final String access_token;
  final String token_type;
  final String refresh_token;
  final int expires_in;
  final String scope;
  final String jti;

  AccessToken({this.access_token, this.token_type, this.refresh_token, this.expires_in, this.scope, this.jti});

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
        access_token: json['access_token'],
        token_type: json['token_type'],
        refresh_token: json['refresh_token'],
        expires_in: json['expires_in'],
        scope: json['scope'],
        jti: json['jti']
    );
  }
}
