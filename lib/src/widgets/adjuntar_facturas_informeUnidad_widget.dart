
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transmap_app/src/models/informe_detalle_model.dart';
import 'package:transmap_app/src/services/informe_detalle_services.dart';
import 'package:transmap_app/utils/sp_global.dart';


class ChipModelFacturas{
  final String id, name;
  final Color colorcito;
  final bool esPrincipal;

  ChipModelFacturas({required this.id, required this.name, required this.colorcito , required this.esPrincipal});
}


class AdjuntarFacturasInformeUnidadWidget extends StatefulWidget {

  String? idDetalle;



  AdjuntarFacturasInformeUnidadWidget({
    this.idDetalle
  });


  @override
  State<AdjuntarFacturasInformeUnidadWidget> createState() => _AdjuntarFacturasInformeUnidadWidgetState();
}




class _AdjuntarFacturasInformeUnidadWidgetState extends State<AdjuntarFacturasInformeUnidadWidget> {


  SPGlobal _prefs = SPGlobal();
  final formKey = GlobalKey<FormState>();
  bool loading = true;


  // InformeUnidadFacturasModel? _selectedFacturas;
  // List<DropdownMenuItem<InformeUnidadFacturasModel>>? _facturasDropdownMenuItems;


  GlobalKey<AutoCompleteTextFieldState<InformeUnidadFacturasModel>> keyFacturas = new GlobalKey();
  AutoCompleteTextField? searchFacturas;

  final List<ChipModelFacturas> _chipListFacturas=[];

  static List<InformeUnidadFacturasModel> facturasList = [];
  static List<InformeUnidadFacturasModel> facturasListLoad = [];
  var _services = new InformeDetalleService();

  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  void getData() async {
    try {
      facturasList = await _services.InformeUnidad_GetFacturas();
      facturasListLoad = await _services.InformeUnidad_ObtenerFacturasComprasxId(widget.idDetalle!);

      if (facturasListLoad.length >0){
        facturasListLoad.forEach((element){
          _chipListFacturas.add(ChipModelFacturas(
              id:element.comprasFk!,
              name: element.documento!,
              colorcito: Colors.blue,
              esPrincipal: true));
        });
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }


  mensajeToast(String mensaje, Color colorFondo, Color colorText) {
    Fluttertoast.showToast(
        msg: mensaje,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colorFondo,
        textColor: colorText,
        fontSize: 16.0);
  }
  void registrar() async{
    loading = true;
    List<InformeUnidadFacturasModel> modList = [];
    _chipListFacturas.forEach((element){
      InformeUnidadFacturasModel mod = new InformeUnidadFacturasModel();
      mod.informeUnidadFk = widget.idDetalle;
      mod.comprasFk = element.id;
      mod.documento = element.name;
      mod.usuarioCreacion = _prefs.idUser;
      modList.add(mod);
print("ID USUARIO ENVIANDO XD: " + _prefs.idUser);
    });
    if (_chipListFacturas.length == 0) {
      return;
    }

    String res =
    await _services.InformeUnidadDetalle_GrabarFacturas(modList);

    print(res);
    if (res == "1") {
      mensajeToast("REGISTRO CORRECTO", Colors.green, Colors.white);
      Navigator.pop(context);

    } else {
      mensajeToast("Ocurrio un Error al registrar las Facturas", Colors.red, Colors.white);
    }
    loading = false;
    setState(() {


    });


  }




  @override
  Widget build(BuildContext context) {
    return !loading ? AlertDialog(
      content: Form(
        key: formKey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("ADJUNTAR FACTURAS"),
                searchFacturas = fieldCliente(),
                Wrap(
                  spacing: 3,
                  children: _chipListFacturas.map((myChip) => Chip(
                    label: Text(myChip.name),
                    labelStyle: TextStyle(fontSize: 12, color: Colors.white),
                    backgroundColor: myChip.colorcito ,
                    onDeleted: (){

                      deleteFacturaChips(myChip.id);

                    },


                  )).toList(),
                ),
                SizedBox(
                  height: 20.0,
                ),

              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancelar",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            registrar();

          },
          child: Text(
            "Aceptar",
          ),
        ),
      ],
    ) : Center(child: CircularProgressIndicator());
  }

  void deleteFacturaChips(String id){
    setState(() {
      _chipListFacturas.removeWhere((element) => element.id == id);
    });
  }


  AutoCompleteTextField<InformeUnidadFacturasModel> fieldCliente() {

    return AutoCompleteTextField<InformeUnidadFacturasModel>(
      key: keyFacturas,
      clearOnSubmit: false,
      suggestions: facturasList,
      style: TextStyle(color: Colors.black54, fontSize: 15.0),

      decoration: InputDecoration(
        hintText: "Facturas ",
        labelText: "Facturas ",
        hintStyle: TextStyle(color: Colors.black54),

        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 17.0,
          height: 17.0,
          child: SvgPicture.asset(
            "assets/icons/frame.svg",
            color: Colors.black87.withOpacity(0.6),
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      itemFilter: (item, query) {
        return item.documento!.toLowerCase().contains(query.toLowerCase()) ;
      },
      itemSorter: (a, b) {
        return a.documento!.compareTo(b.documento!);
      },
      itemSubmitted: (item) {
        setState(() {

          _chipListFacturas.add(ChipModelFacturas(id:item.comprasFk!, name: item.documento!, colorcito: Colors.blue, esPrincipal: true));

          searchFacturas!.textField!.controller!.text = "";
          // searchFacturas!.textField!.controller!.text = item.documento! ;
          // guiaModel.clientesFk = item.tipoId;
          // guiaModel.clientesFkDesc = item.tipoDescripcion;
          // subclientes = [];

        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowCliente(item);
      },
    );
  }
  Widget rowCliente(InformeUnidadFacturasModel cliente) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              cliente.documento!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Text(
              cliente.monto!,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.blue,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }




}



