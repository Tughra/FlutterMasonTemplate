import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  const SearchField(
      {super.key, this.controller, required this.onChanged, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 46,
        width: MediaQuery.sizeOf(context).width,
        child: TextField(
          onChanged: onChanged,
          controller: controller,
          onTap: onTap,
          style: const TextStyle(fontSize: 16, height: 1.2),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              hintText: "Ara",
              hintStyle: const TextStyle(
                  height: 1,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(101, 93, 83, 0.6)),
              prefixIcon: const Icon(
                Icons.search,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Colors.transparent),
                borderRadius: BorderRadius.circular(46),
              ),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Colors.transparent),
                borderRadius: BorderRadius.circular(46),
              ),
              fillColor: const Color.fromRGBO(242, 242, 242, 1)),
        ));
  }
}
