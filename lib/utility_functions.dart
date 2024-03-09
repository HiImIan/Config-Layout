import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double superText = 26;
double titleText = 22;
double subtitleText = 20;
double errorText = 18;
double simpleText = 16;

Color yellow = const Color.fromARGB(255, 255, 254, 3);
Color red = const Color.fromARGB(255, 236, 1, 17);
Color blue = const Color.fromARGB(255, 0, 91, 161);
Color darkBlue = const Color.fromARGB(255, 2, 69, 121);
Color? backgroundColor = Colors.grey[350];

final validCharacters = RegExp(r'^[a-zA-Z0-9 ]');

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

Widget loginTextFormField(TextEditingController controller, bool isPassword) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 5),
        child: Text(
          isPassword ? "Senha" : "Email",
          style: TextStyle(
              color: Color.fromARGB(255, 0, 91, 161),
              fontWeight: FontWeight.w900,
              fontSize: 18),
        ),
      ),
      TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        obscureText: isPassword,
        maxLength: 20,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          constraints: const BoxConstraints(maxWidth: 300, minWidth: 200),
          prefixIcon: Icon(
            isPassword ? CupertinoIcons.lock_fill : Icons.email,
            size: 16,
            color: Colors.black,
          ),
          errorStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.red[400]),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 0, 91, 161),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          fillColor: Colors.grey[250],
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return isPassword ? "Informe sua senha" : "Informe seu email";
          }
          if (isPassword && value.length < 2) {
            return "Senha com mínimo de 2 caracteres";
          }
          if (isPassword && !validCharacters.hasMatch(value)) {
            return "Senha com caracteres especiais";
          }
          if (value.endsWith(" ")) {
            return "Campo terminando com espaçamento";
          }
          return null;
        },
      ),
    ],
  );
}

Widget textFormField(
    {required double? maxWidth,
    required TextEditingController controller,
    required String? label,
    int? maxLength,
    bool? havePadding,
    bool? readOnly,
    String? hintText,
    Function()? onTap,
    required bool validate,
    List<TextInputFormatter>? inputFormatters}) {
  return Padding(
    padding: havePadding ?? true
        ? const EdgeInsets.symmetric(vertical: 12, horizontal: 10)
        : EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: ((label != "" && label != null) ? true : false),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              label!,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: simpleText),
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.black),
          cursorColor: Colors.black,
          maxLength: maxLength,
          readOnly: readOnly ?? false,
          keyboardType: TextInputType.number,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
            errorStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.red[400]),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 173, 173, 173),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 91, 161),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
          ),
          onTap: onTap,
          validator: !validate
              ? null
              : (value) {
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
        ),
      ],
    ),
  );
}

InputDecoration textFormDecoration(
    String label, Widget? suffix, bool enable, bool limit) {
  return InputDecoration(
    isDense: true,
    suffix: suffix,
    errorStyle: const TextStyle(fontSize: 16),
    labelText: label,
    contentPadding: EdgeInsets.symmetric(vertical: 10),
    floatingLabelAlignment: FloatingLabelAlignment.center,
    labelStyle: TextStyle(
      color: Colors.grey[700],
      fontSize: subtitleText,
    ),
    enabled: enable,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: limit
              ? Colors.transparent
              : const Color.fromARGB(150, 0, 92, 161),
          width: 2),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: limit ? Colors.transparent : Colors.grey, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: limit
              ? Colors.transparent
              : const Color.fromARGB(255, 0, 92, 161),
          width: 2),
    ),
    border: OutlineInputBorder(
      gapPadding: 3.3,
      borderSide: BorderSide(
          color: limit
              ? Colors.transparent
              : const Color.fromARGB(255, 0, 92, 161),
          width: 2),
      borderRadius: BorderRadius.circular(5),
    ),
    errorBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: limit ? Colors.transparent : Colors.red, width: 2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: limit ? Colors.transparent : Colors.red, width: 2),
    ),
  );
}

final MaterialStateProperty<Icon?> thumbIcon =
    MaterialStateProperty.resolveWith<Icon?>(
  (Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return const Icon(Icons.check);
    }
    return const Icon(Icons.close);
  },
);

