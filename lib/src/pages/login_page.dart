import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transmap_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transmap_app/src/models/login_model.dart';
import 'package:transmap_app/src/models/placa_model.dart';
import 'package:transmap_app/src/models/placa_preferencial_model.dart';
import 'package:transmap_app/src/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transmap_app/src/services/detail_services.dart';
import 'package:transmap_app/src/services/login_services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool loading = true;

  LoginModel sendModel = new LoginModel();

  bool _isFetching = false;
  String _email = "", _password = "";

  static List<LoginTiposModel> placas = [];
  static List<LoginTiposModel> placasPreferenciales =[];



  LoginTiposModel? _selectedPlaca;
  LoginTiposModel? _selectedPlacaReferencial;

  List<DropdownMenuItem<LoginTiposModel>>? _placaDropdownMenuItems;
  List<DropdownMenuItem<LoginTiposModel>>? _placaReferencialDropdownMenuItems;

  LoginServices loginServices = new LoginServices();



  List<DropdownMenuItem<LoginTiposModel>> buildDropDownMenuItems(List placas) {
    List<DropdownMenuItem<LoginTiposModel>> items = [];
    for (LoginTiposModel placa in placas) {
      items.add(DropdownMenuItem( value: placa, child: Text(placa.tipoDescripcion!),));
    }
    return items;
  }

  List<DropdownMenuItem<LoginTiposModel>> buildPlacaReferencialDropDownMenuItems(List placas) {
    List<DropdownMenuItem<LoginTiposModel>> items = [];
    for (LoginTiposModel placa in placas) {
      items.add(DropdownMenuItem( value: placa, child: Text(placa.tipoDescripcion!),));
    }
    return items;
  }


  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }

  void getData() async {
    try {

      sendModel.placaFk = "0";
      sendModel.placaFkDesc = "0";
      sendModel.placaRefFk = "0";
      sendModel.placaRefFkDesc = "0";

      print("Parte 1");
      var objDetailServices = new DetailServices();

      placas = await objDetailServices.Login_ObtenerPlacas();
      placasPreferenciales = await objDetailServices.Login_ObtenerSubPlacas();

      _placaDropdownMenuItems = buildDropDownMenuItems(placas);
      _placaReferencialDropdownMenuItems = buildPlacaReferencialDropDownMenuItems(placasPreferenciales);


      setState(() {
        print("Parte 2");
        print(placas.length);
        print(placasPreferenciales.length);
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }


  onChangeDropdownItem(LoginTiposModel? selectedPlaca) {
    sendModel.placaFkDesc = selectedPlaca!.tipoDescripcion;
    sendModel.placaFk = selectedPlaca.tipoId;
    setState(() {
      _selectedPlaca = selectedPlaca;
      print(_selectedPlaca!.tipoDescripcion);
    });
  }

  onPlancasReferencialChangeDropdownItem(LoginTiposModel? selectedPlaca) {
    sendModel.placaRefFkDesc = selectedPlaca!.tipoDescripcion;
    sendModel.placaRefFk = selectedPlaca.tipoId;
    setState(() {
      _selectedPlacaReferencial = selectedPlaca;
      print(_selectedPlacaReferencial!.tipoDescripcion);
    });
  }


  _submit() async {

    setState(() {
      _isFetching = true;
    });

    String rpta = await loginServices.login(_email, _password, sendModel.placaFk!,sendModel.placaFkDesc!, sendModel.placaRefFk!, sendModel.placaRefFkDesc!);


    if (rpta == "0") {
      setState(() {
        _isFetching = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text(
                  "Hubo un problema, verifique sus datos e inténtelo nuevamente."),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Aceptar"),
                )
              ],
            );
          });
      }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String rol = await prefs.getString("rolId")!;
      setState(() {
        _isFetching = false;
      });
      Navigator.pushReplacementNamed(context, 'home', arguments: _email);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator())
      :Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
          if (_isFetching)
            Positioned(
              child: Container(
                color: Colors.black26,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //      print(sendModel.toJson());
      //     });
      //   },
      //   child: const Icon(Icons.navigation),
      // ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final primerFondo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color(0xFFF7F7F7),
        Color(0xFFF7F7F7),
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.1)),
    );

    return Stack(
      children: <Widget>[
        primerFondo,
        Positioned(
          top: 90.0,
          left: 30.0,
          child: circulo,
        ),
        Positioned(
          top: -40.0,
          right: -30.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          right: -10.0,
          child: circulo,
        ),
        Positioned(
          bottom: 120.0,
          right: 20.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          left: -20.0,
          child: circulo,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 200.0,
                padding: EdgeInsets.only(top: 70.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset("assets/logo.jpg"),
                ))
          ],
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 3.0),
                      spreadRadius: 3.0),
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  "INGRESO",
                  style: TextStyle(fontSize: 30.0, letterSpacing: 1.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _crearEmail(),
                SizedBox(height: 20),
                _crearPassword(),
                SizedBox(height: 20),
                _creaPlaca(),
                SizedBox(height: 20),
                _creaPlacaRef(),
                SizedBox(height: 50),
                _crearBoton(),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          )
        ],
      ),
    );
  }

  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Color(0xFF05BF7D)),
          hintText: "Usuario",
          labelText: "Usuario",
        ),
        onChanged: (value) {
          _email = value;
        },
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Color(0xFF05BF7D)),
          labelText: "Contraseña",
        ),
        onChanged: (value) {
          _password = value;
        },
      ),
    );
  }

  Widget _creaPlaca() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: "Placa",
          prefixIcon: Container(
            width: 20,
            height: 40,
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(
              "assets/icons/car-parking.svg", color: Colors.black54,),
          ),
          contentPadding: EdgeInsets.all(10.0),
          // border: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10)),
        ),
        isExpanded: true,
        value: _selectedPlaca,
        items: _placaDropdownMenuItems,
        onChanged: onChangeDropdownItem,
        elevation: 2,
        style: TextStyle(color: Colors.black54, fontSize: 16),
        isDense: true,
        iconSize: 40.0,
      ),
    );
  }


  Widget _creaPlacaRef() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: "Placa Referencial",
          prefixIcon: Container(
            width: 20,
            height: 40,
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(
              "assets/icons/car-parking.svg", color: Colors.black54,),
          ),
          contentPadding: EdgeInsets.all(10.0),
          // border: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10)),
        ),
        isExpanded: true,
        value: _selectedPlacaReferencial,
        items: _placaReferencialDropdownMenuItems,
        onChanged: onPlancasReferencialChangeDropdownItem,
        elevation: 2,
        style: TextStyle(color: Colors.black54, fontSize: 16),
        isDense: true,
        iconSize: 40.0,
      ),
    );
  }



  Widget _crearBoton() {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text("Ingresar"),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 0.0,
        color: Color(0xFF05BF7D),
        textColor: Colors.white,
        onPressed: () {
          _submit();
        });
  }

//  _login(LoginBloc bloc, BuildContext context) async {
//    Map info = await usuarioProvider.login(bloc.email, bloc.password);
//
//    if (info['ok']) {
//      Navigator.pushReplacementNamed(context, 'home');
//    } else {
//      mostrarAlerta(context,info['mensaje']);
//    }
//  }






}
