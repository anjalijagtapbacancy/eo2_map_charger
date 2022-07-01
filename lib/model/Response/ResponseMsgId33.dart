class ResponseMsgId33 {
  int msgId;
  Properties33 properties;

  ResponseMsgId33({this.msgId, this.properties});

  ResponseMsgId33.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties33.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg_id'] = this.msgId;
    if (this.properties != null) {
      data['properties'] = this.properties.toJson();
    }
    return data;
  }
}

class Properties33 {
  List<Array33> array;
  int status;

  Properties33({this.array, this.status});

  Properties33.fromJson(Map<String, dynamic> json) {
    if (json['array'] != null) {
      array = <Array33>[];
      json['array'].forEach((v) {
        array.add(new Array33.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.array != null) {
      data['array'] = this.array.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Array33 {
  String idTag;

  Array33({this.idTag});

  Array33.fromJson(Map<String, dynamic> json) {
    idTag = json['id_tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_tag'] = this.idTag;
    return data;
  }
}