//as variáveis em ordem são: hora, minuto, mostrar quando a hora for zero, escrever hora e minuto entre os numeros
String formatTime(int hour, int minute, bool showHourZero, bool onlyNumbers) {
  return showHourZero
      ? "${(hour < 10) ? '0' + hour.toString() : hour}${onlyNumbers ? ':' : 'h'}${(minute < 10) ? '0' + minute.toString() : minute}${onlyNumbers ? '' : 'min'}"
      : "${hour == 0 ? '' : hour < 10 ? '0$hour${onlyNumbers ? ':' : 'h'}' : '$hour${onlyNumbers ? ':' : 'h'}'}${(minute < 10) ? '0' + minute.toString() : minute}${onlyNumbers ? '' : 'min'}";
}

String formatDateAndTime(String stringDate) {
  DateTime date = DateTime(
    int.parse(stringDate.substring(0, 4)),
    int.parse(stringDate.substring(5, 7)),
    int.parse(stringDate.substring(8, 10)),
    //  int.parse(stringDate.substring(11, 13)),
    //  int.parse(stringDate.substring(14, 16))
  );
  return "${date.day < 10 ? '0' + date.day.toString() : date.day}/${date.month < 10 ? '0' + date.month.toString() : date.month}/${date.year}"; /*  - ${formatTime(date.hour, date.minute, true, true)} */
}

Widget infoText(
    BuildContext context,
    double ecMin,
    double ecMax,
    double? limitMin,
    double? limitMax,
    String? initTime,
    String? finalTime,
    bool? limit,
    bool time) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Column(
      children: [
        Visibility(
          visible: limit == false,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: simpleText),
              children: <TextSpan>[
                TextSpan(text: "Se o EC do Tanque", children: [
                  const TextSpan(
                    text: " for menor que ",
                  ),
                  TextSpan(
                    text: "${ecMin.toString().replaceAll(".", ",")} mS/cm",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: ", irá dosar até atingir ",
                  ),
                  TextSpan(
                    text: "${ecMax.toString().replaceAll(".", ",")} mS/cm",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: ".",
                  ),
                ])

                //não mais usado
              ],
            ),
          ),
        ),
        Visibility(
          visible: limit == true,
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: simpleText),
              children: <TextSpan>[
                limitMin != null
                    ? TextSpan(
                        text:
                            "O dispositivo irá parar de dosar se o EC do tanque for menor do que ",
                        children: [
                            TextSpan(
                              text:
                                  "${limitMin.toString().replaceAll(".", ",")} mS/cm",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ])
                    : const TextSpan(),
                limitMax != null
                    ? TextSpan(
                        text: limitMin != null
                            ? " ou maior que "
                            : "O dispositivo irá parar de dosar se o EC do tanque for maior do que ",
                        children: [
                            TextSpan(
                              text:
                                  "${limitMax.toString().replaceAll(".", ",")} mS/cm",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ])
                    : const TextSpan(),
                const TextSpan(
                  text: ".",
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: limit == null && time,
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: simpleText),
              children: <TextSpan>[
                TextSpan(
                    text: "O dispositivo realizará dosagens somente entre",
                    children: [
                      TextSpan(
                        text: initTime != null ? " ${initTime}h" : "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                finalTime != null
                    ? TextSpan(text: initTime != null ? " e " : "", children: [
                        TextSpan(
                          text: "${finalTime}h",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ])
                    : TextSpan(),

                TextSpan(
                  text: ".",
                ),
                //não mais usado
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget warningText(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.red, fontSize: errorText),
    ),
  );
}

showSomething(
  context,
  String title,
  String text,
  List<Widget> actionButton,
  Function? whenComplete,
  bool popWhenComplete,
) {
  showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text(title,
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: titleText)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: subtitleText))
              ],
            ),
          ),
          actions: actionButton);
    },
  ).whenComplete(() async {
    whenComplete != null ? whenComplete() : null;
    popWhenComplete ? Navigator.of(context).pop() : null;
  });
}

formatToDouble(String value) => value = value.replaceAll(",", ".");

String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  print(
      "valor $minutes agora como ${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}");
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
}
