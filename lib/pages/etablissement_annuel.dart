import 'package:epsp_sige/pages/home/widgets/SchoolListPage.dart';
import 'package:epsp_sige/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EtablissementAnnuel extends StatelessWidget {
  //
  int idAnnee;
  //
  var box = GetStorage();
  //
  EtablissementAnnuel(this.idAnnee) {
    //.cast<Map<String, dynamic>>() ??
    //identifications = a['identifications'].cast<Map<String, dynamic>>() ?? [];
  }
  //establishments
  Requete requete = Requete();
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text("Veuillez selectionner une école"),
            ),
            Expanded(
              flex: 9,
              child: Container(
                child: FutureBuilder(
                    future: getAllEtablissement(),
                    builder: (context, t) {
                      if (t.hasData) {
                        List annees = t.data as List;
                        return SchoolListPage(
                          establishments: annees,
                          annee: idAnnee,
                        );
                        // return Column(
                        //   children: [
                        //     Expanded(
                        //       flex: 7,
                        //       child: ListView(
                        //         children: List.generate(annees.length, (e) {
                        //           Map annee = annees[e];
                        //           //
                        //           return ListTile(
                        //             onTap: () {
                        //               //
                        //               //
                        //               // §§SchoolListPageRoutes
                        //               // Get.to(
                        //               //   SchoolListPage(
                        //               //       establishments: identifications),
                        //               // );
                        //               //
                        //             },
                        //             title: Text("${annee['libAnneeScolaire']}"),
                        //             //subtitle: Text(
                        //             //  "Active : ${annee['open'] ? 'Oui' : 'Non'}"),
                        //           );
                        //         }),
                        //       ),
                        //     )
                        //   ],
                        // );
                      } else if (t.hasError) {
                        return Container();
                      }

                      return Center(
                        child: Container(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }),
              ),
            ),
            // Expanded(
            //   flex: 4,
            //   child: ListView(
            //     children: List.generate(identifications.length, (e) {
            //       Map establishment = identifications[e];
            //       //
            //       return ListTile(
            //         onTap: () {
            //           //
            //         },
            //         leading: const Icon(Icons.school),
            //         title: Text("${establishment['nomEtab']}"),
            //         //subtitle: Text("Active : ${establishment['open'] ? 'Oui' : 'Non'}"),
            //       );
            //     }),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
  //

  Future<List> getAllEtablissement() async {
    //idAnnee
    Map user = box.read("user") ?? {};
    //
    Response response = await requete.getE(
        "identifications/etablissement_annuel?sousProvedId=${user["sousProvedId"]}&anneeId=$idAnnee");
    if (response.isOk) {
      return response.body;
    } else {
      return [];
    }
  }
}
