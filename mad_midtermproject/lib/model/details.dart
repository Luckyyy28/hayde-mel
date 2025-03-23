import 'package:flutter/material.dart';
import '../data.dart';
import '../flipcardgame.dart';

class Details {
  String name; 
  Widget goto;
  
  Details({
     required this.name,
    required this.goto,
  });
}

List<Details> list = [
  Details(
      name: "EASY",
      goto: FlipCardGame(Level.Easy)),
  Details(
      name: "MEDIUM",
      goto: FlipCardGame(Level.Medium)),
  Details(
      name: "HARD",
      goto: FlipCardGame(Level.Hard))
];