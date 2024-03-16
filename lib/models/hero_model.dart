// Define a model for Marvel hero information.
// This class encapsulates the data for a single Marvel hero, including properties
// such as name, description, and image URL, ensuring a structured approach to handling hero data.

// Representation of a Marvel Series
class Series {
  final String name;
  final String resourceURI;

  Series({required this.name, required this.resourceURI});

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      name: json['name'],
      resourceURI: json['resourceURI'],
    );
  }

  static List<Series> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Series.fromJson(json)).toList();
  }

  @override
  String toString() {
    // Retorna uma representação string do objeto Series
    return name;
  }
}

// Representation of a Marvel Event
class Event {
  final String name;
  final String resourceURI;

  Event({required this.name, required this.resourceURI});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      resourceURI: json['resourceURI'],
    );
  }

  static List<Event> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Event.fromJson(json)).toList();
  }

  @override
  String toString() {
    // Retorna uma representação string do objeto Series
    return name;
  }
}

class HeroModel {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final List<Series> series;
  final List<Event> events;

  // Constructor initializes a HeroModel with data.
  HeroModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.series,
    required this.events,
  });

  // Factory constructor for creating a HeroModel from a JSON map.
  // This constructor enables the creation of HeroModel instances from JSON data, facilitating data parsing and object instantiation.
  factory HeroModel.fromJson(Map<String, dynamic> json) {
    return HeroModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      imageUrl:
          "${json['thumbnail']['path']}.${json['thumbnail']['extension']}",
      series: Series.fromJsonList(json['series']['items']),
      events: Event.fromJsonList(json['events']['items']),
    );
  }

  // Method to convert a list of JSON maps to a list of HeroModels.
  // This static method supports converting raw JSON data into a structured list of HeroModels, streamlining the parsing process.
  static List<HeroModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => HeroModel.fromJson(json)).toList();
  }
}
