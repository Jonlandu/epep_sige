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
      _buildSummaryItem('Des programmes officiels de cours ?', widget.formData['programmesOfficiels']), // 'programmesOfficiels'
      _buildSummaryItem('D\'un COPA ?', widget.formData['copa']), // 'copa'
      _buildSummaryItem('Les locaux, sont-ils utilisés par un 2ème ?', widget.formData['locauxUtilises']), // 'locauxUtilises'
      _buildSummaryItem('Point d\'eau existant ?', widget.formData['pointEauExistant']), // 'pointEauExistant'
      _buildSummaryItem('De sources d\'énergie ?', widget.formData['sourcesEnergie']), // 'sourcesEnergie'
      _buildSummaryItem('Des latrines (W.C) ?', widget.formData['latrines']), // 'latrines'
      _buildSummaryItem('Une cour de récréation ?', widget.formData['courRecreation']), // 'courRecreation'
      _buildSummaryItem('Un terrain de jeux ?', widget.formData['terrainJeux']), // 'terrainJeux'
      _buildSummaryItem('Une clôture ?', widget.formData['cloture']), // 'cloture'
      _buildSummaryItem('Est-il pris en charge par le Programme de réfugiés ?', widget.formData['programmeRefugies']), // 'programmeRefugies'
      _buildSummaryItem('Votre établissement a-t-il développé un projet d\'établissement ?', widget.formData['projetEtablissement']), // 'projetEtablissement'
      _buildSummaryItem('Prévisions budgétaires ?', widget.formData['previsionsBudgetaires']), // 'previsionsBudgetaires'
      _buildSummaryItem('Plan d\'action opérationnel ?', widget.formData['planActionOperational']), // 'planActionOperational'
      _buildSummaryItem('Tableau élaboré ?', widget.formData['tableauElabore']), // 'tableauElabore'
      _buildSummaryItem('Revue Annuelle de Performance (RAP) ?', widget.formData['revueAnnuelle']), // 'revueAnnuelle'
      _buildSummaryItem('Nombre d\'éducateurs formés (12 derniers mois)', widget.formData['nombreEducateursFormation']), // 'nombreEducateursFormation'
      _buildSummaryItem('Nombre d\'éducateurs bien cotés (E, TB, B)', widget.formData['nombreEducateursCotes']), // 'nombreEducateursCotes'
      _buildSummaryItem('Nombre d\'éducateurs inspectés (C3)', widget.formData['nombreEducateursInspection']), // 'nombreEducateursInspection'
      _buildSummaryItem('Formation continue du Chef d\'établissement ?', widget.formData['formationContinue']), // 'formationContinue'
      _buildSummaryItem('Chef d\'établissement coté positivement ?', widget.formData['chefCotePositivement']), // 'chefCotePositivement'

      // Ajout des champs de CapacityStep
      _buildSummaryItem('Lecture / Français - 1ère année', widget.formData['lectureFr1']), // 'lectureFr1'
      _buildSummaryItem('Lecture / Français - 2ème année', widget.formData['lectureFr2']), // 'lectureFr2'
      _buildSummaryItem('Lecture / Français - 3ème année', widget.formData['lectureFr3']), // 'lectureFr3'
      _buildSummaryItem('Lecture / Français - Total', widget.formData['lectureFrTotal']), // 'lectureFrTotal'
      _buildSummaryItem('Compte - 1ère année', widget.formData['compte1']), // 'compte1'
      _buildSummaryItem('Compte - 2ème année', widget.formData['compte2']), // 'compte2'
      _buildSummaryItem('Compte - 3ème année', widget.formData['compte3']), // 'compte3'
      _buildSummaryItem('Compte - Total', widget.formData['compteTotal']), // 'compteTotal'
      _buildSummaryItem('Éducation au milieu - 1ère année', widget.formData['milieu1']), // 'milieu1'
      _buildSummaryItem('Éducation au milieu - 2ème année', widget.formData['milieu2']), // 'milieu2'
      _buildSummaryItem('Éducation au milieu - 3ème année', widget.formData['milieu3']), // 'milieu3'
      _buildSummaryItem('Éducation au milieu - Total', widget.formData['milieuTotal']), // 'milieuTotal'
      _buildSummaryItem('Manuels pour les matières transversales - 1ère année', widget.formData['transversales1']), // 'transversales1'
      _buildSummaryItem('Manuels pour les matières transversales - 2ème année', widget.formData['transversales2']), // 'transversales2'
      _buildSummaryItem('Manuels pour les matières transversales - 3ème année', widget.formData['transversales3']), // 'transversales3'
      _buildSummaryItem('Manuels pour les matières transversales - Total', widget.formData['transversalesTotal']), // 'transversalesTotal'
      _buildSummaryItem('Autres manuels (1ère année)', widget.formData['autres1']), // 'autres1'
      _buildSummaryItem('Autres manuels (2ème année)', widget.formData['autres2']), // 'autres2'
      _buildSummaryItem('Autres manuels (3ème année)', widget.formData['autres3']), // 'autres3'
      _buildSummaryItem('Autres manuels - Total', widget.formData['autresTotal']), // 'autresTotal'

      // Ajout des champs de ContactStep
      _buildSummaryItem('Adresse complète', widget.formData['adresse']), // 'adresse'
      _buildSummaryItem('Téléphone', widget.formData['telephone']), // 'telephone'
      _buildSummaryItem('Email', widget.formData['email']), // 'email'
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