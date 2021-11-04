import 'package:flutter/material.dart';

class SelectionData extends ChangeNotifier{
  int secs = 0;
  int mins = 0;
  int hrs = 0;
  int rep = 1;

  bool isPlaying = true;

  void updateSecs(value){
    secs = value;
    notifyListeners();
  }

  void updateMins(value){
    mins = value;
    notifyListeners();
  }

  void updateHrs(value){
    hrs = value;
    notifyListeners();
  }

  void updateReps(value){
    rep = value;
    notifyListeners();
  }

  void updatePlayingStatus(){
    isPlaying = !isPlaying;
    notifyListeners();
  }
}