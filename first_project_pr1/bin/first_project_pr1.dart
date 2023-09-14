import 'dart:io';
import 'package:ansicolor/ansicolor.dart';
import 'package:faker/faker.dart';
import 'dart:math';

AnsiPen penError = AnsiPen()
  ..white()
  ..rgb(r: 1.0, g: 0, b: 0);

AnsiPen penWarning = AnsiPen()
  ..white()
  ..rgb(r: 255.0, g: 255.0, b: 0);

AnsiPen penDone = AnsiPen()
  ..white()
  ..rgb(r: 0.0, g: 1.0, b: 0);

class Student {
  int id;
  String surName;
  String middleName;
  String firstName;
  int age;
  String group;
  double grade;
  String address;
  String company;
  String phoneNumber;

  Student(this.id, this.surName, this.middleName, this.firstName, this.age,
      this.group, this.grade, this.address, this.company, this.phoneNumber);
}

class StudentList {
  List<Student> students = [];

  void addStudent(Student student) {
    students.add(student);
  }

  void fillListStudents() {
    final faker = Faker();

    Random random = Random();
    for (int i = 0; i <= 20; i++) {
      String tempGrade = "${random.nextInt(5)}.${random.nextInt(9)}";
      double grade = double.parse(tempGrade);
      grade <= 1.9 ? grade = 2.0 : grade;
      Student tempStudent = Student(
          i + random.nextInt(999),
          faker.person.firstName(),
          faker.person.lastName(),
          faker.person.name(),
          random.nextInt(80),
          "П50-${(random.nextInt(9) + 1).toString()}-20",
          grade,
          faker.address.city(),
          faker.company.name(),
          faker.phoneNumber.us());
      students.add(tempStudent);
    }
  }

  void printStudentInfo(List<Student> listInfo,
      [String? filter, bool? paramReversed]) {
    if (filter == null) {
      for (var student in listInfo) {
        print(
            "id: ${student.id}, Фамилия: ${student.surName}, Отчество: ${student.middleName}, Имя: ${student.firstName}, Возраст: ${student.age}, Группа: ${student.group}, Средний балл: ${student.grade}, Адрес: ${student.address}, Работает в: ${student.company}, Номер телефона: ${student.phoneNumber}");
      }
    } else {
      switch (filter) {
        case 'id':
          listInfo.sort((a, b) => a.id.compareTo(b.id));
          break;
        case 'surName':
          listInfo.sort((a, b) => a.surName.compareTo(b.surName));
          break;
        case 'middleName':
          listInfo.sort((a, b) => a.middleName.compareTo(b.middleName));
          break;
        case 'firstName':
          listInfo.sort((a, b) => a.firstName.compareTo(b.firstName));
          break;
        case 'age':
          listInfo.sort((a, b) => a.age.compareTo(b.age));
          break;
        case 'group':
          listInfo.sort((a, b) => a.group.compareTo(b.group));
          break;
        case 'grade':
          listInfo.sort((a, b) => a.grade.compareTo(b.grade));
          break;
        case 'address':
          listInfo.sort((a, b) => a.address.compareTo(b.address));
          break;
        case 'company':
          listInfo.sort((a, b) => a.company.compareTo(b.company));
          break;
        case 'phoneNumber':
          listInfo.sort((a, b) => a.phoneNumber.compareTo(b.phoneNumber));
          break;
      }

      if (paramReversed != null && paramReversed) {
        listInfo = listInfo.reversed.toList();
      }

      for (var student in listInfo) {
        print(
            "id: ${student.id}, Фамилия: ${student.surName}, Отчество: ${student.middleName}, Имя: ${student.firstName}, Возраст: ${student.age}, Группа: ${student.group}, Средний балл: ${student.grade}, Адрес: ${student.address}, Работает в: ${student.company}, Номер телефона: ${student.phoneNumber}");
      }
    }
  }

  List<Student> getStudentWithHighestGrade(bool param) {
    List<Student> returnedListStudent = [];

    double tempHighestOrLowerGrade = students.elementAt(0).grade;
    for (int i = 1; i < students.length - 1; i++) {
      if (param) {
        if (tempHighestOrLowerGrade < students.elementAt(i).grade) {
          tempHighestOrLowerGrade = students.elementAt(i).grade;
          i = 1;
        }
      } else {
        if (tempHighestOrLowerGrade > students.elementAt(i).grade) {
          tempHighestOrLowerGrade = students.elementAt(i).grade;
          i = 1;
        }
      }
    }

    for (var student in students) {
      student.grade == tempHighestOrLowerGrade
          ? returnedListStudent.add(student)
          : student.grade;
    }

    return returnedListStudent;
  }

  double getAverageGrade() {
    double sumGrages = 0.0;
    for (var student in students) {
      sumGrages += student.grade;
    }

    return sumGrages / students.length * 100 ~/ 1 / 100;
  }

  void deleteStudentAtId(int id) {
    for (int i = 0; i < students.length; i++) {
      if (students.elementAt(i).id == id) {
        students.removeAt(i);
      }
    }
  }

  void updateStudentInfo(int id, age, String surName, middleName, firstName,
      group, address, company, phoneNumber, double grade) {
    for (int i = 0; i < students.length; i++) {
      if (students.elementAt(i).id == id) {
        students.elementAt(i).surName = surName;
        students.elementAt(i).middleName = middleName;
        students.elementAt(i).firstName = firstName;
        students.elementAt(i).age = age;
        students.elementAt(i).group = group;
        students.elementAt(i).grade = grade;
        students.elementAt(i).address = address;
        students.elementAt(i).company = company;
        students.elementAt(i).phoneNumber = phoneNumber;
      }
    }
  }
}

