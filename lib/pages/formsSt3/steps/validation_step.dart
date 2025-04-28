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
      // ==============================================
      // CHAMPS DU STEP 1 (SchoolInformationForm)
      // ==============================================

      // Section: Informations Générales
      _buildSummaryItem('Nom de l\'établissement', widget.formData['nom_etablissement']),
      _buildSummaryItem('Adresse', widget.formData['adresse_etablissement']),
      _buildSummaryItem('Téléphone', widget.formData['telephone_etablissement']),
      _buildSummaryItem('Année', widget.formData['annee']),

      // Section: Localisation Administrative
      _buildSummaryItem('Province', widget.formData['province']),
      _buildSummaryItem('Ville', widget.formData['ville']),
      _buildSummaryItem('Territoire/Commune', widget.formData['territoire_commune']),
      _buildSummaryItem('Village', widget.formData['village']),
      _buildSummaryItem('Province éducationnelle', widget.formData['province_educationnelle']),
      _buildSummaryItem('Code Adm Ets', widget.formData['code_adm_ets']),
      _buildSummaryItem('Code Adm Ets (auto)', widget.formData['code_adm_ets_auto']),
      _buildSummaryItem('Régime de gestion', widget.formData['regime_gestion']),

      // Section: Localisation Scolaire
      _buildSummaryItem('Latitude', widget.formData['latitude']),
      _buildSummaryItem('Longitude', widget.formData['longitude']),
      _buildSummaryItem('Altitude', widget.formData['altitude']),
      _buildSummaryItem('Centre de regroupement', widget.formData['centre_regroupement']),
      _buildSummaryItem('Milieu', widget.formData['milieu']),

      // Section: Référence Juridique
      _buildSummaryItem('Référence juridique', widget.formData['reference_juridique']),
      _buildSummaryItem('Matricule SECOPE', widget.formData['matricule_secope']),
      _buildSummaryItem('État établissement', widget.formData['etat_etablissement']),
      _buildSummaryItem('Statut occupation', widget.formData['statut_occupation']),

      // Section: Informations Établissement
      _buildSummaryItem('Programmes officiels', widget.formData['programmes_officiels']),
      _buildSummaryItem('COPA', widget.formData['copa']),
      if (widget.formData['copa'] == 'Oui') ...[
        _buildSummaryItem('COPA opérationnel', widget.formData['copa_operationnel']),
        _buildSummaryItem('Réunions avec PV', widget.formData['reunions_pv']),
      ],
      _buildSummaryItem('COGES', widget.formData['coges']),
      if (widget.formData['coges'] == 'Oui') ...[
        _buildSummaryItem('COGES opérationnel', widget.formData['coges_operationnel']),
        _buildSummaryItem('Réunions rapport gestion', widget.formData['reunions_rapport']),
      ],
      _buildSummaryItem('Locaux utilisés par 2nd établissement', widget.formData['locaux_utilises']),
      if (widget.formData['locaux_utilises'] == 'Oui') ...[
        _buildSummaryItem('Nom 2nd établissement', widget.formData['nom_second_etablissement']),
      ],
      _buildSummaryItem('Point d\'eau', widget.formData['point_eau']),
      if (widget.formData['point_eau'] == 'Oui') ...[
        _buildSummaryItem('Type point d\'eau', widget.formData['type_point_eau']),
      ],
      _buildSummaryItem('Sources d\'énergie', widget.formData['sources_energie']),
      if (widget.formData['sources_energie'] == 'Oui') ...[
        _buildSummaryItem('Type sources énergie', widget.formData['type_sources_energie']),
      ],
      _buildSummaryItem('Latrines', widget.formData['latrines']),
      if (widget.formData['latrines'] == 'Oui') ...[
        _buildSummaryItem('Nombre compartiments', widget.formData['nombre_compartiments']),
        _buildSummaryItem('Compartiments filles', widget.formData['compartiments_filles']),
      ],
      _buildSummaryItem('Cour de récréation', widget.formData['cour_recreation']),
      _buildSummaryItem('Terrain de jeux', widget.formData['terrain_jeux']),
      _buildSummaryItem('Clôture', widget.formData['cloture']),
      if (widget.formData['cloture'] == 'Oui') ...[
        _buildSummaryItem('Nature clôture', widget.formData['nature_cloture']),
      ],
      _buildSummaryItem('Projet d\'établissement', widget.formData['projet_etablissement']),
      if (widget.formData['projet_etablissement'] == 'Oui') ...[
        _buildSummaryItem('Organisme projet', widget.formData['organisme_projet']),
      ],
      _buildSummaryItem('Plan d\'action', widget.formData['plan_action']),
      _buildSummaryItem('Revue performance', widget.formData['revue_performance']),

      // Section: Personnel Éducatif
      _buildSummaryItem('Éducateurs formés', widget.formData['educateurs_formes']),
      _buildSummaryItem('Éducateurs cotés positifs', widget.formData['educateurs_cotes_positifs']),
      _buildSummaryItem('Éducateurs inspectés', widget.formData['educateurs_inspectes']),
      _buildSummaryItem('Chef formation continue', widget.formData['chef_formation']),
      _buildSummaryItem('Chef coté positivement', widget.formData['chef_cote_positif']),

      // ==============================================
      // CHAMPS DES AUTRES STEPS (existant dans votre code original)
      // ==============================================
      _buildSummaryItem('Province', widget.formData['province']),
      _buildSummaryItem('Proved', widget.formData['proved']),
      _buildSummaryItem('Sous-Proved', widget.formData['sousProved']),
      _buildSummaryItem('Centre de regroupement', widget.formData['centreRegroupement']),
      _buildSummaryItem('Nom établissement', widget.formData['nomEtablissement']),
      _buildSummaryItem('Chef établissement', widget.formData['nomChefEtablissement']),
      _buildSummaryItem('Type', widget.formData['typeEtablissement']),
      _buildSummaryItem('Niveaux', widget.formData['niveauxEnseignement']?.join(',') ?? ''),
      _buildSummaryItem('Capacité', widget.formData['capaciteAccueil']),
      _buildSummaryItem('Nombre d\'élèves', widget.formData['nombreEleves']),
      _buildSummaryItem('Nombre d\'enseignants', widget.formData['nombreEnseignants']),
      _buildSummaryItem('Adresse', widget.formData['adresse']),
      _buildSummaryItem('Téléphone', widget.formData['telephone']),
      _buildSummaryItem('Email', widget.formData['email']),
      _buildSummaryItem('Année de création', widget.formData['anneeCreation']),
      _buildSummaryItem('Infrastructures', widget.formData['infrastructures']?.join(',') ?? ''),

      // Champs du formulaire 1 (LocationStep)
      _buildSummaryItem('Programmes officiels des cours', widget.formData['programmesOfficiels']),
      _buildSummaryItem('COPA', widget.formData['copa']),
      if (widget.formData['copa'] == 'Oui') ...[
        _buildSummaryItem('COPA opérationnel', widget.formData['copaOperationnel']),
        _buildSummaryItem('Réunions avec PV', widget.formData['reunionsPV']),
        _buildSummaryItem('Femmes dans COPA', widget.formData['femmesCOPA']),
      ],
      _buildSummaryItem('COGES', widget.formData['coges']),
      if (widget.formData['coges'] == 'Oui') ...[
        _buildSummaryItem('COGES opérationnel', widget.formData['cogesOperationnel']),
        _buildSummaryItem('Réunions rapport gestion', widget.formData['reunionsRapportGestion']),
        _buildSummaryItem('Femmes dans COGES', widget.formData['femmesCOGES']),
      ],
      _buildSummaryItem('Locaux utilisés par 2ème établissement', widget.formData['locauxUtilises']),
      if (widget.formData['locauxUtilises'] == 'Oui') ...[
        _buildSummaryItem('Nom 2ème établissement', widget.formData['nomSecondEtablissement']),
      ],
      _buildSummaryItem('Point d\'eau', widget.formData['pointEau']),
      if (widget.formData['pointEau'] == 'Oui') ...[
        _buildSummaryItem('Type point d\'eau', _formatMap(widget.formData['typePointEau'])),
      ],
      _buildSummaryItem('Sources d\'énergie', widget.formData['sourcesEnergie']),
      if (widget.formData['sourcesEnergie'] == 'Oui') ...[
        _buildSummaryItem('Type énergie', _formatMap(widget.formData['typeEnergie'])),
      ],
      _buildSummaryItem('Latrines', widget.formData['latrines']),
      if (widget.formData['latrines'] == 'Oui') ...[
        _buildSummaryItem('Compartiments latrines', widget.formData['compartimentsLatrines']),
        _buildSummaryItem('Latrines pour filles', widget.formData['latrinesFilles']),
      ],
      _buildSummaryItem('Cour de récréation', widget.formData['courRecreation']),
      _buildSummaryItem('Terrain de sport', widget.formData['terrainSport']),

      // Champs du formulaire 2 (InfrastructureStep)
      _buildSummaryItem('Femmes dans COGES (form2)', widget.formData['femmesCoges']),
      _buildSummaryItem('Locaux utilisés par 2ème établissement (form2)', widget.formData['secondEtablissement']),
      if (widget.formData['secondEtablissement'] == 'Oui') ...[
        _buildSummaryItem('Nom 2ème établissement (form2)', widget.formData['nomSecondEtablissement']),
      ],
      _buildSummaryItem('Point d\'eau (form2)', widget.formData['pointEau']),
      if (widget.formData['pointEau'] == 'Oui') ...[
        _buildSummaryItem('Robinet', widget.formData['pointEauRobinet']?.toString() ?? 'Non'),
        _buildSummaryItem('Forage/puits', widget.formData['pointEauForagePuits']?.toString() ?? 'Non'),
        _buildSummaryItem('Sources', widget.formData['pointEauSources']?.toString() ?? 'Non'),
      ],
      _buildSummaryItem('Sources d\'énergie (form2)', widget.formData['sourceEnergie']),
      if (widget.formData['sourceEnergie'] == 'Oui') ...[
        _buildSummaryItem('Énergie électrique', widget.formData['sourceEnergieElectrique']?.toString() ?? 'Non'),
        _buildSummaryItem('Énergie solaire', widget.formData['sourceEnergieSolaire']?.toString() ?? 'Non'),
        _buildSummaryItem('Générateur', widget.formData['sourceEnergieGenerateur']?.toString() ?? 'Non'),
      ],
      _buildSummaryItem('Latrines (form2)', widget.formData['latrines']),
      if (widget.formData['latrines'] == 'Oui') ...[
        _buildSummaryItem('Nombre compartiments latrines', widget.formData['nombreCompartiments']),
        _buildSummaryItem('Latrines pour filles (form2)', widget.formData['latrinesFilles']),
      ],
      _buildSummaryItem('Cour de récréation (form2)', widget.formData['courRecreation']),
      _buildSummaryItem('Terrain de sport (form2)', widget.formData['terrainSport']),
      _buildSummaryItem('Clôture', widget.formData['cloture']),
      if (widget.formData['cloture'] == 'Oui') ...[
        _buildSummaryItem('Clôture en dur', widget.formData['clotureEnDur']?.toString() ?? 'Non'),
        _buildSummaryItem('Clôture semi-dur', widget.formData['clotureSemiDur']?.toString() ?? 'Non'),
        _buildSummaryItem('Clôture haie', widget.formData['clotureHaie']?.toString() ?? 'Non'),
        _buildSummaryItem('Autres clôtures', widget.formData['clotureAutres']?.toString() ?? 'Non'),
      ],
      _buildSummaryItem('Internat', widget.formData['internat']),
      _buildSummaryItem('Pris en charge réfugié', widget.formData['prisEnChargeRefugie']),
      if (widget.formData['prisEnChargeRefugie'] == 'Oui') ...[
        _buildSummaryItem('Organisme pris en charge', widget.formData['organismePrisEnCharge']),
      ],
      _buildSummaryItem('Projet d\'établissement', widget.formData['projetEtablissement']),
      _buildSummaryItem('Documents budgétaires', widget.formData['documentsBudgetaires']),
      _buildSummaryItem('Plan d\'action opérationnel', widget.formData['planActionOperationnel']),
      _buildSummaryItem('Tableau de bord', widget.formData['tableauBord']),
      _buildSummaryItem('Revue annuelle performance', widget.formData['revueAnnuellePerformance']),

      // Champs du formulaire 3 (EducationStep)
      _buildSummaryItem('Enseignants formés (12 mois)', widget.formData['enseignantsFormation12mois']),
      _buildSummaryItem('Enseignants cotés positivement', widget.formData['enseignantsCotesPositivement']),
      _buildSummaryItem('Enseignants inspection C3', widget.formData['enseignantsInspectionC3']),
      _buildSummaryItem('Chef formation continue', widget.formData['chefFormationContinue']),
      _buildSummaryItem('Chef coté positivement', widget.formData['chefCotePositivement']),
      _buildSummaryItem('Activités parascolaires', widget.formData['activitesParascolaires']),
      _buildSummaryItem('Unité pédagogique', widget.formData['unitePedagogique']),
      _buildSummaryItem('Gouvernement d\'élèves', widget.formData['gouvernementEleves']),
      _buildSummaryItem('PV de réunions', widget.formData['pvReunions']),
      _buildSummaryItem('Manuel de procédure', widget.formData['manuelProcedure']),
      _buildSummaryItem('Plan de communication', widget.formData['planCommunication']),
      _buildSummaryItem('Participation REP', widget.formData['participationREP']),
      _buildSummaryItem('Réseau directeurs', widget.formData['reseauDirecteurs']),
      _buildSummaryItem('Participation RLD', widget.formData['participationRLD']),
      _buildSummaryItem('Arbres disponibles', widget.formData['arbresDisponibles']),
      if (widget.formData['arbresDisponibles'] == 'Oui') ...[
        _buildSummaryItem('Arbres plantés', widget.formData['arbresPlantes']),
      ],
      _buildSummaryItem('Enseignants premiers soins', widget.formData['enseignantsPremiersSoins']),
      _buildSummaryItem('Coins déchets', widget.formData['coinsDechets']),
      _buildSummaryItem('Femmes enseignantes recrutées', widget.formData['femmesEnseignantesRecrutees']),
      _buildSummaryItem('Enseignants formation genre', widget.formData['enseignantsFormationGenre']),

      // Tableau des violences
      _buildSummaryItem('Intimidation (G)', widget.formData['intimidationG']),
      _buildSummaryItem('Intimidation (F)', widget.formData['intimidationF']),
      _buildSummaryItem('Intimidation (G+F)', widget.formData['intimidationGF']),
      _buildSummaryItem('Châtiment corporel (G)', widget.formData['chatimentG']),
      _buildSummaryItem('Châtiment corporel (F)', widget.formData['chatimentF']),
      _buildSummaryItem('Châtiment corporel (G+F)', widget.formData['chatimentGF']),
      _buildSummaryItem('Harcèlement (G)', widget.formData['harcelementG']),
      _buildSummaryItem('Harcèlement (F)', widget.formData['harcelementF']),
      _buildSummaryItem('Harcèlement (G+F)', widget.formData['harcelementGF']),
      _buildSummaryItem('Discrimination (G)', widget.formData['discriminationG']),
      _buildSummaryItem('Discrimination (F)', widget.formData['discriminationF']),
      _buildSummaryItem('Discrimination (G+F)', widget.formData['discriminationGF']),
      _buildSummaryItem('Abus sexuels (G)', widget.formData['abusSexuelsG']),
      _buildSummaryItem('Abus sexuels (F)', widget.formData['abusSexuelsF']),
      _buildSummaryItem('Abus sexuels (G+F)', widget.formData['abusSexuelsGF']),
      _buildSummaryItem('Autres violences (G)', widget.formData['autresViolencesG']),
      _buildSummaryItem('Autres violences (F)', widget.formData['autresViolencesF']),
      _buildSummaryItem('Autres violences (G+F)', widget.formData['autresViolencesGF']),
    ];
  }

// Helper function to format map data
  String _formatMap(Map<dynamic, dynamic>? data) {
    if (data == null) return '';
    return data.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .join(', ');
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