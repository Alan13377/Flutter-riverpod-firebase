import 'dart:io';

import 'package:firebase_riverpod/ui/items/providers/write_item_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class WriteItemPage extends ConsumerWidget {
  static const String route = "/writeItem";
  const WriteItemPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;

    final model = ref.watch(WriteItemViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Item"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: MaterialButton(
          padding: EdgeInsets.all(14),
          color: scheme.primary,
          onPressed: () {},
          child: Text("LISTO"),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //**SELECCIONAR IMAGEN */
            GestureDetector(
              onTap: () async {
                final picked =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  model.file = File(picked.path);
                }
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: (model.image != null || model.file != null)
                        ? DecorationImage(
                            image: model.file != null
                                ? FileImage(model.file!)
                                : NetworkImage(model.image!) as ImageProvider,
                            fit: BoxFit.cover,
                          )
                        : null),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (model.image == null && model.file == null)
                      Expanded(
                        child: Center(
                          child: Icon(
                            Icons.photo,
                            color: scheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    Material(
                      color: theme.cardColor.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Selecciona Imagen".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: style.bodySmall),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //** FORMULARIO*/
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              initialValue: model.title,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: "Titulo",
              ),
              onChanged: (value) => model.title = value,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              initialValue: model.description,
              minLines: 5,
              maxLines: 10,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: "Description",
              ),
              onChanged: (value) => model.description = value,
            ),
          ],
        ),
      ),
    );
  }
}
