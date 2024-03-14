import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double superText = 26;
double titleText = 22;
double subtitleText = 20;
double errorText = 18;
double simpleText = 16;
double subSimpleText = 14;

Color backGroundColorToField = const Color.fromARGB(255, 245, 246, 250);
Color lightGrey = const Color.fromARGB(255, 217, 217, 217);
Color subGrey = const Color.fromARGB(255, 211, 211, 211);
Color grey = const Color.fromARGB(255, 240, 240, 240);

Color red = const Color.fromARGB(255, 255, 0, 0);
Color blue = const Color.fromARGB(255, 15, 39, 139);

String convertMonth(int month) {
  late String convertMonth;
  switch (month) {
    case 1:
      convertMonth = "Jan";
      break;
    case 2:
      convertMonth = "Fev";
      break;
    case 3:
      convertMonth = "Mar";
      break;
    case 4:
      convertMonth = "Abr";
      break;
    case 5:
      convertMonth = "Mai";
      break;
    case 6:
      convertMonth = "Jun";
      break;
    case 7:
      convertMonth = "Jul";
      break;
    case 8:
      convertMonth = "Ago";
      break;
    case 9:
      convertMonth = "Set";
      break;
    case 10:
      convertMonth = "Out";
      break;
    case 11:
      convertMonth = "Nov";
      break;
    case 12:
      convertMonth = "Dez";
      break;
  }
  return convertMonth;
}

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
    {required TextEditingController controller,
    required bool validate,
    TextAlign? textAlign,
    double? maxWidth,
    double? maxHeight,
    String? label,
    Color? fillColor,
    Color? borderColor,
    Color? hintTextColor,
    int? maxLength,
    bool? havePadding,
    bool? readOnly,
    bool? enabled,
    String? hintText,
    Function()? onTap,
    List<TextInputFormatter>? inputFormatters}) {
  return Padding(
    padding: havePadding ?? true
        ? const EdgeInsets.symmetric(vertical: 6, horizontal: 0)
        : EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: (label != null ? true : false),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2.5),
            child: Text(
              label ?? "",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: subSimpleText - 1),
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          style: const TextStyle(
            color: Colors.black,
          ),
          cursorColor: Colors.black,
          maxLength: maxLength,
          readOnly: readOnly ?? false,
          textAlign: textAlign ?? TextAlign.start,
          keyboardType: TextInputType.name,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            fillColor: fillColor ?? Colors.white,
            filled: true,
            enabled: enabled ?? true,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: simpleText, color: lightGrey),
            contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            constraints: BoxConstraints(
                maxWidth: maxWidth ?? double.infinity,
                maxHeight: maxHeight ?? 30),
            errorStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.red[400]),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: borderColor ?? subGrey,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide(
                color: blue,
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
      ? "${(hour < 10) ? '0$hour' : hour}${onlyNumbers ? ':' : 'h'}${(minute < 10) ? '0$minute' : minute}${onlyNumbers ? '' : 'min'}"
      : "${hour == 0 ? '' : hour < 10 ? '0$hour${onlyNumbers ? ':' : 'h'}' : '$hour${onlyNumbers ? ':' : 'h'}'}${(minute < 10) ? '0' + minute.toString() : minute}${onlyNumbers ? '' : 'min'}";
}

String formatDateAndTime(DateTime stringDate, bool monthInString) {
  return "${stringDate.day < 10 ? '0${stringDate.day}' : stringDate.day}${monthInString ? ' de ' : '/'}${monthInString ? convertMonth(stringDate.month) : stringDate.month < 10 ? '0${stringDate.month}' : stringDate.month}${monthInString ? '. de ' : '/'}${stringDate.year.toString().substring(
        monthInString ? 0 : 2,
      )}"; /*  - ${formatTime(date.hour, date.minute, true, true)} */
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
