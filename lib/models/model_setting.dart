class SettingModel {
  String? sId;
  bool? likeAlarm;
  bool? replyAlarm;
  bool? systemAlarm;
  bool? emailSend;
  bool? mateJoinAlarm;
  bool? mateAcceptAlarm;
  bool? messageAlarm;

  SettingModel(
      {this.sId,
      this.likeAlarm,
      this.replyAlarm,
      this.systemAlarm,
      this.emailSend,
      this.mateJoinAlarm,
      this.mateAcceptAlarm,
      this.messageAlarm});

  SettingModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    likeAlarm = json['likeAlarm'];
    replyAlarm = json['replyAlarm'];
    systemAlarm = json['systemAlarm'];
    emailSend = json['emailSend'];
    mateJoinAlarm = json['mateJoinAlarm'];
    mateAcceptAlarm = json['mateAcceptAlarm'];
    messageAlarm = json['messageAlarm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['likeAlarm'] = likeAlarm;
    data['replyAlarm'] = replyAlarm;
    data['systemAlarm'] = systemAlarm;
    data['emailSend'] = emailSend;
    data['mateJoinAlarm'] = mateJoinAlarm;
    data['mateAcceptAlarm'] = mateAcceptAlarm;
    data['messageAlarm'] = messageAlarm;
    return data;
  }
}
