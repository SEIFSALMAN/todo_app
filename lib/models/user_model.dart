class UserModel
{
  String? name;
  String? email;
  String? uId;
  String? phoneNumber;

  UserModel({this.name, this.email, this.uId,this.phoneNumber});

  UserModel.fromJSON(Map <String,dynamic>json){
    email = json['email'];
    name = json['name'];
    uId = json['uId'];
    phoneNumber = json['phoneNumber'];
  }
  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'email': email,
      'uId':uId,
      'phoneNumber':phoneNumber
    };
  }

}