import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class RSAUtil {

  static encrypt(String key, String text) {
    String begin = '-----BEGIN PUBLIC KEY-----\n';
    String end = '\n-----END PUBLIC KEY-----';
    key = begin + key + end;
    final parser = RSAKeyParser();
    RSAPublicKey publicKey = parser.parse(key);
    Encrypter encrypter = Encrypter(RSA(publicKey: publicKey));
    String cipherText = encrypter.encrypt(text).base64;
    return cipherText;
  }

}