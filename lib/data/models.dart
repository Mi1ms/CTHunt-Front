class Quest {
  final int id;
  final String title;
  final String description;
  final String level;
  final double latitude;
  final double longitude;
  final String tip;
  final String solution;

  const Quest(
      {this.id = -1,
      this.title = "",
      this.description = "",
      this.level = "",
      this.latitude = 0,
      this.longitude = 0,
      this.tip = "",
      this.solution = ""});
}
