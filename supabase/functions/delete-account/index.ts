
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

Deno.serve(async (req) => {
  try {
    const authHeader = req.headers.get("Authorization");

    if (!authHeader) {
      return new Response(JSON.stringify({ error: "No auth header" }), {
        status: 401,
      });
    }

    const token = authHeader.replace("Bearer ", "");

    const supabaseAdmin = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SERVICE_ROLE_KEY")!
    );

    const {
      data: { user },
      error,
    } = await supabaseAdmin.auth.getUser(token);

    if (error || !user) {
      return new Response(JSON.stringify({ error: "Invalid token" }), {
        status: 401,
      });
    }

    const user_id = user.id;

    // 1. Get posts
    // const { data: posts } = await supabaseAdmin
    //   .from("posts")
    //   .select("file_name")
    //   .eq("user_id", user_id);
      const { data: posts } = await supabaseAdmin
  .from("posts")
  .select("content")
  .eq("user_id", user_id);


    // console.log("POSTS DATA:", posts);


    // 2. Get comments
    const { data: comments } = await supabaseAdmin
      .from("post_comments")
      .select("file_name")
      .eq("user_id", user_id);

   // 3. Delete storage (posts)
const postFiles: string[] = [];

posts?.forEach((post) => {
 try {
   const content =
     typeof post.content === "string"
       ? JSON.parse(post.content)
       : post.content;
 
   const media = content?.media ?? [];
 
   media.forEach((item: any) => {
     if (item.fileName) {
       postFiles.push(item.fileName);
     }
   });
 } catch (e) {
    console.error("Failed to parse post content:", e);

 }
});

    //console.log("POST FILES:", postFiles);

if (postFiles.length) {
 // const { error } = 
  
  await supabaseAdmin.storage
    .from("Posts")
    .remove(postFiles);

 // console.log("DELETE POSTS ERROR:", error);
}

    // 4. Delete storage (comments)
    if (comments?.length) {
      const files = comments.map((c) => c.file_name).filter(Boolean);
      if (files.length) {
// const { error } =

await supabaseAdmin.storage
  .from("Comments")
  .remove(files);

// console.log("DELETE COMMENTS ERROR:", error);    

}
    }

    // 5. Delete DB data
    await supabaseAdmin.from("post_comments").delete().eq("user_id", user_id);
    await supabaseAdmin.from("posts").delete().eq("user_id", user_id);
    await supabaseAdmin.from("post_interactions").delete().eq("user_id", user_id);


// const { error: userImageError } = 

await supabaseAdmin.storage
  .from("Users")
  .remove([`${user_id}.jpg`]);

// console.log("DELETE USER IMAGE ERROR:", userImageError);


    // 6. Delete auth user
    await supabaseAdmin.auth.admin.deleteUser(user_id);

    return new Response(
      JSON.stringify({
        success: true,
        message: "Account deleted successfully",
      }),
      { status: 200 }
    );
  } catch (err) {
    return new Response(
      JSON.stringify({
        success: false,
        error: err.message,
      }),
      { status: 500 }
    );
  }
});


