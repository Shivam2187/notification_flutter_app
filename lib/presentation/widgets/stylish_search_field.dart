import 'package:flutter/material.dart';

class StylishSearchField extends StatefulWidget {
  final Function(String) onChanged;
  final String initialText;

  const StylishSearchField(
      {super.key, required this.onChanged, required this.initialText});

  @override
  State<StylishSearchField> createState() => _StylishSearchFieldState();
}

class _StylishSearchFieldState extends State<StylishSearchField> {
  bool isFocused = false;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => isFocused = _focusNode.hasFocus);
    });
    _controller.text = widget.initialText;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: isFocused
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
              size: 28,
            ),
            hintText: 'Search by Employee Name',
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            border: InputBorder.none,
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
