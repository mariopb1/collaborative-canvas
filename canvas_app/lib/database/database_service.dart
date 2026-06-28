import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  // TODO: this name has to be the name of your supabase table!
  static const tableName = 'pixels';

  // Get a reference your Supabase client
  final supabase = Supabase.instance.client;

  // Save information on one Pixel in database
  Future<void> setPixel(int id, Color color) async {
    int colorAsInt = color.toARGB32();
    Map<String, int> data = {'id': id, 'color': colorAsInt};

    // use upsert to insert data if id doesn't exist yet und update data if id already exists
    await supabase.from(tableName).upsert(data);
  }

  // Get saved data from database (complete table)
  Stream getPixelStream() {
    Stream stream = supabase.from(tableName).stream(primaryKey: ['id']);
    return stream;
  }
}