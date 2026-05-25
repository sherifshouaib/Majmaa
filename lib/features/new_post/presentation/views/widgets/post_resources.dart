import 'package:flutter/material.dart';

import 'post_resources_body.dart';

class PostResources extends StatelessWidget {
  const PostResources({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),

        borderRadius: BorderRadius.circular(5),
      ),
      child: PostResourcesBody(),
    );
  }
}
