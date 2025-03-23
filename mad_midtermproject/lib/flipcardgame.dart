import 'dart:developer';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mad_midtermproject/box.dart';
import 'package:mad_midtermproject/homeScreen.dart';
import 'package:quickalert/quickalert.dart';
import 'data.dart';
import 'dart:async';

class FlipCardGame extends StatefulWidget {
  final Level _level;  FlipCardGame(this._level);
  @override
  _FlipCardGameState createState() => _FlipCardGameState(_level);
}

class _FlipCardGameState extends State<FlipCardGame> {
  _FlipCardGameState(this._level);

  Level _level;
  int _previousIndex = -1;
  bool _flip = false;
  bool _start = false;
  bool _wait = false;

  Timer? _timer;
  int _elapsedSeconds = 0;
  
  var highScore;

  late bool _isFinished;
  late int _left;
  late List<String> _data;
  late List<bool> _cardFlips;
  late List<GlobalKey<FlipCardState>> _cardStateKeys;

  Widget getItem(int index) { 
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
              spreadRadius: 0.8,
              offset: Offset(2.0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(4.0),
      child: Image.asset(_data[index]),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.check_circle_outline_rounded),
        title: const Text("FilipiKnows"),
        centerTitle: true,
       backgroundColor: Colors.brown[200],
      foregroundColor: Colors.white,
        actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                     Navigator.of(context).pop( CupertinoPageRoute(  builder: (_) => HomeScreen()));
                  },
                ),
              ],
      ),
      body: _isFinished
        ? Scaffold(  
            body: Center( 
              child: GestureDetector(
                onTap: () => restart(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column( mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                     Container(    
                      decoration: BoxDecoration(
                            color: Colors.brown[500], 
                            borderRadius: BorderRadius.circular(50) 
                           ),
                            child: ListTile(
                            title: const Center(child: Text('Play Again',
                            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold))),  
                            onTap: () => restart(),

                           ),), 
                          SizedBox(height: 15),
                              Container( decoration:   BoxDecoration(
                                  color: Colors.brown[200], 
                                  borderRadius: BorderRadius.circular(50), 
                                ),
                              child: ListTile( 
                              title: const Center(child: Text('Home',
                              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),)),
                              onTap: () {
                                print("tapped");
                                  Navigator.of(context).pop(
                                  CupertinoPageRoute(
                                    builder: (_) => HomeScreen()));
                              },
                            ),
                          ), 
                  ],
              ),
            )
              ),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(  
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column( crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                               Text('Pairs Left: $_left',style: Theme.of(context).textTheme.headlineSmall), 
                               Text('Time: $_elapsedSeconds seconds',style: Theme.of(context).textTheme.headlineSmall),
                              ],
                            ),
                    ),
                   Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics:  const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          if (!_start) { 
                            return getItem(index);
                          }
                        return FlipCard( 
                            key: _cardStateKeys[index],
                            onFlip: () {
                              if (!_flip) {
                                _flip = true;
                                _previousIndex = index;
                              } else {
                                _flip = false;
                                if (_previousIndex != index) {
                                  if (_data[_previousIndex] != _data[index]) 
                                  { //cards DONT match po
                                    _wait = true;
                                    Future.delayed(const Duration(milliseconds: 1000), () { 
                                      _cardStateKeys[_previousIndex].currentState!.toggleCard(); 
                                      _previousIndex = index;
                                      _cardStateKeys[_previousIndex].currentState!.toggleCard();
                                      Future.delayed(const Duration(milliseconds: 150), () { 
                                        setState(() {
                                          _wait = false; 
                                        });
                                      });
                                    });
                                  } 
                                  else {  
                                    _cardFlips[_previousIndex] = false;
                                    _cardFlips[index] = false;
                                    setState(() {
                                      _left -= 1; 
                                    });
                                    if (_cardFlips.every((t) => t == false)) { 
                                      if (highScore == null || _elapsedSeconds < highScore) {
                                        _newHighScore();
                                      }
                                      Future.delayed(const Duration(milliseconds: 800), () {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.success,
                                          title: 'High Score: $highScore seconds',
                                          text: 'Time: $_elapsedSeconds seconds',
                                          confirmBtnColor: Colors.brown,
                                          headerBackgroundColor: Colors.brown,
                                      );
                                        setState(() { print('won');
                                          _isFinished = true;
                                          _start = false;
                                        });
                                        print("Seconds: " + _elapsedSeconds.toString());
                                        _stopTimer();
                                      });
                                    }
                                  }
                                }
                              }
                              setState(() {});
                            },
                            flipOnTouch: _wait ? false : _cardFlips[index],
                            direction: FlipDirection.HORIZONTAL,
                            front: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 3,
                                    spreadRadius: 0.8,
                                    offset: Offset(2.0, 1),
                                  )
                                ]
                              ),
                              margin: EdgeInsets.all(4.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "assets/pics/quest.png",
                                ),
                              ),
                            ),
                            back: getItem(index),
                          );
                        },
                        itemCount: _data.length,
                      ),
                    )
                
                  ],
                ),
              ),
            ),
        ),
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _elapsedSeconds = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  void _getHighScore() {
    if (_level == Level.Easy) {
      highScore = hscore.get("easyHighScore");
    }
    else if (_level == Level.Medium) {
      highScore = hscore.get("mediumHighScore");
    }
    else if (_level == Level.Hard) {
      highScore = hscore.get("hardHighScore");
    }
  }

  void _newHighScore() {
    if (_level == Level.Easy) {
      hscore.put("easyHighScore", _elapsedSeconds);
      highScore = _elapsedSeconds;
    }
    else if (_level == Level.Medium) {
      hscore.put("mediumHighScore", _elapsedSeconds);
      highScore = _elapsedSeconds;
    }
    else if (_level == Level.Hard) {
      hscore.put("hardHighScore", _elapsedSeconds);
      highScore = _elapsedSeconds;
    }
  }

  void _stopTimer() {
    _timer?.cancel();
  }
  
 void restart() {
  _getHighScore();
  _data = getSourceArray(_level).cast<String>(); 
  _cardFlips = getInitialItemState(_level); 
  _cardStateKeys = getCardStateKeys(_level);
  _left = (_data.length ~/ 2); 
  _isFinished = false;

  _cardStateKeys.forEach((key) { 
    key.currentState?.toggleCard();
  });

  setState(() {
    _start = true;
  });

  _startTimer();
}


  @override
  void initState() {
    super.initState();
    restart();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

}

