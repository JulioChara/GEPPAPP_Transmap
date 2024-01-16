


import 'package:flutter/material.dart';
import 'package:transmap_app/src/models/carpetas/carpetas_model.dart';
import 'package:transmap_app/src/services/carpetas/carpetas_services.dart';
import 'package:transmap_app/utils/sp_global.dart';
import 'package:lottie/lottie.dart';
import 'package:line_icons/line_icons.dart';


class CarpetasPage extends StatefulWidget {



  @override
  State<CarpetasPage> createState() => _CarpetasPageState();
}

class _CarpetasPageState extends State<CarpetasPage> {

  SPGlobal _prefs = SPGlobal();
  bool isLoading = false;
  CarpetasServices _services = CarpetasServices();
  List<Post> listPost = [];
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  getData() async {
    print("Hola mundo");
    isLoading=true;

    listPost = await _services.getPosts();

    print("GET DATA");
    print(listPost.length);
    setState(() {
      isLoading = false;
    });

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // // String rol = await prefs.getString("rolId")!;
    // // String user = await prefs.getString("idUser")!;
    // String ped = await prefs.getString("idPed")!;
    // print(ped);
    //
    // _service.getNotasentradaxPed(ped).then((value) {
    //   informeModelList2 = value;
    //   informeModelList3.addAll(informeModelList2);
    //
    //   print(informeModelList2);
    //   Accion=0;
    //   // choiceGlob = 0;
    //   isLoading = false;
    //   setState(() {});
    // });
  }












