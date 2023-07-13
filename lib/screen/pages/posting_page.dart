import 'package:flutter/material.dart';

class Posting extends StatelessWidget {
  const Posting({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color.fromARGB(255, 42, 41, 41) : Colors.white,
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
                color: !isDark
                    ? const Color.fromARGB(255, 42, 41, 41)
                    : Colors.white,
              )
            ],
          ),
          Text(
            "Post",
            style: TextStyle(
                color: !isDark
                    ? const Color.fromARGB(255, 42, 41, 41)
                    : Colors.white,
                fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              style: TextStyle(
                color: !isDark
                    ? const Color.fromARGB(255, 42, 41, 41)
                    : Colors.white,
              ),
              decoration: InputDecoration(
                hintText: "Content",
                hintStyle: TextStyle(
                  color: !isDark
                      ? const Color.fromARGB(255, 42, 41, 41)
                      : Colors.white,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isDark
                          ? const Color.fromARGB(255, 13, 213, 150)
                          : Colors
                              .amber), // Set the desired border color when focused
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: !isDark
                        ? const Color.fromARGB(255, 42, 41, 41)
                        : Colors.white,
                  ), // Set the desired border color when enabled
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
