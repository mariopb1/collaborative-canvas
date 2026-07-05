import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  static const tableName = 'pixels';
  final supabase = Supabase.instance.client;

  // Speichert ein gemaltes Pixel in der Datenbank
  Future<void> setPixel(int id, Color color) async {
    int colorAsInt = color.toARGB32();
    Map<String, dynamic> data = {'id': id, 'color': colorAsInt};

    // upsert: einfügen wenn neu, aktualisieren wenn schon existiert
    await supabase.from(tableName).upsert(data);
  }

  // Holt die Daten in Echtzeit aus der Datenbank
  Stream<List<Map<String, dynamic>>> getPixelStream() {
    return supabase.from(tableName).stream(primaryKey: ['id']);
  }
}
