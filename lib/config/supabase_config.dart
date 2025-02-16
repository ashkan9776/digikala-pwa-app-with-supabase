import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://addyaqafbaqqisyitndb.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFkZHlhcWFmYmFxcWlzeWl0bmRiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkxOTE3MjMsImV4cCI6MjA1NDc2NzcyM30.cpsCpEN8mxXgNyy-i2ZBh1kXnAoOta5TGUxz405nMFo',
    );
  }
}
