import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:logging/logging.dart';

class SignalR extends StatefulWidget {
  const SignalR({Key? key}) : super(key: key);

  @override
  State<SignalR> createState() => _SignalRState();
}

class _SignalRState extends State<SignalR> {
  final String serverUrl = "https://topbantz.com/chatHub";
  late HubConnection hubConnection;
  late Logger hubProtLogger;
  late Logger transportProtLogger;
  late HttpConnectionOptions httpOptions;

  @override
  void initState() {
    super.initState();

    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      log('${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    Logger hubProtLogger = Logger("SignalR - hub");
    transportProtLogger = Logger("SignalR - transport");
    httpOptions = HttpConnectionOptions(logger: transportProtLogger);

    hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl, options: httpOptions)
        .configureLogging(hubProtLogger)
        .build();
    connectToHub();
  }

  @override
  void dispose() {
    super.dispose();
    hubConnection.onclose(({Exception? error}) {
      log(error.toString());
    });
  }

  void connectToHub() async {
    try {
      await hubConnection.start();
      log('Success');
    } catch (e) {
      log(e.toString());
    }
  }

  sendAMessage() async {
    final result = await hubConnection.invoke(
      "sendAMessage",
      args: [
        {
          'content': "Hi, how are you?",
          'sender': "TopBantz",
        }
      ],
    );
    log("Result: '$result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Center(
          child: InkWell(
            onTap: () {
              sendAMessage();
            },
            child: Container(
              height: 100,
              width: 100,
              color: CustomColors.themeColor,
            ),
          ),
        )
      ],
    ));
  }
}
