import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CartScreenAppBar extends StatelessWidget {
  const CartScreenAppBar({
    super.key,
    required this.onFieldSubmitted,
  });

  final void Function(String) onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      // Apply gradient background to the app bar
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 42,
              margin: const EdgeInsets.only(left: 15),
              child: Material(
                borderRadius: BorderRadius.circular(7),
                elevation: 0,
                child: TextFormField(
                  // Call the provided function when search is submitted
                  onFieldSubmitted: onFieldSubmitted,
                  decoration: InputDecoration(
                    // Add a prefix icon for search
                    prefixIcon: InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 23,
                        ),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(top: 10),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                      borderSide: BorderSide(color: Colors.black38, width: 1),
                    ),
                    hintText: 'Search Amazon.in',
                    hintStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Add a microphone icon button
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mic,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
