import 'package:flutter/material.dart';

class SelectCurrency extends StatefulWidget {
  const SelectCurrency({super.key});

  @override
  State<SelectCurrency> createState() => _SelectCurrencyState();
}

class _SelectCurrencyState extends State<SelectCurrency> {
  List<Map<String, dynamic>> currencylist = [
    {
      'id': 1,
      'name': 'Euro',
    },
    {
      'id': 2,
      'name': 'Dollar',
    },
    {
      'id': 3,
      'name': 'Pounds',
    },
  ];

  final ValueNotifier<List> selected = ValueNotifier<List>([]);
  String selectedValue = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected.value.addAll(currencylist);
    selectedValue = currencylist[0]['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Choose Your Currency",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      onChanged: (value) {
                        if (value == '') {
                          selected.value = [];
                          selected.value.addAll(currencylist);
                        } else {
                          selected.value = [];

                          for (var i = 0; i < currencylist.length; i++) {
                            if (currencylist[i]['name']
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                              selected.value.add(currencylist[i]);
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
                                color: Colors.lightBlue, width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.deepPurple, width: 1)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 1)),
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
                          itemCount: currencylist.length,
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
