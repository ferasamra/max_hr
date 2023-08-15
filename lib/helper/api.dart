import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/helper/store.dart';
import 'package:max_hr/model/attendance.dart';
import 'package:max_hr/model/discount_rewards.dart';
import 'package:max_hr/model/employee.dart';
import 'package:max_hr/model/employee_document.dart';
import 'package:max_hr/model/lateness.dart';
import 'package:max_hr/model/my_docs.dart';
import 'package:max_hr/model/overtime.dart';
import 'package:max_hr/model/requests.dart';
import 'package:max_hr/model/vacations.dart';
import 'package:max_hr/model/vacations_type.dart';
import 'package:max_hr/view/no_internet.dart';
import 'package:http/http.dart' as http;
import 'package:max_hr/view/requests.dart';
class Api{

  static String url = "http://hr-system-613863818.ap-northeast-1.elb.amazonaws.com";
  static String media_url = url+"/uploads/";
  static String token = "";

  static Future<List<EmployeeDocument>> getEmployeeDocument()async{
    var headers = {
      'authorization': 'Bearer '+token,
    };
    var request = http.Request('GET', Uri.parse(url+'/api/mobile/employee-document/${Global.employee!.roleId}/${Global.employee!.eId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      print(data);
      return EmployeeDocumentDecoder.fromJson(json.decode(data)).employeeDocument;
    }
    else {
      print(response.reasonPhrase);
      return <EmployeeDocument>[];
    }

  }

  static Future<List<dynamic>?> getEmployeeDocumentById(de_id)async{
    var headers = {
      'authorization': 'Bearer '+token,
    };
    var request = http.Request('GET', Uri.parse('http://52.69.83.36:3000/api/employee/document/$de_id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      print(data);
      return json.decode(data);
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }

  static Future<Employee?> login(String username,String password)async{
    try{
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request('POST', Uri.parse(url+'/api/employee/mobile/login'));
      request.body = json.encode({
        "username": username,
        "password": password,
        "firebase_token":Global.firebase_token
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String data = (await response.stream.bytesToString());
        Employee employee = EmployeeDecoder.fromJson(json.decode(data)).employee;
        Store.saveLoginInfo(username, password);
        token = employee.token;
        return employee;
      }
      else {
        return null;
      }
    }catch(err){
      print(err);
    }
  }
  static Future<bool> checkInOutWithImage(String location,XFile? image)async{
    var headers = {
      'Authorization': 'Bearer '+token,
    };
    var request = http.MultipartRequest('POST', Uri.parse(url+'/api/in-out/with-image'));
    request.fields.addAll({
      "e_id": Global.employee!.eId.toString(),
      "location": location
    });
    if(image != null){
      request.files.add(await http.MultipartFile.fromPath('file', image.path));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }

  }
  static Future<bool> checkInOut(String location)async{
    var headers = {
      'Authorization': 'Bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/in-out'));
    request.body = json.encode({
      "e_id": Global.employee!.eId,
      "location": location
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }

  }
  static Future<bool> deleteDocument(int de_id)async{
    var headers = {
      'Authorization': 'Bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('DELETE', Uri.parse(url+'/api/employee/document'));
    request.body = json.encode({
      "id": de_id,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future<bool> addDocument(XFile file,int doc_id,String note,String? expired_date)async{
    var headers = {
      'Authorization': 'Bearer '+token
    };
    var request = http.MultipartRequest('POST', Uri.parse(url+'/api/employee/document'));
    request.fields.addAll({
      'e_id': Global.employee!.eId.toString(),
      'doc_id': doc_id.toString(),
      'note': note
    });
    if(expired_date != null){
      request.fields.addAll({'expired_date': expired_date,});
    }
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      print(await response.stream.bytesToString());
      return false;
    }
  }
  static Future<bool> editDocument(XFile? file,int doc_id,String note,String? expired_date,int de_id,String old_document)async{
    var headers = {
      'Authorization': 'Bearer '+token
    };
    var request = http.MultipartRequest('PUT', Uri.parse(url+'/api/employee/document'));
    request.fields.addAll({
      'e_id': Global.employee!.eId.toString(),
      'doc_id': doc_id.toString(),
      'note': note,
      'old_document':old_document,
      "id":de_id.toString()
    });
    if(expired_date != null){
      request.fields.addAll({'expired_date': expired_date,});
    }
    if(file != null){
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future<List<Lateness>> getLateness(int year,int month)async{
    var headers = {
      'authorization': 'Bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/mobile/lateness'));
    request.body = json.encode({
      "e_id": Global.employee!.eId,
      "year": year,
      "month": month
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      
      return LatenessDecoder.fromJson(json.decode(data)).lateness;
    }
    else {
      print(response.reasonPhrase);
      return <Lateness>[];
    }

  }

  static Future<List<OverTime>> getOvertime(int year,int month)async{
    var headers = {
      'authorization': 'Bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/mobile/overtime'));
    request.body = json.encode({
      "e_id": Global.employee!.eId,
      "year": year,
      "month": month
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      
      return OvertimeDecoder.fromJson(json.decode(data)).overTime;
    }
    else {
      print(response.reasonPhrase);
      return <OverTime>[];
    }
  }

  static Future<List<Vacation>> getVacation(int year,int month)async{
    var headers = {
      'authorization': 'Bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/mobile/vacations'));
    request.body = json.encode({
      "e_id": Global.employee!.eId,
      "year": year,
      "month": month
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      
      return VacationDecoder.fromJson(json.decode(data)).vacations;
    }
    else {
      print(response.reasonPhrase);
      return <Vacation>[];
    }
  }

  static Future<List<DiscountReward>> getDiscountRewards(int state)async{
    var headers = {
      'authorization': 'Bearer '+token,
    };
    var request = http.Request('GET', Uri.parse((url+'/api/mobile/discount-rewards/${Global.employee!.eId}/$state')));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      return DiscountRewardsDecoder.fromJson(json.decode(data)).discountRewards;
    }
    else {
      print(response.reasonPhrase);
      return <DiscountReward>[];
    }

  }

  static Future<List<Attendance>> getAttendance(int year , int month)async{
    var headers = {
      'authorization': 'Bearer '+token,
    };
    var request = http.Request('GET', Uri.parse(url+'/api/mobile/attendance/${Global.employee!.eId}/$month/$year'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      
      return AttendanceDecoder.fromJson(json.decode(data)).attendance;
    }
    else {
      print(response.reasonPhrase);
      return <Attendance>[];
    }

  }

  static Future<bool> changeOvertimeState(int state , String note , int ot_id)async{
    var headers = {
      'authorization': 'Bearer '+token,
      'Content-Type': 'application/json',
    };
    var request = http.Request('PUT', Uri.parse(url+'/api/mobile/line-manager-overtime-request'));
    request.body = json.encode({
      "e_id": Global.employee!.eId,
      "state": state,
      "note": note,
      "ot_id":ot_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      print(data);
      return true;
    }
    else {
      print(response.reasonPhrase);
      String data = (await response.stream.bytesToString());
      print(data);
      return false;
    }
  }

  static Future<bool> changeVacationState(int state , String note , int vr_id)async{
    var headers = {
      'authorization': 'Bearer '+token,
      'Content-Type': 'application/json',
    };
    var request = http.Request('PUT', Uri.parse(url+'/api/mobile/line-manager-vacation-request'));
    request.body = json.encode({
      "e_id": Global.employee!.eId,
      "state": state,
      "note": note,
      "vr_id":vr_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future<bool> acceptVacationAsNotPaid(int state , String note , int vr_id)async{
    var headers = {
      'authorization': 'Bearer '+token,
      'Content-Type': 'application/json',
    };
    var request = http.Request('PUT', Uri.parse(url+'/api/mobile/line-manager-vacation-request/un-paid'));
    request.body = json.encode({
      "e_id": Global.employee!.eId,
      "state": state,
      "note": note,
      "vr_id":vr_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  static Future<bool> archiveOverTime(int ot_id)async{
    var headers = {
      'authorization': 'Bearer '+token,
      'Content-Type': 'application/json',
    };
    var request = http.Request('DELETE', Uri.parse(url+'/api/overtime'));
    request.body = json.encode({
      "id":ot_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      print(data);
      return true;
    }
    else {
      print(response.reasonPhrase);
      String data = (await response.stream.bytesToString());
      print(data);
      return false;
    }
  }

  static Future<bool> archiveVacations(int vr_id)async{
    var headers = {
      'authorization': 'Bearer '+token,
      'Content-Type': 'application/json',
    };
    var request = http.Request('DELETE', Uri.parse(url+'/api/vacations'));
    request.body = json.encode({
      "id":vr_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  static Future<MyRequests?> getRequests()async{
    var headers = {
      'authorization': 'Bearer '+token,
    };
    var request = http.Request('GET', Uri.parse(url+'/api/mobile/approvals/${Global.employee!.eId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      
      return MyRequests.fromJson(json.decode(data));
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }

  static Future<bool> addOverTimeRequest(String from,String to,String date, String note)async{
    var headers = {
      'Authorization': 'Bearer '+token,
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'/api/overtime'));
    request.body = json.encode({
      "e_id": Global.employee!.eId,
      "_from": from,
      "_to": to,
      "date": date,
      "note": note
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }

  }

  static Future<int> addVacationRequest(List<MyDocs> docs,String vt_id,String is_paid,String from,String to,String note)async{
    var headers = {
      'Authorization': 'Bearer '+token
    };
    var request = http.MultipartRequest('POST', Uri.parse(url+'/api/vacations'));
    request.fields.addAll({

      'e_id': Global.employee!.eId.toString(),
      'vt_id': vt_id,
      'is_paid': is_paid,
      '_from': from,
      '_to': to,
      'note': note
    });
    for(int i=0;i<docs.length;i++){
      request.files.add(await http.MultipartFile.fromPath('files', docs[i].file.path));
      request.fields.addAll({
        'docs_name[$i]': docs[i].name,
      });
    }
    request.headers.addAll(headers);
    print(request.fields);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return 1;
    }
    else {
      print(response.reasonPhrase);
      String msg = (await response.stream.bytesToString());
      if(msg.contains('this employee donot Have vacations')){
        return -1;
      }else{
        return 0;
      }
    }

  }

  static Future<List<VacationType>> getVacationTypes()async{
    var headers = {
      'Authorization': 'Bearer '+token,
    };
    var request = http.MultipartRequest('GET', Uri.parse(url+'/api/vacations/type/with-docs'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      
      return VacationTypeDecoder.fromJson(json.decode(data)).vacations;
    }
    else {
      print(response.reasonPhrase);
      return <VacationType>[];
    }

  }

  static Future<bool> uploadAvatar(XFile image)async{
    var headers = {
      'Authorization': 'Bearer '+token
    };
    var request = http.MultipartRequest('PUT', Uri.parse(url+'/api/employee/mobile/upload-avatar'));
    request.fields.addAll({
      'e_id': Global.employee!.eId.toString()
    });
    request.files.add(await http.MultipartFile.fromPath('file', image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    return true;
    }
    else {
    print(response.reasonPhrase);
    return false;
    }

  }

  static Future<String> changePassword(String old , String newPass, String confirm)async{
    var headers = {
      'Authorization': 'Bearer '+token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(url+'/api/employee/mobile/change-password'));
    request.body = json.encode({
      "old": old,
      "new": newPass,
      "confirm": confirm,
      "e_id": Global.employee!.eId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Store.saveLoginInfo(Global.employee!.email, newPass);
      return "password_change_successfully";
    }
    else {
    print(response.reasonPhrase);
    String data = (await response.stream.bytesToString());
    return data;
    }

  }

  static Future<bool> hasInternet()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      var succ = await Get.to(()=>NoInternet());
      return hasInternet();
    } else {
      return true;
    }
  }

  static Future<bool> checkInterNet()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

}