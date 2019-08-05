import 'package:clubangel/models/angel_widget_model.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AngelDateWidget extends StatelessWidget {
  AngelDateWidget(this.viewModel);
  final AngelWidgetModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffffab91),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      height: 56.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: viewModel.dates.map((date) {
            return _DateSelectorItem(date, viewModel);
          }).list,
        ),
      ),
    );
  }
}

class _DateSelectorItem extends StatelessWidget {
  _DateSelectorItem(
    this.date,
    this.viewModel,
  );

  final DateTime date;
  final AngelWidgetModel viewModel;

  @override
  Widget build(BuildContext context) {
    final isSelected = date == viewModel.selectedDate;
    final backgroundColor = isSelected ? Colors.redAccent : Colors.transparent;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      color: backgroundColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => viewModel.changeCurrentDate(date),
          radius: 56.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _ItemContent(date, isSelected),
          ),
        ),
      ),
    );
  }
}

class _ItemContent extends StatelessWidget {
  static final dateFormat = DateFormat('E');

  _ItemContent(this.date, this.isSelected);
  final DateTime date;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final dayColor = isSelected ? Colors.white : Colors.black54;
    final dateColor = isSelected ? Colors.white : Colors.black54;
    final dateWeight = isSelected ? FontWeight.w500 : FontWeight.w300;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 100),
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: dayColor,
          ),
          child: Text(dateFormat.format(date)),
        ),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 100),
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: dateWeight,
            color: dateColor,
          ),
          child: Text(date.day.toString()),
        ),
      ],
    );
  }
}
