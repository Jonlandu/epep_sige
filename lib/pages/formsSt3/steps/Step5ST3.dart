import 'package:flutter/material.dart';

class Step5ST3 extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;

  const Step5ST3({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _Step5ST3State createState() => _Step5ST3State();
}

class _Step5ST3State extends State<Step5ST3> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader("Ressources de l'Établissement"),

            // Section 1: Personnel Administratif
            _buildSection(
              title: "4. Personnel Administratif",
              children: [
                _buildAdminTable("D4", "d4"),
                const SizedBox(height: 20),
                _buildAdminTable("EM", "em"),
                const SizedBox(height: 20),
                _buildAdminTable("D4P", "d4p"),
                const SizedBox(height: 20),
                _buildAdminTable("P6", "p6"),
                const SizedBox(height: 20),
                _buildAdminTable("D6", "d6"),
                const SizedBox(height: 20),
                _buildAdminTable("Autres", "autres"),
              ],
            ),

            // Section 2: Manuels d'enfants
            _buildSection(
              title: "6. Manuels d'enfants",
              children: [
                _buildMaterialTable(
                  types: [
                    "Français",
                    "Comptage",
                    "Éveil",
                    "Étude du milieu",
                    "Thèmes transversaux",
                    "Autres"
                  ],
                  prefix: "manuels",
                ),
              ],
            ),

            // Section 3: Guides d'éducateurs
            _buildSection(
              title: "7. Guides d'éducateurs",
              children: [
                _buildMaterialTable(
                  types: [
                    "Français",
                    "Comptage",
                    "Éveil",
                    "Étude du milieu",
                    "Thèmes transversaux",
                    "Autres"
                  ],
                  prefix: "guides",
                ),
              ],
            ),

            // Section 4: Locaux selon caractéristiques et états
            _buildSection(
              title: "8. Locaux selon caractéristiques et états",
              children: [
                _buildLocalTable("Salle d'activités", "salle_activites"),
                const SizedBox(height: 20),
                _buildLocalTable("Salle de repos", "salle_repos"),
                const SizedBox(height: 20),
                _buildLocalTable("Salle de jeux/sport", "salle_jeux"),
                const SizedBox(height: 20),
                _buildLocalTable("Salle d'attente", "salle_attente"),
                const SizedBox(height: 20),
                _buildLocalTable("Bureau", "bureau"),
                const SizedBox(height: 20),
                _buildLocalTable("Magasin", "magasin"),
              ],
            ),

            // Navigation buttons
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

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

  Widget _buildAdminTable(String title, String prefix) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          border: TableBorder.all(color: Colors.grey.shade300),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.blueGrey.shade50),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Poste",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Hommes",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Femmes",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            _buildAdminRow("Directeur/Directrice", "${prefix}_directeur"),
            _buildAdminRow("Directeur adjoint/Directrice adjointe",
                "${prefix}_directeur_adjoint"),
            _buildAdminRow("Surveillant/Surveillante", "${prefix}_surveillant"),
            _buildAdminRow("Ouvrier/Ouvrière", "${prefix}_ouvrier"),
          ],
        ),
      ],
    );
  }

  TableRow _buildAdminRow(String label, String keyPrefix) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: "${keyPrefix}_h"),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: "${keyPrefix}_f"),
        ),
      ],
    );
  }

  Widget _buildMaterialTable(
      {required List<String> types, required String prefix}) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueGrey.shade50),
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Type",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "1ère année",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "2ème année",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "3ème année",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        ...types.map((type) {
          String key =
              type.toLowerCase().replaceAll(' ', '_').replaceAll('é', 'e');
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(type),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: _buildNumberFormField(
                    label: "", key: "${prefix}_${key}_1ere"),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: _buildNumberFormField(
                    label: "", key: "${prefix}_${key}_2eme"),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: _buildNumberFormField(
                    label: "", key: "${prefix}_${key}_3eme"),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildLocalTable(String title, String prefix) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
          },
          border: TableBorder.all(color: Colors.grey.shade300),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.blueGrey.shade50),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Type de construction",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Bon état",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Mauvais état",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                prefix != "salle_activites"
                    ? const Padding(padding: EdgeInsets.all(0))
                    : Container(),
                prefix != "salle_activites"
                    ? const Padding(padding: EdgeInsets.all(0))
                    : Container(),
              ],
            ),
            _buildLocalRow("Dur", "${prefix}_dur"),
            _buildLocalRow("Semi-dur", "${prefix}_semidur"),
            _buildLocalRow("Terre battue", "${prefix}_terre"),
            _buildLocalRow("Paille/feuillage", "${prefix}_paille"),
            if (prefix == "salle_activites")
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Détruits ou occupés"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: _buildNumberFormField(
                        label: "", key: "${prefix}_detruits"),
                  ),
                  const Padding(padding: EdgeInsets.all(0)),
                  const Padding(padding: EdgeInsets.all(0)),
                  const Padding(padding: EdgeInsets.all(0)),
                ],
              ),
          ],
        ),
      ],
    );
  }

  TableRow _buildLocalRow(String label, String keyPrefix) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: "${keyPrefix}_bon"),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: "${keyPrefix}_mauvais"),
        ),
        const Padding(padding: EdgeInsets.all(0)),
        const Padding(padding: EdgeInsets.all(0)),
      ],
    );
  }

  Widget _buildNumberFormField({
    required String label,
    required String key,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
      keyboardType: TextInputType.number,
      initialValue: widget.formData[key]?.toString() ?? '0',
      onChanged: (value) {
        widget.formData[key] = int.tryParse(value) ?? 0;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer une valeur';
        }
        if (int.tryParse(value) == null) {
          return 'Veuillez entrer un nombre valide';
        }
        return null;
      },
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () => widget.controller.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          child: const Text('Précédent'),
        ),
        ElevatedButton(
          onPressed: () => widget.controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          child: const Text('Suivant'),
        ),
      ],
    );
  }
}
