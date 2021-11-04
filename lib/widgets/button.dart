import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer/screens/selection.dart';
import 'package:workout_timer/screens/timer.dart';
import 'package:workout_timer/services/button_labels.dart';
import 'package:workout_timer/services/data_provider.dart';

class Button extends StatelessWidget {
  final String label;
  final AnimationController? controller;
  const Button({Key? key, required this.label, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionData>(
      builder: (_,data,__){
        return SizedBox(
          height: 70,
          width: 70,
          child: FloatingActionButton(
              heroTag: label,
              onPressed: (data.secs==0 && data.mins==0 && data.hrs==0) ? null : (){
                if(label==ButtonLabels.start){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(seconds: 1),
                        reverseTransitionDuration: const Duration(milliseconds: 400),
                        pageBuilder: (_,__,___) => TimerScreen(hr: data.hrs, min: data.mins, sec: data.secs, rep: data.rep,)
                    )
                    //MaterialPageRoute(builder: (context)=>TimerScreen(hr: data.hrs, min: data.mins, sec: data.secs, rep: data.rep,))
                  );
                } else if(label==ButtonLabels.pause){
                  if(controller!.isAnimating){
                    controller!.stop();
                  } else {
                    controller!.reverse(from: controller!.value==0 ? 1.0 : controller!.value);
                  }
                  data.updatePlayingStatus();
                } else if(label==ButtonLabels.stop){
                  if(controller!.isAnimating){
                    controller!.stop();
                  } else {
                    data.updatePlayingStatus();
                  }
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(seconds: 1),
                        reverseTransitionDuration: const Duration(milliseconds: 400),
                        pageBuilder: (_,__,___) => SelectionScreen(hr: data.hrs, min: data.mins, sec: data.secs, rep: data.rep-1,)
                    )
                    //MaterialPageRoute(builder: (context)=>SelectionScreen(hr: data.hrs, min: data.mins, sec: data.secs, rep: data.rep-1,))
                  );
                }
              },
              backgroundColor: Colors.white.withOpacity(0.16),
              splashColor: Colors.white.withOpacity(0.1),
              elevation: 0,
              child: label==ButtonLabels.start ? const Center(
                child: Icon(
                  FontAwesomeIcons.play,
                  size: 20,
                  color: Colors.blue,
                ),
              ) : (label==ButtonLabels.pause ? Center(
                child: Icon(
                  data.isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                  size: 20,
                  color: Colors.blue,
                ),
              ) : const Center(
                child: Icon(
                  FontAwesomeIcons.stop,
                  size: 20,
                  color: Colors.blue,
                ),
              ))
          ),
        );
      },
    );
  }
}
