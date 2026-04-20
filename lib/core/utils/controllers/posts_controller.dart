import 'dart:io';
import 'package:merhaba/main_development.dart';
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';

class PostsController {
  static Future<Map<String, dynamic>> uploadPostMedia(File file) async {
    try {
      String fileName =
          "${DateTime.now().toIso8601String().replaceAll(" ", "").replaceAll(".", "").replaceAll(":", "")}_${p.basename(file.path).replaceAll(" ", "")}";

      final String fullPath = await Supabase.instance.client.storage
          .from('Posts')
          .upload(
            fileName,
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      final String publicUrl = await Supabase.instance.client.storage
          .from("Posts")
          .getPublicUrl(fileName);

      return {
        "result": true,
        "message": "Uploaded successfully ... ",
        "url": publicUrl,
        "fileName": fileName,
        "fullPath": fullPath,
      };
    } catch (e) {
      print(e.toString());
      return {"result": false, "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> addPost(Map<String, dynamic> data) async {
    try {
      var uid = await secureStorage.read(key: "uid");

      if (uid == null) {
        return {"result": false, "message": "Please login again!!"};
      }

      data["user_id"] = uid;
      data["added_by"] = uid;
      data["updated_by"] = uid;
      data["date_added"] = DateTime.now().toIso8601String();
      data["date_updated"] = DateTime.now().toIso8601String();

      await Supabase.instance.client.from("posts").insert(data);

      return {"result": true, "message": "Posted successfully ... "};
    } catch (e) {
      print(e.toString());
      return {"result": false, "message": e.toString()};
    }
  }
}
