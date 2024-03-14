import 'package:tarefa_periodo/periods/db/period_model.dart';

import 'package:tarefa_periodo/utility_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// função que retorna um Modal Button com as informações para serem preenchidas
Future<dynamic> period(BuildContext context, int? index, bool canEdit,
    PeriodModel? period, Function update) {
  final TextEditingController periodName = TextEditingController();
  final TextEditingController periodStart = TextEditingController();

  final TextEditingController periodEnd = TextEditingController();
  int periodTypeSelected = 0;
  final TextEditingController periodgoal1 = TextEditingController();
  final TextEditingController periodgoal2 = TextEditingController();
  final ValueNotifier<bool> edit = ValueNotifier<bool>(false);
  GlobalKey<FormState> periodForm = GlobalKey();
  edit.value = canEdit;
  DateTime? newPeriodStart;
  DateTime? newPeriodEnd;
  if (period != null) {
    periodName.text = period.name;
    periodStart.text = formatDateAndTime(period.start, true);
    newPeriodStart = period.start;
    periodEnd.text = formatDateAndTime(period.end, true);
    newPeriodEnd = period.end;
    periodTypeSelected = period.type;
    periodgoal1.text = period.goal1.toString();
    periodgoal2.text = period.goal2.toString();
  }
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    constraints: BoxConstraints.loose(Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height * 0.7)),
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
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
            builder: (BuildContext context, bool isEdit, Widget? child) {
              return Form(
                key: periodForm,
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: <Widget>[
                        //
                        //
                        // Nome do periodo
                        //
                        textFormField(
                            maxWidth: MediaQuery.of(context).size.width * 0.9,
                            maxHeight: 60,
                            readOnly: !isEdit,
                            controller: periodName,
                            hintText: "Nomeie seu periodo",
                            hintTextColor: lightGrey,
                            fillColor: backGroundColorToField,
                            borderColor: backGroundColorToField,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "preencha o campo";
                              }
                              return null;
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                                color: isEdit
                                    ? backGroundColorToField
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Column(
                              children: [
                                //
                                //
                                // Data inicial
                                //
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
                                    textFormField(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        maxHeight: 60,
                                        enabled: isEdit,
                                        readOnly: true,
                                        fillColor: isEdit
                                            ? Colors.white
                                            : Colors.transparent,
                                        textAlign: isEdit
                                            ? TextAlign.center
                                            : TextAlign.end,
                                        borderColor: subGrey,
                                        controller: periodStart,
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: newPeriodStart ??
                                                newPeriodEnd ??
                                                DateTime.now(),
                                            firstDate: DateTime(2001, 04, 15),
                                            lastDate: newPeriodEnd ??
                                                DateTime(2099, 1, 1),
                                          ).then((value) {
                                            if (value != null) {
                                              newPeriodStart = value;
                                              periodStart.text =
                                                  formatDateAndTime(
                                                      value, true);
                                            }
                                          });
                                        },
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "escolha uma data";
                                          }
                                          return null;
                                        }),
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
                                //
                                //
                                // Data final
                                //
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
                                                0.5,
                                        maxHeight: 60,
                                        enabled: isEdit,
                                        fillColor: isEdit
                                            ? Colors.white
                                            : Colors.transparent,
                                        textAlign: isEdit
                                            ? TextAlign.center
                                            : TextAlign.end,
                                        borderColor: subGrey,
                                        controller: periodEnd,
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: newPeriodEnd ??
                                                newPeriodStart ??
                                                DateTime.now(),
                                            firstDate: newPeriodStart ??
                                                DateTime(2001, 04, 15),
                                            lastDate: DateTime(2099, 1, 1),
                                          ).then((value) {
                                            if (value != null) {
                                              newPeriodEnd = value;
                                              periodEnd.text =
                                                  formatDateAndTime(
                                                      value, true);
                                            }
                                          });
                                        },
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "escolha uma data";
                                          }
                                          return null;
                                        }),
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
                                //
                                //
                                // Drop Down Button
                                //
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
                                          alignment: isEdit
                                              ? Alignment.center
                                              : Alignment.centerRight,
                                          value: index + 1,
                                          child: Text(
                                            "Categoria ${index + 1}",
                                            style: TextStyle(
                                                fontSize: simpleText,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      icon: isEdit
                                          ? Icon(
                                              CupertinoIcons.chevron_down,
                                              color: subGrey,
                                            )
                                          : const SizedBox(
                                              width: 10,
                                            ),
                                      validator: (value) {
                                        if (value == null) {
                                          return "Escolha uma categoria";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        enabled: isEdit,
                                        fillColor: isEdit
                                            ? Colors.white
                                            : Colors.transparent,
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 10, 10, 0),
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            maxHeight: 60),
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
                                          borderSide: const BorderSide(
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
                                      onChanged: isEdit
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
                                //
                                //
                                // meta 1
                                //
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
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          maxHeight: 60,
                                          enabled: isEdit,
                                          fillColor: isEdit
                                              ? Colors.white
                                              : Colors.transparent,
                                          textAlign: isEdit
                                              ? TextAlign.center
                                              : TextAlign.end,
                                          borderColor: subGrey,
                                          controller: periodgoal1,
                                          textInputType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return "Preencha";
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                //
                                //
                                // Meta 2
                                //
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
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          maxHeight: 60,
                                          enabled: isEdit,
                                          fillColor: isEdit
                                              ? Colors.white
                                              : Colors.transparent,
                                          textAlign: isEdit
                                              ? TextAlign.center
                                              : TextAlign.end,
                                          borderColor: subGrey,
                                          controller: periodgoal2,
                                          textInputType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return "Preencha";
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          // os botões alternam a visibilidade conforme a possibilidade de alterar esta ativa
                          // novos periodos vem com a variável isEdit = true
                          // botões já existentem precisam acionar o botão Editar para que seja possível
                          // alterar os campos do periodo.
                          child: Visibility(
                            visible: isEdit,
                            replacement: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //
                                //
                                // Botão excluir
                                //
                                ElevatedButton(
                                  style: ButtonStyle(
                                      fixedSize: const MaterialStatePropertyAll(
                                        Size(120, 40),
                                      ),
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
                                //
                                //
                                // Botão editar
                                //
                                ElevatedButton(
                                  style: ButtonStyle(
                                      fixedSize: const MaterialStatePropertyAll(
                                        Size(120, 40),
                                      ),
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
                            //
                            //
                            // Botão de concluir
                            //
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  fixedSize: const MaterialStatePropertyAll(
                                    Size(150, 40),
                                  ),
                                  backgroundColor:
                                      MaterialStatePropertyAll(blue)),
                              child: const Text(
                                'Concluir',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (periodForm.currentState!.validate()) {
                                  if (period == null) {
                                    getPeriods().add(PeriodModel(
                                        name: periodName.text,
                                        start: newPeriodStart!,
                                        end: newPeriodEnd!,
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
                                            start: newPeriodStart!,
                                            end: newPeriodEnd!,
                                            type: periodTypeSelected,
                                            goal1: int.parse(periodgoal1.text),
                                            goal2:
                                                int.parse(periodgoal2.text)));
                                    Navigator.pop(context);
                                    update();
                                  }
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
