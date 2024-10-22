import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(
        {
          "type": "service_account",
          "project_id": "gym-mate-86c8a",
          "private_key_id": "8ec8c1aff1553eb0f2b0df579328d83bc3b534da",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDiyV1WGXnoI/RL\nl2hfqBh4HfC4M2R0Pl4CWtydLNNJmJOmGLFUZePtDBZayT890oe1r3cG9SwXDTOh\nnX18FmBx+81aNA4Ed3xY0cXECEvSml8N16o0gowoDzYSg+473Fjx8gBxbjR2GbBF\nRXqgWgomFxLin9ScCMAHPWirK3QIodPNiBM5dCkkiiZ3lYXAqlJY2YxAXaHSjd+M\npApExxE3PJQh1KqPe5ACRscFCAvNFBS2EKtPCTc7geacGhHs1JVBiAU1LRdHYenX\nHk88GgCDu1qEwTtCCWuH5WYhZ9i7vMb2UjbcvI0oowESfmMuHU0EUNthFxD8d76f\nnqcQoDndAgMBAAECggEAGvXTSbwHmQhFL4NVXiHOnuD4T/2UEJmldWQ1292LVLF1\nxAYldqISQYjxU2OfSAsyJPAyFzqoPilMnQbq9wh1+Lb1h6auj+tgdfKiLxbJZMUD\nTdL4oftvDAga5oKWnLkqPcEGOnXeeLe/E80ZsdxiXnrZvOVBUjdcFMBBJDArQCc7\nikfLY5tYyWawoAuPyB3pjl96KcfeF/Qv8a/zmtSAfUuwrh/7pRqYLlYyu2GUKqOx\n+KSZlMsUBs6XjkeiBCaaObelItM9kPioU/fr66khIitMQeg5DqX8jc0LTVJJVjIf\nxKb9AwJYEsg+6ZYI3vJfUrpg4lfhBpv1k7p4zwWORQKBgQD0Tj1dVbSPMav7j1r1\nHVLCArZiPFfyqng6D4sX5X4JZbeMAgIkQ4GwucvMu9hDPCpQZPef54jj/+0r//wa\nYt8KGWExSDSSrIxa+ZNIHSStQY1blUCfJod8F4c3ndNZEEgWzr16bZibgh9MYyBg\nNVOU1bWBjgdV+oFCEDbCJxp3MwKBgQDtpHGXxzQBfm9Nas1RAHkOqvGg/NNAKqvQ\nE8okhXaYPOUkt5tDqDOpKuU060zHilAqoHcLjkCmwzurskHngtdmaR31/AHvfH+f\nmkYPxsO/pg4b8VwKHydFswSbMpj6i17v39vrIES749FcPFTlEj7JAJT9NKikOIIg\n9g3PxJxKrwKBgQDayB5IMXJrMe50b6LjE4mDWO5/9s5D8MmOJVFI6yn9vGutJDdK\nxnGkFB8gj7BSNdUm/eSL/Msoc46v8qSP9K8M2kGh4qnCGGfxKMPutrqbtbKjq3ud\niuGWDXP4KIyWm/ATDL2+n9skmFjzDWp2/gqFpQTQqqKDKr0Krn57TI105QKBgEgg\nWAW8BTHK4Rc7KjPCk/t6sLmu4qMgEGOoDftFsrgEC3w4adyACaX3ifekzvnlJe26\nJEeSllbG/K5g/RW6JYxErT5CjYfVXprfZRJWvoTFbpTWjZvY1r+V1PkRw1KPyHG/\nnOzhL1tjiuCWwyF/hyTUk2PCfsjRCdXdOFXuE42rAoGBAK4muxtrYeEAVFO9rC9m\ngCRkaHDvnAF+QCDGMj16z143Sb7UGSHcSUpYHJ7SsZw/P86WTDh6f4bN8qOWYnrB\nRJDISr62/j3Jzq4zQ8s905YEGeAP2JPre0WqjOoCn9fHIgFs/BSU8Tt8vMwQE4xH\nRD4Rfc/jcmtNvoPosYflsuOg\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-kcnsy@gym-mate-86c8a.iam.gserviceaccount.com",
          "client_id": "112134549011030264242",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-kcnsy%40gym-mate-86c8a.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        },
      ),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
