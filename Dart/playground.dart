import 'dart:io';

main() {
  String firstName = 'Vijeth';
  String lastName = 'test';
  print(firstName + ' ' + lastName);
  stdout.writeln('Enter name');
  String name = stdin.readLineSync() ?? "";
  print("My name is $name");

  int amount1 = 100;
  dynamic amount2 = 200;

  print('amount $amount1 | amount2 $amount2');

  amount2 = 'test';

  var one = int.parse('1');
  assert(one == 1);
  print(one);

  var onePoint = double.parse('1.1');
  assert(onePoint == 1.1);
  print(onePoint);

  String oneString = 1.toString();
  assert(oneString == '1');
  print(oneString);

  String piAsString = 3.14159.toStringAsFixed(2);
  assert(piAsString == '3.14');
  print(piAsString);

  const aConstNum = 0;
  print(aConstNum.runtimeType);

  int num = 0;
  if (num == 0) {
    print(num);
  }

  var n = Num();
  print(n.num);

//null check
  var number = n?.num ?? 0;
  print(number);

  if (number is int) {
    print("number is integer");
  }

  number = 8;
  if (number == 0) {
    print("it is zero");
  } else if (number % 2 == 0) {
    print("even");
  } else {
    print("odd");
  }

  switch (number) {
    case 0:
      print("it is zero");
      break;
    case 1:
      print("it is one");
      break;
    default:
      print("confused");
  }

  for (var i = 0; i < 10; i++) {
    print(i);
  }
  var data = [1, 2, 3];
  for (var n in data) {
    print("for in loop $n");
  }

  data.forEach((x) => {print("for each loop $x"), print("hello")});

  data.forEach((element) {
    print("using forEach anonynous function $element");
  });

  num = 10;
  while (num > 0) {
    print(num);
    num--;
    if (num == 5) {
      break;
    }
  }
// Normally list without an type inference will be List<Object>
  List dataObjs = ["test", 12, 1.1];
//static typed with type inference in <>
  List<String> names = ['jack', 'jill'];
  print(names[0]);
  print(dataObjs);

  List nonMutable = const ['test1', 'test2'];
// nonMutable[1] = "test2" will throw error

//Set
  Set<String> halogens = {'flourine', 'chlorine', 'flourine'};
  for (var x in halogens) {
    print(x);
  }

// Map
  Map<String, String> gifts = {
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings'
  };
  print(gifts);
  print("fifth gift ${gifts['fifth']}");

  showOutput("square of 2 = ${square(2)}");

  showOutput("2 + 3 = ${sum(2, num2: 3)}");

  showOutput("4 + 0 = ${sum(4)}");

  Person p = new Person("test", 12);
  p.showoutput();

  var p1 = Person.guest();
  p1.showoutput();

  var x = X('jack');
  print(x.name);
  print(X.age);

  var maruti = Car("swift", 2022, 600000);
  maruti.showOutput();

  try {
    maruti.mustBeGreaterThanThousand(100);
  } catch (e) {
    print(e);
  } finally {
    print("finally is called");
  }
}

class Num {
  int num = 10;
}

class X {
  final name; // can be initialized only once per object
  static const int age = 10; // cannot be changed

  X(this.name);
}

dynamic square(var num) => num * num;

// named parameters to achieve this parameters should be inside {}
dynamic sum(var num1, {var num2 = 0}) => num1 + num2;
void showOutput(var msg) {
  print(msg);
}

class Person {
  late String name;
  late int age;

  Person(String Name, [int Age = 0]) {
    this.age = Age;
    this.name = Name;
  }

  // named constructor
  Person.guest() {
    this.name = "Guest";
    this.age = 23;
  }

  void showoutput() {
    print(name);
    print(age);
  }
}

class Vehicle {
  String model;
  int year;
  Vehicle(this.model, this.year) {
    print(this.model);
    print(this.year);
  }

  void showOutput() {
    print(model);
    print(year);
  }
}

class Car extends Vehicle {
  double _price;

  Car(String model, int year, this._price) : super(model, year);

  void showOutput() {
    super.showOutput();
    print(this._price);
  }

  bool mustBeGreaterThanThousand(int val) {
    if (val < 1000) {
      throw Exception("Value should be more than thousand");
    }
    return true;
  }
}
