import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'flipcardgame.dart';
import 'data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  bool isAudioOn = true; 
  AudioPlayer audioPlayer = AudioPlayer(); 

void playAudio() async {
  await audioPlayer.play((AssetSource('audio/bgm.mp3')));
   audioPlayer.onPlayerComplete.listen((event) {
    audioPlayer.play( AssetSource('audio/bgm.mp3'));
  });
 
}
  void _toggleAudio() async {
    setState(() {
      isAudioOn = !isAudioOn;
    });

    if (isAudioOn) {
       await audioPlayer.resume();
    } else { 
      isAudioOn==false;
      await audioPlayer.pause();
    }
  }

  @override void initState() {
    playAudio();
    super.initState();
  }
  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FilipiKnows'),
        centerTitle: true,
        backgroundColor: Colors.brown[200],
        foregroundColor: Colors.white,
        leading: Icon(Icons.camera_enhance),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: IconButton(
              onPressed: _toggleAudio,
              icon: Icon(isAudioOn ? Icons.volume_up : Icons.volume_off),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/pics/house.png'),
            alignment: Alignment.bottomCenter,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => FlipCardGame(Level.Easy))),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Easy', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('(Dishes)', style: TextStyle(color: Colors.white60, fontSize: 12, fontWeight: FontWeight.w300)),
                    Gap(2),
                    Icon(Icons.star_rounded, color: Colors.yellow),
                  ],
                ),
              ),
              Gap(8),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => FlipCardGame(Level.Medium))),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Medium', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('(Famous Personalities)', style: TextStyle(color: Colors.white60, fontSize: 12, fontWeight: FontWeight.w300)),
                    Gap(2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star_rounded, color: Colors.yellow),
                        Icon(Icons.star_rounded, color: Colors.yellow),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(8),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => FlipCardGame(Level.Hard))),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hard', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('(Traditional Costumes)', style: TextStyle(color: Colors.white60, fontSize: 12, fontWeight: FontWeight.w300)),
                    Gap(2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star_rounded, color: Colors.yellow),
                        Icon(Icons.star_rounded, color: Colors.yellow),
                        Icon(Icons.star_rounded, color: Colors.yellow),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

