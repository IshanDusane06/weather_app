import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/pages/home_page/model/persistent_data.model.dart';

class PersistentDataService {
  // static var hiveBox;
  // static var dataBox;

  static Future initHiveBox() async {
    // hiveBox = Hive.openBox<PersistentDataModel>('data');
    // dataBox = Hive.box<PersistentDataModel>('data');
  }

  Future<PersistentDataModel?> getData() async {
    try {
      // await initHiveBox();
      await Hive.openBox<PersistentDataModel>('data');
      final dataBox = Hive.box<PersistentDataModel>('data');
      return dataBox.get('citiesAndPreference');
    } catch (e) {
      throw FlutterError('Unable to fetch users preferences');
    }
  }

  Future putData(PersistentDataModel data) async {
    try {
      // await initHiveBox();
      Hive.openBox<PersistentDataModel>('data');
      final dataBox = Hive.box<PersistentDataModel>('data');
      var dataModel = PersistentDataModel(
        recentlySearchedCities: data.recentlySearchedCities,
        isCelsius: data.isCelsius,
      );
      return dataBox.put('citiesAndPreference', dataModel);
    } catch (e) {
      throw FlutterError('Unable to set users preferences');
    }
  }
}
