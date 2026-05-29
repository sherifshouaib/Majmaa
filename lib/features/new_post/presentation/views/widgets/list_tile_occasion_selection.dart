import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/utils/providers/new_post_provider.dart';
import 'package:provider/provider.dart';

class ListTileOccasionSelection extends StatelessWidget {
  const ListTileOccasionSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      trailing: const Icon(Icons.announcement),
      onTap: () {
        final myProvider = context.read<NewPostProvider>();

        String? tempSelectedOccasion = myProvider.selectedOccasion;

        showDialog<String>(
          context: context,
          builder: (dialogContext) {
            return StatefulBuilder(
              builder: (context, setState) {
                return fluent.ContentDialog(
                  title: Text(
                    AppLocale.occasionLabel.getString(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          fluent.ComboBox<String>(
                            value: tempSelectedOccasion,
                            items: myProvider
                                .getOccasionsOptions(context)
                                .map<fluent.ComboBoxItem<String>>((e) {
                                  return fluent.ComboBoxItem<String>(
                                    value: e["value"].toString(),
                                    child: Text(e["label"].toString()),
                                  );
                                })
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                tempSelectedOccasion = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    FilledButton(
                      onPressed: () {
                        if (tempSelectedOccasion != null) {
                          myProvider.setSelectedOccasion(tempSelectedOccasion!);
                        }

                        GoRouter.of(dialogContext).pop();
                      },
                      child: Text(AppLocale.confirmLabel.getString(context)),
                    ),
                    FilledButton(
                      onPressed: () {
                        GoRouter.of(dialogContext).pop();
                      },
                      child: Text(AppLocale.cancelLabel.getString(context)),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      title: Text(
        AppLocale.occasionLabel.getString(context),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

// import 'package:fluent_ui/fluent_ui.dart' as fluent;

// import 'package:flutter/material.dart';
// import 'package:flutter_localization/flutter_localization.dart';
// import 'package:merhaba/core/locale/app_locale.dart';
// import 'package:merhaba/core/utils/providers/new_post_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:go_router/go_router.dart';

// class ListTileOccasionSelection extends StatelessWidget {
//   const ListTileOccasionSelection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       dense: true,
//       trailing: const Icon(Icons.announcement),
//       onTap: () {
//         showDialog<String>(
//           context: context,
//           builder: (context) => fluent.ContentDialog(
//             title: Text(
//               AppLocale.occasion_label.getString(context),
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             content: Consumer<NewPostProvider>(
//               builder: (context, myProvider, child) {
//                 return Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.end,

//                       children: [
//                         fluent.ComboBox<String>(
//                           value: myProvider.selectedOccasion,
//                           items: myProvider
//                               .getOccasionsOptions(context)
//                               .map<fluent.ComboBoxItem<String>>((e) {
//                                 return fluent.ComboBoxItem<String>(
//                                   value: e["value"].toString(),
//                                   child: Text(e["label"].toString()),
//                                 );
//                               })
//                               .toList(),
//                           onChanged: (value) {
//                             if (value == null) {
//                               return;
//                             }

//                             myProvider.setSelectedOccasion(value);
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               },
//             ),
//             actions: [
//               FilledButton(
//                 // style: ButtonStyle(
//                 //   backgroundColor: WidgetStateProperty.all(
//                 //     Colors.purple,
//                 //   ),
//                 // ),
//                 onPressed: () async {
//                   GoRouter.of(context).pop();
//                 },

//                 child: Text(AppLocale.confirm_label.getString(context)),
//               ),
//               FilledButton(
//                 child: Text(AppLocale.cancel_label.getString(context)),
//                 onPressed: () async {
//                   GoRouter.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//       title: Text(
//         AppLocale.occasion_label.getString(context),
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//       ),
//     );
//   }
// }
