import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterComponent extends StatefulWidget {
  final List<FilterComponentArg> options;
  final int groupValue;
  final Function(int) onValueChanged;
  const FilterComponent({
    Key? key,
    required this.options,
    required this.groupValue,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  State<FilterComponent> createState() => _FilterComponentState();
}

class _FilterComponentState extends State<FilterComponent> {
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(children: [
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                final isSelected = index == widget.groupValue;
                final backgroundColor = isSelected
                    ? themeCubit.primaryColor
                    : themeCubit.darkBackgroundColor;
                final textColor = isSelected
                    ? themeCubit.backgroundColor
                    : themeCubit.textColor;
                return GestureDetector(
                  onTap: () => widget.onValueChanged(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            widget.options[index].title,
                            style: TextStyle(color: textColor),
                          ),
                        ),
                        if ((widget.options[index].count ?? 0) > 0)
                          Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorConstants.btnGradientColor,
                                  Colors.white
                                ],
                              ),
                              borderRadius: BorderRadius.circular(17.0),
                            ),
                            child: Center(
                              child: Text(
                                widget.options[index].count! > 99
                                    ? '99+'
                                    : widget.options[index].count.toString(),
                                style: TextStyle(
                                    color: themeCubit.backgroundColor),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                );
              }),
        )
      ]),
    );
  }
}

class FilterComponentArg {
  String title;
  int? count;
  FilterComponentArg({required this.title, this.count});
}
