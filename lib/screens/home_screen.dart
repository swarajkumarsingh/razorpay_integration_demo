import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:razorpay_integration/constants/constants.dart';
import 'package:razorpay_integration/utils/razorpay.dart';
import 'package:razorpay_integration/utils/utils.dart';

import 'package:razorpay_integration/widgets/custom_text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController keyIdController = TextEditingController();
    TextEditingController orderIdController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Razorpay Demo Application"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //! [ KeyID TextField ]
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(20.0),
                child: NameTextField(
                  text: "Enter razorpay KeyId",
                  controller: keyIdController,
                ),
              ),
              //! [ OrderID TextField ]
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(20.0),
                child: NameTextField(
                  text: "Enter razorpay orderId",
                  controller: orderIdController,
                ),
              ),
              //! [ Payment Button ]
              ElevatedButton(
                onPressed: () async {
                  try {
                    String myOrderId = orderIdController.text != ""
                        ? orderIdController.text
                        : RazorpayConstants.orderId;
                    String myKeyId = keyIdController.text != ""
                        ? keyIdController.text
                        : RazorpayConstants.keyId;

                    Razorpay razorpay = Razorpay();
                    var options = {
                      'key': myKeyId,
                      'amount': 100,
                      'name': 'Acme Corp.',
                      'description': 'Fine T-Shirt',
                      'retry': {'enabled': true, 'max_count': 1},
                      'order_id': myOrderId,
                      'send_sms_hash': true,
                      'prefill': {
                        'contact': '8888888888',
                        'email': 'test@razorpay.com'
                      },
                      'external': {
                        'wallets': ['paytm']
                      }
                    };
                    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (response) {
                      showAlertDialog(context, "Payment Failed",
                          "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
                    });
                    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (res) {
                      navigateToPaymentScreen(
                        context,
                        res.orderId,
                        res.paymentId,
                        res.signature,
                      );
                    });
                    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (response) {
                      showAlertDialog(context, "External Wallet Selected",
                          "${response.walletName}");
                    });
                    razorpay.open(options);
                  } catch (e) {
                    return RazorpayUtils.showCustomToast(RazorpayConstants.defaultErrorMsg);
                  }
                },
                child: const Text("Pay with Razorpay"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
