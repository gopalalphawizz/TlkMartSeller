import 'package:flutter/material.dart';

class SelectLuanguage extends StatefulWidget {
  const SelectLuanguage({super.key});

  @override
  State<SelectLuanguage> createState() => _SelectLuanguageState();
}

class _SelectLuanguageState extends State<SelectLuanguage> {
  List<Map<String, dynamic>> languagelist = [
    {
      'id': 1,
      'name': 'English',
    },
    {
      'id': 2,
      'name': 'Hindi',
    },
    {
      'id': 3,
      'name': 'Italian',
    },
    {
      'id': 4,
      'name': 'Bangla',
    }
  ];

  final ValueNotifier<List> selected = ValueNotifier<List>([]);
  String selectedValue = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected.value.addAll(languagelist);
    selectedValue = languagelist[0]['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Choose your Language",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      onChanged: (value) {
                        if (value == '') {
                          selected.value = [];
                          selected.value.addAll(languagelist);
                        } else {
                          selected.value = [];

                          for (var i = 0; i < languagelist.length; i++) {
                            if (languagelist[i]['name']
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                              selected.value.add(languagelist[i]);
                            }
                          }
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        hintText: 'Search',
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                    valueListenable: selected,
                    builder: (context, value, child) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: languagelist.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  selectedValue = selected.value[index]['name'];
                                });
                              },
                              title: Text(
                                selected.value[index]['name'],
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              trailing:
                                  selected.value[index]['name'] == selectedValue
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      : Container(
                                          width: 0,
                                        ),
                            );
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
