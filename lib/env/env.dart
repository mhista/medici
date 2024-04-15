import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'GOOGLE_WEB_AUTH')
  static String googleWebAuth = _Env.googleWebAuth;
}
