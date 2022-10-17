import 'package:firebase_riverpod/ui/providers/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingLayer extends ConsumerWidget {
  final Widget child;
  const LoadingLayer({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Stack(
      children: [
        child,
        Consumer(builder: ((context, ref, child) {
          final model = ref.watch(loadingProvider);
          return model.loading
              ? Material(
                  color: scheme.surfaceVariant.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox();
        }))
      ],
    );
  }
}
