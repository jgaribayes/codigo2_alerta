import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:codigo2_alerta/models/news_model.dart';
import 'package:codigo2_alerta/ui/general/colors.dart';
import 'package:codigo2_alerta/ui/pages/News_register_page.dart';
import 'package:codigo2_alerta/ui/widgets/general_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../services/api_service.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  ApiService apiService = ApiService();

  List<NewsModel> listData = [];

  buildPDF() async {
    ByteData byteData = await rootBundle.load('assets/images/periodico.png');
    Uint8List imageBytes = byteData.buffer.asUint8List();

    pw.Document pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
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
                        pw.Text(
                          "Bienvenido al reporte Noticias",
                        ),
                        pw.Text(
                          "Av. Jose Maria Arguedas - Lima",
                        ),
                        pw.Text(
                          "940861371",
                        ),
                        pw.Text(
                          "central@garycode.com",
                        ),
                      ]),
                ],
              ),
              pw.Divider(),
              pw.ListView.builder(
                  //     itemCount: listData.length,
                  //       itemBuilder: (pw.Context context, int index){
                  //       return pw.Text("Hola");
                  // },
                  itemCount: listData.length,
                  itemBuilder: (pw.Context context, int index) {
                    return pw.Container(
                      margin: const pw.EdgeInsets.symmetric(vertical: 16.0),
                      padding: const pw.EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 10.0),
                      decoration: pw.BoxDecoration(
                        border:
                            pw.Border.all(width: 0.7, color: PdfColors.black),
                      ),
                      child: pw.Row(children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("id: ${listData[index].id.toString()}"),
                            pw.Text("Link: ${listData[index].link}"),
                            pw.Text("Titulo: ${listData[index].titulo}"),
                            pw.Text(
                                "imagen: ${listData[index].imagen.toString()}",
                                style: pw.TextStyle()),
                          ],
                        ),
                      ]),
                    );
                  }),
            ];
          }),
    );

    Uint8List bytes = await pdf.save();
    Directory directory = await getApplicationDocumentsDirectory();
    File filePdf = File("${directory.path}/Noticia.pdf");
    filePdf.writeAsBytes(bytes);
    OpenFilex.open(filePdf.path);
  }

  @override
  Widget build(BuildContext context) {
    //apiService.getNoticias();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Listado de Noticias",
                style: TextStyle(
                  color: kFontPrimaryColor.withOpacity(0.80),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              spacing10,
              FutureBuilder(
                future: apiService.getNoticias(),
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.hasData) {
                    listData = snap.data;
                    return Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: listData.length,
                        separatorBuilder: (context, index) => const Divider(
                          indent: 12.0,
                          endIndent: 12.0,
                        ),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              listData[index].titulo,
                              style: TextStyle(
                                  color: kFontPrimaryColor.withOpacity(0.80),
                                  fontSize: 15.0),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                spacing3,
                                Text(
                                  "Link: ${listData[index].link}",
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 13.0),
                                ),
                                spacing3,
                                Text(
                                  "Fecha: ${listData[index].fecha}",
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 13.0),
                                ),
                                // Container(
                                //   height: 80.0,
                                //   decoration: BoxDecoration(
                                //     //shape: BoxShape.circle,
                                //     color: Colors.blue,
                                //     borderRadius: BorderRadius.circular(20),
                                //   ),
                                //   child: Expanded(
                                //     child: Image(
                                //       image: CachedNetworkImageProvider(
                                //         listData[index].imagen,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      alignment: FractionalOffset.center,
                                      image: CachedNetworkImageProvider(listData[index].imagen),
                                    ),
                                  ),
                                ),
                                // CachedNetworkImage(
                                //   placeholder: (context, url) => const CircularProgressIndicator(),
                                //   imageUrl: listData[index].imagen,
                                // ),


                                spacing3,
                                // Text(
                                //   "Imagen: ${listData[index].imagen}",
                                //   style: TextStyle(
                                //       color:
                                //           kFontPrimaryColor.withOpacity(0.55),
                                //       fontSize: 13.0),
                                // ),
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
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewsRegisterPage()));
            },
            child: Icon(Icons.add),
            backgroundColor: kBrandPrimaryColor,
          ),
        ],
      ),
    );
  }
}
