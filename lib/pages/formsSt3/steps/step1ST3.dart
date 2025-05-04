import 'package:flutter/material.dart';

class step1ST3 extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  PageController controller = PageController();

  step1ST3({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _Stap1State createState() => _Stap1State();
}

class _Stap1State extends State<step1ST3> {
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
            _buildHeader("Identification de l'Établissement"),

            // Section 1: Informations Générales
            _buildSection(
              title: "Informations Générales",
              children: [
                _buildTextFormField(
                  label: "Nom de l'établissement",
                  key: "nom_etablissement",
                ),
                _buildTextFormField(
                  label: "Adresse de l'établissement",
                  key: "adresse_etablissement",
                ),
                _buildTextFormField(
                  label: "Téléphone de l'établissement",
                  key: "telephone_etablissement",
                  keyboardType: TextInputType.phone,
                ),
                _buildNumberFormField(
                  label: "Année",
                  key: "annee",
                ),
              ],
            ),

            // Section 2: Localisation Administrative
            _buildSection(
              title: "Localisation Administrative",
              children: [
                _buildTextFormField(
                  label: "Province",
                  key: "province",
                ),
                _buildTextFormField(
                  label: "Ville",
                  key: "ville",
                ),
                _buildTextFormField(
                  label: "Territoire ou commune",
                  key: "territoire_commune",
                ),
                _buildTextFormField(
                  label: "Village",
                  key: "village",
                ),
                _buildTextFormField(
                  label: "Province éducationnelle",
                  key: "province_educationnelle",
                ),
                _buildTextFormField(
                  label: "Code Adm Ets",
                  key: "code_adm_ets",
                ),
                _buildTextFormField(
                  label: "Code Adm. Ets (auto)",
                  key: "code_adm_ets_auto",
                ),
                _buildRadioGroup(
                  label: "Régime de gestion",
                  key: "regime_gestion",
                  options: [
                    "Non conventionné (ENC)",
                    "Catholique",
                    "Protestant",
                    "Kimbaguiste (ECK)",
                    "Islamique (ECI)",
                    "Salutiste (ECS)",
                    "Fraternité(ECF)",
                    "Privée (EPR)",
                    "Autres",
                  ],
                ),
              ],
            ),

            // Section 3: Localisation Scolaire
            _buildSection(
              title: "Localisation Scolaire",
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildNumberFormField(
                        label: "Latitude",
                        key: "latitude",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildNumberFormField(
                        label: "Longitude",
                        key: "longitude",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildNumberFormField(
                        label: "Altitude",
                        key: "altitude",
                      ),
                    ),
                  ],
                ),
                _buildYesNoRadio(
                  label: "Centre de regroupement",
                  key: "centre_regroupement",
                ),
                _buildRadioGroup(
                  label: "Milieu",
                  key: "milieu",
                  options: ["Rural", "Urban"],
                ),
              ],
            ),

            // Section 4: Référence Juridique
            _buildSection(
              title: "Référence Juridique",
              children: [
                _buildTextFormField(
                  label:
                      "Référence Juridique (Arrêté d'agrément/d'autorisation)",
                  key: "reference_juridique",
                ),
                _buildTextFormField(
                  label: "N° Matricule SECOPE",
                  key: "matricule_secope",
                ),
                _buildRadioGroup(
                  label: "L'établissement est",
                  key: "etat_etablissement",
                  options: ["Mécanisé et payé", "Mécanisé et non payé"],
                ),
                _buildRadioGroup(
                  label: "Statut d'occupation parcellaire",
                  key: "statut_occupation",
                  options: ["Propriétaire", "Co-propriétaire"],
                ),
              ],
            ),

            // Section 5: Informations sur l'Établissement
            _buildSection(
              title: "Informations sur l'Établissement",
              children: _buildSchoolInfoChildren(),
            ),

            // Section 6: Personnel Éducatif
            _buildSection(
              title: "Personnel Éducatif",
              children: [
                _buildNumberFormField(
                  label: "Nombre d'éducateurs formés (12 derniers mois)",
                  key: "educateurs_formes",
                ),
                _buildNumberFormField(
                  label: "Nombre d'éducateurs cotés positivement (E, TB, B)",
                  key: "educateurs_cotes_positifs",
                ),
                _buildNumberFormField(
                  label: "Nombre d'éducateurs inspectés pédagogique C3",
                  key: "educateurs_inspectes",
                ),
                _buildYesNoRadio(
                  label:
                      "Le Chef d'Etablissement a-t-il reçu une formation continue ?",
                  key: "chef_formation",
                ),
                _buildYesNoRadio(
                  label:
                      "Le Chef d'Etablissement a-t-il été coté Positivement ?",
                  key: "chef_cote_positif",
                ),
              ],
            ),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //
                    //widget.formData[''] = "";
                    widget.controller.nextPage(
                      //scrollOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOutQuint,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Suivant',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSchoolInfoChildren() {
    return [
      _buildYesNoRadio(
        label: "Des programmes officiels des cours ?",
        key: "programmes_officiels",
      ),
      _buildYesNoRadio(
        label: "D'un COPA ?",
        key: "copa",
      ),
      if (widget.formData['copa'] == 'Oui') ...[
        _buildYesNoRadio(
          label: "COPA opérationnel ?",
          key: "copa_operationnel",
        ),
        if (widget.formData['copa_operationnel'] == 'Oui')
          _buildNumberFormField(
            label: "Nombre de réunions avec PV (année passée)",
            key: "reunions_pv",
          ),
      ],
      _buildYesNoRadio(
        label: "D'un COGES ?",
        key: "coges",
      ),
      if (widget.formData['coges'] == 'Oui') ...[
        _buildYesNoRadio(
          label: "COGES opérationnel ?",
          key: "coges_operationnel",
        ),
        if (widget.formData['coges_operationnel'] == 'Oui')
          _buildNumberFormField(
            label: "Réunions avec rapport de gestion (année précédente)",
            key: "reunions_rapport",
          ),
      ],
      _buildYesNoRadio(
        label: "Locaux utilisés par un 2nd établissement ?",
        key: "locaux_utilises",
      ),
      if (widget.formData['locaux_utilises'] == 'Oui')
        _buildTextFormField(
          label: "Nom du 2nd établissement",
          key: "nom_second_etablissement",
        ),
      _buildYesNoRadio(
        label: "D'un point d'eau ?",
        key: "point_eau",
      ),
      if (widget.formData['point_eau'] == 'Oui')
        _buildRadioGroup(
          label: "Type de point d'eau",
          key: "type_point_eau",
          options: ["Robinet", "Forage/puits", "Sources"],
        ),
      _buildYesNoRadio(
        label: "De sources d'énergie ?",
        key: "sources_energie",
      ),
      if (widget.formData['sources_energie'] == 'Oui')
        _buildRadioGroup(
          label: "Type de sources d'énergie",
          key: "type_sources_energie",
          options: ["Electrique", "Solaire", "Groupe électrogène"],
        ),
      _buildYesNoRadio(
        label: "Des latrines (W.C) ?",
        key: "latrines",
      ),
      if (widget.formData['latrines'] == 'Oui') ...[
        _buildNumberFormField(
          label: "Nombre de compartiments",
          key: "nombre_compartiments",
        ),
        _buildNumberFormField(
          label: "Dont pour les filles",
          key: "compartiments_filles",
        ),
      ],
      _buildYesNoRadio(
        label: "Une cour de récréation ?",
        key: "cour_recreation",
      ),
      _buildYesNoRadio(
        label: "Un terrain de jeux ?",
        key: "terrain_jeux",
      ),
      _buildYesNoRadio(
        label: "Une clôture ?",
        key: "cloture",
      ),
      if (widget.formData['cloture'] == 'Oui')
        _buildRadioGroup(
          label: "Nature de la clôture",
          key: "nature_cloture",
          options: ["En dur", "En semi dur", "En haie", "Autres"],
        ),
      _buildYesNoRadio(
        label: "Projet d'établissement avec parties prenantes ?",
        key: "projet_etablissement",
      ),
      if (widget.formData['projet_etablissement'] == 'Oui')
        _buildTextFormField(
          label: "Organisme du projet",
          key: "organisme_projet",
        ),
      _buildYesNoRadio(
        label: "Plan d'action opérationnel ?",
        key: "plan_action",
      ),
      _buildYesNoRadio(
        label: "Revue annuelle de Performance (RAP) organisée ?",
        key: "revue_performance",
      ),
    ];
  }

  Widget _buildHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const Divider(
          color: Colors.blueAccent,
          thickness: 1.5,
          height: 20,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String key,
    TextInputType? keyboardType,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          isDense: true,
        ),
        keyboardType: keyboardType,
        onChanged: (value) => widget.formData[key] = value,
        initialValue: widget.formData[key]?.toString(),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildNumberFormField({
    required String label,
    required String key,
  }) {
    return _buildTextFormField(
      label: label,
      key: key,
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildYesNoRadio({
    required String label,
    required String key,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              _buildCompactRadioOption(
                  key: key, value: "Oui", color: Colors.green),
              const SizedBox(width: 16),
              _buildCompactRadioOption(
                  key: key, value: "Non", color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioGroup({
    required String label,
    required String key,
    required List<String> options,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              return _buildCompactRadioOption(
                key: key,
                value: option,
                color: Colors.blue,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactRadioOption({
    required String key,
    required String value,
    required Color color,
  }) {
    final isSelected = widget.formData[key] == value;

    return GestureDetector(
      onTap: () => setState(() => widget.formData[key] = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Radio<String>(
                value: value,
                groupValue: widget.formData[key],
                onChanged: (String? newValue) {
                  setState(() => widget.formData[key] = newValue);
                },
                activeColor: color,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? color : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
