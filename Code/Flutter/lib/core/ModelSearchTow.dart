import 'dart:convert';

ModelSearchTow modelSearchFromJson(String str) => ModelSearchTow.fromJson(json.decode(str));

String modelSearchToJson(ModelSearchTow data) => json.encode(data.toJson());

class ModelSearchTow {
  List<List<double>>? distances;
  List<List<String>>? documents;

  ModelSearchTow({
    this.distances,
    this.documents,
  });

  factory ModelSearchTow.fromJson(Map<String, dynamic> json) => ModelSearchTow(
    distances: json["distances"] == null ? [] : List<List<double>>.from(json["distances"]!.map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
    documents: json["documents"] == null ? [] : List<List<String>>.from(json["documents"]!.map((x) => List<String>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    "distances": distances == null ? [] : List<dynamic>.from(distances!.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}
