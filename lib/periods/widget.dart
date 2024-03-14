import 'package:config_layout/home/config_page.dart';
import 'package:config_layout/periods/db/period_model.dart';
import 'package:config_layout/utility_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final TextEditingController periodName = TextEditingController();
final TextEditingController periodStart = TextEditingController();

final TextEditingController periodEnd = TextEditingController();
int periodTypeSelected = 0;
final TextEditingController periodgoal1 = TextEditingController();
final TextEditingController periodgoal2 = TextEditingController();
final ValueNotifier<bool> edit = ValueNotifier<bool>(false);

Future<dynamic> period(BuildContext context, int? index, bool canEdit,
    PeriodModel? period, Function update) {
  edit.value = canEdit;
  late DateTime newPeriodStart;
  late DateTime newPeriodEnd;
  if (period != null) {
    periodName.text = period.name;
    periodStart.text = formatDateAndTime(period.start, true);
    newPeriodStart = period.start;
    periodEnd.text = formatDateAndTime(period.end, true);
    newPeriodEnd = period.end;
    periodTypeSelected = period.type;
    periodgoal1.text = period.goal1.toString();
    periodgoal2.text = period.goal2.toString();
  } else {
    periodName.clear();
    periodStart.clear();
    newPeriodStart = DateTime.now();
    periodEnd.clear();
    newPeriodEnd = DateTime.now();
    periodTypeSelected = 0;
    periodgoal1.clear();
    periodgoal2.clear();
  }
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    backgroundColor: Colors.white,
    context: context,
    isDismissible: false,
    enableDrag: false,
    builder: (BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              "Novo Período",
              textAlign: TextAlign.end,
              style:
                  TextStyle(fontSize: simpleText, fontWeight: FontWeight.w800),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                    iconSize: 25,
                    color: subGrey,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(CupertinoIcons.xmark)),
              )
            ],
          ),
          body: ValueListenableBuilder<bool>(
            valueListenable: edit,
            builder: (BuildContext context, bool value, Widget? child) {
              // This builder will only get called when the _counter
              // is updated.
              return Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        textFormField(
                            maxWidth: MediaQuery.of(context).size.width * 0.9,
                            maxHeight: 40,
                            readOnly: !edit.value,
                            controller: periodName,
                            hintText: "Nomeie seu periodo",
                            hintTextColor: lightGrey,
                            validate: false,
                            fillColor: backGroundColorToField,
                            borderColor: backGroundColorToField),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: edit.value
                                  ? backGroundColorToField
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Começa",
                                      style: TextStyle(
                                          fontSize: simpleText,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Visibility(
                                      child: textFormField(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        maxHeight: 35,
                                        enabled: edit.value,
                                        readOnly: true,
                                        textAlign: edit.value
                                            ? TextAlign.center
                                            : TextAlign.end,
                                        borderColor: subGrey,
                                        controller: periodStart,
                                        validate: false,
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: newPeriodStart,
                                            firstDate: DateTime(2001, 04, 15),
                                            lastDate: DateTime(2099, 1, 1),
                                          ).then((value) {
                                            if (value != null) {
                                              newPeriodStart = value;
                                              periodStart.text =
                                                  formatDateAndTime(
                                                      value, true);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.5),
                                  child: Divider(
                                    color: lightGrey,
                                    thickness: 2,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Termina",
                                      style: TextStyle(
                                          fontSize: simpleText,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    textFormField(
                                      readOnly: true,
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.45,
                                      maxHeight: 35,
                                      enabled: edit.value,
                                      textAlign: edit.value
                                          ? TextAlign.center
                                          : TextAlign.end,
                                      borderColor: subGrey,
                                      controller: periodEnd,
                                      validate: false,
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: newPeriodEnd,
                                          firstDate: DateTime(2001, 04, 15),
                                          lastDate: DateTime(2099, 1, 1),
                                        ).then((value) {
                                          if (value != null) {
                                            newPeriodEnd = value;
                                            periodEnd.text =
                                                formatDateAndTime(value, true);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.5),
                                  child: Divider(
                                    color: lightGrey,
                                    thickness: 2,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        "Categoria",
                                        style: TextStyle(
                                            fontSize: simpleText,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DropdownButtonFormField(
                                      value: period?.type,
                                      iconSize: 20,
                                      isExpanded: true,
                                      alignment: Alignment.center,
                                      items: List.generate(
                                        5,
                                        (index) => DropdownMenuItem(
                                          alignment: edit.value
                                              ? Alignment.center
                                              : Alignment.centerRight,
                                          value: index + 1,
                                          child: Text(
                                            "Categoria ${index + 1}",
                                            style: TextStyle(
                                                fontSize: simpleText + 1,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      icon: edit.value
                                          ? Icon(
                                              CupertinoIcons.chevron_down,
                                              color: subGrey,
                                            )
                                          : const SizedBox(
                                              width: 12.7,
                                            ),
                                      decoration: InputDecoration(
                                        enabled: edit.value,
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 10, 10, 0),
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            maxHeight: 35),
                                        errorStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red[400]),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: BorderSide(
                                            color: subGrey,
                                            width: 2,
                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          borderSide: BorderSide(
                                            color: blue,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      onChanged: edit.value
                                          ? (value) {
                                              periodTypeSelected =
                                                  int.parse(value.toString());
                                            }
                                          : null,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Meta 1",
                                        style: TextStyle(
                                            fontSize: simpleText,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      textFormField(
                                        hintText: "Un",
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        maxHeight: 35,
                                        enabled: edit.value,
                                        textAlign: edit.value
                                            ? TextAlign.center
                                            : TextAlign.end,
                                        borderColor: subGrey,
                                        controller: periodgoal1,
                                        validate: false,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Meta 2",
                                        style: TextStyle(
                                            fontSize: simpleText,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      textFormField(
                                        hintText: "Un",
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        maxHeight: 35,
                                        enabled: edit.value,
                                        textAlign: edit.value
                                            ? TextAlign.center
                                            : TextAlign.end,
                                        borderColor: subGrey,
                                        controller: periodgoal2,
                                        validate: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Visibility(
                            visible: edit.value,
                            replacement: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(red)),
                                  child: const Text(
                                    'Excluir',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    period!.delete();
                                    Navigator.pop(context);
                                    update();
                                  },
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(blue)),
                                  child: const Text(
                                    'Editar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    edit.value = !edit.value;
                                    update();
                                  },
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(blue)),
                              child: const Text(
                                'Concluir',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (period == null) {
                                  getPeriods().add(PeriodModel(
                                      name: periodName.text,
                                      start: newPeriodStart,
                                      end: newPeriodEnd,
                                      type: periodTypeSelected,
                                      goal1: int.parse(periodgoal1.text),
                                      goal2: int.parse(periodgoal2.text)));
                                  Navigator.pop(context);
                                  update();
                                } else {
                                  getPeriods().putAt(
                                      index!,
                                      PeriodModel(
                                          name: periodName.text,
                                          start: newPeriodStart,
                                          end: newPeriodEnd,
                                          type: periodTypeSelected,
                                          goal1: int.parse(periodgoal1.text),
                                          goal2: int.parse(periodgoal2.text)));
                                  Navigator.pop(context);
                                  update();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ));
    },
  );
}
