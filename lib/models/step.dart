class Step {
  int id;
  int processId;
  String qrCode;
  String name;
  String content;

  Step({
    this.id,
    this.processId,
    this.qrCode,
    this.name,
    this.content,
  });

  Step.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    processId = json['process_id'];
    qrCode = json['qr_code'];
    name = json['name'];
    content = json['content'];
  }

  factory Step.convertToStep(Map<String, dynamic> json) {
    return Step(
      id: json['id'],
      processId: json['process_id'],
      qrCode: json['qr_code'],
      name: json['name'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['process_id'] = this.processId;
    data['qr_code'] = this.qrCode;
    data['name'] = this.name;
    data['content'] = this.content;

    return data;
  }
}
