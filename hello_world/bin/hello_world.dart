import 'dart:io';

import 'package:hello_world/hello_world.dart' as hello_world;

void main(List<String> arguments) {
  print('Hello world: ${hello_world.calculate()}!');
  List marks = [2, 3, 4, 5];

  for (int i = 0; i < marks.length; i++) {
    //print(marks[i]);
    marks[i] % 2 == 0 ? print('Четное') : print('Нечетное');
  }

  for (var mark in marks) {}

  //Map<String, int> peoples = {"Дмитрий": 19, "Матвей": 20};
  //Set<int> ages = {10, 10, 10, 20, 43, 34};

  /*peoples.forEach((key, value) {
    print("$key $value");
  });

  for (int j = 0; j < ages.length; j++) {
    ages.add(j);
    print(ages.elementAt(j));
  }*/
}
