class MessgeModel {
  String? senderId;
  String? reciverId;
  String? dateTime;
  String? text;
  String? image;
  MessgeModel({
    this.senderId,
    this.reciverId,
    this.dateTime,
    this.text,
    this.image,
  });
  MessgeModel.fromJson(Map<String?, dynamic> json) {
    senderId = json['senderId'];
    reciverId = json['reciverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    image = json['image'];
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'reciverId': reciverId,
      'dateTime': dateTime,
      'text': text,
      'image': image,
    };
  }
}
