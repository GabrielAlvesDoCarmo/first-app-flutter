import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        onPressed: () {},
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
                            onLongPress: () {
                              showDetail(model);
                            },
                            onTap: () {},
                            leading: Icon(Icons.list_alt_rounded, size: 56,),
                            title: Text("Data : ${model.data} hora : ${model.minute}"),
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

  void remove(Hour model) {}

  void showDetail(Hour model) {}
}
