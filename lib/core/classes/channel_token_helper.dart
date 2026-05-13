import 'package:encrypt/encrypt.dart' as encrypt;

class ChannelTokenHelper {
  static String encryptToken(String plainText, String sharedSecret) {
    // Pad or trim sharedSecret to 32 bytes for AES-256
    final key =
        encrypt.Key.fromUtf8(sharedSecret.padRight(32).substring(0, 32));
    final iv = encrypt.IV.fromLength(16); // zero IV (like C#)
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'),
    );
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static String decryptToken(String encryptedText, String sharedSecret) {
    final key =
        encrypt.Key.fromUtf8(sharedSecret.padRight(32).substring(0, 32));
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'),
    );
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}
