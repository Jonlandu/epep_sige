import 'package:flutter/material.dart';

class ThemesTransversauxStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const ThemesTransversauxStep({
    super.key,
    required this.formData,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "3. PRISE EN COMPTE DES THÈMES TRANSVERSAUX DANS LE PROGRAMME D'ÉDUCATION",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              const SizedBox(height: 20),

              // Section 3.1 - Tableau des thèmes transversaux
              Text(
                "3.1. Formulaire des thèmes transversaux",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Veuillez remplir les champs (*) obligatoires :",
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 8,
                  columns: const [
                    DataColumn(label: Text('Thèmes', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Enseigné?', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Oui', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Non', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Programme officiel', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Discipline à part', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Activités parascolaires', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: [
                    _buildThemeRow('VIH/Sida', 'vihSida'),
                    _buildThemeRow('Santé sexuelle et reproductive', 'santeSexuelle'),
                    _buildThemeRow('Sensibilisation contre les abus', 'sensibilisationAbus'),
                    _buildThemeRow('Éducation environnementale', 'educationEnvironnementale'),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Section 3.2 - Règlements et directives
              Text(
                "3.2. Règlements et directives",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 16),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16,
                  columns: const [
                    DataColumn(label: Text('Relatifs à', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Oui', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Non', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: [
                    _buildReglementRow('Sécurité physique', 'reglementSecurite'),
                    _buildReglementRow('Stigmatisation et discrimination', 'reglementDiscrimination'),
                    _buildReglementRow('Harcèlements et abus sexuels', 'reglementAbus'),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Section 3.3 - Cellule d'orientation
              _buildRadioQuestion(
                "3.3. Cellule d'orientation pour EVF",
                'celluleOrientationEVF',
              ),

              const SizedBox(height: 20),

              // Section 3.4 - Enseignants formés EVF
              _buildRadioQuestion(
                "3.4. Enseignants formés sur EVF",
                'enseignantsFormesEVF',
              ),

              const SizedBox(height: 30),

              // Section 3.6 - Tableau enseignants EVF
              Text(
                "3.6. Enseignants formés et dispensant EVF",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 16),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16,
                  columns: const [
                    DataColumn(label: Text('ENSEIGNANTS', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('H', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('F', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('H+F', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: [
                    _buildEnseignantRow('Formés', 'evfFormes'),
                    _buildEnseignantRow('Dont dispensés', 'evfDispenses'),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      // Enregistrement des données
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text('Enregistrer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildThemeRow(String theme, String key) {
    return DataRow(cells: [
      DataCell(Text(theme)),
      DataCell(const Text('')),
      DataCell(
        Checkbox(
          value: formData['${key}Enseigne'] ?? false,
          onChanged: (value) => formData['${key}Enseigne'] = value,
        ),
      ),
      DataCell(
        Checkbox(
          value: !(formData['${key}Enseigne'] ?? true),
          onChanged: (value) => formData['${key}Enseigne'] = !value!,
        ),
      ),
      DataCell(
        Checkbox(
          value: formData['${key}Programme'] ?? false,
          onChanged: (value) => formData['${key}Programme'] = value,
        ),
      ),
      DataCell(
        Checkbox(
          value: formData['${key}Discipline'] ?? false,
          onChanged: (value) => formData['${key}Discipline'] = value,
        ),
      ),
      DataCell(
        Checkbox(
          value: formData['${key}Parascolaire'] ?? false,
          onChanged: (value) => formData['${key}Parascolaire'] = value,
        ),
      ),
    ]);
  }

  DataRow _buildReglementRow(String sujet, String key) {
    return DataRow(cells: [
      DataCell(Text(sujet)),
      DataCell(
        Checkbox(
          value: formData['${key}Oui'] ?? false,
          onChanged: (value) {
            formData['${key}Oui'] = value;
            formData['${key}Non'] = !value!;
          },
        ),
      ),
      DataCell(
        Checkbox(
          value: formData['${key}Non'] ?? false,
          onChanged: (value) {
            formData['${key}Non'] = value;
            formData['${key}Oui'] = !value!;
          },
        ),
      ),
    ]);
  }

  Widget _buildRadioQuestion(String question, String key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
            color: Colors.grey.shade800,
          ),
        ),
        Row(
          children: [
            Row(
              children: [
                Radio<String>(
                  value: 'Oui',
                  groupValue: formData[key] ?? '',
                  onChanged: (value) => formData[key] = value,
                ),
                const Text('Oui'),
              ],
            ),
            const SizedBox(width: 20),
            Row(
              children: [
                Radio<String>(
                  value: 'Non',
                  groupValue: formData[key] ?? '',
                  onChanged: (value) => formData[key] = value,
                ),
                const Text('Non'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  DataRow _buildEnseignantRow(String label, String key) {
    return DataRow(cells: [
      DataCell(Text(label)),
      DataCell(
        TextFormField(
          initialValue: formData['${key}H']?.toString() ?? '0',
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
          onSaved: (value) {
            formData['${key}H'] = int.tryParse(value ?? '0') ?? 0;
          },
        ),
      ),
      DataCell(
        TextFormField(
          initialValue: formData['${key}F']?.toString() ?? '0',
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
          onSaved: (value) {
            formData['${key}F'] = int.tryParse(value ?? '0') ?? 0;
          },
        ),
      ),
      DataCell(
        Text(
          ((int.tryParse(formData['${key}H']?.toString() ?? '0') ?? 0) +
              (int.tryParse(formData['${key}F']?.toString() ?? '0') ?? 0))
              .toString(),
        ),
      ),
    ]);
  }
}