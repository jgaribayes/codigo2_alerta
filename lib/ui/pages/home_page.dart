import 'package:codigo2_alerta/ui/general/colors.dart';
import 'package:codigo2_alerta/ui/pages/citizens_page.dart';
import 'package:codigo2_alerta/ui/pages/incident_page.dart';
import 'package:codigo2_alerta/ui/pages/incident_type_page.dart';
import 'package:codigo2_alerta/ui/pages/news_page.dart';
import 'package:codigo2_alerta/ui/widgets/general_widget.dart';
import 'package:codigo2_alerta/ui/widgets/item_menu_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bienvenido Ramón",
                style: TextStyle(
                  color: kFontPrimaryColor.withOpacity(0.80),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              spacing10,
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
                style: TextStyle(
                  color: kFontPrimaryColor.withOpacity(0.65),
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              spacing14,
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 14.0,
                  mainAxisSpacing: 14.0,
                  children: [
                    ItemMenuWidget(
                      color: Color(0xfff72585),
                      icon: Icons.people,
                      text: "Ciudadanos",
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CitizenPage()));
                      },
                    ),
                    ItemMenuWidget(
                      color: Color(0xffffba08),
                      icon: Icons.add_alert,
                      text: "Incidentes",
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => IncidentPage()));

                      },
                    ),
                    ItemMenuWidget(
                      color: Color(0xff00509d),
                      icon: Icons.newspaper,
                      text: "Noticias",
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPage()));
                      },

                    ),
                    ItemMenuWidget(
                      color: Color(0xff02c39a),
                      icon: Icons.bar_chart,
                      text: "Reportes",
                      onTap: (){},
                    ),
                    ItemMenuWidget(
                      color: Color(0xff7b2cbf),
                      icon: Icons.bar_chart,
                      text: "Tipo de incidentes",
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => IncidentTypePage()));
                      },
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}