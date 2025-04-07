import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fisrt_app_flutter/utils/helpers/hour_helper.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uuid/uuid.dart';

import '../components/menu.dart';
import '../models/hour.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Hour> listHours = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hora v3")),
      drawer: Menu(user: widget.user),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDetail();
        },
      ),
      body:
          (listHours.isEmpty)
              ? Center(
                child: Text(
                  "Nada por aqui \n vamos registrar um dia de trabalho",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              )
              : ListView(
                padding: EdgeInsets.only(left: 4, right: 4),
                children: List.generate(listHours.length, (index) {
                  Hour model = listHours[index];

                  return Dismissible(
                    key: ValueKey(model),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 12),
                      color: Colors.red,
                      child: Icon(Icons.delete),
                    ),
                    onDismissed: (direction) {
                      remove(model);
                    },
                    child: Card(
                      elevation: 2,
                      child: Column(
                        children: [
                          ListTile(
                            onLongPress: () => showDetail(model: model),
                            onTap: () {},
                            leading: Icon(Icons.list_alt_rounded, size: 56),
                            title: Text(
                              "Data : ${model.data} hora : ${HourHelpers.minutesToHours(model.minute)}",
                            ),
                            subtitle: Text("Descrição : ${model.description}"),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
    );
  }

  showDetail({Hour? model}) {
    String title = "Adicionar";
    String confirmButton = "Salvar";
    String skipButton = "Cancelar";

    TextEditingController dataController = TextEditingController();
    final dataMaskFormatter = MaskTextInputFormatter(mask: '##/##/####');

    TextEditingController minuteController = TextEditingController();
    final minuteMaskFormatter = MaskTextInputFormatter(mask: '##:##');

    TextEditingController descriptionController = TextEditingController();

    if (model != null) {
      title = "Editando";
      dataController.text = model.data;
      minuteController.text = HourHelpers.minutesToHours(model.minute);
      descriptionController.text = model.description ?? "";
      confirmButton = "Atualizar";
      skipButton = "Cancelar";
    }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(32),
          child: ListView(
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineSmall),
              TextFormField(
                controller: dataController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  hintText: "01/01/2001",
                  labelText: "Data",
                ),
                inputFormatters: [dataMaskFormatter],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: minuteController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "00:00",
                  labelText: "Hora",
                ),
                inputFormatters: [minuteMaskFormatter],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Descrição",
                  labelText: "Descrição",
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(skipButton),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed:
                        () => saveFIreStore(
                          dataController,
                          minuteController,
                          descriptionController,
                          model,
                          context,
                        ),
                    child: Text(confirmButton),
                  ),
                ],
              ),
              const SizedBox(height: 180),
            ],
          ),
        );
      },
    );
  }

  saveFIreStore(
    TextEditingController dataController,
    TextEditingController minuteController,
    TextEditingController descriptionController,
    Hour? model,
    BuildContext context,
  ) {
    Hour hour = getHour(dataController, minuteController);

    if (descriptionController.text.isNotEmpty) {
      hour.description = descriptionController.text;
    }

    if (model != null) hour.id = model.id;

    _firestore.collection(widget.user.uid).doc(hour.id).set(hour.toMap());
    refresh();
    Navigator.pop(context);
  }

  Hour getHour(
    TextEditingController dataController,
    TextEditingController minuteController,
  ) {
    return Hour(
      id: const Uuid().v8(),
      data: dataController.text,
      minute: HourHelpers.hoursToMinutes(minuteController.text),
    );
  }

  refresh() async{
    List<Hour> list = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection(widget.user.uid).get();
    for (var doc in snapshot.docs) {
      list.add(Hour.fromMap(doc.data()));
    }
    setState(() {
      listHours = list;
    });
  }

  remove(Hour model) {
    _firestore.collection(widget.user.uid).doc(model.id).delete();
    refresh();
  }
}
