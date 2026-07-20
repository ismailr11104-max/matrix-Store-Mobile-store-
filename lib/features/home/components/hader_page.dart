import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/core/dete_surce/local_dete/user_repository.dart';
import 'package:matrix_app/features/favorites/cubit/favorites_cubit.dart';
import 'package:matrix_app/features/favorites/favorites_screen.dart';
import 'package:matrix_app/features/search/search_screen.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserRepository().getUser();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: AppSized.r24,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: (() {
                    final imagePath = user?.imageUser;
                    if (imagePath != null &&
                        imagePath.isNotEmpty &&
                        File(imagePath).existsSync()) {
                      return FileImage(File(imagePath)) as ImageProvider;
                    }
                    return const AssetImage('assets/images/path_ismail.png');
                  }()),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? "Guest User",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const Text(
                      'What are you looking for today?',
                      style: TextStyle(fontSize: 12, color: Color(0xFF777777)),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
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
                      builder: (BuildContext context) => SearchScreen(),
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
                          child: const FavoritesScreen(),
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
