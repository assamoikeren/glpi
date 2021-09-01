class Observer {
  int id;
  String name;

  Observer({
    this.id,
    this.name,
  });

  Observer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  factory Observer.convertToObserver(Map<String, dynamic> json) {
    return Observer(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
