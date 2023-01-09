import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen(
      {super.key,
      required this.orderId,
      required this.paymentId,
      required this.signature});
  final String orderId;
  final String paymentId;
  final String signature;

  @override
  Widget build(BuildContext context) {
    onTap(String orderId, String paymentId, String signature) async {
      String textToCopy = json.encode(
          {orderId: orderId, paymentId: paymentId, signature: signature});

      Clipboard.setData(ClipboardData(text: textToCopy)).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Copied to your clipboard !')));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Successful Screen"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'PaymentID: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    TextSpan(
                      text: paymentId,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'OrderID: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    TextSpan(
                      text: orderId,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                maxLines: 1,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Signature: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextSpan(
                      text: signature,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => onTap(orderId, paymentId, signature),
                child: const Text("Copy to Clipboard"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
