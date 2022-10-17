// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_riverpod/ui/providers/cache_provider.dart';
import 'package:firebase_riverpod/ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../root.dart';
import '../utils/assets.dart';

class OnBoardingPage extends HookConsumerWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final styles = theme.textTheme;

    final List<OnBoardingItem> items = [
      OnBoardingItem(
        image: Assets.intro1,
        title: "Intro 1",
        description: "Pago online",
      ),
      OnBoardingItem(
        image: Assets.intro2,
        title: "Intro 2",
        description: "Estadisticas de ventas",
      ),
      OnBoardingItem(
        image: Assets.intro3,
        title: "Intro 3",
        description: "Multiplataforma",
      ),
    ];
    //*Controlador
    final controller = useTabController(initialLength: items.length);
    final index = useState(0);
    controller.addListener(() {
      if (index.value != controller.index) {
        index.value = controller.index;
      }
    });

    void done() async {
      await ref.read(cacheProvider).value!.setBool(Constants.seen, true);
      Navigator.pushReplacementNamed(context, Root.route);
    }

    return Scaffold(
      backgroundColor: theme.cardColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: done,
              child: Text("SKIP"),
            ),
            MaterialButton(
              color: scheme.primary,
              child: Text(index.value == 2 ? "DONE" : "NEXT"),
              onPressed: () {
                //Items [0,1,2]
                if (controller.index < 2) {
                  controller.animateTo(controller.index + 1);
                  index.value++;
                  print(controller.index);
                } else {
                  done();
                }
              },
            ),
          ],
        ),
      ),

      bottomSheet: Material(
        color: theme.cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              items.length,
              (i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: StadiumBorder(),

                    //*Index de UseState
                    color: index.value == i
                        ? scheme.tertiary
                        : scheme.tertiaryContainer,
                  ),
                  child: AnimatedSize(
                    duration: Duration(milliseconds: 500),
                    reverseDuration: Duration(milliseconds: 500),
                    child: SizedBox(
                      height: 16,
                      width: index.value == i ? 32 : 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      //*TABBAR
      body: TabBarView(
        controller: controller,
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Expanded(flex: 32, child: Image.asset(item.image)),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: styles.headlineLarge,
                      ),
                      Spacer(),
                      Text(
                        item.description,
                        textAlign: TextAlign.center,
                        style: styles.titleLarge,
                      ),
                      Spacer(
                        flex: 6,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class OnBoardingItem {
  final String image;
  final String title;
  final String description;
  OnBoardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}
