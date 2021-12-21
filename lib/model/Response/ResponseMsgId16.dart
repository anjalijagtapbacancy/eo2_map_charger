class ResponseMsgId16 {
  int msgId;
  Properties16 properties;

  ResponseMsgId16({this.msgId, this.properties});

  ResponseMsgId16.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties16.fromJson(json['properties'])
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

class Properties16 {
  int log;
  int status;

  Properties16({this.log, this.status});

  Properties16.fromJson(Map<String, dynamic> json) {
    log = json['log'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['log'] = this.log;
    data['status'] = this.status;
    return data;
  }
}
