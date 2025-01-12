import 'package:hive/hive.dart';
part 'persistent_data.model.g.dart';

@HiveType(typeId: 0)
class PersistentDataModel {
  const PersistentDataModel({
    this.recentlySearchedCities,
    this.isCelsius,
  });

  @HiveField(0)
  final List<String>? recentlySearchedCities;

  @HiveField(1)
  final bool? isCelsius;

  PersistentDataModel copyWith({
    List<String>? recentlySearchedCities,
    bool? isCelsius,
  }) {
    return PersistentDataModel(
      recentlySearchedCities:
          recentlySearchedCities ?? this.recentlySearchedCities,
      isCelsius: isCelsius ?? this.isCelsius,
    );
  }
}
