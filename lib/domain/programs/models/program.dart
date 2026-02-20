class Program {
  final int id;
  final String name;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String locationName;
  final String displayUrl;
  final String category;
  final bool isFavorite;
  final int locationId;

  Program({
    required this.id,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.locationName,
    required this.displayUrl,
    required this.category,
    required this.isFavorite,
    required this.locationId,
  });

  Program copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? locationName,
    String? displayUrl,
    String? category,
    bool? isFavorite,
    int? locationId,
  }) {
    return Program(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      locationName: locationName ?? this.locationName,
      displayUrl: displayUrl ?? this.displayUrl,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      locationId: locationId ?? this.locationId,
    );
  }
}
