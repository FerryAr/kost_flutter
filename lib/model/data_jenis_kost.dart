class DataJenisKost {
  DataJenisKost({
    required this.status,
    required this.data,
  });
  late final String status;
  late final List<Data> data;

  DataJenisKost.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.jenis,
  });
  late final String id;
  late final String jenis;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jenis = json['jenis'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['jenis'] = jenis;
    return _data;
  }
}
