class YesNoModel {
  final String answer;
  final bool forced;
  final String image;

  YesNoModel({
    required this.answer,
    required this.forced,
    required this.image,
  });

  factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
        answer: json['answer'] as String,
        forced: (json['forced'] ?? json['focer'] ?? false) as bool,
        image: json['image'] as String,
      );
}
