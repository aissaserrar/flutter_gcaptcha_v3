# How to Check if reCAPTCHA is Ready

This guide explains how to check if the Google reCAPTCHA is loaded and ready to use in the flutter_gcaptcha_v3 package.

## Overview of Changes

The following files have been updated to support checking if reCAPTCHA is ready:

1. `RecaptchaHandler` now has an `isReady` property and a `setReady()` method
2. The HTML file now sends a message when reCAPTCHA is fully loaded
3. The `ReCaptchaWebView` widget now accepts an `onCaptchaReady` callback

## How to Use

### Method 1: Using the `onCaptchaReady` Callback

When creating a `ReCaptchaWebView` widget, you can provide an `onCaptchaReady` callback:

```dart
ReCaptchaWebView(
  url: 'file:///android_asset/${AppConstants.webPage}',
  width: 1,
  height: 1,
  onTokenReceived: (String receivedToken) {
    // Handle token
  },
  onCaptchaReady: () {
    // This will be called when reCAPTCHA is ready
    setState(() {
      isReady = true;
    });
    print('reCAPTCHA is now ready for use!');
  },
)
```

### Method 2: Checking the `isReady` Property Directly

You can also check the ready state at any time by using the `isReady` property on the `RecaptchaHandler`:

```dart
bool captchaReady = RecaptchaHandler.instance.isReady;
```

## Example

A complete example showing how to check and use the ready state is available at:
`example/lib/check_ready_example.dart`

## Best Practices

1. Always check if reCAPTCHA is ready before executing it
2. Disable submission buttons until reCAPTCHA is ready
3. Provide visual feedback to users about the loading status

## Troubleshooting

If the ready callback is not firing:

1. Make sure you have a proper internet connection
2. Verify that your site key is valid
3. Check the console for any JavaScript errors
