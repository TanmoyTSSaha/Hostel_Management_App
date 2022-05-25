String describeUser(String userGroup){
  if(userGroup=="Alpha 1 Male")return "This is alpha male 1.";
  if(userGroup=="Alpha 2 Male")return "This is alpha male 2.";
  if(userGroup=="Alpha 3 Male")return "This is alpha male 3.";
  if(userGroup=="Alpha 4 Male")return "This is alpha male 4.";
  if(userGroup=="Alpha 5 Male")return "This is alpha male 5.";
  if(userGroup=="Alpha 6 Male")return "This is alpha male 6.";
  if(userGroup=="Alpha 7 Male")return "This is alpha male 7.";
  if(userGroup=="Beta 1 Male")return "This is Beta male 1.";
  if(userGroup=="Beta 2 Male")return "This is Beta male 2.";
  if(userGroup=="Beta 3 Male")return "This is Beta male 3.";
  if(userGroup=="Beta 4 Male")return "This is Beta male 4.";
  if(userGroup=="Beta 5 Male")return "This is Beta male 5.";
  if(userGroup=="Beta 6 Male")return "This is Beta male 6.";
  if(userGroup=="Beta 7 Male")return "This is Beta male 7.";
  if(userGroup=="Alpha 1 Female")return "This is alpha female 1.";
  if(userGroup=="Alpha 2 Female")return "This is alpha female 2.";
  if(userGroup=="Alpha 3 Female")return "This is alpha female 3.";
  if(userGroup=="Alpha 4 Female")return "This is alpha female 4.";
  if(userGroup=="Alpha 5 Female")return "This is alpha female 5.";
  if(userGroup=="Alpha 6 Female")return "This is alpha female 6.";
  if(userGroup=="Alpha 7 Female")return "This is alpha female 7.";
  if(userGroup=="Beta 1 Female")return "This is beta female 1.";
  if(userGroup=="Beta 2 Female")return "This is beta female 2.";
  if(userGroup=="Beta 3 Female")return "This is beta female 3.";
  if(userGroup=="Beta 4 Female")return "This is beta female 4.";
  if(userGroup=="Beta 5 Female")return "This is beta female 5.";
  if(userGroup=="Beta 6 Female")return "This is beta female 6.";
  if(userGroup=="Beta 7 Female")return "This is beta female 7.";
  return "Other ";


}
class Description{
  String currentUserGroup;
  String currentUserGender;
  String otherUserGroup;
  String otherUserGender;
  Description({this.currentUserGender,this.currentUserGroup,this.otherUserGender,this.otherUserGroup});

