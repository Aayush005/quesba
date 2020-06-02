import 'base_model.dart';

class UserModel extends BaseModel {
  int DomainId;
  int EmailId;
  int Password;


  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    DomainId = parsedJson['DomainId'];
    EmailId = parsedJson['EmailId'];
    Password = parsedJson['Password'];

  }

  static List<UserModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
      return UserModel.fromJson(item);
    })?.toList();
  }
}