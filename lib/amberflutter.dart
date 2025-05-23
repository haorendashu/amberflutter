import 'amberflutter_platform_interface.dart';
import 'package:amberflutter/models.dart';

export 'models.dart';

class Amberflutter {
  Future<Map<dynamic, dynamic>> getPublicKey({
    List<Permission>? permissions,
  }) {
    return AmberflutterPlatform.instance.getPublicKey(
      permissions: permissions,
    );
  }

  Future<bool> isAppInstalled() {
    return AmberflutterPlatform.instance.isAppInstalled();
  }

  Future<bool> isAndroidSignerInstalled() {
    return AmberflutterPlatform.instance.isAndroidSignerInstalled();
  }

  Future<Map<dynamic, dynamic>> signEvent({
    required String currentUser,
    required String eventJson,
    String? id,
    String? package,
  }) {
    return AmberflutterPlatform.instance.signEvent(
      currentUser,
      eventJson,
      id,
      package: package ?? "",
    );
  }

  Future<Map<dynamic, dynamic>> nip04Encrypt({
    required String plaintext,
    required String currentUser,
    required String pubKey,
    String? id,
    String? package,
  }) {
    return AmberflutterPlatform.instance.nip04Encrypt(
      plaintext,
      currentUser,
      pubKey,
      id,
      package: package ?? "",
    );
  }

  Future<Map<dynamic, dynamic>> nip04Decrypt({
    required String ciphertext,
    required String currentUser,
    required String pubKey,
    String? id,
    String? package,
  }) {
    return AmberflutterPlatform.instance.nip04Decrypt(
      ciphertext,
      currentUser,
      pubKey,
      id,
      package: package ?? "",
    );
  }

  Future<Map<dynamic, dynamic>> nip44Encrypt({
    required String plaintext,
    required String currentUser,
    required String pubKey,
    String? id,
    String? package,
  }) {
    return AmberflutterPlatform.instance.nip44Encrypt(
      plaintext,
      currentUser,
      pubKey,
      id,
      package: package ?? "",
    );
  }

  Future<Map<dynamic, dynamic>> nip44Decrypt({
    required String ciphertext,
    required String currentUser,
    required String pubKey,
    String? id,
    String? package,
  }) {
    return AmberflutterPlatform.instance.nip44Decrypt(
      ciphertext,
      currentUser,
      pubKey,
      id,
      package: package ?? "",
    );
  }

  Future<Map<dynamic, dynamic>> decryptZapEvent({
    required String eventJson,
    required String currentUser,
    String? id,
    String? package,
  }) {
    return AmberflutterPlatform.instance.decryptZapEvent(
      eventJson,
      currentUser,
      id,
      package: package ?? "",
    );
  }
}
