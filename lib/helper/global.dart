import 'package:get/get.dart';
import 'package:max_hr/model/employee.dart';
import 'package:max_hr/model/login_info.dart';

class Global{

  static String locale = "en";
  static String firebase_token = "";
  static LoginInfo? loginInfo;
  static String temp_email = "";
  static Employee? employee;
  static List<MyMonth> months = <MyMonth>[];
  static DateTime now = DateTime.now();
  static MyMonth currentMonth = MyMonth(
      name: getMonthName(now.month),
      shortName: getMonthShortName(now.month),
      number: now.month,
      year: now.year,
      isNow: true,
      selected: true.obs
  );

  static generateMonths(){
    DateTime begin = DateTime(2023,1,1);
    DateTime end = DateTime.now();
    var loop = true;
    while(loop){
      if(begin.year > end.year){
        loop = false;
      }else if(begin.year == end.year
      && begin.month > end.month ){
        loop = false;
      }
      months.add(MyMonth(
          name: getMonthName(begin.month),
          shortName: getMonthShortName(begin.month),
          number: begin.month,
          year: begin.year,
          isNow: (begin.year == end.year && begin.month == end.month)?true:false,
          selected: (begin.year == end.year && begin.month == end.month)?true.obs:false.obs,
      ));
      if(begin.month == 12){
        begin = DateTime((begin.year+1),1,1);
      }else{
        begin = DateTime((begin.year),(begin.month + 1 ),1);
      }
    }
  }
  static getNow(){
    months.forEach((element) {
      print(element.year);
      print(element.number);
    });
  }
}



String getMonthName(int monthNumber) {
  late String month;
  switch (monthNumber) {
    case 1:
      month = "January";
      break;
    case 2:
      month = "February";
      break;
    case 3:
      month = "March";
      break;
    case 4:
      month = "April";
      break;
    case 5:
      month = "May";
      break;
    case 6:
      month = "June";
      break;
    case 7:
      month = "July";
      break;
    case 8:
      month = "August";
      break;
    case 9:
      month = "September";
      break;
    case 10:
      month = "October";
      break;
    case 11:
      month = "November";
      break;
    case 12:
      month = "December";
      break;
  }
  return month;
}

String getMonthShortName(int monthNumber) {
  late String month;
  switch (monthNumber) {
    case 1:
      month = "Jan";
      break;
    case 2:
      month = "Feb";
      break;
    case 3:
      month = "Mar";
      break;
    case 4:
      month = "Apr";
      break;
    case 5:
      month = "May";
      break;
    case 6:
      month = "Jun";
      break;
    case 7:
      month = "Jul";
      break;
    case 8:
      month = "Aug";
      break;
    case 9:
      month = "Sep";
      break;
    case 10:
      month = "Oct";
      break;
    case 11:
      month = "Nov";
      break;
    case 12:
      month = "Dec";
      break;
  }
  return month;
}

class MyMonth{
  String name;
  String shortName;
  int number;
  int year;
  bool isNow;
  RxBool selected;

  MyMonth({required this.name,required this.shortName,required this.number,required this.year,required this.isNow,required this.selected});
}