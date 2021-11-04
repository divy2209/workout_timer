import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer/services/button_labels.dart';
import 'package:workout_timer/services/data_provider.dart';
import 'package:workout_timer/widgets/button.dart';
import 'package:workout_timer/widgets/vertical_line.dart';

class SelectionScreen extends StatefulWidget {
  final int hr;
  final int min;
  final int sec;
  final int rep;
  const SelectionScreen({Key? key, required this.hr, required this.min, required this.sec, required this.rep}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  late FixedExtentScrollController _controller1;
  late FixedExtentScrollController _controller2;
  late FixedExtentScrollController _controller3;
  late FixedExtentScrollController _controller4;

  final double height = 300;
  final double width = 90;
  final double diameterRatio = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller1 = FixedExtentScrollController(initialItem: widget.hr);
    _controller2 = FixedExtentScrollController(initialItem: widget.min);
    _controller3 = FixedExtentScrollController(initialItem: widget.sec);
    _controller4 = FixedExtentScrollController(initialItem: widget.rep);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SelectionData>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: const BottomAppBar(
        elevation: 0,
        color: Colors.black,
        child: SizedBox(
          height: 130,
          child: Center(child: Button(label: ButtonLabels.start)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: ListWheelScrollView.useDelegate(
                    controller: _controller1,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (value){
                      data.updateHrs(value);
                    },
                    diameterRatio: diameterRatio,
                    itemExtent: 90,
                    overAndUnderCenterOpacity: 0.35,
                    squeeze: 0.9,
                    childDelegate: ListWheelChildLoopingListDelegate(
                        children: List.generate(
                            24, (index) => Hero(
                          tag: "hr$index",
                          child: Text(index.toString().length==1 ? "0" + (index).toString() : (index).toString(), style: const TextStyle(color: Colors.white, fontSize: 45),),
                        )
                        ),
                    ),
                  ),
                ),
                const VerticalLine(),
                SizedBox(
                  height: height,
                  width: width,
                  child: ListWheelScrollView.useDelegate(
                    controller: _controller2,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (value){
                      data.updateMins(value);
                    },
                    diameterRatio: diameterRatio,
                    itemExtent: 90,
                    overAndUnderCenterOpacity: 0.35,
                    squeeze: 0.9,
                    childDelegate: ListWheelChildLoopingListDelegate(
                        children: List.generate(
                            60, (index) => Hero(
                          tag: "min$index",
                          child: Text(index.toString().length==1 ? "0" + (index).toString() : (index).toString(), style: const TextStyle(color: Colors.white, fontSize: 45),),
                        )
                        )
                    ),
                  ),
                ),
                const VerticalLine(),
                SizedBox(
                  height: height,
                  width: width,
                  child: ListWheelScrollView.useDelegate(
                    controller: _controller3,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (value){
                      data.updateSecs(value);
                    },
                    diameterRatio: diameterRatio,
                    itemExtent: 90,
                    overAndUnderCenterOpacity: 0.35,
                    squeeze: 0.9,
                    childDelegate: ListWheelChildLoopingListDelegate(
                        children: List.generate(
                            60, (index) => Hero(
                          tag: "sec$index",
                          child: Text(index.toString().length==1 ? "0" + (index).toString() : (index).toString(), style: const TextStyle(color: Colors.white, fontSize: 45),),
                        )
                        )
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50,),
            SizedBox(
              height: 145,
              width: width,
              child: ListWheelScrollView.useDelegate(
                controller: _controller4,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (value){
                  data.updateReps(value+1);
                },
                diameterRatio: diameterRatio,
                itemExtent: 50,
                overAndUnderCenterOpacity: 0.15,
                squeeze: 1,
                childDelegate: ListWheelChildLoopingListDelegate(
                    children: List.generate(
                        100, (index) => Text((index+1).toString().length==1 ? "0" + (index+1).toString() : (index+1).toString(), style: const TextStyle(color: Colors.white, fontSize: 29),)
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

