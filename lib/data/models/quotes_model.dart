class QuoteModel {
  String quote;
  QuoteModel({
    required this.quote,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
        quote: json["quote"],
      );
}
