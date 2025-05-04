import 'package:flutter/material.dart';

class SallesEffectifsStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const SallesEffectifsStep({
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
              // Tableau 1 - Salles d'activités
              _buildTableauSalles(),
              const SizedBox(height: 30),

              // Tableau 2 - Effectifs des enfants
              _buildTableauEffectifs(),
              const SizedBox(height: 30),

              // Tableau 3 - Résultats ENAFEP
              _buildTableauENAFEP(),
              const SizedBox(height: 30),

              // Tableau 4 - Absences et visites médicales
              _buildTableauAbsences(),
              const SizedBox(height: 30),

              // Bouton Enregistrer
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

  Widget _buildTableauSalles() {
    final classes = [
      'Classe pré-primaire',
      '1ère année',
      '2ème année',
      '3ème année',
      '4ème année',
      '5ème année',
      '6ème année',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tableau 1 : NOMBRE DE SALLES D'ACTIVITÉS AUTORISÉES ET ORGANISÉES",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 12),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 16,
            columns: const [
              DataColumn(label: Text('Année d\'études')),
              DataColumn(label: Text('Salles autorisées')),
              DataColumn(label: Text('Salles organisées')),
              DataColumn(label: Text('Classes Multigrades')),
            ],
            rows: [
              ...classes.map((classe) {
                final key = classe.toLowerCase().replaceAll(' ', '').replaceAll('è', 'e');
                return DataRow(cells: [
                  DataCell(Text(classe)),
                  DataCell(
                    TextFormField(
                      initialValue: formData['${key}SallesAutorisees']?.toString() ?? '0',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      onSaved: (value) => formData['${key}SallesAutorisees'] = int.tryParse(value ?? '0') ?? 0,
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      initialValue: formData['${key}SallesOrganisees']?.toString() ?? '0',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      onSaved: (value) => formData['${key}SallesOrganisees'] = int.tryParse(value ?? '0') ?? 0,
                    ),
                  ),
                  DataCell(
                    // Multigrades seulement pour certaines classes
                    (classe == '1ère année' || classe == '3ème année' || classe == '5ème année')
                        ? TextFormField(
                      initialValue: formData['${key}Multigrades']?.toString() ?? '0',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      onSaved: (value) => formData['${key}Multigrades'] = int.tryParse(value ?? '0') ?? 0,
                    )
                        : const SizedBox(),
                  ),
                ]);
              }).toList(),
              DataRow(cells: [
                const DataCell(Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                  classes.map((c) {
                    final key = c.toLowerCase().replaceAll(' ', '').replaceAll('è', 'e');
                    return formData['${key}SallesAutorisees'] ?? 0;
                  }).reduce((a, b) => a + b).toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  classes.map((c) {
                    final key = c.toLowerCase().replaceAll(' ', '').replaceAll('è', 'e');
                    return formData['${key}SallesOrganisees'] ?? 0;
                  }).reduce((a, b) => a + b).toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  ['1ère année', '3ème année', '5ème année'].map((c) {
                    final key = c.toLowerCase().replaceAll(' ', '').replaceAll('è', 'e');
                    return formData['${key}Multigrades'] ?? 0;
                  }).reduce((a, b) => a + b).toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableauEffectifs() {
    final niveaux = ['-6 ans', '6 ans', '7 ans', '8 ans', '9 ans', '10 ans', '11 ans', '+11 ans'];
    final categories = [
      'Dont redoublants',
      'Dont redoublants de 6 ans en 1ère année',
      'Dont à l\'Internat',
      'Dont Orphelins',
      'Dont Autochtones',
      'Dont Étrangers',
      'Dont Réfugiés',
      'Dont Déplacés Externes',
      'Dont Déplacés Internes',
      'Dont réintégrants',
      'Dont Avec handicaps',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tableau 2 : Effectifs des enfants inscrits par année d'études et sexe selon l'âge révolu",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 12),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-têtes complexes
              DataTable(
                columns: [
                  const DataColumn(label: Text('Niveau d\'Études')),
                  ...['C/P', '1ère', '2ème', '3ème', '4ème', '5ème', '6ème', 'Total'].map((niveau) {
                    return DataColumn(label: Text(niveau));
                  }).toList(),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(SizedBox()),
                    DataCell(Text('F')), DataCell(Text('G')), DataCell(Text('F+G')),
                    DataCell(Text('F')), DataCell(Text('G')), DataCell(Text('F+G')),
                    DataCell(Text('F')), DataCell(Text('G')), DataCell(Text('F+G')),
                    DataCell(Text('F')), DataCell(Text('G')), DataCell(Text('F+G')),
                    DataCell(Text('F')), DataCell(Text('G')), DataCell(Text('F+G')),
                    DataCell(Text('F')), DataCell(Text('G')), DataCell(Text('F+G')),
                    DataCell(Text('F')), DataCell(Text('G')), DataCell(Text('F+G')),
                    DataCell(Text('F')), DataCell(Text('G')), DataCell(Text('F+G')),
                  ]),
                ],
              ),

              // Données par âge
              ...niveaux.map((niveau) {
                final key = niveau.replaceAll(' ', '').replaceAll('+', 'plus');
                return DataTable(
                  columns: const [DataColumn(label: SizedBox())],
                  rows: [
                    DataRow(cells: [
                      DataCell(
                        Row(
                          children: [
                            SizedBox(width: 100, child: Text(niveau)),
                            ...List.generate(24, (index) {
                              return SizedBox(
                                width: 60,
                                child: TextFormField(
                                  initialValue: formData['${key}_${index}']?.toString() ?? '0',
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                  ),
                                  onSaved: (value) => formData['${key}_${index}'] = int.tryParse(value ?? '0') ?? 0,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ]),
                  ],
                );
              }),

              // Catégories spéciales
              ...categories.map((categorie) {
                final key = categorie.toLowerCase().replaceAll(' ', '').replaceAll('\'', '');
                return DataTable(
                  columns: const [DataColumn(label: SizedBox())],
                  rows: [
                    DataRow(cells: [
                      DataCell(
                        Row(
                          children: [
                            SizedBox(width: 200, child: Text(categorie)),
                            ...List.generate(24, (index) {
                              return SizedBox(
                                width: 60,
                                child: TextFormField(
                                  initialValue: formData['${key}_${index}']?.toString() ?? '0',
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                  ),
                                  onSaved: (value) => formData['${key}_${index}'] = int.tryParse(value ?? '0') ?? 0,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ]),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableauENAFEP() {
    final parametres = [
      'ÉLÈVES INSCRITS (Participants à l\'ENAFEP)',
      'ÉLÈVES PRÉSENTS (de cette année / année en cours)',
      'Total ADMIS (Qui ont réussi au test)',
      'ADMIS (Qui ont réussi en français)',
      'ADMIS (Qui ont réussi en Maths)',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tableau 3 : RÉSULTATS À L'ENAFEP DE L'ANNÉE PRÉCÉDENTE",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 12),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 16,
            columns: const [
              DataColumn(label: Text('PARAMÈTRES')),
              DataColumn(label: Text('G')),
              DataColumn(label: Text('F')),
              DataColumn(label: Text('TOTAL')),
            ],
            rows: [
              ...parametres.map((param) {
                final key = param.toLowerCase().replaceAll(' ', '').replaceAll('\'', '').replaceAll('(', '').replaceAll(')', '');
                return DataRow(cells: [
                  DataCell(SizedBox(width: 300, child: Text(param))),
                  DataCell(
                    TextFormField(
                      initialValue: formData['${key}G']?.toString() ?? '0',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      onSaved: (value) => formData['${key}G'] = int.tryParse(value ?? '0') ?? 0,
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
                      onSaved: (value) => formData['${key}F'] = int.tryParse(value ?? '0') ?? 0,
                    ),
                  ),
                  DataCell(Text(
                    ((formData['${key}G'] ?? 0) + (formData['${key}F'] ?? 0)).toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                ]);
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableauAbsences() {
    final anneesEtudes = ['1ère Année', '2ème Année', '3ème Année', '4ème Année', '5ème Année', '6ème Année'];
    final parametres = [
      'Nombre total d\'élèves',
      'Nombre d\'absences d\'élèves par année d\'Étude',
      'Nombre de jours ouvrables par année',
      'Nombre d\'élèves ayant bénéficié au moins d\'une visite médicale au cours de l\'année',
      'Nombre d\'élèves ayant bénéficié d\'un déparasitage au moins une fois au cours de l\'année',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tableau 4 : NOMBRE D'ABSENCES, VISITE MÉDICALE ET DÉPARASITAGE D'ÉLÈVES ENREGISTRÉS DURANT L'ANNÉE SCOLAIRE PRÉCÉDENTE ET PAR NIVEAU D'ÉTUDES",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 12),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 16,
            columns: [
              const DataColumn(label: Text('Niveau d\'Études')),
              ...anneesEtudes.map((annee) {
                return DataColumn(label: Text(annee));
              }).toList(),
              const DataColumn(label: Text('Total')),
            ],
            rows: [
              ...parametres.map((param) {
                final key = param.toLowerCase().replaceAll(' ', '').replaceAll('\'', '').replaceAll('(', '').replaceAll(')', '');
                return DataRow(cells: [
                  DataCell(SizedBox(width: 300, child: Text(param))),
                  ...anneesEtudes.map((annee) {
                    final anneeKey = annee.toLowerCase().replaceAll(' ', '').replaceAll('è', 'e');
                    return DataCell(
                      TextFormField(
                        initialValue: formData['${key}_${anneeKey}']?.toString() ?? '0',
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        ),
                        onSaved: (value) => formData['${key}_${anneeKey}'] = int.tryParse(value ?? '0') ?? 0,
                      ),
                    );
                  }).toList(),
                  DataCell(Text(
                    anneesEtudes.map((annee) {
                      final anneeKey = annee.toLowerCase().replaceAll(' ', '').replaceAll('è', 'e');
                      return formData['${key}_${anneeKey}'] ?? 0;
                    }).reduce((a, b) => a + b).toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                ]);
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}