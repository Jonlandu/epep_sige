import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Step15ST3 extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;

  const Step15ST3({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _Step15ST3State createState() => _Step15ST3State();
}

class _Step15ST3State extends State<Step15ST3> {
  final List<String> _gradeLevels = [
    'Préprimaire',
    '1ère année',
    '2ème année',
    '3ème année',
    '4ème année',
    '5ème année',
    '6ème année'
  ];

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
            _buildHeader(
                "Effectif des eleves inscrits par sexe et année d'études selon l'age resolu."),

            // Tabs pour naviguer entre les niveaux
            DefaultTabController(
              length: _gradeLevels.length,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    dragStartBehavior: DragStartBehavior.start,
                    tabAlignment: TabAlignment.center,
                    tabs:
                        _gradeLevels.map((level) => Tab(text: level)).toList(),
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: TabBarView(
                      children: _gradeLevels.map((level) {
                        return _buildGradeLevelTab(level);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Navigation buttons
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeLevelTab(String gradeLevel) {
    final prefix = _getGradePrefix(gradeLevel);
    final ageCategories = _getAgeCategoriesForGrade(gradeLevel);
    final specialCategories = _getSpecialCategoriesForGrade(gradeLevel);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Section: Répartition par âge
          _buildSection(
            title: "Répartition par Âge - $gradeLevel",
            children: [
              _buildAgeTable(prefix, ageCategories),
              const SizedBox(height: 20),
            ],
          ),

          // Section: Catégories spéciales
          _buildSection(
            title: "Catégories Spéciales - $gradeLevel",
            children: [
              _buildSpecialCategoriesTable(prefix, specialCategories),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAgeTable(String prefix, List<String> ageCategories) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(1.5),
      },
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueGrey.shade50),
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Tranche d'âge",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Garçons",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Filles",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        for (final age in ageCategories)
          _buildAgeRow(
            _getAgeLabel(age),
            'st2_nombre_${prefix}_g_$age',
            'st2_nombre_${prefix}_f_$age',
          ),
      ],
    );
  }

  Widget _buildSpecialCategoriesTable(String prefix, List<String> categories) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(1.5),
      },
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueGrey.shade50),
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Catégorie",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Garçons",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Filles",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        for (final category in categories)
          _buildSpecialCategoryRow(
            _getCategoryLabel(category),
            'st2_nombre_${prefix}_g_$category',
            'st2_nombre_${prefix}_f_$category',
          ),
      ],
    );
  }

  // Helper methods
  String _getGradePrefix(String gradeLevel) {
    switch (gradeLevel) {
      case 'Préprimaire':
        return 'preprimaire';
      case '1ère année':
        return 'premiere';
      case '2ème année':
        return 'deuxieme';
      case '3ème année':
        return 'troisieme';
      case '4ème année':
        return 'quatrieme';
      case '5ème année':
        return 'cinquieme';
      case '6ème année':
        return 'sixieme';
      default:
        return '';
    }
  }

  List<String> _getAgeCategoriesForGrade(String gradeLevel) {
    switch (gradeLevel) {
      case 'Préprimaire':
        return ['moins6', '6', '7', '8', '9', '10', '11', 'plus11'];
      case '1ère année':
        return ['moins6', '6', '7', '8', '9', '10', '11', 'plus11'];
      case '2ème année':
        return ['6', '7', '8', '9', '10', '11', 'plus11'];
      case '3ème année':
        return ['7', '8', '9', '10', '11', 'plus11'];
      case '4ème année':
        return ['8', '9', '10', '11', 'plus11'];
      case '5ème année':
        return ['9', '10', '11', 'plus11'];
      case '6ème année':
        return ['10', '11', 'plus11'];
      default:
        return [];
    }
  }

  List<String> _getSpecialCategoriesForGrade(String gradeLevel) {
    final categories = [
      'dont_redoublons',
      if (gradeLevel == '1ère année') 'dont_redoublons_de6',
      'dont_internants',
      'dont_orphelins',
      'dont_autochtone',
      'dont_etrangers',
      'dont_refugies',
      'dont_deplaces',
      'dont_reintegrants',
      'dont_avec_handicap',
    ];
    return categories;
  }

  String _getAgeLabel(String age) {
    switch (age) {
      case 'moins6':
        return '<6 ans';
      case 'plus11':
        return '>11 ans';
      default:
        return '$age ans';
    }
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case 'dont_redoublons':
        return 'Redoublants';
      case 'dont_redoublons_de6':
        return 'Redoublants de 6 ans';
      case 'dont_internants':
        return 'Internants';
      case 'dont_orphelins':
        return 'Orphelins';
      case 'dont_autochtone':
        return 'Autochtones';
      case 'dont_etrangers':
        return 'Étrangers';
      case 'dont_refugies':
        return 'Réfugiés';
      case 'dont_deplaces':
        return 'Déplacés';
      case 'dont_reintegrants':
        return 'Réintégrants';
      case 'dont_avec_handicap':
        return 'Élèves handicapés';
      default:
        return category;
    }
  }

  // Reused components from your example
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

  TableRow _buildAgeRow(String label, String keyG, String keyF) {
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

  TableRow _buildSpecialCategoryRow(String label, String keyG, String keyF) {
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
