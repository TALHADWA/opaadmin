import 'dart:convert';


import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
// import 'package:nutrition_app/BaseHelper/basehelper.dart';
// import 'package:nutrition_app/notifications/call.dart';

// import 'package:googleapis/servicecontrol/v1.dart'as servicecontrol;
import 'package:googleapis_auth/auth_io.dart' as auth;

class Notificationss {
  static Future<String> getaceessToken() async {
    final serviceaccount = {
  "type": "service_account",
  "project_id": "opa-need",
  "private_key_id": "a9f3e1708ee771cec3ae708a13c2e5464c0d97d9",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDA0IWMMzgoywMA\nY9bsD3wRr//t9nWJXYt4UtbgJmGEDlGlYzjL1q7WRmETivb5ZY1FnnyV6y3eY0sY\n0BGYVp57Tpz/NL5sEyBeRf885Eq8Z0xhoO6PWE/P/DKWHNmuKFNauS/4cg1QjPRN\npfrppojTyNr+4opsYy2Y9mtvWLEFoedoM3adZkSHvw+rWWWYg+Di5gBIgKhzGN84\nfPs8rXNexrxkQWrOoTrymGJROhPmSGwIb2lWiGSz5ULLG+CZu5wZsDETAGskKUvf\nB+T5eTfM/quKkNmvmetsi89pS159GF6pLpCQw57lByXTNhCKR0Sn9KXXlPldiEuZ\n/AaIAZMJAgMBAAECggEAKjZ8xnEAPo4TniY9i3joZMbvdR2cJfLA8hrQyEoe11Z7\nMYZDjPz3UhoebrTh1UASaceE5x2R8Toz2r7S21M7ZyuS25ykg+y8DWettZsVcaH7\n6vPcxq1C6/n+6TZvwd06QoaAphfyKkxxv/4yrKy1EAjNSTg3rfsYpIBujPYR63Vh\nXbwn4mIMEnnr+iw/vH1Kfgkb6sJrmkcKiA7+Z5C1COmYQGPsU3gO7jcOEnrgwYKP\np8CaWEFrn+dKNqAVusoKNJlGS0vu3weo2t3YbYPLHwb7tBrHOmXjsZVXCiIc3UF4\n2wTucQUdWkiWQbCKtU2UgcRaniRa2a1PAyeyhX6HMQKBgQDopAsaMlHYKTI2PrIU\np911nQYyLBcEEroJSjotcvN9AFa1AvMGfAwqpwTgmrPWJ4D9zHJ60BIyJw1a5HTW\ndqbL9/ZV1MMPSZwr1C/S2SyzBCo0zKdk8hbx+24BimeYCLMOT+FfcT334Ppu91g8\nCvIQOIMbnn8bRl+krG2oVY0n2wKBgQDULMHYso6QHaPt1Y/NQFnJfefoBS0URTP/\n+6atIHSUx1/OrYZnVLdrrZn/Al9b2x/oO9c2KgsTMhTjcSNt3ACGyfOdEhgQys4S\nprybPLMivqhzsHNH+JXHR2soKWDUz6KCuflzP0oEYIJSC6I64PXS4sKbqfAYgVpP\n/hC6mTUH6wKBgQCCvq7+qgkVUxHFKrcqpKzxzK4OxHiq8VtcnTrVECWHuwj/8ghj\nPJQZ5IP5NvibAtibyqsMGqQfS5NV4c9IOKbFOzZWRpzZmqUKfNXjyeo1McIGqn3p\nXaVHmebZNs/BwiHfiUVAPoR1KxuUAa61D/G67AfDHfCRg5t9EOsQEASkwQKBgGP6\n2zVjnm4mqXKPKf4MDsM1wyvAFKfynDhJuxblrknVUT4w4p6aevwQh/p0gb7lGLn0\nSMtLMIDRHqq2S32fJ9hcHaGsPw7aohSD4Wg9SCRdNz+crBYD+4A2FTaNmQVu+iMj\nw3odHqHFYGOM+9tG2k+PbyivAWZqvcXn8LYdL7IVAoGBAJrFaQv5T0WgjgYuK7SZ\nHTsQTz0ds7jkcaUasoVcAvlk2ulh3A/mEGvFVRLQ1vmncL2HKAT/gKoZTePGyPsI\nrjCODFSHB5M5m4jXLVpIISfqNTKCJA3b48ECTLbi/p58Ff5W29lkEOm2xdo/J3ep\nAGEFjhbHY88XcsLbUJhjIZhZ\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-fbsvc@opa-need.iam.gserviceaccount.com",
  "client_id": "115084493175421169037",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40opa-need.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
};

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/userinfo.email"
    ];
    http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceaccount), scopes);
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceaccount),
            scopes,
            client);
    client.close();
    return credentials.accessToken.data;
  }

  static sendnotification(String? tokens, String? name, String message,
      BuildContext context) async {
    final String token = await getaceessToken();
    print("talha new token $token");

    try {
      http.Response response = await http.post(
        Uri.parse(
            "https://fcm.googleapis.com/v1/projects/opa-need/messages:send"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
          <String, dynamic>{
            'message': {
              'token':
                  tokens, // Assuming token is the device registration token
              'notification': {
                'body': message,
                'title': name,
              },
              'android': {
                'notification': {
                  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                },
              },
              'data': {
                'type': "message",
                'sendedby': "",
              },
            },
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('Error sending FCM message: $e');
    }
  }
}