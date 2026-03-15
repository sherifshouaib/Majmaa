import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:fluent_ui/fluent_ui.dart';

class RowLogCreateAcc extends fluent.StatelessWidget {
  RowLogCreateAcc({super.key, required this.textButton, this.onPressed});
  final String textButton;
  void Function()? onPressed;
  @override
  fluent.Widget build(fluent.BuildContext context) {
    return fluent.Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.green),
          ),
          child: Text(
            textButton,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
