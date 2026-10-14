import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jewelry_app/core/widget/blog/blog-item.dart';
import 'package:jewelry_app/models/blog.dart';

class BlogSection extends StatelessWidget {
  final List<BlogModel> blogs;
  final VoidCallback onSeeMore;
  final int maxItems; 

  const BlogSection({
    super.key,
    required this.blogs,
    required this.onSeeMore,
    this.maxItems = 2, 
  });

  @override
  Widget build(BuildContext context) {
    if (blogs.isEmpty) return const SizedBox.shrink();

    final displayedBlogs = blogs.take(maxItems).toList();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader("Tin tức nổi bật", onSeeMore),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayedBlogs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final blog = displayedBlogs[index];
              return BlogItem(
                imagePath: blog.image,
                title: blog.title,
                date: blog.date,
                onTap: () {
                  context.push("/blog/${blog.id}");
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title, VoidCallback onSeeMore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onSeeMore,
          child: const Text("Xem thêm", style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
