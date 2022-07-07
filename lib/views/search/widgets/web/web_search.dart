import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:studentprojectmanager/util/colors.dart';
import 'package:studentprojectmanager/views/search/search_screen.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController tc = TextEditingController();

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/google-logo.png',
              height: size.height * 0.12,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            // another way of doing things
            // also everything in search bar is same except this width so just use this
            width: size.width > 768 ? size.width * 0.4 : size.width * 0.9,
            child: TextFormField(
              // controller: tc,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: searchBorder),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  suffixIcon: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(Icons.search)),
                  hoverColor: Colors.green),
              onFieldSubmitted: (val) {
                Logger l = Logger();
                l.i(val);
                if (val != "") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(
                        searchQuery: val.trim(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
