import 'package:flutter/material.dart';
import 'package:first_flutter_bloc/models/models.dart';

class DropdownWidget extends StatefulWidget {
  final String label;
  final List<ItemDropdown> list;
  final Function onSelect;
  final bool error;

  const DropdownWidget({
    super.key,
    required this.list,
    required this.onSelect,
    required this.label,
    this.error = false,
  });

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  ItemDropdown? select;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.label,
              style: TextStyle(
                  color: widget.error
                      ? Theme.of(context).primaryColor
                      : Colors.white)),
          const SizedBox(height: 5.0),
          Container(
            padding: const EdgeInsets.all(5.0),
            child: DropdownButton(
              dropdownColor: Theme.of(context).primaryColor,
              isExpanded: true,
              value: select,
              hint: Text(
                'Seleccione...',
                style: TextStyle(
                    color: widget.error
                        ? Theme.of(context).primaryColor
                        : Colors.white60),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color:
                    widget.error ? Theme.of(context).primaryColor : Colors.grey,
              ),
              underline: Container(
                height: 1,
                color:
                    widget.error ? Theme.of(context).primaryColor : Colors.grey,
              ),
              items: widget.list.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item.label,
                    style: const TextStyle(color: Colors.white60),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                widget.onSelect(newValue);
                setState(() {
                  select = newValue!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
