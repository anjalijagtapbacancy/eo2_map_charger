class ResponseMsgId22 {
  int msgId;
  Properties22 properties;

  ResponseMsgId22({this.msgId, this.properties});

  ResponseMsgId22.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties22.fromJson(json['properties'])
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

class Properties22 {
  int starttm;
  int status;

  Properties22({this.starttm, this.status});

  Properties22.fromJson(Map<String, dynamic> json) {
    starttm = json['starttm'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['starttm'] = this.starttm;
    data['status'] = this.status;
    return data;
  }
}
