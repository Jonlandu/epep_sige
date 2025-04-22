import 'package:flutter/material.dart';

class VictimesStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const VictimesStep({
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
                "FORMULAIRE D'ENFANTS VICTIMES",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Veuillez remplir les champs (*) obligatoires :",
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 20),

              // Tableau des formes de violence
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16,
                  columns: const [
                    DataColumn(label: Text('Forme de violence', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('G', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('F', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('G+F', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: [
                    _buildDataRow('Intimidation', 'intimidation'),
                    _buildDataRow('Châtiment corporel', 'chatimentCorporel'),
                    _buildDataRow('Harcèlement', 'harcelement'),
                    _buildDataRow('Discrimination', 'discrimination'),
                    _buildDataRow('Abus sexuels', 'abusSexuels'),
                    _buildDataRow('Autres', 'autresViolences'),
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

  DataRow _buildDataRow(String label, String key) {
    return DataRow(cells: [
      DataCell(Text(label)),
      DataCell(
        TextFormField(
          initialValue: formData['${key}G']?.toString() ?? '0',
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
          onSaved: (value) {
            formData['${key}G'] = int.tryParse(value ?? '0') ?? 0;
          },
          validator: (value) {
            if (value == null || value.isEmpty) return 'Obligatoire';
            if (int.tryParse(value) == null) return 'Nombre valide';
            return null;
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
          validator: (value) {
            if (value == null || value.isEmpty) return 'Obligatoire';
            if (int.tryParse(value) == null) return 'Nombre valide';
            return null;
          },
        ),
      ),
      DataCell(
        TextFormField(
          initialValue: formData['${key}Total']?.toString() ?? '0',
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
          onSaved: (value) {
            formData['${key}Total'] = int.tryParse(value ?? '0') ?? 0;
          },
          validator: (value) {
            if (value == null || value.isEmpty) return 'Obligatoire';
            if (int.tryParse(value) == null) return 'Nombre valide';
            return null;
          },
        ),
      ),
    ]);
  }
}