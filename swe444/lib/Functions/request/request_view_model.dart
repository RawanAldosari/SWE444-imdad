import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:swe444/Models/request.dart';
import 'package:swe444/Widgets/show_snackbar.dart';

class RequestViewModel {
  String? _posted_by;
  String? _type;
  int? _amount;
  int _donated = 0;
  String? _description;
  String? _title;
  String? _mosque_name;
  String? _mosque_location;
  DateTime? _uplaod_time;
  String? _token;
  String? _item;
  int? _requested;
  late String message;
  late String msgType;

  get userDocument {
    return FirebaseFirestore.instance.collection("users").doc(_posted_by).get();
  }

  set postedBy(String? value) {
    if (value != null) {
      _posted_by = value;
    }
  }

  set setType(String? value) {
    if (value != null) {
      _type = value;
    }
  }

  set setAmount(int? value) {
    if (value != null) {
      _amount = value;
    }
  }

  set setDescription(String? value) {
    if (value != null) {
      _description = value;
    }
  }

  set setTitle(String? value) {
    if (value != null) {
      _title = value;
    }
  }

  set setMName(String? value) {
    if (value != null) {
      _mosque_name = value;
    }
  }

  set setMLocation(String? value) {
    if (value != null) {
      _mosque_location = value;
    }
  }

  set setUploadTime(DateTime? value) {
    if (value != null) {
      _uplaod_time = value;
    }
  }

  set setDonations(int? value) {
    if (value != null) {
      _donated = value;
    }
  }

  set setToken(String? value) {
    if (value != null) {
      _token = value;
    }
  }

  /// items requests

  // set setItem(String? value) {
  //   if (value != null) {
  //     _item = value;
  //   }
  // }

  set setRequested(int? value) {
    if (value != null) {
      _requested = value;
    }
  }

  Future<void> add() async {
    String _message = "";
    String _msgtype = "";
    // await FirebaseMessaging.getToken().then((token){
    //   FirebaseFirestore.instance.collection('tokens').add({
    //     'token':token
    //   });
    // });

    if (_type == "مبلغ") {
      FundsRequest request = FundsRequest(
          amount: _amount,
          donated: _donated,
          type: _type,
          posted_by: _posted_by,
          description: _description,
          mosque_name: _mosque_name,
          mosque_location: _mosque_location,
          title: _title,
          uplaod_time: _uplaod_time,
          token: _token);

      await FirebaseFirestore.instance
          .collection('requests')
          .add(request.toJson())
          .then((value) =>
              {_message = 'تمت إضافة الطلب بنجاح', _msgtype = "success"})
          .catchError((error) =>
              {_message = " فشل في إضافة الطلب:" + error, _msgtype = "fail"});
    } else if (_type == "موارد") {
      ItemsRequest request = ItemsRequest(
          // item: _item,
          type: _type,
          donated: _donated,
          amount: _requested,
          posted_by: _posted_by,
          description: _description,
          mosque_name: _mosque_name,
          mosque_location: _mosque_location,
          title: _title,
          uplaod_time: _uplaod_time,
          token: _token);

      await FirebaseFirestore.instance
          .collection('requests')
          .add(request.toJson())
          .then((value) =>
              {_message = 'تمت إضافة الطلب بنجاح', _msgtype = "success"})
          .catchError((error) =>
              {_message = " فشل في إضافة الطلب:" + error, _msgtype = "fail"});
    }

    message = _message;
    msgType = _msgtype;
  }

  Future update(String docId) async {
    String _message = "";
    String _msgtype = "";

    if (_type == "مبلغ") {
      FundsRequest request = FundsRequest(
          amount: _amount,
          donated: _donated,
          type: _type,
          posted_by: _posted_by,
          description: _description,
          mosque_name: _mosque_name,
          mosque_location: _mosque_location,
          title: _title,
          uplaod_time: _uplaod_time, token: _token);

      await FirebaseFirestore.instance
          .collection('requests')
          .doc(docId)
          .set(request.toJson())
          .then((value) =>
              {_message = 'تم تعديل الطلب بنجاح', _msgtype = "success"})
          .catchError((error) =>
              {_message = " فشل في تعديل الطلب:" + error, _msgtype = "fail"});
    } else if (_type == "موارد") {
      ItemsRequest request = ItemsRequest(
          // item: _item,
          type: _type,
          donated: _donated,
          amount: _requested,
          posted_by: _posted_by,
          description: _description,
          mosque_name: _mosque_name,
          mosque_location: _mosque_location,
          title: _title,
          uplaod_time: _uplaod_time, token: _token);

      await FirebaseFirestore.instance
          .collection('requests')
          .doc(docId)
          .set(request.toJson())
          .then((value) =>
              {_message = 'تم تعديل الطلب بنجاح', _msgtype = "success"})
          .catchError((error) =>
              {_message = " فشل في تعديل الطلب:" + error, _msgtype = "fail"});
    }

    message = _message;
    msgType = _msgtype;
  }

  Future cancelRequest(DocumentSnapshot document) async {
    String _message = "";
    String _msgtype = "";

    return await FirebaseFirestore.instance
        .collection('requests')
        .doc(document.id)
        .delete()
        .then((value) {
      _message = "تم إلغاء الطلب بنجاح";
      _msgtype = "success";
      msgType = _msgtype;
      message = _message;
    }).catchError((error) {
      _message = "فشل في إلغاء الطلب";
      _msgtype = "fail";
      msgType = _msgtype;
      message = _message;
    });
  }
}
