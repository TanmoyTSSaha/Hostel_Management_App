

class UserDetails{
  String DOB;
  String Gender;
  String Name;
  List<int> a_test_ans;
  int a_test_marks;
  int b_test_marks;
  int c_test_marks;
  String email;
  String phoneNo;
  int total_test_marks;
  String user_group;

  UserDetails({this.DOB,this.Gender,
    this.Name,this.email,this.a_test_ans,
    this.a_test_marks,this.b_test_marks,
    this.c_test_marks,this.phoneNo,this.total_test_marks,
    this.user_group});
  factory UserDetails.fromJson(Map<String,dynamic>json){
    return UserDetails(
      DOB:json['DOB'],
     a_test_ans: json['a_test_ans'],
     a_test_marks: json['a_test_marks'],
     b_test_marks: json['b_test_marks'],
     c_test_marks: json['c_test_marks'],
     email: json['email'],
     Gender: json['Gender'],
     Name: json['Name'],
     phoneNo: json['phoneNo'],
     total_test_marks: json['total_test_marks'],
     user_group: json['user_group'],
    );
  }
  Map<String,dynamic> toJson(UserDetails details){
      return {
        'DOB':details.DOB,
        'a_test_ans':details.a_test_ans,
        'a_test_marks':details.a_test_marks
      };
  }

}