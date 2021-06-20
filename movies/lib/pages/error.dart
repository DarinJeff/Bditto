import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetryPressed;

  const Error({Key? key, required this.errorMessage, required this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle buttonText = const TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold);
    String errorText = "Oops! Something went wrong, please check your internet connection and try again";
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(errorText, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center,),
            const SizedBox(height: 15),
            Text(errorMessage,style: buttonText, textAlign: TextAlign.center),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orange),
              child: const Text('RETRY', style: TextStyle(color: Colors.black, letterSpacing: 2)),
              onPressed: onRetryPressed,
            )
          ],
        ),
      ),
    );
  }
}