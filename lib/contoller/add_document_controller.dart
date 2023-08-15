import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:max_hr/contoller/personal_info_controller.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';

class AddDocumentController extends GetxController{
  RxBool loading = false.obs;
  RxBool successfully = false.obs;
  RxBool showImagePicker = false.obs;
  RxBool fake = false.obs;
  RxBool validation = false.obs;
  DateTime? expiredDate;
  int? de_id;
  int doc_id = -1;
  int hasExpiredDate = -1;
  bool isEdit = false;
  String oldDocument = "";

  TextEditingController note = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? image;
  initPage()async{
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      isEdit = false;
      if(de_id != null){
        loading(true);
        await Api.hasInternet();
        List<dynamic>? list = await Api.getEmployeeDocumentById(de_id);
        if(list != null && list.length > 0){
          isEdit = true;
          note.text = list[0]['note'];
          if(hasExpiredDate == 1 && list[0]['expired_date'] != null){
            expiredDate = DateTime.parse(list[0]['expired_date']);
          }
          oldDocument = list[0]['document'].toString();
        }
        print(list);
        loading(false);
      }
    });

  }
  refreshPage(){
    fake(!fake.value);
  }
  save(BuildContext context)async{
    validation(true);
    if((hasExpiredDate == 0 || expiredDate != null) && (image != null || oldDocument.isNotEmpty)){
      loading(true);
      await Api.hasInternet();
      bool succ= false;
      if(isEdit){
        print('eDDDDDDit');
        print(image);
        print(doc_id);
        print(expiredDate);
        print(de_id);
        print(oldDocument);
        succ = await Api.editDocument(image,doc_id,note.text,expiredDate==null?null:getFormatedDate(expiredDate!),de_id!,oldDocument);
      }else{
        succ = await Api.addDocument(image!,doc_id,note.text,expiredDate==null?null:getFormatedDate(expiredDate!));
      }

      if(succ){
        refreshPersonalInfoController();
        successfully(true);
        await Future.delayed(Duration(milliseconds: 1500));
        Get.back();
      }else{
        App.errMsg(context, "documents", "wrong");
      }
      loading(false);
    }
  }
  getFormatedDate(DateTime dateTime){
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }
  pickGallary()async{
    final XFile? image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 15);
    if(image != null){
      this.image = image;
      showImagePicker(false);
      refreshPage();
    }
  }
  pickCamera()async{
    final XFile? image = await picker.pickImage(source: ImageSource.camera,imageQuality: 15);
    if(image != null){
      this.image = image;
      showImagePicker(false);
      refreshPage();
    }
  }

  refreshPersonalInfoController(){
    PersonalInfoController personalInfoController = Get.find();
    personalInfoController.initPage();
  }
}