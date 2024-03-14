import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// padrão de fontes
double superText = 26;
double titleText = 22;
double subtitleText = 20;
double errorText = 18;
double simpleText = 16;
double subSimpleText = 14;

//padrão de cores
Color backGroundColorToField = const Color.fromARGB(255, 245, 246, 250);
Color lightGrey = const Color.fromARGB(255, 217, 217, 217);
Color subGrey = const Color.fromARGB(255, 211, 211, 211);
Color grey = const Color.fromARGB(255, 240, 240, 240);
Color red = const Color.fromARGB(255, 255, 0, 0);
Color blue = const Color.fromARGB(255, 15, 39, 139);

//conversor de meses numéricos
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

//padrão de campo de texto
Widget textFormField(
    {required TextEditingController controller,
    String? Function(String?)? validate,
    TextAlign? textAlign,
    double? maxWidth,
    double? maxHeight,
    String? label,
    Color? fillColor,
    Color? borderColor,
    Color? hintTextColor,
    int? maxLength,
    TextInputType? textInputType,
    bool? readOnly,
    bool? enabled,
    String? hintText,
    Function(String)? onSubmit,
    Function()? onTap,
    List<TextInputFormatter>? inputFormatters}) {
  return Column(
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
          keyboardType: textInputType ?? TextInputType.name,
          inputFormatters: inputFormatters,
          onFieldSubmitted: onSubmit,
          decoration: InputDecoration(
            fillColor: fillColor ?? Colors.transparent,
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
              borderSide: const BorderSide(
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
          validator: validate),
    ],
  );
}

// convertor de variável DateTime para String patronizado
String formatDateAndTime(DateTime stringDate, bool monthInString) {
  return "${stringDate.day < 10 ? '0${stringDate.day}' : stringDate.day}${monthInString ? ' de ' : '/'}${monthInString ? convertMonth(stringDate.month) : stringDate.month < 10 ? '0${stringDate.month}' : stringDate.month}${monthInString ? '. de ' : '/'}${stringDate.year.toString().substring(
        monthInString ? 0 : 2,
      )}";
}

// notificação padronizada para o usuário
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
