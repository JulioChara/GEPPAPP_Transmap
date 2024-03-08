
import 'package:flutter/material.dart';
import 'package:transmap_app/src/pages/reportes/informe_unidad_reporte_page.dart';
import 'package:transmap_app/src/widgets/menu_widget.dart';
import 'package:transmap_app/utils/sp_global.dart';

class HomeReportePage extends StatelessWidget {
  SPGlobal _prefs = SPGlobal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(),
      appBar: AppBar(
        title: Text("Reportes"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[_prefs.colorA, _prefs.colorB])),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> InformeUnidadReportePage()));
            },
            title: Text("Informe de unidad"),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
