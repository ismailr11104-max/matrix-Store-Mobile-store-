import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F9),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search products',
                    hintStyle: TextStyle(
                      color: Color(0x8A000000),
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Color(0x8A000000),
                      size: 26,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),
            Container(
              height: 54,
              width: 54,
              decoration: const BoxDecoration(
                color: Color(0xFFF7F7F9),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                  size: 24,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