void main(List<String> arguments) {
  StudentList studentList = StudentList();
  studentList.fillListStudents();

  print("\n\t\tПРОГРАММА ПО УПРАВЛЕНИЮ СПИСКОМ СТУДЕНТОВ");
  while (true) {
    print(penDone("\tДЕЙСТВИЯ:"));
    print("1- Добавление студента");
    print("2- Наивысший/Наименьший балл среди студентов");
    print("3- Средний балл всех студентов");
    print("4- Удаление студента");
    print("5- Изменение данных студента");
    print("6- Вывод списка студентов");
    print(penWarning("-----Введите номер действия-----"));
    String action = stdin.readLineSync().toString();
    switch (action) {
      case '1':
        print("Введите фамилию");
        String surName = stdin.readLineSync().toString();
        print("Введите отчество");
        String middleName = stdin.readLineSync().toString();
        print("Введите имя");
        String firstName = stdin.readLineSync().toString();

        String inputAge;
        int age = 0;
        try {
          do {
            print("Введите возраст:");
            inputAge = stdin.readLineSync().toString();
            age = int.parse(inputAge);
          } while (age <= 0 && age >= 150);
        } catch (e) {
          print('Неверный возраст!');
        }

        print("Введите группу");
        String group = stdin.readLineSync().toString();

        String inputGrade;
        double grade = 0.0;
        try {
          do {
            print("Введите средний балл:");
            inputGrade = stdin.readLineSync().toString();
            grade = double.parse(inputGrade);
          } while (grade <= 0.0 && grade >= 5.0);
        } catch (e) {
          print('Неверный средний балл!');
        }

        print("Введите адрес");
        String address = stdin.readLineSync().toString();
        print("Введите компанию");
        String company = stdin.readLineSync().toString();
        print("Введите номер телефона");
        String phoneNumber = stdin.readLineSync().toString();

        Student newStudent = Student(random.integer(999), surName, middleName,
            firstName, age, group, grade, address, company, phoneNumber);
        studentList.addStudent(newStudent);
        break;
      case '2':
        print("Вывод студентов с наивышим средним баллом [Y/N]?");
        bool param;
        String paramReader = stdin.readLineSync().toString();
        paramReader == 'Y' || paramReader == 'y' ? param = true : param = false;
        List<Student> sortStudents =
            studentList.getStudentWithHighestGrade(param);
        studentList.printStudentInfo(sortStudents);
        break;
      case '3':
        print(
            "Средний балл по всем студентам: ${studentList.getAverageGrade()}");
        break;
      case '4':
        print("Введите id удаляемого студента: ");
        String idInput;
        int id = 0;

        try {
          do {
            idInput = stdin.readLineSync().toString();
            id = int.parse(idInput);
          } while (id <= 0);
        } catch (e) {
          print(penError("ОШИБКА! Введите данные корректно\n"));
        }

        studentList.deleteStudentAtId(id);
        break;
      case '5':
        print("Введите id изменяемого студента");
        String idInput;
        int id = 0;

        try {
          do {
            idInput = stdin.readLineSync().toString();
            int.parse(idInput);
          } while (id <= 0);
        } catch (e) {
          print(penError("ОШИБКА! Введите данные корректно\n"));
        }

        print("Введите фамилию");
        String surName = stdin.readLineSync().toString();
        print("Введите отчество");
        String middleName = stdin.readLineSync().toString();
        print("Введите имя");
        String firstName = stdin.readLineSync().toString();

        String inputAge;
        int age = 0;
        try {
          do {
            print("Введите возраст:");
            inputAge = stdin.readLineSync().toString();
            age = int.parse(inputAge);
          } while (age <= 0 && age >= 150);
        } catch (e) {
          print('Неверный возраст!');
        }

        print("Введите группу");
        String group = stdin.readLineSync().toString();

        String inputGrade;
        double grade = 0.0;
        try {
          do {
            print("Введите средний балл:");
            inputGrade = stdin.readLineSync().toString();
            grade = double.parse(inputGrade);
          } while (grade <= 0.0 && grade >= 5.0);
        } catch (e) {
          print('Неверный средний балл!');
        }

        print("Введите адрес");
        String address = stdin.readLineSync().toString();
        print("Введите компанию");
        String company = stdin.readLineSync().toString();
        print("Введите номер телефона");
        String phoneNumber = stdin.readLineSync().toString();

        studentList.updateStudentInfo(id, age, surName, middleName, firstName,
            group, address, company, phoneNumber, grade);
        break;
      case '6':
        print(
            "Введите фильтр, либо нажмите кнопку ввода (Доступные фильтры:id-surName-middleName-firstName-age-group-grade-address-company-phoneNumber)");
        String filter = stdin.readLineSync().toString();
        print("Вывод списка по возрастанию [Y/N]?");
        bool paramReversed;
        String paramReader = stdin.readLineSync().toString();
        paramReader == 'Y' || paramReader == 'y'
            ? paramReversed = true
            : paramReversed = false;
        studentList.printStudentInfo(
            studentList.students, filter, paramReversed);
        break;
      default:
        print(penError("ОШИБКА! Введите действие корректно\n"));
        break;
    }
  }
}
