import 'package:flutter/material.dart';

class TypeStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const TypeStep({
    super.key,
    required this.formData,
    required this.formKey,
  });

  @override
  _TypeStepState createState() => _TypeStepState();
}

class _TypeStepState extends State<TypeStep> {
  // Contrôleurs pour tous les champs de formulaire
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    // Initialiser tous les contrôleurs avec les valeurs du formData ou '0'
    _initializeControllers();
  }

  @override
  void dispose() {
    // Nettoyer tous les contrôleurs
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void _initializeControllers() {
    // Liste de toutes les clés possibles pour les champs de tableau
    final allKeys = [
      // Tableau enfants
      'age3G', 'age3F', 'age4G', 'age4F', 'age5PlusG', 'age5PlusF',
      'totalG', 'totalF', 'autochtoneG', 'autochtoneF', 'orphelinsG',
      'orphelinsF', 'deplacesInternesG', 'deplacesInternesF',
      'deplacesExternesG', 'deplacesExternesF',

      // Tableau personnel enseignant
      'emH', 'emF', 'em2H', 'em2F', 'em3H', 'em3F', 'emTotal',
      'd4H', 'd4F', 'd42H', 'd42F', 'd43H', 'd43F', 'd4Total',
      'p6H', 'p6F', 'p62H', 'p62F', 'p63H', 'p63F', 'p6Total',
      'd6H', 'd6F', 'd62H', 'd62F', 'd63H', 'd63F', 'd6Total',
      'autres6H', 'autres6F', 'autres62H', 'autres62F', 'autres63H',
      'autres63F', 'autres6Total',
      'total6H', 'total6F', 'total62H', 'total62F', 'total63H',
      'total63F', 'total6Total',

      // Tableau administratif
      'emDirH', 'emDirF', 'emAdjH', 'emAdjF', 'emSurvH', 'emSurvF',
      'emouvrierH', 'emouvriereF',
      'd4DirH', 'd4DirF', 'd4AdjH', 'd4AdjF', 'd4SurvH', 'd4SurvF',
      'd4ouvrierH', 'd4ouvriereF',
      'p6DirH', 'p6DirF', 'p6AdjH', 'p6AdjF', 'p6SurvH', 'p6SurvF',
      'p6ouvrierH', 'p6ouvriereF',
      'd6DirH', 'd6DirF', 'd6AdjH', 'd6AdjF', 'd6SurvH', 'd6SurvF',
      'd6ouvrierH', 'd6ouvriereF',
      'autresDirH', 'autresDirF', 'autresAdjH', 'autresAdjF',
      'autresSurvH', 'autresSurvF', 'autresouvrierH', 'autresouvriereF',
      'total1', 'total2', 'total3', 'total4', 'total5', 'total6',
      'total7', 'total8',

      // Champ texte
      'nombreEducateursFormation'
    ];

    // Initialiser chaque contrôleur
    for (var key in allKeys) {
      _controllers[key] = TextEditingController(
        text: widget.formData[key]?.toString() ?? '0',
      );
    }
  }

  // Méthode pour calculer les totaux
  int _calculateRowTotal(List<String> keys, String gender) {
    int total = 0;
    for (var key in keys) {
      if (key.endsWith(gender)) {
        total += int.tryParse(_controllers[key]?.text ?? '0') ?? 0;
      }
    }
    return total;
  }

  // Méthode pour calculer le total d'une colonne
  int _calculateColumnTotal(List<String> rowKeys) {
    int total = 0;
    for (var key in rowKeys) {
      total += int.tryParse(_controllers[key]?.text ?? '0') ?? 0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... (tous les Text d'en-tête restent les mêmes)

            // Tableau enfants
            _buildChildrenEffectivesTable(),
            const SizedBox(height: 10),

            // Tableau 2ème année
            _buildAdditionalTable(),
            const SizedBox(height: 10),

            // Tableau 3ème année
            _buildAdditional2Table(),
            const SizedBox(height: 10),

            // Tableau personnel enseignant
            _buildPersonnelTable(),
            const SizedBox(height: 10),

            // Champ texte
            _buildTextFormField(
              label: 'Nombre d\'enseignants éligibles à la retraite',
              controller: _controllers['nombreEducateursFormation']!,
              validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
              icon: Icons.school_outlined,
            ),
            const SizedBox(height: 12),

            // Tableau administratif
            _buildAdministrativeTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildChildrenEffectivesTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            _buildTableCell('Niveau d\'études / Sexe / Age', isHeader: true),
            _buildTableCell('G', isHeader: true),
            _buildTableCell('F', isHeader: true),
          ],
        ),
        _buildTableRowWithControllers('3 ans', 'age3G', 'age3F'),
        _buildTableRowWithControllers('4 ans', 'age4G', 'age4F'),
        _buildTableRowWithControllers('5 ans et plus', 'age5PlusG', 'age5PlusF'),
        _buildTableRowWithControllers('Total', 'totalG', 'totalF', isTotal: true),
        _buildTableRowWithControllers('Dont autochtones', 'autochtoneG', 'autochtoneF'),
        _buildTableRowWithControllers('Dont orphelins', 'orphelinsG', 'orphelinsF'),
        _buildTableRowWithControllers('Dont déplacés internes', 'deplacesInternesG', 'deplacesInternesF'),
        _buildTableRowWithControllers('Dont déplacés externes', 'deplacesExternesG', 'deplacesExternesF'),
        _buildTableRowWithControllers('Dont réintégrants', 'deplacesExternesG', 'deplacesExternesF'),
        _buildTableRowWithControllers('Dont avec handicap', 'deplacesExternesG', 'deplacesExternesF'),
      ],
    );
  }

  TableRow _buildTableRowWithControllers(String label, String keyG, String keyF, {bool isTotal = false}) {
    return TableRow(children: [
      _buildTableCell(label),
      _buildTextFormFieldCell(keyG, isTotal: isTotal),
      _buildTextFormFieldCell(keyF, isTotal: isTotal),
    ]);
  }

  Widget _buildTextFormFieldCell(String key, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        controller: _controllers[key],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: isTotal,
          fillColor: Colors.grey[200],
        ),
        onChanged: (value) {
          // Mettre à jour les totaux quand une valeur change
          setState(() {
            widget.formData[key] = value;
            _updateTotals();
          });
        },
        onSaved: (value) => widget.formData[key] = value,
      ),
    );
  }

  void _updateTotals() {
    // Mettre à jour les totaux pour le tableau enfants
    _controllers['totalG']?.text = _calculateRowTotal(
        ['age3G', 'age4G', 'age5PlusG'], 'G'
    ).toString();

    _controllers['totalF']?.text = _calculateRowTotal(
        ['age3F', 'age4F', 'age5PlusF'], 'F'
    ).toString();

    // Mettre à jour les totaux pour le tableau personnel enseignant
    _updateTeachingStaffTotals();

    // Mettre à jour les totaux pour le tableau administratif
    _updateAdministrativeTotals();
  }

  void _updateTeachingStaffTotals() {
    // Pour chaque qualification (EM, D4, P6, D6, Autres)
    final qualifications = ['em', 'd4', 'p6', 'd6', 'autres6'];

    for (var qualif in qualifications) {
      // Total pour la qualification
      _controllers['${qualif}Total']?.text = _calculateColumnTotal(
          ['${qualif}H', '${qualif}F', '${qualif}2H', '${qualif}2F', '${qualif}3H', '${qualif}3F']
      ).toString();
    }

    // Total général
    _controllers['total6Total']?.text = _calculateColumnTotal(
        ['emTotal', 'd4Total', 'p6Total', 'd6Total', 'autres6Total']
    ).toString();
  }

  void _updateAdministrativeTotals() {
    // Pour chaque qualification (EM, D4, P6, D6, Autres)
    final qualifications = ['em', 'd4', 'p6', 'd6', 'autres'];

    // Calcul des totaux par qualification (ligne)
    for (var qualif in qualifications) {
      // Total Hommes pour la qualification
      _controllers['${qualif}TotalH']?.text = _calculateColumnTotal(
          ['${qualif}DirH', '${qualif}AdjH', '${qualif}SurvH', '${qualif}ouvrierH']
      ).toString();

      // Total Femmes pour la qualification
      _controllers['${qualif}TotalF']?.text = _calculateColumnTotal(
          ['${qualif}DirF', '${qualif}AdjF', '${qualif}SurvF', '${qualif}ouvriereF']
      ).toString();
    }

    // Calcul des totaux par colonne
    // Colonne 1: Directeurs H
    _controllers['total1']?.text = _calculateColumnTotal(
        ['emDirH', 'd4DirH', 'p6DirH', 'd6DirH', 'autresDirH']
    ).toString();

    // Colonne 2: Directeurs F
    _controllers['total2']?.text = _calculateColumnTotal(
        ['emDirF', 'd4DirF', 'p6DirF', 'd6DirF', 'autresDirF']
    ).toString();

    // Colonne 3: Directeurs adjoints H
    _controllers['total3']?.text = _calculateColumnTotal(
        ['emAdjH', 'd4AdjH', 'p6AdjH', 'd6AdjH', 'autresAdjH']
    ).toString();

    // Colonne 4: Directeurs adjoints F
    _controllers['total4']?.text = _calculateColumnTotal(
        ['emAdjF', 'd4AdjF', 'p6AdjF', 'd6AdjF', 'autresAdjF']
    ).toString();

    // Colonne 5: Surveillants H
    _controllers['total5']?.text = _calculateColumnTotal(
        ['emSurvH', 'd4SurvH', 'p6SurvH', 'd6SurvH', 'autresSurvH']
    ).toString();

    // Colonne 6: Surveillants F
    _controllers['total6']?.text = _calculateColumnTotal(
        ['emSurvF', 'd4SurvF', 'p6SurvF', 'd6SurvF', 'autresSurvF']
    ).toString();

    // Colonne 7: Ouvriers H
    _controllers['total7']?.text = _calculateColumnTotal(
        ['emouvrierH', 'd4ouvrierH', 'p6ouvrierH', 'd6ouvrierH', 'autresouvrierH']
    ).toString();

    // Colonne 8: Ouvrières F
    _controllers['total8']?.text = _calculateColumnTotal(
        ['emouvriereF', 'd4ouvriereF', 'p6ouvriereF', 'd6ouvriereF', 'autresouvriereF']
    ).toString();

    // Total général Hommes (colonne Total H)
    _controllers['totalGeneralH']?.text = _calculateColumnTotal(
        ['emTotalH', 'd4TotalH', 'p6TotalH', 'd6TotalH', 'autresTotalH']
    ).toString();

    // Total général Femmes (colonne Total F)
    _controllers['totalGeneralF']?.text = _calculateColumnTotal(
        ['emTotalF', 'd4TotalF', 'p6TotalF', 'd6TotalF', 'autresTotalF']
    ).toString();
  }

  Widget _buildPersonnelTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        // Header Row
        TableRow(
          children: [
            _buildTableCell("Qualification", isHeader: true),
            _buildTableCell("1ère H", isHeader: true),
            _buildTableCell("1ère F", isHeader: true),
            _buildTableCell("2ème H", isHeader: true),
            _buildTableCell("2ème F", isHeader: true),
            _buildTableCell("3ème H", isHeader: true),
            _buildTableCell("3ème F", isHeader: true),
            _buildTableCell("Total", isHeader: true),
          ],
        ),
        // Data Rows
        _buildPersonnelTableRow("EM", "em"),
        _buildPersonnelTableRow("D4", "d4"),
        _buildPersonnelTableRow("P6", "p6"),
        _buildPersonnelTableRow("D6", "d6"),
        _buildPersonnelTableRow("Autres", "autres6"),
        TableRow(
          children: [
            _buildTableCell("Total"),
            _buildTextFormFieldCell('total6H'),
            _buildTextFormFieldCell('total6F'),
            _buildTextFormFieldCell('total62H'),
            _buildTextFormFieldCell('total62F'),
            _buildTextFormFieldCell('total63H'),
            _buildTextFormFieldCell('total63F'),
            _buildTextFormFieldCell('total6Total'),
          ],
        ),
      ],
    );
  }

  TableRow _buildPersonnelTableRow(String label, String prefix) {
    return TableRow(
      children: [
        _buildTableCell(label),
        _buildTextFormFieldCell('${prefix}H'),
        _buildTextFormFieldCell('${prefix}F'),
        _buildTextFormFieldCell('${prefix}2H'),
        _buildTextFormFieldCell('${prefix}2F'),
        _buildTextFormFieldCell('${prefix}3H'),
        _buildTextFormFieldCell('${prefix}3F'),
        _buildTextFormFieldCell('${prefix}Total'),
      ],
    );
  }

  Widget _buildAdditionalTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        // Header Row
        TableRow(
          children: [
            _buildTableCell("Niveau d'études / Sexe / Age", isHeader: true),
            _buildTableCell("G", isHeader: true),
            _buildTableCell("F", isHeader: true),
          ],
        ),
        // Data Rows
        _buildAdditionalTableRow("- 3 ans", 'moins3G', 'moins3F'),
        _buildAdditionalTableRow("3 ans", 'age3G', 'age3F'),
        _buildAdditionalTableRow("4 ans", 'age4G', 'age4F'),
        _buildAdditionalTableRow("5 ans", 'age5G', 'age5F'),
        _buildAdditionalTableRow("+ 5 ans", 'plus5G', 'plus5F'),
        _buildAdditionalTableRow("Total", 'total2G', 'total2F', isTotal: true),
        _buildAdditionalTableRow("Dont autochtone", 'autochtone2G', 'autochtone2F'),
        _buildAdditionalTableRow("Dont orphelins", 'orphelins2G', 'orphelins2F'),
        _buildAdditionalTableRow("Dont réfugiés", 'refugies2G', 'refugies2F'),
        _buildAdditionalTableRow("Dont déplacés internes", 'deplacer_internes2G', 'deplacer_internes2F'),
        _buildAdditionalTableRow("Dont déplacés externes", 'deplacer_externes2G', 'deplacer_externes2F'),
        _buildAdditionalTableRow("Dont réintégrants", 'dont_reintegrants2G', 'dont_reintegrants2F'),
        _buildAdditionalTableRow("Dont avec handicap", 'dont_handicape2G', 'dont_handicape2F'),
      ],
    );
  }

  TableRow _buildAdditionalTableRow(String label, String keyG, String keyF, {bool isTotal = false}) {
    return TableRow(children: [
      _buildTableCell(label),
      _buildTextFormFieldCell(keyG, isTotal: isTotal),
      _buildTextFormFieldCell(keyF, isTotal: isTotal),
    ]);
  }

  Widget _buildAdditional2Table() {
    return Table(
      border: TableBorder.all(),
      children: [
        // Header Row
        TableRow(
          children: [
            _buildTableCell("Niveau d'études / Sexe / Age", isHeader: true),
            _buildTableCell("G", isHeader: true),
            _buildTableCell("F", isHeader: true),
          ],
        ),
        // Data Rows
        _buildAdditional2TableRow("- 3 ans", 'moins_23G', 'moins_23F'),
        _buildAdditional2TableRow("3 ans", 'age_23G', 'age_23F'),
        _buildAdditional2TableRow("4 ans", 'age_24G', 'age_24F'),
        _buildAdditional2TableRow("5 ans", 'age_25G', 'age_25F'),
        _buildAdditional2TableRow("+ 5 ans", 'plus_25G', 'plus_25F'),
        _buildAdditional2TableRow("Total", 'total_22G', 'total_22F', isTotal: true),
        _buildAdditional2TableRow("Dont autochtone", 'autochtone_22G', 'autochtone_22F'),
        _buildAdditional2TableRow("Dont étrangers", 'etrangers_2', 'etrangers_22F'),
        _buildAdditional2TableRow("Dont orphelins", 'orphelins_22G', 'orphelins_22F'),
        _buildAdditional2TableRow("Dont réfugiés", 'refugies_22G', 'refugies_22F'),
        _buildAdditional2TableRow("Dont déplacés internes", 'deplacer_internes_22G', 'deplacer_internes_22F'),
        _buildAdditional2TableRow("Dont déplacés externes", 'deplacer_externes_22G', 'deplacer_externes_22F'),
        _buildAdditional2TableRow("Dont réintégrants", 'dont_reintegrants_22G', 'dont_reintegrants_22F'),
        _buildAdditional2TableRow("Dont avec handicap", 'dont_handicape_22G', 'dont_handicape_22F'),
      ],
    );
  }

  TableRow _buildAdditional2TableRow(String label, String keyG, String keyF, {bool isTotal = false}) {
    return TableRow(children: [
      _buildTableCell(label),
      _buildTextFormFieldCell(keyG, isTotal: isTotal),
      _buildTextFormFieldCell(keyF, isTotal: isTotal),
    ]);
  }

  Widget _buildAdministrativeTable() {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FixedColumnWidth(100), // Colonne Qualification
        1: FixedColumnWidth(80),  // Autres colonnes
        2: FixedColumnWidth(80),
        3: FixedColumnWidth(80),
        4: FixedColumnWidth(80),
        5: FixedColumnWidth(80),
        6: FixedColumnWidth(80),
        7: FixedColumnWidth(80),
        8: FixedColumnWidth(80),
        9: FixedColumnWidth(80),
        10: FixedColumnWidth(80),
      },
      children: [
        // En-tête
        TableRow(
          children: [
            _buildTableCell("Qualification", isHeader: true),
            _buildTableCell("Directeur H", isHeader: true),
            _buildTableCell("Directeur F", isHeader: true),
            _buildTableCell("Directeur Adjoint H", isHeader: true),
            _buildTableCell("Directeur Adjoint F", isHeader: true),
            _buildTableCell("Surveillant H", isHeader: true),
            _buildTableCell("Surveillant F", isHeader: true),
            _buildTableCell("Ouvrier H", isHeader: true),
            _buildTableCell("Ouvrière F", isHeader: true),
            _buildTableCell("Total H", isHeader: true),
            _buildTableCell("Total F", isHeader: true),
          ],
        ),
        // Ligne EM
        _buildAdminTableRow("EM", "em"),
        // Ligne D4
        _buildAdminTableRow("D4", "d4"),
        // Ligne P6
        _buildAdminTableRow("P6", "p6"),
        // Ligne D6
        _buildAdminTableRow("D6", "d6"),
        // Ligne Autres
        _buildAdminTableRow("Autres", "autres"),
        // Ligne Total
        TableRow(
          children: [
            _buildTableCell("Total", isHeader: true),
            _buildTableCell(_controllers['total1']?.text ?? '0', isTotal: true),
            _buildTableCell(_controllers['total2']?.text ?? '0', isTotal: true),
            _buildTableCell(_controllers['total3']?.text ?? '0', isTotal: true),
            _buildTableCell(_controllers['total4']?.text ?? '0', isTotal: true),
            _buildTableCell(_controllers['total5']?.text ?? '0', isTotal: true),
            _buildTableCell(_controllers['total6']?.text ?? '0', isTotal: true),
            _buildTableCell(_controllers['total7']?.text ?? '0', isTotal: true),
            _buildTableCell(_controllers['total8']?.text ?? '0', isTotal: true),
            _buildTableCell(_controllers['totalGeneralH']?.text ?? '0', isTotal: true),
            _buildTableCell(_controllers['totalGeneralF']?.text ?? '0', isTotal: true),
          ],
        ),
      ],
    );
  }

  TableRow _buildAdminTableRow(String label, String prefix) {
    return TableRow(
      children: [
        _buildTableCell(label),
        _buildTextFormFieldCell('${prefix}DirH'),
        _buildTextFormFieldCell('${prefix}DirF'),
        _buildTextFormFieldCell('${prefix}AdjH'),
        _buildTextFormFieldCell('${prefix}AdjF'),
        _buildTextFormFieldCell('${prefix}SurvH'),
        _buildTextFormFieldCell('${prefix}SurvF'),
        _buildTextFormFieldCell('${prefix}ouvrierH'),
        _buildTextFormFieldCell('${prefix}ouvriereF'),
        _buildTableCell(_controllers['${prefix}TotalH']?.text ?? '0', isTotal: true),
        _buildTableCell(_controllers['${prefix}TotalF']?.text ?? '0', isTotal: true),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false, bool isTotal = false}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: isHeader
          ? Colors.grey[300]
          : isTotal
          ? Colors.grey[200]
          : null,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader || isTotal ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    FormFieldValidator<String>? validator,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(),
      ),
      validator: validator,
      onSaved: (value) => widget.formData['nombreEducateursFormation'] = value,
    );
  }
}