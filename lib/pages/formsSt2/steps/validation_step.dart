import 'package:flutter/material.dart';

class ValidationStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const ValidationStep({
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
          _buildTitle(),
          const SizedBox(height: 8),
          _buildSubtitle(),
          const SizedBox(height: 24),
          _buildSummaryCard(),
          const SizedBox(height: 24),
          _buildValidationCheckbox(context),
          if (formData['validation'] == false) _buildValidationWarning(),
        ],
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
    return Text(
      'Vérifiez les informations avant soumission',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade600,
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
            _buildSummaryItem('Province', formData['province']),
            _buildSummaryItem('Proved', formData['proved']),
            _buildSummaryItem('Sous-Proved', formData['sousProved']),
            _buildSummaryItem('Centre de regroupement', formData['centreRegroupement']),
            _buildSummaryItem('Nom établissement', formData['nomEtablissement']),
            _buildSummaryItem('Chef établissement', formData['nomChefEtablissement']),
            _buildSummaryItem('Type', formData['typeEtablissement']),
            _buildSummaryItem('Niveaux', formData['niveauxEnseignement'].join(', ')),
            _buildSummaryItem('Capacité', formData['capaciteAccueil']),
            _buildSummaryItem('Nombre d\'élèves', formData['nombreEleves']),
            _buildSummaryItem('Nombre d\'enseignants', formData['nombreEnseignants']),
            _buildSummaryItem('Adresse', formData['adresse']),
            _buildSummaryItem('Téléphone', formData['telephone']),
            _buildSummaryItem('Email', formData['email']),
            _buildSummaryItem('Année de création', formData['anneeCreation']),
            _buildSummaryItem('Infrastructures', formData['infrastructures'].join(', ')),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _buildValidationCheckbox(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.red.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: formData['validation'] ? Colors.green : Colors.red.shade300,
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
          value: formData['validation'] as bool,
          onChanged: (bool? value) {
            formData['validation'] = value ?? false;
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
}