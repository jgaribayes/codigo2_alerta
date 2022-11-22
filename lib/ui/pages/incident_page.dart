import 'dart:io';
import 'dart:typed_data';

import 'package:codigo2_alerta/models/incident_model.dart';
import 'package:codigo2_alerta/models/incidente_type_model.dart';
import 'package:codigo2_alerta/services/api_service.dart';
import 'package:codigo2_alerta/ui/general/colors.dart';
import 'package:codigo2_alerta/ui/pages/incidente_map_page.dart';
import 'package:codigo2_alerta/ui/pages/modals/resgister_incident_modal.dart';
import 'package:codigo2_alerta/ui/widgets/general_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class IncidentPage extends StatefulWidget {
  @override
  State<IncidentPage> createState() => _IncidentPageState();
}

class _IncidentPageState extends State<IncidentPage>
    with TickerProviderStateMixin {
  List<IncidentTypeModel> incidentTypeList = [];
  ApiService apiService = ApiService();

  List<IncidentModel> listData = [];

  @override
  initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    incidentTypeList = await apiService.getIncidentType();
  }

  showAddIncidentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      transitionAnimationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 350),
      ),
      builder: (BuildContext context) {
        return RegisterIncidentModal(
          incidentTypeList: incidentTypeList,
        );
      },
    ).then((value) {
      setState(() {});
    });
  }


  buildPDF() async {

    ByteData byteData = await rootBundle.load('assets/images/hoja.png');
    Uint8List imageBytes =  byteData.buffer.asUint8List();

    pw.Document pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context){
            return [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(
                    pw.MemoryImage(imageBytes),
                    height: 50.0,
                  ),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text("Bienvenido",),
                        pw.Text("Av. Lima 12323 - Cercado - Arequipa",),
                        pw.Text("343 232 122",),
                        pw.Text("central@livcode.com",),
                      ]
                  ),
                ],
              ),
              pw.Divider(),

              pw.ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (pw.Context context, int index){
                    return pw.Container(
                      margin: const pw.EdgeInsets.symmetric(vertical: 16.0),
                      padding: const pw.EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                            width: 0.7,
                            color: PdfColors.black
                        ),
                      ),
                      child: pw.Row(
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Tipo Incidente: "),
                                pw.Text("Ciudadano: "),
                                pw.Text("Teléfono: "),
                                pw.Text("Documento Identidad: "),
                                pw.Text("Fecha: "),
                                pw.Text("Hora: "),
                              ],
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(listData[index].tipoIncidente.title),
                                pw.Text(listData[index].datosCiudadano.nombres),
                                pw.Text(listData[index].datosCiudadano.telefono),
                                pw.Text(listData[index].datosCiudadano.dni),
                                pw.Text(listData[index].fecha),
                                pw.Text(listData[index].hora),
                              ],
                            ),
                          ]
                      ),
                    );
                  }
              ),

            ];
          }
      ),
    );



    Uint8List bytes = await pdf.save();
    Directory directory = await getApplicationDocumentsDirectory();
    File filePdf = File("${directory.path}/alerta.pdf");
    filePdf.writeAsBytes(bytes);
    OpenFilex.open(filePdf.path);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              buildPDF();
            },
            child: Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.picture_as_pdf,
                color: Colors.white,
              ),
            ),
          ),
          spacing10,
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IncidentMapPage(
                    incidentList: listData,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: kFontPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.map,
                color: Colors.white,
              ),
            ),
          ),
          spacing10,
          FloatingActionButton(
            onPressed: () {
              showAddIncidentModal(context);
            },
            backgroundColor: kBrandPrimaryColor,
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Listado de Incidentes",
                style: TextStyle(
                  color: kFontPrimaryColor.withOpacity(0.80),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              spacing20,
              FutureBuilder(
                future: apiService.getIncident(),
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.hasData) {
                    listData = snap.data;
                    return Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: listData.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              listData[index].tipoIncidente.title,
                              style: TextStyle(
                                  color: kFontPrimaryColor.withOpacity(0.80),
                                  fontSize: 15.0),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                spacing3,
                                Text(
                                  "Ciudadano: ${listData[index].datosCiudadano.nombres}",
                                  style: TextStyle(
                                      color:
                                      kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 13.0),
                                ),
                                spacing3,
                                Text(
                                  "Teléfono: ${listData[index].datosCiudadano.telefono}",
                                  style: TextStyle(
                                      color:
                                      kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 13.0),
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  listData[index].hora,
                                  style: TextStyle(
                                      color:
                                      kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 13.0),
                                ),
                                spacing3,
                                Text(
                                  listData[index].fecha,
                                  style: TextStyle(
                                      color:
                                      kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 13.0),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}