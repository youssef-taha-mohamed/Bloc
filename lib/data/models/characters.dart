class Character {
  late int charId;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic> jobs;
  late String statusIfDeadOrAlive;
  late List<dynamic> appearanceOfSeasons;
  late String actorName;
  late String categoryForTwoSeries;
  late List<dynamic> betterCallSualAppearance;

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    nickName = json['nickName'] ?? '';
    image = json['img'];
    jobs = json['occupation'];
    statusIfDeadOrAlive = json['status'];
    appearanceOfSeasons = json['appearance'];
    actorName = json['portraed'] ?? '';
    categoryForTwoSeries = json['category'];
    betterCallSualAppearance = json['better_call_asul_appearance']!;
  }
}
