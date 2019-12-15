import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StandardTextform extends StatefulWidget {
  final IconData icon;
  final String labeltext;
  final GlobalKey<FormState> formKey;
  final Function refresh;
  final Function validator;
  final TextEditingController controller;
  DateFormat dateFormat;
  bool isDateForm = false;

  StandardTextform({
    @required this.icon,
    @required this.labeltext,
    @required this.formKey,
    @required this.refresh,
    @required this.validator,
    this.controller,
  });

  StandardTextform.date({
    @required this.icon,
    @required this.labeltext,
    @required this.formKey,
    @required this.refresh,
    @required this.validator,
    @required this.dateFormat,
    this.controller,
    this.isDateForm = true,
  });

  @override
  _StandardTextformState createState() => _StandardTextformState();
}

class _StandardTextformState extends State<StandardTextform> {
  Future<String> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.dateFormat.parse(controller.text),
      firstDate: DateTime(1970, 1, 1),
      lastDate: DateTime(2200, 12, 31),
    );
    return pickedDate == null
        ? controller.text
        : widget.dateFormat.format(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    widget.isDateForm
        ? widget.controller.text = widget.dateFormat.format(DateTime.now())
        : '';
    Color formColor = Colors.white70;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextFormField(
        onTap: () async {
          if (widget.isDateForm) {
            String picked = await _selectDate(context, widget.controller);
            widget.refresh(() {
              widget.controller.text = picked;
            });
          }
        },
        controller: widget.controller,
        validator: (String value) => widget.validator(value),
        style: TextStyle(color: formColor),
        decoration: InputDecoration(
          labelText: widget.labeltext,
          labelStyle: TextStyle(color: formColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: formColor,
              width: 0.0,
            ),
          ),
          icon: Icon(
            widget.icon,
            color: formColor,
          ),
        ),
        cursorColor: formColor,
      ),
    );
  }
}
