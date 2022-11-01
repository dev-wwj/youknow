import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于我们'),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          // color: MyColor.randomLightish(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'resources/images/icon_180.png',
                width: 80,
                height: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('彩虹拼音 v 1.0.0'),
              const SizedBox(
                height: 60,
              ),
              Container(
                width: double.infinity,
                color: MyColor.randomLightish(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text('联系作者'),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            _sendEmail();
                          },
                          child: const Text('fyddwwj@hotmail.com'),
                        ),
                        const MaterialButton(
                          onPressed: null,
                          child: Text('微信：JH-jianr'),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _sendEmail() {
    final Email email = Email(
      body: '...',
      subject: '彩虹拼音',
      recipients: ['fyddwwj@hotmail.com'],
      isHTML: false,
    );
    FlutterEmailSender.send(email);
  }
}
