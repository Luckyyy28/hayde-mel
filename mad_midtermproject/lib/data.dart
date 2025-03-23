import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

enum Level { Hard, Medium, Easy }

List<String> fillSourceArray() {
  return [
    'assets/pics/kare.png',
    'assets/pics/kare.png',
    'assets/pics/sinigang.png',
    'assets/pics/sinigang.png',
    'assets/pics/adobo.png',
    'assets/pics/adobo.png',
  ];
}

List<String> fillSourceArrayM() {
  return [
    'assets/pics/dingdong.png',
    'assets/pics/dingdong.png',
    'assets/pics/leah.png',
    'assets/pics/leah.png',
    'assets/pics/luna.png',
    'assets/pics/luna.png',
    'assets/pics/rizal.png',
    'assets/pics/rizal.png',
    'assets/pics/wang.png',
    'assets/pics/wang.png',
    'assets/pics/manny.png',
    'assets/pics/manny.png',
  ];
}
List<String> fillSourceArrayH() {
  return [
    'assets/pics/1.png',
    'assets/pics/1.png',
    'assets/pics/2.png',
    'assets/pics/2.png',
    'assets/pics/3.png',
    'assets/pics/3.png',
    'assets/pics/4.png',
    'assets/pics/4.png',
    'assets/pics/5.png',
    'assets/pics/5.png',
    'assets/pics/6.png',
    'assets/pics/6.png',
    'assets/pics/7.png',
    'assets/pics/7.png',
    'assets/pics/8.png',
    'assets/pics/8.png',
    'assets/pics/9.png',
    'assets/pics/9.png',
  ];
}
List<String> getSourceArray(
  Level level,
) {
  List<String> levelAndKindList = <String>[];  
  List<String> sourceArray = fillSourceArray().cast<String>();
  List<String> sourceArrayM = fillSourceArrayM().cast<String>();
  List<String> sourceArrayH = fillSourceArrayH().cast<String>();
  if (level == Level.Hard) {
    for (int i = 0; i < 18; i++) {
      levelAndKindList.add(sourceArrayH[i]);
    }
  } 
  else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      levelAndKindList.add(sourceArrayM[i]);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  }

  levelAndKindList.shuffle();
  return levelAndKindList;
}

List<bool> getInitialItemState(Level level) {
  List<bool> initialItemState = <bool>[]; 
  if (level == Level.Hard) {
    for (int i = 0; i < 18; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      initialItemState.add(true);
    }
  }
  return initialItemState;
}

List<GlobalKey<FlipCardState>> getCardStateKeys(Level level) {
  List<GlobalKey<FlipCardState>> cardStateKeys = <GlobalKey<FlipCardState>>[];  
  if (level == Level.Hard) {
    for (int i = 0; i < 18; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  }
  return cardStateKeys;
}
