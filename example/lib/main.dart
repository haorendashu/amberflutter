import 'package:flutter/material.dart';
import 'package:amberflutter/amberflutter.dart';
import 'package:nostr/nostr.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AmberFlutter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final amber = Amberflutter();
  String _package = '';
  String _npub = '';
  String _pubkeyHex = '';
  String _text = '';
  String _cipherText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AmberFlutter Example',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FilledButton(
              onPressed: () {
                amber.isAndroidSignerInstalled().then((value) {
                  setState(() {
                    _text = 'isAndroidSignerInstalled? $value';
                  });
                });
              },
              child: const Text('IsAndroidSignerInstall ?'),
            ),
            FilledButton(
              onPressed: () {
                amber.getPublicKey(
                  permissions: [
                    const Permission(
                      type: "nip04_encrypt",
                    ),
                    const Permission(
                      type: "nip04_decrypt",
                    ),
                  ],
                ).then((value) {
                  _package = value['package'] ?? '';
                  _npub = value['signature'] ?? '';
                  _pubkeyHex = Nip19.decodePubkey(_npub);
                  setState(() {
                    _text = '$value';
                  });
                });
              },
              child: const Text('Get Public Key'),
            ),
            FilledButton(
              onPressed: () {
                final eventJson = jsonEncode({
                  'id': '',
                  'pubkey': Nip19.decodePubkey(_npub),
                  'kind': 1,
                  'content': 'Hello from Amber Flutter!',
                  'created_at':
                      (DateTime.now().millisecondsSinceEpoch / 1000).round(),
                  'tags': [],
                  'sig': '',
                });

                amber
                    .signEvent(
                  currentUser: _npub,
                  eventJson: eventJson,
                  package: _package,
                )
                    .then((value) {
                  setState(() {
                    _text = '$value';
                  });
                });
              },
              child: const Text('Sign Event'),
            ),
            FilledButton(
              onPressed: () {
                amber
                    .nip04Encrypt(
                  plaintext: "Hello from Amber Flutter, Nip 04!",
                  currentUser: _npub,
                  pubKey: _pubkeyHex,
                  package: _package,
                )
                    .then((value) {
                  _cipherText = value['signature'] ?? '';
                  setState(() {
                    _text = '$value';
                  });
                });
              },
              child: const Text('Nip 04 Encrypt'),
            ),
            FilledButton(
              onPressed: () {
                amber
                    .nip04Decrypt(
                  ciphertext: _cipherText,
                  currentUser: _npub,
                  pubKey: _pubkeyHex,
                  package: _package,
                )
                    .then((value) {
                  setState(() {
                    _text = '$value';
                  });
                });
              },
              child: const Text('Nip 04 Decrypt'),
            ),
            FilledButton(
              onPressed: () {
                amber
                    .nip44Encrypt(
                  plaintext: "Hello from Amber Flutter, Nip 44!",
                  currentUser: _npub,
                  pubKey: _pubkeyHex,
                  package: _package,
                )
                    .then((value) {
                  _cipherText = value['signature'] ?? '';
                  setState(() {
                    _text = '$value';
                  });
                });
              },
              child: const Text('Nip 44 Encrypt'),
            ),
            FilledButton(
              onPressed: () {
                amber
                    .nip44Decrypt(
                  ciphertext: _cipherText,
                  currentUser: _npub,
                  pubKey: _pubkeyHex,
                  package: _package,
                )
                    .then((value) {
                  setState(() {
                    _text = '$value';
                  });
                });
              },
              child: const Text('Nip 44 Decrypt'),
            ),
            Text(_text),
          ],
        ),
      ),
    );
  }
}