  @override
  Widget build(BuildContext context) {
    // prefs.ultimaPagina = HomePage.routeName;.

    return Scaffold(
      appBar: AppBar(
        title: Text("CARPETAS"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[_prefs.colorA, _prefs.colorB])),
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.add_circle_outline),
          //   color: Colors.white,
          //   iconSize: 30.0,
          //   onPressed: () {
          //     // Navigator.pushNamed(context, 'viajesCreate');
          //
          //
          //     // showDialog(
          //     //   context: context,
          //     //   barrierDismissible: false,
          //     //   builder: (BuildContext context) {
          //     //
          //     //     //ALIMENTOS
          //     //     return ViajesCrearDocumentoWidget();
          //     //   },
          //     // ).then((val) {
          //     //   //Navigator.pop(context);
          //     //   getData();
          //     //   setState(() {});
          //     // });
          //
          //
          //   },
          // )
        ],
      ),

      // drawer: MenuWidget(),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) : Stack(
        children: <Widget>[dashBg, content],
      ),
    );
  }


  get dashBg =>
      Column(
        children: <Widget>[
          _crearFondo(context)
          // Expanded(
          //   child: Container(color: Colors.deepPurple),
          //   flex: 2,
          // ),
          // Expanded(
          //   child: Container(color: Colors.transparent),
          //   flex: 5,
          // ),
        ],
      );

  get content =>
      Container(
        child: Column(
          children: <Widget>[
            //  header,
            grid,
            // Lottie.asset("assets/animation/animation_fall.json", height: 500),
            //Lottie.asset("assets/animation/animation_halloween_cat.json", height: 250)
            //fechas,
          ],
        ),
      );
  var list = ["one", "two", "three", "four", "five", "six"];
  var files = ["one", "two", "three", "four", "five", "six"];
 // Map<String, String> files = {'numero': "0", 'numero': "1", 'numero': "2"};
  get grid =>



      Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: GridView.count(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 3,
              childAspectRatio: .90,
              children: [
                 for(var item in listPost )
                //for(var item in files )
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, 'planInventarios');
                  },
                  child: Card(
                    elevation: 2,
                    color: Colors.transparent.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        //children: <Widget>[FlutterLogo(), Text('SUBIR')],
                        children: <Widget>[
                          Icon(Icons.folder,
                              color: Colors.amber, size: 80),
                           Text("${(item.title)}",
                         //  Text("${(listPost[item].id)}",
                       //   Text("aaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaa",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                              style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)
                        ],
                      ),
                    ),
                  ),
                ),

                for(var item in listPost )
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, 'planInventarios');
                    },
                    child: Card(
                      elevation: 2,
                      color: Colors.transparent.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          //children: <Widget>[FlutterLogo(), Text('SUBIR')],
                          children: <Widget>[
                            // Icon(Icons.file_present_rounded,
                            Icon(LineIcons.excelFile,
                                color: Colors.green, size: 80),
                            Text("${(item.id)}",
                         //   Text(files[item],
                        //   Text("Files",
                              style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                    ),
                  ),


                      // List.generate(listPost.length, (index) {
                      //
                      //       print(listPost.length);
                      //       return Text(
                      //         // listPost[index].toString(),
                      //        // listPost[index].id.toString(),
                      //         listPost[index].title.toString(),
                      //         style: const TextStyle(fontSize: 22),
                      //       );
                      //     },
                      //


              //   Column(
              //     children: List.generate(listPost.length, (index) {
              //
              //       print(listPost.length);
              //       return Text(
              //         // listPost[index].toString(),
              //        // listPost[index].id.toString(),
              //         listPost[index].title.toString(),
              //         style: const TextStyle(fontSize: 22),
              //       );
              //     }),
              //   )
              // ]
              ]
          ),

        ),



      );

  // Expanded(
  //   child: Container(
  //     padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
  //     child: GridView.count(
  //         crossAxisSpacing: 16,
  //         mainAxisSpacing: 16,
  //         crossAxisCount: 3,
  //         childAspectRatio: .90,
  //           children:
  //             List.generate(listPost.length, (index) {
  //             print(listPost.length);
  //                     return  InkWell(
  //                         onTap: () {
  //                           Navigator.pushReplacementNamed(
  //                               context, 'planInventarios');
  //                         },
  //                         child: Card(
  //                           elevation: 2,
  //                           color: Colors.transparent.withOpacity(0.5),
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(8)),
  //                           child: Center(
  //                             child: Column(
  //                               mainAxisSize: MainAxisSize.min,
  //                               //children: <Widget>[FlutterLogo(), Text('SUBIR')],
  //                               children: <Widget>[
  //                                 Icon(Icons.folder,
  //                                     color: Colors.amber, size: 80),
  //                               //   Text("${(listPost[item].id)}",
  //                                 Text("${(listPost[index].title)}",
  //                                   overflow: TextOverflow.ellipsis,
  //                                   maxLines: 2,
  //                                     style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       );
  //           },
  //             ),
  //     ),
  //   ),
  // );




  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    // final primerFondo = Container(
    //   height: size.height * 0.4,
    //   width: double.infinity,
    //   decoration: BoxDecoration(
    //       gradient: LinearGradient(colors: <Color>[
    //         Color(0xFFF7F7F7),
    //         Color(0xFFF7F7F7),
    //       ])),
    // );

    final primerFondo = Container(
      // height: size.height,
      // width: size.width,
      // height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight + kBottomNavigationBarHeight),
      height: MediaQuery.of(context).size.height- (MediaQuery.of(context).padding.top + kToolbarHeight ) ,
      width: size.width ,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            // 'assets/wallpapers/menu_wallpaper.png'),
              'assets/wallpapers/11.jpg'),
          fit: BoxFit.fill,
        ),
        // shape: BoxShape.circle,
      ),
    );

    // final circulo = Container(
    //   width: 100.0,
    //   height: 100.0,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(100.0),
    //       // color: Color.fromRGBO(255, 255, 255, 0.1)),
    //       color: Color.fromRGBO(150, 255, 255, 0.2)),
    // );

    return Stack(
      children: <Widget>[
        primerFondo,
        // Lottie.asset("assets/animation/animation_fall.json", height: 800),
        Positioned(
          // left: -200,
          // top: -200,
          left: 0,
          top: 0,
          height: size.height,
          width: size.width,
          child: Opacity(
            opacity: 0.9,
            // child: LottieBuilder.asset(
            //   // "assets/animation/animation_wallpaper_cristmas.json",
            //   "assets/animation/animation_wallpaper_line.json",
            //   //   reverse: true,
            //   // options: LottieOptions(enableApplyingOpacityToLayers: true),
            //   fit: BoxFit.fill,
            // ),
          ),
        ),
      ],
    );





  }


}