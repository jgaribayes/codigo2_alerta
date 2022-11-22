import 'package:codigo2_qr/db/db_admin.dart';
import 'package:codigo2_qr/models/qr_model.dart';
import 'package:codigo2_qr/providers/db_provider.dart';
import 'package:codigo2_qr/providers/example_provider.dart';
import 'package:codigo2_qr/ui/general/colors.dart';
import 'package:codigo2_qr/ui/widgets/button_normal_widget.dart';
import 'package:codigo2_qr/ui/widgets/general_widget.dart';
import 'package:codigo2_qr/ui/widgets/textfield_normal_widget.dart';
import 'package:codigo2_qr/utils/assets.dart';
import 'package:codigo2_qr/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RegisterPage extends StatelessWidget {
  String valueQR;

  RegisterPage({
    required this.valueQR,
  });

  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    ExampleProvider _exampleProvider = Provider.of<ExampleProvider>(context, listen: false);
    DBProvider _dbProvider = Provider.of<DBProvider>(context);
    print("BUILD REGISTER!!!!!!");

    return Scaffold(
      backgroundColor: kBrandSecondaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 7,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 22),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _keyForm,
                    child: Column(
                      children: [
                        divider20,
                        Container(
                          width: 48,
                          height: 4.5,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        divider20,
                        Text(
                          "Nuevo registro",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xff1E1E1E),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        divider6,
                        Text(
                          "Por favor ingresa todos los datos solicitados a continuación ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            height: 1.6,
                            color: Color(0xff1E1E1E).withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        divider30,

                        TextFieldNormalWidget(
                          text: "Título",
                          icon: Assets.iconTitle,
                          controller: _titleController,
                        ),

                        divider20,

                        TextFieldNormalWidget(
                          text: "Descripción",
                          icon: Assets.iconDescription,
                          maxLines: 3,
                          controller: _descriptionController,
                        ),

                        // divider20,
                        //
                        // TextFieldNormalWidget(
                        //   text: "DNI",
                        //   icon: Assets.iconTitle,
                        //   controller: _dniController,
                        //   type: InputTypeEnum.dni,
                        // ),

                        divider30,
                        const Text(
                          "Qr Generado",
                        ),
                        divider6,
                        QrImage(
                          size: 120,
                          data: valueQR,
                        ),
                        divider14,
                        Text(
                          _exampleProvider.counter.toString(),
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),

                        // Consumer<ExampleProvider>(
                        //   builder: (context, provider, _) {
                        //     return Text(
                        //       provider.counter.toString(),
                        //       style: TextStyle(
                        //         fontSize: 40.0,
                        //       ),
                        //     );
                        //   },
                        // ),
                        ButtonNormalWidget(
                          text: "Registrar",
                          onPressed: () async {
                            _exampleProvider.addCounter();

                            if(_keyForm.currentState!.validate()){

                              final DateTime now = DateTime.now();
                              final DateFormat formatterDate =
                              DateFormat('dd-MM-yyyy');
                              final DateFormat formatterTime = DateFormat('Hm');
                              final String formattedDate =
                              formatterDate.format(now);
                              final String formattedTime =
                              formatterTime.format(now);

                              QRModel model = QRModel(
                                title: _titleController.text,
                                description: _descriptionController.text,
                                date: formattedDate,
                                time: formattedTime,
                                url: valueQR,
                              );

                              _dbProvider.addRegister(model);

                              if (_dbProvider.res > 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: kBrandSecondaryColor,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14.0)
                                    ),
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                        ),
                                        dividerWidth10,
                                        Text(
                                          "Registro realizado con éxito.",
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                Navigator.pop(context);
                              }

                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}