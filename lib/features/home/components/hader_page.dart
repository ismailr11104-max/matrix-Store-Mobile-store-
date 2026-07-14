import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/features/favorites/cubit/favorites_cubit.dart';
import 'package:matrix_app/features/favorites/favorites_screen.dart';
import 'package:matrix_app/features/search/search_screen.dart';

class Search extends StatelessWidget {
  const Search({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Image.asset('assets', width: 80, height: 80),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, User!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                    Text(
                      'What are you looking for today?',
                      style: TextStyle(fontSize: 12, color: Color(0xFF777777)),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Container(
              height: 54,
              width: 54,
              decoration: const BoxDecoration(
                color: Color(0xFFF7F7F9),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.search_outlined,
                  color: Colors.black,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return SearchScreen();
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 6),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext _) {
                        return BlocProvider.value(
                          value: context.read<FavoritesCubit>(),
                          child: FavoritesScreen(),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
