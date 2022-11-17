import 'package:pbp_flutter_tutorial/main.dart';
import 'package:flutter/material.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();

  // padding -> textformfield (textfield nama lengkap)
  String _namaLengkap = "";

  // container -> column -> checkboxlisttile (checkboxes jenjang)
  bool jenjangSarjana = false;
  bool jenjangDiploma = false;
  bool jenjangMagister = false;
  bool jenjangDoktor = false;

  // listtile -> slider (slider umur)
  double _umur = 0;

  // listtile -> dropdownbutton (dropdown kelas PBP)
  String _kelasPBP = 'A';
  List<String> listKelasPBP = ['A', 'B', 'C', 'D', 'E', 'F', 'KI'];

  // switchlisttile (switch practice mode)
  bool _nilaiSwitch = false;

  // tombol save is a textbutton

  @override
  Widget build(BuildContext context) {
    String getJenjang() {
      if (jenjangSarjana) {
        return "Sarjana";
      } else if (jenjangDiploma) {
        return "Diploma";
      } else if (jenjangMagister) {
        return "Magister";
      } else if (jenjangDoktor) {
        return "Doktor";
      } else {
        return "Belum dipilih";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                // textfield nama lengkap
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Pak Dengklek",
                      labelText: "Nama Lengkap",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.people),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _namaLengkap = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _namaLengkap = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama lengkap tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),

                // checkboxes jenjang
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ListTile(
                        leading: Icon(Icons.school),
                        title: Text("Jenjang"),
                      ),
                      CheckboxListTile(
                        title: const Text('Sarjana'),
                        value: jenjangSarjana,
                        onChanged: (bool? value) {
                          setState(() {
                            jenjangSarjana = value!;
                            if (value) {
                              jenjangMagister =
                                  jenjangDiploma = jenjangDoktor = false;
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Diploma'),
                        value: jenjangDiploma,
                        onChanged: (bool? value) {
                          setState(() {
                            jenjangDiploma = value!;
                            if (value) {
                              jenjangMagister =
                                  jenjangSarjana = jenjangDoktor = false;
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Magister'),
                        value: jenjangMagister,
                        onChanged: (bool? value) {
                          setState(() {
                            jenjangMagister = value!;
                            if (value) {
                              jenjangDiploma =
                                  jenjangSarjana = jenjangDoktor = false;
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Doktor'),
                        value: jenjangDoktor,
                        onChanged: (bool? value) {
                          setState(() {
                            jenjangDoktor = value!;
                            if (value) {
                              jenjangMagister =
                                  jenjangSarjana = jenjangDiploma = false;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),

                // slider umur
                ListTile(
                  leading: const Icon(Icons.co_present),
                  title: Row(
                    children: [
                      Text('Umur: ${_umur.round()}'),
                    ],
                  ),
                  subtitle: Slider(
                    value: _umur,
                    max: 100,
                    divisions: 100,
                    label: _umur.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _umur = value;
                      });
                    },
                  ),
                ),

                // dropdown kelas pbp
                ListTile(
                  leading: const Icon(Icons.class_),
                  title: const Text(
                    'Kelas PBP',
                  ),
                  trailing: DropdownButton(
                    value: _kelasPBP,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: listKelasPBP.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _kelasPBP = newValue!;
                      });
                    },
                  ),
                ),

                // switch practice mode (on/off)
                SwitchListTile(
                  title: const Text('Practice Mode'),
                  value: _nilaiSwitch,
                  onChanged: (bool value) {
                    setState(() {
                      _nilaiSwitch = value;
                    });
                  },
                  secondary: const Icon(Icons.run_circle_outlined),
                ),

                // tombol simpan
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 15,
                            child: Container(
                              child: ListView(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                shrinkWrap: true,
                                children: <Widget>[
                                  const Center(child: Text('Informasi Data', style: TextStyle(fontWeight: FontWeight.bold),)),
                                  const SizedBox(height: 20),
                                  Center(
                                      child:
                                          Text('Nama Lengkap: $_namaLengkap')),
                                  const SizedBox(height: 5),
                                  Center(
                                      child: Text('Jenjang: ${getJenjang()}')),
                                  const SizedBox(height: 5),
                                  Center(child: Text('Umur: ${_umur.round()}')),
                                  const SizedBox(height: 5),
                                  Center(child: Text('Kelas PBP: $_kelasPBP')),
                                  const SizedBox(height: 5),
                                  Center(
                                      child: Text(
                                          'Practice Mode?: $_nilaiSwitch')),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Kembali', style: TextStyle(color: Colors.red),),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
