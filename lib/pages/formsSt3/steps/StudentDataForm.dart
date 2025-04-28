import 'package:flutter/material.dart';

class StudentDataForm extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const StudentDataForm({
    Key? key,
    required this.formData,
    required this.formKey,
  }) : super(key: key);

  @override
  _StudentDataFormState createState() => _StudentDataFormState();
}

class _StudentDataFormState extends State<StudentDataForm> {
  int _currentStep = 0;
  late Map<String, dynamic> _formData;

  @override
  void initState() {
    super.initState();
    _formData = widget.formData;
    // Initialiser les données si elles n'existent pas
    _formData['studentData'] ??= {};
    _formData['studentData']['demographics'] ??= {};
    _formData['studentData']['specialCategories'] ??= {};
    _formData['studentData']['teachers'] ??= {};
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Stepper(
        currentStep: _currentStep,
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                if (_currentStep != 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Précédent'),
                    ),
                  ),
                if (_currentStep != 0) const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.formKey.currentState!.validate()) {
                        details.onStepContinue!();
                      }
                    },
                    child: Text(
                      _currentStep == 2 ? 'Terminer' : 'Suivant',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep += 1);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          }
        },
        steps: [
          _buildStudentDemographicsStep(),
          _buildSpecialCategoriesStep(),
          _buildTeacherDistributionStep(),
        ],
      ),
    );
  }

  Step _buildStudentDemographicsStep() {
    return Step(
      title: const Text('Démographie des élèves'),
      content: Column(
        children: [
          _buildAgeGroupSection('Primaire', [
            'CP', '1ère', '2ème', '3ème', '4ème', '5ème', '6ème'
          ]),
          const SizedBox(height: 16),
          _buildAgeGroupSection('Secondaire', [
            '7ème', '8ème', '2ème H', '3ème H', '4ème H'
          ]),
        ],
      ),
    );
  }

  Widget _buildAgeGroupSection(String level, List<String> grades) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(level),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: grades.map((grade) {
                return _buildGradeInputRow(level, grade);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeInputRow(String level, String grade) {
    final key = '${level}_$grade';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(grade)),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Filles'),
              keyboardType: TextInputType.number,
              initialValue: _formData['studentData']['demographics']?[key]?['female']?.toString() ?? '',
              validator: (value) {
                if (value == null || value.isEmpty) return 'Champ obligatoire';
                return null;
              },
              onSaved: (value) {
                _formData['studentData']['demographics'] ??= {};
                _formData['studentData']['demographics'][key] ??= {};
                _formData['studentData']['demographics'][key]['female'] = int.tryParse(value!) ?? 0;
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Garçons'),
              keyboardType: TextInputType.number,
              initialValue: _formData['studentData']['demographics']?[key]?['male']?.toString() ?? '',
              validator: (value) {
                if (value == null || value.isEmpty) return 'Champ obligatoire';
                return null;
              },
              onSaved: (value) {
                _formData['studentData']['demographics'] ??= {};
                _formData['studentData']['demographics'][key] ??= {};
                _formData['studentData']['demographics'][key]['male'] = int.tryParse(value!) ?? 0;
              },
            ),
          ),
        ],
      ),
    );
  }

  Step _buildSpecialCategoriesStep() {
    return Step(
      title: const Text('Catégories spéciales'),
      content: Column(
        children: [
          _buildCategoryCard('Redoublants'),
          const SizedBox(height: 8),
          _buildCategoryCard('Élèves internes'),
          const SizedBox(height: 8),
          _buildCategoryCard('Orphelins'),
          const SizedBox(height: 8),
          _buildCategoryCard('Élèves handicapés'),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String category) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(category),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildCategoryInputRow(category, 'Filles'),
                _buildCategoryInputRow(category, 'Garçons'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryInputRow(String category, String gender) {
    final key = '${category}_${gender.toLowerCase()}';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(gender)),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Nombre'),
              keyboardType: TextInputType.number,
              initialValue: _formData['studentData']['specialCategories']?[key]?.toString() ?? '',
              validator: (value) {
                if (value == null || value.isEmpty) return 'Champ obligatoire';
                return null;
              },
              onSaved: (value) {
                _formData['studentData']['specialCategories'] ??= {};
                _formData['studentData']['specialCategories'][key] = int.tryParse(value!) ?? 0;
              },
            ),
          ),
        ],
      ),
    );
  }

  Step _buildTeacherDistributionStep() {
    return Step(
      title: const Text('Répartition des enseignants'),
      content: Column(
        children: [
          _buildTeacherTypeSection('Enseignement général'),
          const SizedBox(height: 16),
          _buildTeacherTypeSection('Enseignement technique'),
        ],
      ),
    );
  }

  Widget _buildTeacherTypeSection(String type) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(type),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildTeacherInputRow(type, 'Classes'),
                _buildTeacherInputRow(type, 'Enseignantes'),
                _buildTeacherInputRow(type, 'Enseignants'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherInputRow(String type, String label) {
    final key = '${type}_${label.toLowerCase()}';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label)),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              initialValue: _formData['studentData']['teachers']?[key]?.toString() ?? '',
              validator: (value) {
                if (value == null || value.isEmpty) return 'Champ obligatoire';
                return null;
              },
              onSaved: (value) {
                _formData['studentData']['teachers'] ??= {};
                _formData['studentData']['teachers'][key] = int.tryParse(value!) ?? 0;
              },
            ),
          ),
        ],
      ),
    );
  }
}