class RequestMsgId4 {
  int msgId;
  Properties properties;

  RequestMsgId4({this.msgId, this.properties});

  RequestMsgId4.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
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

  static RequestMsgId4 setData(int msgId, String url, String fileName) {
    RequestMsgId4 requestMsgId4 = new RequestMsgId4();
    Properties properties = new Properties(fileName: fileName, url: url);
    requestMsgId4.msgId = msgId;
    requestMsgId4.properties = properties;
    return requestMsgId4;
  }
}

class Properties {
  String fileName;
  String url;

  Properties({this.fileName, this.url});

  Properties.fromJson(Map<String, dynamic> json) {
    fileName = json['file_name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_name'] = this.fileName;
    data['url'] = this.url;
    return data;
  }
}
