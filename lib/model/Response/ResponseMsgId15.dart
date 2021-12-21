class ResponseMsgId15 {
  int msgId;
  Properties15 properties;

  ResponseMsgId15({this.msgId, this.properties});

  ResponseMsgId15.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties15.fromJson(json['properties'])
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

class Properties15 {
  int isSchedule;
  int wdStartTm;
  int wdEndTm;
  int weStartTm;
  int weEndTm;
  int schMaxCurrent;
  int status;

  Properties15(
      {this.isSchedule,
      this.wdStartTm,
      this.wdEndTm,
      this.weStartTm,
      this.weEndTm,
      this.schMaxCurrent,
      this.status});

  Properties15.fromJson(Map<String, dynamic> json) {
    isSchedule = json['is_schedule'];
    wdStartTm = json['wd_start_tm'];
    wdEndTm = json['wd_end_tm'];
    weStartTm = json['we_start_tm'];
    weEndTm = json['we_end_tm'];
    schMaxCurrent = json['sch_max_current'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_schedule'] = this.isSchedule;
    data['wd_start_tm'] = this.wdStartTm;
    data['wd_end_tm'] = this.wdEndTm;
    data['we_start_tm'] = this.weStartTm;
    data['we_end_tm'] = this.weEndTm;
    data['sch_max_current'] = this.schMaxCurrent;
    data['status'] = this.status;
    return data;
  }
}
