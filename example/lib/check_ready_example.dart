// Example showing how to check if the reCAPTCHA is ready
import 'package:flutter/material.dart';
import 'package:flutter_gcaptcha_v3/constants.dart';
import 'package:flutter_gcaptcha_v3/recaptca_config.dart';
import 'package:flutter_gcaptcha_v3/web_view.dart';

class ReCaptchaExample extends StatefulWidget {
  const ReCaptchaExample({Key? key}) : super(key: key);

  @override
  State<ReCaptchaExample> createState() => _ReCaptchaExampleState();
}

class _ReCaptchaExampleState extends State<ReCaptchaExample> {
  bool isReady = false;
  String token = '';

  @override
  void initState() {
    super.initState();
    // Setup your site key
    RecaptchaHandler.instance.setupSiteKey(
      dataSiteKey: "YOUR_RECAPTCHA_SITE_KEY",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('reCAPTCHA Ready Check Example')),
      body: Column(
        children: [
          // Status indicator
          Container(
            padding: const EdgeInsets.all(16),
            color: isReady ? Colors.green : Colors.orange,
            child: Center(
              child: Text(
                isReady ? 'reCAPTCHA is Ready!' : 'reCAPTCHA is Loading...',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Captcha WebView (typically invisible)
          ReCaptchaWebView(
            url:
                'file:///android_asset/${AppConstants.webPage}', // Adjust this based on platform
            width: 1, // Minimal size, usually invisible
            height: 1,
            onTokenReceived: (String receivedToken) {
              setState(() {
                token = receivedToken;
              });
            },
            onCaptchaReady: () {
              // This will be called when reCAPTCHA is ready
              setState(() {
                isReady = true;
              });
              print('reCAPTCHA is now ready for use!');
            },
          ),

          const SizedBox(height: 20),

          // Button to execute captcha
          ElevatedButton(
            onPressed:
                isReady
                    ? () {
                      // Execute the reCAPTCHA
                      RecaptchaHandler.executeV3();
                    }
                    : null, // Disable the button if reCAPTCHA is not ready
            child: const Text('Execute reCAPTCHA'),
          ),

          const SizedBox(height: 20),

          // Display the token
          if (token.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Token:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(token, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),

          // Alternative method to check if reCAPTCHA is ready
          ElevatedButton(
            onPressed: () {
              // You can also check the ready state through the handler
              bool captchaReady = RecaptchaHandler.instance.isReady;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('reCAPTCHA ready state: $captchaReady'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Check Ready State'),
          ),
        ],
      ),
    );
  }
}
