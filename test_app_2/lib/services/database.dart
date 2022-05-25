
import 'package:contacts_service/contacts_service.dart';
import 'package:test_app/services/authentication.dart';

import './contacts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '/concept/classifier.dart';
class Database with ChangeNotifier{
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  // Future<String>  getName(String uid) async{
  //
  //  String name= await
  //  Database().basicInformationAvailable(uid);
  //  return name;
  // }
  // Future<String>  getPhone(String uid) async{
  //
  //   String phoneNo;
  //   phoneNo=await Database().getPhoneNumber(uid);
  //   return phoneNo;
  // }

   Future<String>  basicInformationAvailable () async{
    String uid=Authentication().userId();
    print("uid inside basic info available");
    print(uid);
    if(uid==null){
      return null;
    }
    DocumentSnapshot snapshot=await
     firestore.collection("user").doc(uid).get();
    Map<String,dynamic> data=snapshot.data() as Map<String,dynamic>;
    if(data==null )return null;
    

    print("name got ");
    print(data['Name']);
    return data['Name'];
  }
  Future<Map<String,dynamic>>getCurrentUserGroup()async{
    String uid=Authentication().userId();
    if(uid==null)uid=FirebaseAuth.instance.currentUser.uid;
   DocumentSnapshot snapshot=
   await firestore.collection("user").doc(uid).get();
   Map<String,dynamic>data=snapshot.data() as Map<String,dynamic>;
   Map<String,dynamic>userData={};
   userData=data.map((key, value) {
    if(key=="a_test_ans"){
      List<int>ans=[];
      for(int i=0;i<value.length;i++){
        ans.add(value[i]);
      }
      return MapEntry(key, ans);
    }
    return MapEntry(key, value);
   });

   return userData;
  }
  Future<String> getPhoneNumber() async{

    String uid=FirebaseAuth.instance.currentUser.uid;

    DocumentSnapshot snapshot=await firestore.collection('user').
    doc(uid).get();
    Map<String,dynamic>data=snapshot.data() as Map<String,dynamic>;
    print("phone number gets called");
    print(data['phoneNo']);
    return data['phoneNo'];
  }
  Future<List<Map<String,dynamic>>> dataFetcher() async {
    Set<String>_phonesSet={};
    try {
      List<Item>_phones=await Contacts().requiredPhoneNumbers();
     
      for(int i=0;i<_phones.length;i++){
        _phonesSet.add(_phones[i].value.toString());
      }
    } on Exception catch (e) {
      // TODO
      throw e;
    }
    
    QuerySnapshot snapshot = await firestore
        .collection('user')
        .orderBy('user_group')
        .orderBy('total_test_marks')
        .orderBy('a_test_marks')
        .orderBy('b_test_marks')
        .orderBy('c_test_marks')
        .orderBy('Name')
        .get();
    List<QueryDocumentSnapshot>documents=snapshot.docs;
    User user=FirebaseAuth.instance.currentUser;

    String phoneNumber= user==null ? null : user.phoneNumber;
    List<Map<String,dynamic>>correct=[];
    for(int i=0;i<documents.length;i++){
      var doc=documents[i];
      Map<String,dynamic>data =doc.data() as Map<String,dynamic>;
      String numberFromFirebase=data['phoneNo'];
      String phoneWithoutCountryCode=numberFromFirebase.substring(3);
      // print(numberFromFirebase);
      // print(phoneWithoutCountryCode);
      if(data['phoneNo'] == phoneNumber
          ||
          ((_phonesSet.contains(phoneWithoutCountryCode) ==false)
              && _phonesSet.contains(numberFromFirebase)==false ))continue;

      correct.add(data.map((key, value) {

        if(key=="a_test_ans"){
          List<int>answers=[];
          for(int i=0;i<value.length;i++){
            answers.add(value[i]);
          }
          return MapEntry(key, answers);
        }
        else{
          return MapEntry(key, value.toString());
        }
      }));
    }
    return correct;
  }


  Future<void> userTestMarksDataUpload(
      int a_marks,
      int b_marks,
      int c_marks,
      int total_marks,

      List<int> a_test_ans,

      ) async{
    String uid=Authentication().userId();
    DocumentSnapshot snapshot=await firestore.collection("user").doc(uid)
        .get();
    Map<String,dynamic> data=snapshot.data() as Map<String,dynamic>;
    if(data==null)return null;
    String phoneNumber=Authentication().getPhoneNumber();
    print("phone Number");
    print(phoneNumber);
    if(data['Gender']=="Male"){
      total_marks-=a_marks;
      a_marks=54-a_marks;
      total_marks+=a_marks;
    }
    String userGroup=Classifier().classGroup(a_marks+b_marks+c_marks, a_marks,b_marks,
        c_marks);
    try {
      await firestore.collection("user").doc(uid).set({
        'UID':data["UID"],
        'phoneNo':phoneNumber,
        'Name':data['Name'],
        'DOB':data['DOB'],
        'Gender':data['Gender'],
        'a_test_marks': a_marks,
        'b_test_marks': b_marks,
        'c_test_marks': c_marks,
        'total_test_marks': total_marks,
        'a_test_ans': a_test_ans,
        'user_group': userGroup
      });
    } on Exception catch (e) {
      // TODO
      rethrow;
    }
  }

// fun to upload user personal data to databse
  Future<void> userPersonalDataUpload (
      String name, String gender,DateTime dob) async{
    String uid= Authentication().userId();
    try {
      await firestore.collection("user").doc(uid).set({
        'UID': uid,
        'Name': name,
        'Gender': gender,
        'DOB':dob.toString(),

      });
    } on Exception catch (e) {
      // TODO
      rethrow;
    }
  }
}