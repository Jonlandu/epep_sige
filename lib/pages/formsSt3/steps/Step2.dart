import 'package:flutter/material.dart';

class SchoolPersonnelForm extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;

  const SchoolPersonnelForm({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _SchoolPersonnelFormState createState() => _SchoolPersonnelFormState();
}

class _SchoolPersonnelFormState extends State<SchoolPersonnelForm> {
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
            _buildHeader("Statistiques du Personnel et des Enseignants"),

            // Section 1: Enseignants
            _buildSection(
              title: "3.1. Enseignants du Secondaire",
              children: [
                _buildPersonnelTable(
                  categories: const [
                    "Moins de 6 ans",
                    "6 ans et plus",
                    "A1",
                    "G3",
                    "L2",
                    "L2A",
                    "LA",
                    "IR",
                    "DR",
                    "Autres",
                  ],
                  prefix: "st_3_NombreEnseigantSecondaire",
                ),
                const SizedBox(height: 10),
                _buildAdditionalFields(
                    "Enseignants à la retraite",
                    "st_3_NombreEnseignantARetraite"
                ),
                _buildAdditionalFields(
                    "Enseignants non payés",
                    "st_3_NombreEnseignantNonPaye"
                ),
              ],
            ),

            // Section 2: Personnel administratif
            _buildSection(
              title: "3.2. Personnel Administratif",
              children: [
                _buildSubSection(
                  title: "Préfets d'études",
                  prefix: "st_3_NombrePrefetEtudes",
                ),
                _buildSubSection(
                  title: "Directeurs d'études",
                  prefix: "st_3_NombreDirecteurEtudes",
                ),
                _buildSubSection(
                  title: "Directeurs de discipline",
                  prefix: "st_3_NombreDirecteurDiscipline",
                ),
                _buildSubSection(
                  title: "Conseillers pédagogiques",
                  prefix: "st_3_NombreConseillerPedagogique",
                ),
                _buildSubSection(
                  title: "Surveillants",
                  prefix: "st_3_NombreSurveillant",
                ),
                _buildSubSection(
                  title: "Ouvriers et autres",
                  prefix: "st_3_NombreOuvriersEtAutres",
                ),
              ],
            ),

            // Section 3: Infrastructure
            _buildSection(
              title: "3.3. Infrastructure",
              children: [
                _buildInfrastructureTable(
                  title: "Laboratoires",
                  prefix: "st_3_NombreLaboratoires",
                ),
                const SizedBox(height: 20),
                _buildInfrastructureTable(
                  title: "Autres locaux",
                  prefix: "st_3_NombreAutresLocaux",
                ),
                const SizedBox(height: 20),
                _buildBancsTable(),
              ],
            ),

            // Section 4: Filières/Sections
            _buildSection(
              title: "3.4. Filières/Sections",
              children: [
                _buildFiliereSection(),
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

  Widget _buildSection({required String title, required List<Widget> children}) {
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

  Widget _buildSubSection({required String title, required String prefix}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 8),
          _buildPersonnelTable(
            categories: const [
              "Moins de 6 ans",
              "6 ans et plus",
              "D6",
              "A1",
              "G3",
              "L2",
              "L2A",
              "LA",
              "IR",
              "DR",
              "Autres",
            ],
            prefix: prefix,
          ),
        ],
      ),
    );
  }

  Widget _buildPersonnelTable({
    required List<String> categories,
    required String prefix,
  }) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueGrey.shade50),
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Catégorie",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Hommes",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Femmes",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        for (var category in categories)
          _buildPersonnelRow(
            category,
            "${prefix}H_${_getCategoryKey(category)}",
            "${prefix}F_${_getCategoryKey(category)}",
          ),
      ],
    );
  }

  String _getCategoryKey(String category) {
    switch (category) {
      case "Moins de 6 ans":
        return "MoinsD6";
      case "6 ans et plus":
        return "P6";
      case "D6":
        return "D6";
      case "A1":
        return "A1";
      case "G3":
        return "G3";
      case "L2":
        return "L2";
      case "L2A":
        return "L2A";
      case "LA":
        return "LA";
      case "IR":
        return "IR";
      case "DR":
        return "DR";
      case "Autres":
        return "Autres";
      default:
        return "";
    }
  }

  TableRow _buildPersonnelRow(String label, String keyH, String keyF) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyH),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyF),
        ),
      ],
    );
  }

  Widget _buildAdditionalFields(String label, String key) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label),
          ),
          Expanded(
            flex: 1,
            child: _buildNumberFormField(label: "", key: key),
          ),
        ],
      ),
    );
  }

  Widget _buildInfrastructureTable({
    required String title,
    required String prefix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 8),
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
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Type de construction",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Bon état",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Mauvais état",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            _buildInfrastructureRow("Endur", "${prefix}Endur"),
            _buildInfrastructureRow("Semi-dur", "${prefix}Semidur"),
            _buildInfrastructureRow("Terre battue", "${prefix}Terrebattue"),
            _buildInfrastructureRow("Paille", "${prefix}Paille"),
          ],
        ),
      ],
    );
  }

  TableRow _buildInfrastructureRow(String label, String prefix) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: "${prefix}Bon"),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: "${prefix}Mauvais"),
        ),
      ],
    );
  }

  Widget _buildBancsTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Bancs",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 8),
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
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Type de banc",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Bon état",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Mauvais état",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            _buildBancRow("1 place", "st_3_Banc1Place"),
            _buildBancRow("2 places", "st_3_Banc2Place"),
            _buildBancRow("3 places", "st_3_Banc3Place"),
            _buildBancRow("4 places", "st_3_Banc4Place"),
            _buildBancRow("Plus de 4 places", "st_3_BancPlus4Place"),
          ],
        ),
      ],
    );
  }

  TableRow _buildBancRow(String label, String prefix) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: "${prefix}EnBonEtat"),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: "${prefix}EnMauvaisEtat"),
        ),
      ],
    );
  }

  Widget _buildFiliereSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextFormField(
          label: "Nom de la filière/section",
          key: "st_3_Nom",
        ),
        const SizedBox(height: 16),
        _buildTextFormField(
          label: "Programme National Actuel",
          key: "st_3_ProgrammeNationalActuel",
        ),
        const SizedBox(height: 16),
        _buildTextFormField(
          label: "Programme National Ancien",
          key: "st_3_ProgrammeNationalAncien",
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text("Disponible dans le programme national"),
          value: widget.formData["st_3_est_disponibilite_dans_le_programme_national"] ?? false,
          onChanged: (value) {
            setState(() {
              widget.formData["st_3_est_disponibilite_dans_le_programme_national"] = value;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildEffectifTable(),
      ],
    );
  }

  Widget _buildEffectifTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueGrey.shade50),
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Niveau",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Garçons",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Filles",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        _buildEffectifRow("7ème", "st_3_EffectifElevesG7", "st_3_EffectifElevesF7"),
        _buildEffectifRow("8ème", "st_3_EffectifElevesG8", "st_3_EffectifElevesF8"),
        _buildEffectifRow("1ère année", "st_3_EffectifElevesG1H", "st_3_EffectifElevesF1H"),
        _buildEffectifRow("2ème année", "st_3_EffectifElevesG2H", "st_3_EffectifElevesF2H"),
        _buildEffectifRow("3ème année", "st_3_EffectifElevesG3H", "st_3_EffectifElevesF3H"),
        _buildEffectifRow("4ème année", "st_3_EffectifElevesG4H", "st_3_EffectifElevesF4H"),
      ],
    );
  }

  TableRow _buildEffectifRow(String label, String keyG, String keyF) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyG),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyF),
        ),
      ],
    );
  }

  Widget _buildTextFormField({required String label, required String key}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      initialValue: widget.formData[key]?.toString() ?? '',
      onChanged: (value) {
        widget.formData[key] = value;
      },
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