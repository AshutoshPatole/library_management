import 'dart:convert';

Books booksFromJson(String str) => Books.fromJson(json.decode(str));

String booksToJson(Books data) => json.encode(data.toJson());

class Books {
  Books({
    this.id,
    this.accNo,
    this.title,
    this.author,
    this.edition,
    this.pubYear,
    this.publisher,
    this.callNo,
    this.materialStatus,
    this.materialType,
    this.v,
  });

  String id;
  int accNo;
  String title;
  String author;
  int edition;
  int pubYear;
  String publisher;
  String callNo;
  String materialStatus;
  String materialType;
  int v;

  factory Books.fromJson(Map<String, dynamic> json) => Books(
        id: json["_id"],
        accNo: json["AccNo"],
        title: json["Title"],
        author: json["Author"],
        edition: json["Edition"],
        pubYear: json["PubYear"],
        publisher: json["Publisher"],
        callNo: json["CallNo"],
        materialStatus: json["MaterialStatus"],
        materialType: json["MaterialType"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "AccNo": accNo,
        "Title": title,
        "Author": author,
        "Edition": edition,
        "PubYear": pubYear,
        "Publisher": publisher,
        "CallNo": callNo,
        "MaterialStatus": materialStatus,
        "MaterialType": materialType,
        "__v": v,
      };
}
