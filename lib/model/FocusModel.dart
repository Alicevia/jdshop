class FocusModel {
  late List<FocusItemModel> result;
  FocusModel({required this.result});
  FocusModel.fromJSON(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = List.empty(growable: true);
      json['result'].forEach((v) {
        result.add(new FocusItemModel.fromJSON(v));
      });
    }
  }
}

class FocusItemModel {
  late String sId;
  late String title;
  late String status;
  late String pic;
  late dynamic url;
  FocusItemModel(this.sId, this.title, this.status, this.pic, this.url);
  FocusItemModel.fromJSON(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    url = json['url'];
  }
  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['url'] = this.url;
    return data;
  }
}
