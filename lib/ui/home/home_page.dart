import 'package:firebase_riverpod/root.dart';
import 'package:firebase_riverpod/ui/auth/providers/auth_view_model_provider.dart';
import 'package:firebase_riverpod/ui/items/write_item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        actions: [
          IconButton(
              onPressed: () async {
                ref.read(AuthViewModelProvider).logout();
                Navigator.pushReplacementNamed(context, Root.route);
              },
              icon: Icon(Icons.logout_outlined)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, WriteItemPage.route);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
