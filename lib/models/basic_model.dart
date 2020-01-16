import 'dart:convert';

class BasicModel {
  BasicModel({
    this.initialData,
  });

  Map<String, dynamic> initialData;

  BasicModel.fromJson(
    Map<String, dynamic> data
  ) {
    initialData = data;
  }

  @override
  String toString() {
    if (initialData is Map) {
      return json.encode(initialData);
    }
    return initialData.toString();
  }

  Map<String, dynamic> toJson() {
    return initialData;
  }
}