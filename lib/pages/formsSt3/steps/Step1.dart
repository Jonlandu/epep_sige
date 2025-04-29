import 'package:flutter/material.dart';

class TeachingStatisticsForm extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;

  const TeachingStatisticsForm({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _TeachingStatisticsFormState createState() => _TeachingStatisticsFormState();
}

class _TeachingStatisticsFormState extends State<TeachingStatisticsForm> {
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
            _buildHeader("Statistiques d'Enseignement"),

            // Section 1: Enseignement Général
            _buildSection(
              title: "3. Enseignement Général",
              children: [
                _buildGradeTable(
                  title: "7ème Année",
                  prefix: "st_3_EnseignementGeneral7",
                ),
                _buildGradeTable(
                  title: "8ème Année",
                  prefix: "st_3_EnseignementGeneral8",
                ),
                _buildGradeTable(
                  title: "1ère Humanité",
                  prefix: "st_3_EnseignementGeneral1H",
                ),
                _buildGradeTable(
                  title: "2ème Humanité",
                  prefix: "st_3_EnseignementGeneral2H",
                ),
                _buildGradeTable(
                  title: "3ème Humanité",
                  prefix: "st_3_EnseignementGeneral3H",
                ),
                _buildGradeTable(
                  title: "4ème Humanité",
                  prefix: "st_3_EnseignementGeneral4H",
                ),
              ],
            ),

            // Section 2: Enseignement Normal
            _buildSection(
              title: "3. Enseignement Normal",
              children: [
                _buildGradeTable(
                  title: "1ère Humanité",
                  prefix: "st_3_EnseignementNormal1H",
                ),
                _buildGradeTable(
                  title: "2ème Humanité",
                  prefix: "st_3_EnseignementNormal2H",
                ),
                _buildGradeTable(
                  title: "3ème Humanité",
                  prefix: "st_3_EnseignementNormal3H",
                ),
                _buildGradeTable(
                  title: "4ème Humanité",
                  prefix: "st_3_EnseignementNormal4H",
                ),
              ],
            ),

            // Section 3: Enseignement Technique
            _buildSection(
              title: "3. Enseignement Technique",
              children: [
                _buildGradeTable(
                  title: "7ème Année",
                  prefix: "st_3_EnseignementTechnique7",
                ),
                _buildGradeTable(
                  title: "8ème Année",
                  prefix: "st_3_EnseignementTechnique8",
                ),
                _buildGradeTable(
                  title: "1ère Humanité",
                  prefix: "st_3_EnseignementTechnique1H",
                ),
                _buildGradeTable(
                  title: "2ème Humanité",
                  prefix: "st_3_EnseignementTechnique2H",
                ),
                _buildGradeTable(
                  title: "3ème Humanité",
                  prefix: "st_3_EnseignementTechnique3H",
                ),
                _buildGradeTable(
                  title: "4ème Humanité",
                  prefix: "st_3_EnseignementTechnique4H",
                ),
              ],
            ),

            // Section 4: Enseignement Professionnel
            _buildSection(
              title: "3. Enseignement Professionnel",
              children: [
                _buildGradeTable(
                  title: "7ème Année",
                  prefix: "st_3_EnseignementProfessionnel7",
                ),
                _buildGradeTable(
                  title: "8ème Année",
                  prefix: "st_3_EnseignementProfessionnel8",
                ),
                _buildGradeTable(
                  title: "1ère Humanité",
                  prefix: "st_3_EnseignementProfessionnel1H",
                ),
                _buildGradeTable(
                  title: "2ème Humanité",
                  prefix: "st_3_EnseignementProfessionnel2H",
                ),
                _buildGradeTable(
                  title: "3ème Humanité",
                  prefix: "st_3_EnseignementProfessionnel3H",
                ),
              ],
            ),

            // Section 5: Enseignement Arts et Métiers
            _buildSection(
              title: "3. Enseignement Arts et Métiers",
              children: [
                _buildGradeTable(
                  title: "7ème Année",
                  prefix: "st_3_EnseignementArtsEtMetiers7",
                ),
                _buildGradeTable(
                  title: "8ème Année",
                  prefix: "st_3_EnseignementArtsEtMetiers8",
                ),
                _buildGradeTable(
                  title: "1ère Humanité",
                  prefix: "st_3_EnseignementArtsEtMetiers1H",
                ),
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

  Widget _buildGradeTable({required String title, required String prefix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
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
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Statistique",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Classes",
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
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Redoublants",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Effectifs"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildNumberFormField(
                    label: "",
                    key: "${prefix}NombreClass",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildNumberFormField(
                    label: "",
                    key: "${prefix}G",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildNumberFormField(
                    label: "",
                    key: "${prefix}F",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildNumberFormField(
                          label: "G",
                          key: "${prefix}G_Redoublant",
                          isSmall: true,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: _buildNumberFormField(
                          label: "F",
                          key: "${prefix}F_Redoublant",
                          isSmall: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildNumberFormField({
    required String label,
    required String key,
    bool isSmall = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(
          horizontal: isSmall ? 6 : 10,
          vertical: isSmall ? 8 : 12,
        ),
        labelStyle: isSmall ? const TextStyle(fontSize: 12) : null,
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
          return 'Nombre invalide';
        }
        return null;
      },
      style: isSmall ? const TextStyle(fontSize: 12) : null,
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () => widget.controller.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          child: const Text('Précédent'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              widget.controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          child: const Text('Suivant'),
        ),
      ],
    );
  }
}