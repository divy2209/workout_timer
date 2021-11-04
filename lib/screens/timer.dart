import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:workout_timer/screens/selection.dart';
import 'package:workout_timer/services/button_labels.dart';
import 'package:workout_timer/widgets/button.dart';

class TimerScreen extends StatefulWidget {
  final int hr;
  final int min;
  final int sec;
  final int rep;
  const TimerScreen({Key? key, required this.hr, required this.min, required this.sec, required this.rep}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> with TickerProviderStateMixin{
  late AnimationController controller;
  double progress = 1.0;

  int t = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(hours:widget.hr*widget.rep, seconds: widget.sec*widget.rep+1, minutes: widget.min*widget.rep));
    controller.reverse(from: controller.value==0 ? 1.0 : controller.value);

    controller.addListener(() {
      if(controller.isAnimating){
        if(t-(1-controller.value)*widget.rep<0){
          t++;
          notify();
        }
        setState(() {
          progress = t-(1-controller.value)*widget.rep;
        });
      } else {
        notify();
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(seconds: 1),
                reverseTransitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (_,__,___) => SelectionScreen(hr: widget.hr, min: widget.min, sec: widget.sec, rep: widget.rep-1,)
            )
            //MaterialPageRoute(builder: (context)=>SelectionScreen(hr: widget.hr, min: widget.min, sec: widget.sec, rep: widget.rep-1,))
        );
      }
    });
  }

  void notify(){
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      volume: 0.8,
    );
  }

  Widget get countText{
    Duration count = Duration(hours: widget.hr, minutes: widget.min, seconds: widget.sec) * progress;
    /*return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: "hr${widget.hr}",
          child: Text((count.inHours%24).toString().padLeft(2,'0'), style: const TextStyle(color: Colors.white, fontSize: 45)),
        ),
        const Text(" : ", style: TextStyle(color: Colors.white, fontSize: 45)),
        Hero(
          tag: "min${widget.min}",
          child: Text((count.inMinutes%60).toString().padLeft(2,'0'), style: const TextStyle(color: Colors.white, fontSize: 45)),
        ),
        const Text(" : ", style: TextStyle(color: Colors.white, fontSize: 45)),
        Hero(
          tag: "sec${widget.sec}",
          child: Text((count.inSeconds%60).toString().padLeft(2,'0'), style: const TextStyle(color: Colors.white, fontSize: 45)),
        )
      ],
    );*/
    return Text("${(count.inHours%24).toString().padLeft(2,'0')} : ${(count.inMinutes%60).toString().padLeft(2,'0')} : ${(count.inSeconds%60).toString().padLeft(2,'0')}", style: const TextStyle(color: Colors.white, fontSize: 45));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.black,
        child: SizedBox(
          height: 130,
          child: Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(label: ButtonLabels.stop, controller: controller,),
              const SizedBox(width: 40),
              Button(label: ButtonLabels.pause, controller: controller,),
            ],
          )),
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey.shade300,
                strokeWidth: 6,
                value: progress,

              ),
            ),
            AnimatedBuilder(
              animation: controller,
              builder: (context, child){
                return countText;
              },
            )
          ],
        ),
      ),
    );
  }
}
