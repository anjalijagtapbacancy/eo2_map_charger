class RequestMsgId2 {
  int msgId;
  Properties properties;

  RequestMsgId2({this.msgId, this.properties});

  RequestMsgId2.fromJson(Map<String, dynamic> json) {
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

  static RequestMsgId2 setData(int msgId, bool Scheduling, int wdStartTime,
      int wdEndTime, int weStartTime, int weEndTime, int maxCurrent) {
    RequestMsgId2 requestMsgId2 = new RequestMsgId2();
    Properties properties = new Properties(
        isSchedule: Scheduling ? 1 : 0,
        wdStartTm: wdStartTime,
        wdEndTm: wdEndTime,
        weStartTm: weStartTime,
        weEndTm: weEndTime,schMaxCurrent: maxCurrent);
    requestMsgId2.msgId = msgId;
    requestMsgId2.properties = properties;
    return requestMsgId2;
  }
}

class Properties {
  int isSchedule;
  int wdStartTm;
  int wdEndTm;
  int weStartTm;
  int weEndTm;
  int schMaxCurrent;

  Properties(
      {this.isSchedule,
      this.wdStartTm,
      this.wdEndTm,
      this.weStartTm,
      this.weEndTm,
      this.schMaxCurrent});

  Properties.fromJson(Map<String, dynamic> json) {
    isSchedule = json['is_schedule'];
    wdStartTm = json['wd_start_tm'];
    wdEndTm = json['wd_end_tm'];
    weStartTm = json['we_start_tm'];
    weEndTm = json['we_end_tm'];
    schMaxCurrent = json['sch_max_current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_schedule'] = this.isSchedule;
    data['wd_start_tm'] = this.wdStartTm;
    data['wd_end_tm'] = this.wdEndTm;
    data['we_start_tm'] = this.weStartTm;
    data['we_end_tm'] = this.weEndTm;
    data['sch_max_current'] = this.schMaxCurrent;
    return data;
  }
}
