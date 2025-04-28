import 'package:flutter/material.dart';

class ContactDataForm extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const ContactDataForm({
    Key? key,
    required this.formData,
    required this.formKey,
  }) : super(key: key);

  @override
  _ContactDataFormState createState() => _ContactDataFormState();
}

class _ContactDataFormState extends State<ContactDataForm> {
  int _currentStep = 0;
  late Map<String, dynamic> _formData;
  final List<String> _educationTypes = [
    'NORMAL (Péda Gén, normal et Educ Physique)',
    'TECHNIQUE (Cycle long)',
    'PROFESSIONEL (CYCLE COURT)',
    'ARTS ET METIERS'
  ];
  final List<String> _grades = ['7ème', '8ème', '2ème H', '3ème H', '4ème H'];
  List<TextEditingController> _filiereControllers = List.generate(5, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _formData = widget.formData;
    _formData['studentData'] ??= {};
    _formData['studentData']['educationTypes'] ??= {};
    _formData['studentData']['filieres'] ??= {};
    _formData['studentData']['examResults'] ??= {};
    _formData['studentData']['juryResults'] ??= {};
  }

  @override
  void dispose() {
    for (var controller in _filiereControllers) {
      controller.dispose();
    }
    super.dispose();
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
                      _currentStep == 3 ? 'Terminer' : 'Suivant',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        onStepContinue: () {
          if (_currentStep < 3) {
            setState(() => _currentStep += 1);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          }
        },
        steps: [
          _buildEducationTypesStep(),
          _buildFilieresStep(),
          _buildExamResultsStep(),
          _buildJuryResultsStep(),
        ],
      ),
    );
  }

  Step _buildEducationTypesStep() {
    return Step(
      title: const Text('Types d\'enseignement'),
      content: Column(
        children: _educationTypes.map((type) {
          return _buildEducationTypeCard(type);
        }).toList(),
      ),
    );
  }

  Widget _buildEducationTypeCard(String type) {
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
                ..._grades.map((grade) => _buildGradeInputRow(type, grade)),
                _buildSpecialRow(type, 'Dont Redoublant'),
                _buildSpecialRow(type, 'Total'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeInputRow(String type, String grade) {
    final key = '${type}_$grade';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(grade, style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Classes'),
                  keyboardType: TextInputType.number,
                  initialValue: _formData['studentData']['educationTypes']?[key]?['classes']?.toString() ?? '0',
                  onSaved: (value) {
                    _formData['studentData']['educationTypes'] ??= {};
                    _formData['studentData']['educationTypes'][key] ??= {};
                    _formData['studentData']['educationTypes'][key]['classes'] = int.tryParse(value!) ?? 0;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Garçons'),
                  keyboardType: TextInputType.number,
                  initialValue: _formData['studentData']['educationTypes']?[key]?['male']?.toString() ?? '0',
                  onSaved: (value) {
                    _formData['studentData']['educationTypes'] ??= {};
                    _formData['studentData']['educationTypes'][key] ??= {};
                    _formData['studentData']['educationTypes'][key]['male'] = int.tryParse(value!) ?? 0;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Filles'),
                  keyboardType: TextInputType.number,
                  initialValue: _formData['studentData']['educationTypes']?[key]?['female']?.toString() ?? '0',
                  onSaved: (value) {
                    _formData['studentData']['educationTypes'] ??= {};
                    _formData['studentData']['educationTypes'][key] ??= {};
                    _formData['studentData']['educationTypes'][key]['female'] = int.tryParse(value!) ?? 0;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialRow(String type, String label) {
    final key = '${type}_$label';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Classes'),
                  keyboardType: TextInputType.number,
                  initialValue: _formData['studentData']['educationTypes']?[key]?['classes']?.toString() ?? '0',
                  onSaved: (value) {
                    _formData['studentData']['educationTypes'] ??= {};
                    _formData['studentData']['educationTypes'][key] ??= {};
                    _formData['studentData']['educationTypes'][key]['classes'] = int.tryParse(value!) ?? 0;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Garçons'),
                  keyboardType: TextInputType.number,
                  initialValue: _formData['studentData']['educationTypes']?[key]?['male']?.toString() ?? '0',
                  onSaved: (value) {
                    _formData['studentData']['educationTypes'] ??= {};
                    _formData['studentData']['educationTypes'][key] ??= {};
                    _formData['studentData']['educationTypes'][key]['male'] = int.tryParse(value!) ?? 0;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Filles'),
                  keyboardType: TextInputType.number,
                  initialValue: _formData['studentData']['educationTypes']?[key]?['female']?.toString() ?? '0',
                  onSaved: (value) {
                    _formData['studentData']['educationTypes'] ??= {};
                    _formData['studentData']['educationTypes'][key] ??= {};
                    _formData['studentData']['educationTypes'][key]['female'] = int.tryParse(value!) ?? 0;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Step _buildFilieresStep() {
    return Step(
      title: const Text('Filières/Options'),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Répartition des élèves par Niveau d\'études, sexe et filière/section-option',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          ...List.generate(5, (index) {
            return _buildFiliereCard(index);
          }),
        ],
      ),
    );
  }

  Widget _buildFiliereCard(int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _filiereControllers[index],
              decoration: InputDecoration(
                labelText: 'Filière ou Option ${index + 1}',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                _formData['studentData']['filieres']['filiere_$index'] = value;
              },
            ),
            const SizedBox(height: 16),
            ..._grades.map((grade) => _buildFiliereInputRow('filiere_$index', grade)),
          ],
        ),
      ),
    );
  }

  Widget _buildFiliereInputRow(String filiereKey, String grade) {
    final key = '${filiereKey}_$grade';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(grade, style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Garçons'),
                  keyboardType: TextInputType.number,
                  initialValue: _formData['studentData']['filieres']?[key]?['male']?.toString() ?? '0',
                  onSaved: (value) {
                    _formData['studentData']['filieres'] ??= {};
                    _formData['studentData']['filieres'][key] ??= {};
                    _formData['studentData']['filieres'][key]['male'] = int.tryParse(value!) ?? 0;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Filles'),
                  keyboardType: TextInputType.number,
                  initialValue: _formData['studentData']['filieres']?[key]?['female']?.toString() ?? '0',
                  onSaved: (value) {
                    _formData['studentData']['filieres'] ??= {};
                    _formData['studentData']['filieres'][key] ??= {};
                    _formData['studentData']['filieres'][key]['female'] = int.tryParse(value!) ?? 0;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Step _buildExamResultsStep() {
    return Step(
      title: const Text('Résultats aux Examens'),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Résultats à l\'Examen d\'État de l\'Année Précédente',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          ...List.generate(4, (index) => _buildExamResultCard(index)),
        ],
      ),
    );
  }

  Widget _buildExamResultCard(int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Filière ou Option ${index + 1}',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                _formData['studentData']['examResults']['filiere_$index'] = value;
              },
            ),
            const SizedBox(height: 16),
            _buildExamResultSection('Inscrits', 'filiere_$index', 'inscrits'),
            _buildExamResultSection('Présents', 'filiere_$index', 'presents'),
            _buildExamResultSection('Admis', 'filiere_$index', 'admis'),
          ],
        ),
      ),
    );
  }

  Widget _buildExamResultSection(String title, String filiereKey, String sectionKey) {
    final key = '${filiereKey}_$sectionKey';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Garçons'),
                keyboardType: TextInputType.number,
                initialValue: _formData['studentData']['examResults']?[key]?['male']?.toString() ?? '0',
                onSaved: (value) {
                  _formData['studentData']['examResults'] ??= {};
                  _formData['studentData']['examResults'][key] ??= {};
                  _formData['studentData']['examResults'][key]['male'] = int.tryParse(value!) ?? 0;
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Filles'),
                keyboardType: TextInputType.number,
                initialValue: _formData['studentData']['examResults']?[key]?['female']?.toString() ?? '0',
                onSaved: (value) {
                  _formData['studentData']['examResults'] ??= {};
                  _formData['studentData']['examResults'][key] ??= {};
                  _formData['studentData']['examResults'][key]['female'] = int.tryParse(value!) ?? 0;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Step _buildJuryResultsStep() {
    return Step(
      title: const Text('Résultats Jury National'),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Résultats aux Jury National du Cycle Court de l\'Année Précédente',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          ...List.generate(5, (index) => _buildJuryResultCard(index)),
        ],
      ),
    );
  }

  Widget _buildJuryResultCard(int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Filière ou Option ${index + 1}',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                _formData['studentData']['juryResults']['filiere_$index'] = value;
              },
            ),
            const SizedBox(height: 16),
            _buildJuryResultSection('Participants', 'filiere_$index', 'participants'),
            _buildJuryResultSection('Réussites', 'filiere_$index', 'reussites'),
          ],
        ),
      ),
    );
  }

  Widget _buildJuryResultSection(String title, String filiereKey, String sectionKey) {
    final key = '${filiereKey}_$sectionKey';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Garçons'),
                keyboardType: TextInputType.number,
                initialValue: _formData['studentData']['juryResults']?[key]?['male']?.toString() ?? '0',
                onSaved: (value) {
                  _formData['studentData']['juryResults'] ??= {};
                  _formData['studentData']['juryResults'][key] ??= {};
                  _formData['studentData']['juryResults'][key]['male'] = int.tryParse(value!) ?? 0;
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Filles'),
                keyboardType: TextInputType.number,
                initialValue: _formData['studentData']['juryResults']?[key]?['female']?.toString() ?? '0',
                onSaved: (value) {
                  _formData['studentData']['juryResults'] ??= {};
                  _formData['studentData']['juryResults'][key] ??= {};
                  _formData['studentData']['juryResults'][key]['female'] = int.tryParse(value!) ?? 0;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}