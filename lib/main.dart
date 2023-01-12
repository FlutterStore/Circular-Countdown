import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timer_controller/timer_controller.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Countdown',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late final TimerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TimerController.seconds(15);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CircularCountdown',style: TextStyle(fontSize: 15),),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: TimerControllerListener(
          controller: _controller,
          listenWhen: (previousValue, currentValue) =>
              previousValue.status != currentValue.status,
          listener: (context, timerValue) {},
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TimerControllerBuilder(
                  controller: _controller,
                  builder: (context, timerValue, _) {
                    Color? timerColor;
                    switch (timerValue.status) {
                      case TimerStatus.running:
                        timerColor = Colors.green;
                        break;
                      case TimerStatus.paused:
                        timerColor = Colors.black;
                        break;
                      case TimerStatus.finished:
                        timerColor = Colors.red;
                        break;
                      default:
                    }

                    return Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      spacing: 40,
                      runSpacing: 40,
                      children: <Widget>[
                        Stack(
                          children: [
                            CircularCountdown(
                              diameter: 200,
                              gapFactor: 2,
                              strokeWidth: 100,
                              countdownTotal: _controller.initialValue.remaining,
                              countdownRemaining: timerValue.remaining,
                              countdownCurrentColor: timerColor,
                              countdownRemainingColor:Colors.white,
                              countdownTotalColor: Colors.red,
                            ),
                            CircularCountdown(
                              diameter: 200,
                              countdownTotal: _controller.initialValue.remaining,
                              countdownRemaining: timerValue.remaining,
                              countdownCurrentColor: Colors.transparent,
                              countdownRemainingColor:Colors.transparent,
                              countdownTotalColor: Colors.transparent,
                              textStyle: const TextStyle(
                                color: Colors.blue,
                                fontSize: 50,
                              ),
                            ),
                          ],
                        ),
                        
                      ],
                    );
                  },
                ),
                const Gap(40),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _ActionButton(
                      title: 'Restart',
                      onPressed: () => _controller.restart(),
                    ),
                  ],
                ),
              ],
            ),
          ),
    ),
        ),
      )
    );
  }
}


class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.title,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}