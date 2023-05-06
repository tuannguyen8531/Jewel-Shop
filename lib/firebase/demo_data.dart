List<GemType> gems = [
  GemType(title: "Diamond", icon: "assets/images/diamond.png"),
  GemType(title: "Ruby", icon: "assets/images/ruby.png"),
  GemType(title: "Sapphire", icon: "assets/images/sapphire.png"),
  GemType(title: "Emerald", icon: "assets/images/emerald.png"),
];

class GemType {
  String title;
  String icon;
  GemType({required this.title, required this.icon});
}
