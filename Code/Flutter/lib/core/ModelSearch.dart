import 'dart:convert';

ModelSearch modelSearchFromJson(String str) => ModelSearch.fromJson(json.decode(str));

String modelSearchToJson(ModelSearch data) => json.encode(data.toJson());

class ModelSearch {
  List<List<double>>? distances;
  List<List<String>>? documents;

  ModelSearch({
    this.distances,
    this.documents,
  });

  factory ModelSearch.fromJson(Map<String, dynamic> json) => ModelSearch(
    distances: json["distances"] == null ? [] : List<List<double>>.from(json["distances"]!.map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
    documents: json["documents"] == null ? [] : List<List<String>>.from(json["documents"]!.map((x) => List<String>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    "distances": distances == null ? [] : List<dynamic>.from(distances!.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}
