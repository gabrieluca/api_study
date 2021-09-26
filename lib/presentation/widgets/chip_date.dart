import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/constants.dart';

class ChipDate extends StatelessWidget {
  final DateTime? date;
  final Color color;
  final String dateFormat;

  const ChipDate({
    Key? key,
    required this.date,
    this.color = Colors.red,
    this.dateFormat = kDateFormat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _date =
        date != null ? DateFormat(dateFormat).format(date!) : 'Undefined';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            _date,
            textAlign: TextAlign.end,
            style: const TextStyle(),
          ),
        ],
      ),
    );
  }
}
