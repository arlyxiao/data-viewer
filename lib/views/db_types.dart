import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/form.dart';

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  final TextEditingController colorController = TextEditingController();
  ValueLabel? selectedValue;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ValueLabel>> options = <DropdownMenuEntry<ValueLabel>>[];
    for (final ValueLabel option in ValueLabel.values) {
      options.add(
        DropdownMenuEntry<ValueLabel>(value: option, label: option.label, enabled: true),
      );
    }

    return DropdownMenu<ValueLabel>(
      initialSelection: ValueLabel.mysql,
      controller: colorController,
      label: const Text('Database'),
      dropdownMenuEntries: options,
      onSelected: (ValueLabel? option) {
        setState(() {
          selectedValue = option;
          Provider.of<FormModel>(context, listen: false).selectDatabase(option!.value);
        });
      },
    );
  }
}

enum ValueLabel {
  mysql('mysql', 'mysql'),
  postgres('postgres', 'postgres');

  const ValueLabel(this.label, this.value);
  final String label;
  final String value;
}
