import 'package:flutter/material.dart';
import 'package:merhaba/main_development.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostInteractionsController {
  static Future<Map<String, dynamic>> addReactionToPost(
    int postId,
    String reactType,
  ) async {
    try {
      var uid = await secureStorage.read(key: "uid");
      if (uid == null) {
        return {"result": false, "message": "Please login again!"};
      }

      final oldReaction = await Supabase.instance.client
          .from("post_interactions")
          .select()
          .eq("post_id", postId)
          .eq("user_id", uid)
          .maybeSingle();

      // لو فيه reaction قديم -> update
      if (oldReaction != null) {
        await Supabase.instance.client
            .from("post_interactions")
            .update({
              "react_type": reactType,
              "date_updated": DateTime.now().toIso8601String(),
              "updated_by": uid,
            })
            .eq("id", oldReaction["id"]);
        return {"result": true, "message": "Updated successfully ..."};
      }





      Map<String, dynamic> data = {
        "user_id": uid,
        "post_id": postId,
        "react_type": reactType,
        "date_added": DateTime.now().toIso8601String(),
        "date_updated": "",
        "added_by": uid,
        "updated_by": "",
        "active": true,
      };

      await Supabase.instance.client.from("post_interactions").insert(data);
      return {"result": true, "message": "Saved successfully ..."};
    } catch (e) {
      debugPrint(e.toString());
      return {"result": false, "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> removeReactionToPost(int postId) async {
    try {
      var uid = await secureStorage.read(key: "uid");
      if (uid == null) {
        return {"result": false, "message": "Please login again!"};
      }

      await Supabase.instance.client
          .from("post_interactions")
          .delete()
          .eq("post_id", postId)
          .eq("user_id", uid);
      // .update({
      //   "active": false,
      //   "date_updated": DateTime.now().toIso8601String(),
      //   "updated_by": uid,
      // })
      // .eq("post_id", postId)
      // .eq("user_id", uid);

      return {"result": true, "message": "Removed successfully ..."};
    } catch (e) {
      debugPrint(e.toString());
      return {"result": false, "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> updateReactionToPost(
    int id,
    String reactType,
  ) async {
    try {
      var uid = await secureStorage.read(key: "uid");
      if (uid == null) {
        return {"result": false, "message": "Please login again!"};
      }

      await Supabase.instance.client
          .from("post_interactions")
          .update({
            "react_type": reactType,
            "date_updated": DateTime.now().toIso8601String(),
            "updated_by": uid,
          })
          .eq("id", id);

      return {"result": true, "message": "Updated successfully ..."};
    } catch (e) {
      debugPrint(e.toString());
      return {"result": false, "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> getPostInteractions(int postId) async {
    try {
      var uid = await secureStorage.read(key: "uid");
      if (uid == null) {
        return {"result": false, "message": "Please login again!"};
      }

      var res = await Supabase.instance.client
          .from("post_interactions")
          .select()
          .eq("post_id", postId)
          .eq("active", true);

      res = res.map((r) => {...r, "isMine": r["user_id"] == uid}).toList();

      return {
        "result": true,
        "message": "Retrieved successfully ...",
        "data": res,
      };
    } catch (e) {
      debugPrint(e.toString());
      return {"result": false, "message": e.toString()};
    }
  }
}
