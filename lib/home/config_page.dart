import 'package:tarefa_periodo/periods/db/period_model.dart';
import 'package:tarefa_periodo/periods/modal.dart';
import 'package:tarefa_periodo/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//classe responsável pela tela inicial do aplicativo

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

final TextEditingController nickName = TextEditingController();
String nick = "João";
late Box<PeriodModel> periodsBox;

class _ConfigPageState extends State<ConfigPage> {
  @override
  initState() {
    periodsBox = getPeriods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    Text(
                      "Configurações",
                      style: TextStyle(
                          fontSize: titleText, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      textFormField(
                        maxWidth: MediaQuery.of(context).size.width * 0.4,
                        controller: nickName,
                        label: "Apelido",
                        onSubmit: (newNickName) {
                          setState(() {
                            if (newNickName != "") {
                              nick = newNickName;
                            }
                          });
                          nickName.clear();
                        },
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor: MaterialStatePropertyAll(grey),
                            elevation: const MaterialStatePropertyAll(0),
                            fixedSize:
                                const MaterialStatePropertyAll(Size(165, 55)),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.zero)),
                        icon: const Image(
                            image: AssetImage('assets/photo_profile.png')),
                        label: Text(
                          "Editar Foto",
                          style: TextStyle(
                            fontSize: subSimpleText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: lightGrey,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Períodos",
                        style: TextStyle(
                          fontSize: simpleText,
                          fontWeight: FontWeight.w800,
                        ),
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: backGroundColorToField,
                      borderRadius: BorderRadius.circular(10)),
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ListView.builder(
                    itemCount: periodsBox.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            style: ListTileStyle.list,
                            title: Text(
                              periodsBox.values.elementAt(index).name,
                              style: TextStyle(
                                  fontSize: simpleText,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              //${items[index].start.day.toString()} de ${convertMonth(items[index].start.month)}. de ${items[index].start.year}
                              "${formatDateAndTime(periodsBox.values.elementAt(index).start, false)} a ${formatDateAndTime(periodsBox.values.elementAt(index).end, false)}",
                              style: TextStyle(fontSize: subSimpleText),
                            ),
                            onTap: () => period(
                                context,
                                index,
                                false,
                                periodsBox.values.elementAt(index),
                                () => setState(() {})),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => period(
                          context, null, true, null, () => setState(() {})),
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(blue)),
                      child: Text(
                        "Adicionar Periodo",
                        style: TextStyle(
                            color: Colors.white, fontSize: subSimpleText),
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Image(
                            image: AssetImage('assets/photo_profile.png')),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nick,
                                style: TextStyle(
                                    color: blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: simpleText + 1),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text("Sair",
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              color: blue,
                                              offset: const Offset(0, -2))
                                        ],
                                        color: Colors.transparent,
                                        fontSize: simpleText - 1,
                                        decoration: TextDecoration.underline)),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
