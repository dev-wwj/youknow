import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:youknow/global.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<StatefulWidget> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于我们'),
      ),
      body: SafeArea(
        child: SizedBox(
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
              FutureBuilder(
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(snapshot.requireData);
                  } else {
                    return const SizedBox(
                      height: 40,
                    );
                  }
                },
                future: _version(),
              ),
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

  Future<String> _version() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String varsion = packageInfo.version;
    return '朵朵学字 v$varsion';
  }

  void _sendEmail() {
    final Email email = Email(
      body: '...',
      subject: '朵朵学字',
      recipients: ['fyddwwj@hotmail.com'],
      isHTML: false,
    );
    FlutterEmailSender.send(email);
  }
}
