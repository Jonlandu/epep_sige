import 'package:epsp_sige/pages/etablissement_annuel.dart';
import 'package:epsp_sige/pages/home/widgets/SchoolListPage.dart';
import 'package:epsp_sige/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccueilEnrolleur extends StatelessWidget {
  //
  Map a;
  //
  List<Map<String, dynamic>> identifications = [];
  //
  AccueilEnrolleur(this.a) {
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
              child: const Text("Veuillez selectionner l'année"),
            ),
            Expanded(
              flex: 9,
              child: Container(
                child: FutureBuilder(
                    future: getAllAnnees(),
                    builder: (context, t) {
                      if (t.hasData) {
                        List annees = t.data as List;
                        return Column(
                          children: [
                            Expanded(
                              flex: 7,
                              child: ListView(
                                children: List.generate(annees.length, (e) {
                                  Map annee = annees[e];
                                  //
                                  return ListTile(
                                    onTap: () {
                                      //
                                      print('annee: $annee');
                                      //
                                      if (annee['open']) {
                                        //
                                        //SchoolListPageRoutes
                                        //
                                        Get.to(
                                          EtablissementAnnuel(annee['id']),
                                        );
                                        //
                                      } else {
                                        Get.snackbar(
                                            "Oups", "Année non active");
                                      }
                                    },
                                    title: Text("${annee['libAnneeScolaire']}"),
                                    subtitle: Text(
                                        "Active : ${annee['open'] ? 'Oui' : 'Non'}"),
                                  );
                                }),
                              ),
                            )
                          ],
                        );
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

  Future<List> getAllAnnees() async {
    //
    Response response = await requete.getE("annees-scolaires");
    if (response.isOk) {
      return response.body;
    } else {
      return [];
    }
  }
}
