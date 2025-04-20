import 'package:flutter/material.dart';

class CapacityStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const CapacityStep({
    super.key,
    required this.formData,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Capacité',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tableau 6 : Nombre de manuels d\'enfants disponibles au sein de l\'Etablissement, par année d\'Etudes et selon les types de manuels',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          _buildManualsTable(), // Ajout du tableau des manuels
          const SizedBox(height: 24),
          Text(
            'Tableau 7 : Nombre de guides d\'éducateurs disponibles au sein de l\'établissement, par année d\'études et selon les types de manuels',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          _buildManuals1Table(),
          const SizedBox(height: 24),
          Text(
            'Tableau 8.a. : Nombre de locaux selon leurs caractéristiques et états (Mur)',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          _buildRoomsTable(), // Ajout du tableau des locaux
          const SizedBox(height: 24),
          Text(
            'Tableau 8.b. : Nombre de locaux selon leurs caractéristiques et états (Toiture)',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          _buildRooms1Table(), // Ajout du tableau des locaux
        ],
      ),
    );
  }

  Widget _buildManualsTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        // Header Row
        TableRow(
          children: [
            _buildTableCell("Année d'études / Type de manuels", isHeader: true),
            _buildTableCell("1ère année", isHeader: true),
            _buildTableCell("2ème année", isHeader: true),
            _buildTableCell("3ème année", isHeader: true),
            _buildTableCell("Total", isHeader: true),
          ],
        ),
        // Data Rows
        TableRow(children: [
          _buildTableCell("Lecture / Français"),
          _buildTextFormFieldCell('lectureFr1', '0'),
          _buildTextFormFieldCell('lectureFr2', '0'),
          _buildTextFormFieldCell('lectureFr3', '0'),
          _buildTextFormFieldCell('lectureFrTotal', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Compte"),
          _buildTextFormFieldCell('compte1', '0'),
          _buildTextFormFieldCell('compte2', '0'),
          _buildTextFormFieldCell('compte3', '0'),
          _buildTextFormFieldCell('compteTotal', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Éducation au milieu"),
          _buildTextFormFieldCell('milieu1', '0'),
          _buildTextFormFieldCell('milieu2', '0'),
          _buildTextFormFieldCell('milieu3', '0'),
          _buildTextFormFieldCell('milieuTotal', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Manuels pour les matières transversales"),
          _buildTextFormFieldCell('transversales1', '0'),
          _buildTextFormFieldCell('transversales2', '0'),
          _buildTextFormFieldCell('transversales3', '0'),
          _buildTextFormFieldCell('transversalesTotal', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Autres manuels (à préciser)"),
          _buildTextFormFieldCell('autres1', '0'),
          _buildTextFormFieldCell('autres2', '0'),
          _buildTextFormFieldCell('autres3', '0'),
          _buildTextFormFieldCell('autresTotal', '0'),
        ]),
      ],
    );
  }

  Widget _buildManuals1Table() {
    return Table(
      border: TableBorder.all(),
      children: [
        // Header Row
        TableRow(
          children: [
            _buildTableCell("Année d'études / Type de manuels", isHeader: true),
            _buildTableCell("1ère année", isHeader: true),
            _buildTableCell("2ème année", isHeader: true),
            _buildTableCell("3ème année", isHeader: true),
            _buildTableCell("Total", isHeader: true),
          ],
        ),
        // Data Rows
        TableRow(children: [
          _buildTableCell("Lecture / Français"),
          _buildTextFormFieldCell('lecture1Fr1', '0'),
          _buildTextFormFieldCell('lecture1Fr2', '0'),
          _buildTextFormFieldCell('lecture1Fr3', '0'),
          _buildTextFormFieldCell('lecture1FrTotal', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Compte"),
          _buildTextFormFieldCell('compte11', '0'),
          _buildTextFormFieldCell('compte12', '0'),
          _buildTextFormFieldCell('compte13', '0'),
          _buildTextFormFieldCell('compteTotal1', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Eveil"),
          _buildTextFormFieldCell('eveil1', '0'),
          _buildTextFormFieldCell('eveil2', '0'),
          _buildTextFormFieldCell('eveil3', '0'),
          _buildTextFormFieldCell('eveilTotal', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Etude du milieu"),
          _buildTextFormFieldCell('etudemilieu1', '0'),
          _buildTextFormFieldCell('etudemilieu2', '0'),
          _buildTextFormFieldCell('etudemilieu3', '0'),
          _buildTextFormFieldCell('etudemilieuTotal', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Manuels pour les thèmes transversaux"),
          _buildTextFormFieldCell('transversauxmanuel1', '0'),
          _buildTextFormFieldCell('transversauxmanuel2', '0'),
          _buildTextFormFieldCell('transversauxmanuel3', '0'),
          _buildTextFormFieldCell('transversauxmanuelTotal', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Autres manuels (à préciser)"),
          _buildTextFormFieldCell('autresmanuels1', '0'),
          _buildTextFormFieldCell('autresmanuels2', '0'),
          _buildTextFormFieldCell('autresmanuels', '0'),
          _buildTextFormFieldCell('autresmanuelsTotal', '0'),
        ]),
      ],
    );
  }

  Widget _buildRoomsTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        // Header Row
        TableRow(
          children: [
            _buildTableCell("Type de locaux", isHeader: true),
            _buildTableCell("En dur et bon état", isHeader: true),
            _buildTableCell("En dur et mauvais état", isHeader: true),
            _buildTableCell("Semi-dur et bon état", isHeader: true),
            _buildTableCell("Semi-dur et mauvais état", isHeader: true),
            _buildTableCell("Terre battue et bon état", isHeader: true),
            _buildTableCell("Terre battue et mauvais état", isHeader: true),
            _buildTableCell("Paille feuillage et bon état", isHeader: true),
            _buildTableCell("Paille feuillage et mauvais état", isHeader: true),
            _buildTableCell("Total", isHeader: true),
            _buildTableCell("Dont détruit ou occupés", isHeader: true),
          ],
        ),
        // Data Rows
        TableRow(children: [
          _buildTableCell("Salle d'activités"),
          _buildTextFormFieldCell('salleActivitesDurbon', '0'),
          _buildTextFormFieldCell('salleActivitesDurmauvais', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurbon', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuebon ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuemauvais ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilbon ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesTotal', '0'),
          _buildTextFormFieldCell('dontdetruitoccup', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Salle de repos"),
          _buildTextFormFieldCell('salleActivitesDurbon', '0'),
          _buildTextFormFieldCell('salleActivitesDurmauvais', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurbon', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuebon ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuemauvais ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilbon ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesTotal', '0'),
          _buildTextFormFieldCell('dontdetruitoccup', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Salle de Jeux/Sport"),
          _buildTextFormFieldCell('salleActivitesDurbon', '0'),
          _buildTextFormFieldCell('salleActivitesDurmauvais', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurbon', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuebon ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuemauvais ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilbon ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesTotal', '0'),
          _buildTextFormFieldCell('dontdetruitoccup', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Salle d'attente"),
          _buildTextFormFieldCell('salleActivitesDurbon', '0'),
          _buildTextFormFieldCell('salleActivitesDurmauvais', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurbon', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuebon ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuemauvais ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilbon ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesTotal', '0'),
          _buildTextFormFieldCell('dontdetruitoccup', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Bureau"),
          _buildTextFormFieldCell('salleActivitesDurbon', '0'),
          _buildTextFormFieldCell('salleActivitesDurmauvais', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurbon', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuebon ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuemauvais ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilbon ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesTotal', '0'),
          _buildTextFormFieldCell('dontdetruitoccup', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Magasin"),
          _buildTextFormFieldCell('salleActivitesDurbon', '0'),
          _buildTextFormFieldCell('salleActivitesDurmauvais', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurbon', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuebon ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuemauvais ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilbon ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesTotal', '0'),
          _buildTextFormFieldCell('dontdetruitoccup', '0'),
        ]),
      ],
    );
  }

  Widget _buildRooms1Table() {
    return Table(
      border: TableBorder.all(),
      children: [
        // Header Row
        TableRow(
          children: [
            _buildTableCell("Type de locaux", isHeader: true),
            _buildTableCell("En dur et bon état", isHeader: true),
            _buildTableCell("En dur et mauvais état", isHeader: true),
            _buildTableCell("Semi-dur et bon état", isHeader: true),
            _buildTableCell("Semi-dur et mauvais état", isHeader: true),
            _buildTableCell("Terre battue et bon état", isHeader: true),
            _buildTableCell("Terre battue et mauvais état", isHeader: true),
            _buildTableCell("Paille feuillage et bon état", isHeader: true),
            _buildTableCell("Paille feuillage et mauvais état", isHeader: true),
            _buildTableCell("Total", isHeader: true),
            _buildTableCell("Dont détruit ou occupés", isHeader: true),
          ],
        ),
        // Data Rows
        TableRow(children: [
          _buildTableCell("Salle d'activités"),
          _buildTextFormFieldCell('salleActivitesDurbon', '0'),
          _buildTextFormFieldCell('salleActivitesDurmauvais', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurbon', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuebon ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuemauvais ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilbon ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesTotal', '0'),
          _buildTextFormFieldCell('dontdetruitoccup', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Salle de repos"),
          _buildTextFormFieldCell('salleActivitesDurbon', '0'),
          _buildTextFormFieldCell('salleActivitesDurmauvais', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurbon', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuebon ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuemauvais ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilbon ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesTotal', '0'),
          _buildTextFormFieldCell('dontdetruitoccup', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Salle de Jeux/Sport"),
          _buildTextFormFieldCell('salleActivitesDurbon', '0'),
          _buildTextFormFieldCell('salleActivitesDurmauvais', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurbon', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuebon ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuemauvais ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilbon ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesTotal', '0'),
          _buildTextFormFieldCell('dontdetruitoccup', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Salle d'attente"),
          _buildTextFormFieldCell('salleActivitesDurbon', '0'),
          _buildTextFormFieldCell('salleActivitesDurmauvais', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurbon', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuebon ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuemauvais ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilbon ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesTotal', '0'),
          _buildTextFormFieldCell('dontdetruitoccup', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Bureau"),
          _buildTextFormFieldCell('salleActivitesDurbon', '0'),
          _buildTextFormFieldCell('salleActivitesDurmauvais', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurbon', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuebon ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuemauvais ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilbon ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesTotal', '0'),
          _buildTextFormFieldCell('dontdetruitoccup', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Magasin"),
          _buildTextFormFieldCell('salleActivitesDurbon', '0'),
          _buildTextFormFieldCell('salleActivitesDurmauvais', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurbon', '0'),
          _buildTextFormFieldCell('salleActivitesSemidurmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuebon ', '0'),
          _buildTextFormFieldCell('salleActivitesterrebattuemauvais ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilbon ', '0'),
          _buildTextFormFieldCell('salleActivitespaillefeuilmauvais ', '0'),
          _buildTextFormFieldCell('salleActivitesTotal', '0'),
          _buildTextFormFieldCell('dontdetruitoccup', '0'),
        ]),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTextFormFieldCell(String key, String initialValue) {
    return TextFormField(
      initialValue: initialValue,
      onSaved: (value) => formData[key] = value,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}