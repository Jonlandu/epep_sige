import 'package:epsp_sige/utils/Routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ValidationStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const ValidationStep({
    super.key,
    required this.formData,
    required this.formKey,
  });

  @override
  _ValidationStepState createState() => _ValidationStepState();
}

class _ValidationStepState extends State<ValidationStep> {
  bool _isValidated = false;

  @override
  void initState() {
    super.initState();
    _isValidated = widget.formData['validation'] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(  // Added scrollable view
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            const SizedBox(height: 8),
            _buildSubtitle(),
            const SizedBox(height: 10),
            _buildSummaryCard(),
            const SizedBox(height: 19),
            _buildValidationCheckbox(),
            if (!_isValidated) _buildValidationWarning(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildInfoText(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Validation',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red.shade800,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black87),
              children: [
                TextSpan(
                  text: 'Ceci est un aperçu. Vérifiez les informations avant soumission. Après soumission, vous pourrez le modifier :  ',
                ),
                TextSpan(
                  text: 'Ici',
                  style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.pushNamed(context, Routes.SavedFormsScreenRoutes);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ..._buildSummaryItems(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSummaryItems() {
    return [
      _buildSummaryItem('Province', widget.formData['province']),
      _buildSummaryItem('Proved', widget.formData['proved']),
      _buildSummaryItem('Sous-Proved', widget.formData['sousProved']),
      _buildSummaryItem('Centre de regroupement', widget.formData['centreRegroupement']),
      _buildSummaryItem('Nom établissement', widget.formData['nomEtablissement']),
      _buildSummaryItem('Chef établissement', widget.formData['nomChefEtablissement']),
      _buildSummaryItem('Type', widget.formData['typeEtablissement']),
      _buildSummaryItem('Niveaux', widget.formData['niveauxEnseignement'].join(',')),
      _buildSummaryItem('Capacité', widget.formData['capaciteAccueil']),
      _buildSummaryItem('Nombre d\'élèves', widget.formData['nombreEleves']),
      _buildSummaryItem('Nombre d\'enseignants', widget.formData['nombreEnseignants']),
      _buildSummaryItem('Adresse', widget.formData['adresse']),
      _buildSummaryItem('Téléphone', widget.formData['telephone']),
      _buildSummaryItem('Email', widget.formData['email']),
      _buildSummaryItem('Année de création', widget.formData['anneeCreation']),
      _buildSummaryItem('Infrastructures', widget.formData['infrastructures'].join(',')),
    ];
  }

  Widget _buildSummaryItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value ?? 'N/A')),
        ],
      ),
    );
  }

  Widget _buildValidationCheckbox() {
    return Card(
      elevation: 0,
      color: Colors.red.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _isValidated ? Colors.green : Colors.red.shade300,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: CheckboxListTile(
          title: const Text(
            'Je certifie que les informations fournies sont exactes',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          value: _isValidated,
          onChanged: (bool? value) {
            setState(() {
              _isValidated = value ?? false;
              widget.formData['validation'] = _isValidated;
            });
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.green,
          checkColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildValidationWarning() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        'Vous devez accepter cette déclaration pour soumettre',
        style: TextStyle(color: Colors.red.shade600),
      ),
    );
  }

  Widget _buildInfoText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black87),
        children: [
          TextSpan(
            text: 'Pour des raisons de sécurité, une fois certifiées, ces informations seront enregistrées localement et vous pourrez les envoyer :  ',
          ),
          TextSpan(
            text: 'Ici',
            style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()..onTap = () {
              Navigator.pushNamed(context, Routes.SavedFormsScreenRoutes);
            },
          ),
        ],
      ),
    );
  }
}