  String getDescription(){
    print(otherUserGender);
    print( otherUserGroup);
    String description="NOT ASSIGNED";
      if(otherUserGender=="Male"){
        switch(otherUserGroup){
          case "Alpha 1":description=describeUser("Alpha 1 Male");
          break;
          case "Alpha 2":description=currentUserGroup=="Alpha 2" ?
          describeUser("Alpha 1 Male") : describeUser("Alpha 2 Male");
          break;
          case "Alpha 3":description=currentUserGroup=="Alpha 3" ?
          describeUser("Alpha 1 Male") : describeUser("Alpha 3 Male");
          break;
          case "Alpha 4":description=currentUserGroup=="Alpha 4" ?
          describeUser("Alpha 1 Male") : describeUser("Alpha 4 Male");
          break;
          case "Alpha 5":description=currentUserGroup=="Alpha 5" ?
          describeUser("Alpha 1 Male") : describeUser("Alpha 5 Male");
          break;
          case "Alpha 6":description=currentUserGroup=="Alpha 6" ?
          describeUser("Alpha 1 Male") : describeUser("Alpha 6 Male");
          break;
          case "Alpha 7":description=currentUserGroup=="Alpha 7" ?
          describeUser("Alpha 1 Male") : describeUser("Alpha 7 Male");
          break;
          case "Beta 1":description=currentUserGroup=="Beta 1"
              && currentUserGender!=otherUserGender  ?
          describeUser("Alpha 1 Male") : describeUser("Beta 1 Male");
          break;
          case "Beta 2":description=currentUserGroup=="Beta 2"
              && currentUserGender!=otherUserGender  ?
          describeUser("Alpha 1 Male") : describeUser("Beta 2 Male");
          break;
          case "Beta 3":description=currentUserGroup=="Beta 3"
              && currentUserGender!=otherUserGender  ?
          describeUser("Alpha 1 Male") : describeUser("Beta 3 Male");
          break;
          case "Beta 4":description=currentUserGroup=="Beta 4"
              && currentUserGender!=otherUserGender  ?
          describeUser("Alpha 1 Male") : describeUser("Beta 4 Male");
          break;
          case "Beta 5":description=currentUserGroup=="Beta 5"
              && currentUserGender!=otherUserGender  ?
          describeUser("Alpha 1 Male") : describeUser("Beta 5 Male");
          break;
          case "Beta 6":description=currentUserGroup=="Beta 6"
              && currentUserGender!=otherUserGender  ?
          describeUser("Alpha 1 Male") : describeUser("Beta 6 Male");
          break;
          case "Beta 7":description=currentUserGroup=="Beta 7"
              && currentUserGender!=otherUserGender  ?
          describeUser("Alpha 1 Male") : describeUser("Beta 7 Male");
          break;
        }
      }
      else if(otherUserGender=="Female"){
        switch(otherUserGroup){
          case "Alpha 1":description=describeUser("Alpha 1 Female");
          break;
          case "Alpha 2":description=currentUserGroup=="Alpha 2" ?
          describeUser("Alpha 1 Female") : describeUser("Alpha 2 Female");
          break;
          case "Alpha 3":description=currentUserGroup=="Alpha 3" ?
          describeUser("Alpha 1 Female") : describeUser("Alpha 3 Female");
          break;
          case "Alpha 4":description=currentUserGroup=="Alpha 4" ?
          describeUser("Alpha 1 Female") : describeUser("Alpha 4 Female");
          break;
          case "Alpha 5":description=currentUserGroup=="Alpha 5" ?
          describeUser("Alpha 1 Female") : describeUser("Alpha 5 Female");
          break;
          case "Alpha 6":description=currentUserGroup=="Alpha 6" ?
          describeUser("Alpha 1 Female") : describeUser("Alpha 6 Female");
          break;
          case "Alpha 7":description=currentUserGroup=="Alpha 7" ?
          describeUser("Alpha 1 Female") : describeUser("Alpha 7 Female");
          break;
          case "Beta 1":description=currentUserGroup=="Beta 1"
              && currentUserGender!=otherUserGender  ?
          describeUser("Alpha 1 Female") : describeUser("Beta 1 Female");
          break;
          case "Beta 2":description=currentUserGroup=="Beta 2"
              && currentUserGender!=otherUserGender  ?
          describeUser("Alpha 1 Female") : describeUser("Beta 2 Female");
          break;
          case "Beta 3":description=currentUserGroup=="Beta 3"
              && currentUserGender!=otherUserGender  ?
          describeUser("Alpha 1 Female") : describeUser("Beta 3 Female");
          break;
          case "Beta 4":description=currentUserGroup=="Beta 4"
              && currentUserGender!=otherUserGender  ?
          describeUser("Alpha 1 Female") : describeUser("Beta 4 Female");
          break;
          case "Beta 5":description=currentUserGroup=="Beta 5"
              && currentUserGender!=otherUserGender  ?
          describeUser("Alpha 1 Female") : describeUser("Beta 5 Female");
          break;
          case "Beta 6":description=currentUserGroup=="Beta 6"
              && currentUserGender!=otherUserGender  ?
          describeUser("Alpha 1 Female") : describeUser("Beta 6 Female");
          break;
          case "Beta 7":description=currentUserGroup=="Beta 7"
              && currentUserGender!=otherUserGender  ?
          describeUser("Alpha 1 Female") : describeUser("Beta 7 Female");
          break;
        }

      }
    return description;
  }
}