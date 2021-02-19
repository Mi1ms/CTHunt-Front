import 'package:ct_hunt/data/models.dart';

List<Quest> parseQuests(var quests) {
  List<Quest> newQuests = [];
  for (int i = 0; i < quests.length; i++) {
    var quest = quests[i];
    newQuests.add(
      new Quest(
        id: quest['id'],
        title: quest['title'],
        description: quest['description'],
        level: quest['level'],
        latitude: quest['latitude'],
        longitude: quest['longitude'],
        solution: quest['solution'],
        tip: quest['tip'],
      )
    );
  }
  return  newQuests;
}