import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/model/my_docs.dart';
import 'package:max_hr/model/vacations_type.dart';

class VacationRequestController extends GetxController{
  RxBool loading = false.obs;
  RxBool successfully = false.obs;
  RxBool fake = false.obs;
  RxBool validation = false.obs;
  RxBool showImagePicker = false.obs;
  DateTime? fromDate,toDate;
  TimeOfDay? fromTime,toTime;
  TextEditingController note = TextEditingController();
  List<VacationType> vacations = <VacationType>[];
  VacationType? selectedVacation;
  List<MyDocs> files = <MyDocs>[];
  final ImagePicker picker = ImagePicker();
  int docId = -1;
  String docName = "";
  refreshPage(){
    fake(!fake.value);
  }
  save(BuildContext context)async{
    validation(true);
    if(selectedVacation != null && fromTime != null
        && fromDate != null && toTime != null && toDate != null && files.length == selectedVacation!.vacationDocs.length){
      loading(true);
      await Api.hasInternet();
      int result = await Api.addVacationRequest(files,
          selectedVacation!.vtId.toString(),
          selectedVacation!.isPaid.toString(),
          getFormatedDate(fromDate!)+" "+getFormatedTime(fromTime!),
          getFormatedDate(toDate!)+" "+getFormatedTime(toTime!),
          note.text);
      if(result == 1){
        successfully(true);
        await Future.delayed(Duration(milliseconds: 1500));
        Get.back();
      }else if(result == -1){
        App.errMsg(context, "Vacations", "you_didnot_have_vacations");
      }else{
        App.errMsg(context, "Vacations", "wrong");
      }
      loading(false);
    }

  }
  initPage()async{
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      loading(true);
      await Api.hasInternet();
      vacations = await Api.getVacationTypes();
      selectedVacation = vacations.first;
      loading(false);
    });

  }
  getFormatedDate(DateTime dateTime){
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }
  getFormatedTime(TimeOfDay timeOfDay ){
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);
    return formattedTime;
  }
  openPicker(String name, int Id){
    showImagePicker.value = true;
    docName = name;
    docId = Id;
  }
  pickGallary()async{
    final XFile? image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 15);
    if(image != null){
      files.add(MyDocs(image, docName, docId));
      showImagePicker(false);
      refreshPage();
    }
  }
  pickCamera()async{
    final XFile? image = await picker.pickImage(source: ImageSource.camera,imageQuality: 15);
    if(image != null){
      files.add(MyDocs(image, docName, docId));
      showImagePicker(false);
      refreshPage();
    }
  }
  clearSelectedFiles(){
    files.clear();
  }
  getIfSelected(int id){
    for(int i=0; i < files.length ; i++){
      if(id == files[i].docId){
        return true;
      }
    }
    return false;
  }
}

