class UserStory {
  int id;
  String accountName;
  String backgroundImg;
  String accountPhoto;

  UserStory(int id, String accountName, String backgroundImg, String accountPhoto) {
    this.id = id;
    this.accountName = accountName;
    this.backgroundImg = backgroundImg;
    this.accountPhoto = accountPhoto;
  }

  UserStory.fromJson(Map json)
    : id = json['id'],
      accountName = json['accountName'],
      backgroundImg = json['backgroundImg'],
      accountPhoto = json['accountPhoto'];

  Map toJson() {
    return {
      'id': id,
      'accountName': accountName,
      'backgroundImg': backgroundImg,
      'accountPhoto': accountPhoto
    };
  }

}