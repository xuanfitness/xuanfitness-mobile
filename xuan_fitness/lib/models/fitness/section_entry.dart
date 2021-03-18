enum Type{ exercise, circuit, superset }
class SectionEntry{
  Type type;
  String id, name;
  SectionEntry(this.id, this.name, this.type);
  SectionEntry.fromJson(Map<String, dynamic>json):
      id = json["id"],
      name = json["name"],
      type = Type.values[json["type"]];
}