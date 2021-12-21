class ResponseMsgId12 {
  int msgId;
  Properties12 properties;

  ResponseMsgId12({this.msgId, this.properties});

  ResponseMsgId12.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties12.fromJson(json['properties'])
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

class Properties12 {
  int type;
  List<Array12> array;
  int status;

  Properties12({this.type, this.array, this.status});

  Properties12.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['array'] != null) {
      array = new List<Array12>();
      json['array'].forEach((v) {
        array.add(new Array12.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.array != null) {
      data['array'] = this.array.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Array12 {
  num energy;

  Array12({this.energy});

  Array12.fromJson(Map<String, dynamic> json) {
    energy = json['energy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['energy'] = this.energy;
    return data;
  }
}
