import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:pointycastle/asymmetric/api.dart';

class RSAUtil {

  static String? encrypt(String key, String text) {
    String begin = '-----BEGIN PUBLIC KEY-----\n';
    String end = '\n-----END PUBLIC KEY-----';
    key = begin + key + end;
    final parser = RSAKeyParser();
    RSAAsymmetricKey publicKey = parser.parse(key);
    if (publicKey is RSAPublicKey) {
      Encrypter encrypter = Encrypter(RSA(publicKey: publicKey));
      String cipherText = encrypter.encrypt(text).base64;
      return cipherText;
    }
    return null;
  }

}