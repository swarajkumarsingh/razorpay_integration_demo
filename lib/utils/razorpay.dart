
import 'package:flutter/material.dart';
import 'package:razorpay_integration/screens/payment_success_screen.dart';
 navigateToPaymentScreen(
    BuildContext context,
    String orderId,
    String paymentId,
    String signature,
  ) =>
      {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentSuccessScreen(
              orderId: orderId,
              paymentId: paymentId,
              signature: signature,
            ),
          ),
        )
      };

void showAlertDialog(BuildContext context, String title, String message) {
  // set up the buttons
  Widget continueButton = ElevatedButton(
    child: const Text("Continue"),
    onPressed: () => Navigator.pop(context),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
