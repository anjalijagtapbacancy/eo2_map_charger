class CommonRequest {
  int msgId;

  CommonRequest({this.msgId});

  CommonRequest.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg_id'] = this.msgId;
    return data;
  }

  static CommonRequest setData(int msg_id) {
    CommonRequest commonRequest = new CommonRequest(msgId: msg_id);
    return commonRequest;
  }
}
