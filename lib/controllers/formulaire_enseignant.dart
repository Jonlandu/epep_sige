import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ListEnseignantForm extends StatelessWidget {
  RxList listeProf = [].obs;
  Map<String, dynamic> formData = {};
  //
  var box = GetStorage();
  //
  ListEnseignantForm(this.formData) {
    listeProf.value = formData['Enseignant'] ?? [];
  }
  //
  final List<GlobalKey<FormState>> _stepFormKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Obx(
              () => ListView(
                children: List.generate(
                  listeProf.length,
                  (p) {
                    //
                    Map prof = listeProf[p];
                    return ListTile(
                      leading: Icon(Icons.people),
                      title: Text("${prof['nom']}"),
                      subtitle: Text("${prof['sexe']}"),
                    );
                  },
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              //nom,sexe,annee,matricule_secope,situation_salariale,qualification,annee_engagement
              formData['Enseignant'] = listeProf.value;
              //
              List finalliste = [];
              //
              List list1 = box.read("formData1") ?? [];
              list1.forEach((f) {
                if (f['id'] == formData['id']) {
                  f = formData;
                  //f["updated_at"] = DateTime.now().toIso8601String();
                }
              });
              //
              box.write("formData1", list1);
              //
              //List list2 = box.read("formData2") ?? [];
              //
              //List list3 = box.read("formData3") ?? [];
              //
              // finalliste.addAll(list1);
              // finalliste.addAll(list2);
              // finalliste.addAll(list3);
              //
              finalliste.forEach((f) {
                if (f['id'] == formData['id']) {
                  f = formData;
                  //f["updated_at"] = DateTime.now().toIso8601String();
                }
              });
              //
              Navigator.of(context).pop();
              //
            },
            child: const Text('Ajouter'),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              //
              PageController pageController = PageController();
              //

              return Container(
                padding: const EdgeInsets.all(10),
                child: EnseignantForm(
                  formData: formData,
                  formKey: _stepFormKeys[7],
                  listProf: listeProf,
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EnseignantForm extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  RxList? listProf;

  EnseignantForm({
    super.key,
    required this.formData,
    required this.formKey,
    this.listProf,
  });

  @override
  _EnseignantFormState createState() => _EnseignantFormState();
}

class _EnseignantFormState extends State<EnseignantForm> {
  TextEditingController nom = TextEditingController();
  TextEditingController annee = TextEditingController();
  TextEditingController matricule_secope = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController annee_engagement = TextEditingController();
  //
  String sexe = "Masculin";
  bool situation_salariale = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader("Informations sur l'Enseignant"),
            _buildSection(
              title: "Détails Personnels",
              children: [
                _buildTextField("Nom complet", nom),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        label: "Sexe",
                        key: "sexe",
                        items: const ["Masculin", "Féminin"],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField("Année", annee),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField("Matricule SECOPE", matricule_secope),
              ],
            ),
            _buildSection(
              title: "Informations Professionnelles",
              children: [
                _buildSwitchField("Situation Salariale", situation_salariale),
                const SizedBox(height: 16),
                _buildTextField("Qualification", qualification),
                const SizedBox(height: 16),
                _buildTextField("Année d'engagement", annee_engagement),
              ],
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  //nom,sexe,annee,matricule_secope,situation_salariale,qualification,annee_engagement

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const Divider(thickness: 1),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      // initialValue: widget.formData[key]?.toString() ?? '',
      // onChanged: (value) => widget.formData[key] = value,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Ce champ est obligatoire';
      //   }
      //   return null;
      // },
    );
  }

  Widget _buildDropdown({
    required String label,
    required String key,
    required List<String> items,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      value: sexe,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) => sexe = value as String,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez sélectionner une option';
        }
        return null;
      },
    );
  }

  Widget _buildSwitchField(String label, bool key) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        const Spacer(),
        Switch(
          value: situation_salariale,
          onChanged: (value) {
            setState(() {
              situation_salariale = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            //nom,sexe,annee,matricule_secope,situation_salariale,qualification,annee_engagement
            widget.listProf!.add({
              "nom": nom.text,
              "sexe": sexe,
              "annee": annee.text,
              "situation_salariale": situation_salariale,
              "matricule_secope": matricule_secope.text,
              "qualification": qualification.text,
              "annee_engagement": annee_engagement.text,
            });
            //
            Navigator.of(context).pop();
            //
          },
          child: const Text('Ajouter'),
        ),
      ],
    );
  }
}
