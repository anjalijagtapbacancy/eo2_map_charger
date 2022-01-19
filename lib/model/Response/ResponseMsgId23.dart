class ResponseMsgId23 {
  int msgId;
  Properties23 properties;

  ResponseMsgId23({this.msgId, this.properties});

  ResponseMsgId23.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties23.fromJson(json['properties'])
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

class Properties23 {
  String fwVersion;
  int status;

  Properties23({this.fwVersion, this.status});

  Properties23.fromJson(Map<String, dynamic> json) {
    fwVersion = json['fw_version'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fw_version'] = this.fwVersion;
    data['status'] = this.status;
    return data;
  }
}
