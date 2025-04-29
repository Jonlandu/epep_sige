import 'package:flutter/material.dart';

class Step4 extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;

  const Step4({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _Step5State createState() => _Step5State();
}

class _Step5State extends State<Step4> {
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
            _buildHeader("Éducation à la Santé et Environnement"),

            // Section: Enseignement du VIH/Sida
            _buildSection(
              title: "3.1. Enseignement du VIH/Sida",
              children: [
                _buildBooleanField(
                  label: "VIH/Sida enseigné ?",
                  key: "vih_sida_enseigne",
                ),
                if (widget.formData["vih_sida_enseigne"] == true) ...[
                  const SizedBox(height: 10),
                  _buildSubOptions(
                    mainKey: "vih_sida_enseigne",
                    options: [
                      _buildBooleanField(
                        label: "Dans le programme officiel ?",
                        key: "vih_sida_programme",
                        isSubOption: true,
                      ),
                      _buildBooleanField(
                        label: "En tant que discipline à part ?",
                        key: "vih_sida_discipline",
                        isSubOption: true,
                      ),
                      _buildBooleanField(
                        label: "Lors des activités parascolaires ?",
                        key: "vih_sida_active_parascolaire",
                        isSubOption: true,
                      ),
                    ],
                  ),
                ],
              ],
            ),

            // Section: Santé reproductive
            _buildSection(
              title: "3.1. Enseignement de la santé sexuelle et reproductive",
              children: [
                _buildBooleanField(
                  label: "Santé sexuelle et reproductive enseignée ?",
                  key: "sante_reproductive_enseigne",
                ),
                if (widget.formData["sante_reproductive_enseigne"] == true) ...[
                  const SizedBox(height: 10),
                  _buildSubOptions(
                    mainKey: "sante_reproductive_enseigne",
                    options: [
                      _buildBooleanField(
                        label: "Dans le programme officiel ?",
                        key: "sante_reproductive_programme",
                        isSubOption: true,
                      ),
                      _buildBooleanField(
                        label: "En tant que discipline à part ?",
                        key: "sante_reproductive_discipline",
                        isSubOption: true,
                      ),
                      _buildBooleanField(
                        label: "Lors des activités parascolaires ?",
                        key: "sante_reproductive_parascolaire",
                        isSubOption: true,
                      ),
                    ],
                  ),
                ],
              ],
            ),

            // Section: Sensibilisation contre les abus
            _buildSection(
              title: "3.1. Sensibilisation contre les abus",
              children: [
                _buildBooleanField(
                  label: "Sensibilisation contre les abus enseignée ?",
                  key: "sensibilisation_abus_enseigne",
                ),
                if (widget.formData["sensibilisation_abus_enseigne"] ==
                    true) ...[
                  const SizedBox(height: 10),
                  _buildSubOptions(
                    mainKey: "sensibilisation_abus_enseigne",
                    options: [
                      _buildBooleanField(
                        label: "Dans le programme officiel ?",
                        key: "sensibilisation_abus_programme",
                        isSubOption: true,
                      ),
                      _buildBooleanField(
                        label: "En tant que discipline à part ?",
                        key: "sensibilisation_abus_discipline",
                        isSubOption: true,
                      ),
                      _buildBooleanField(
                        label: "Lors des activités parascolaires ?",
                        key: "sensibilisation_abus_parascolaire",
                        isSubOption: true,
                      ),
                    ],
                  ),
                ],
              ],
            ),

            // Section: Éducation environnementale
            _buildSection(
              title: "3.1. Éducation environnementale",
              children: [
                _buildBooleanField(
                  label: "Éducation environnementale enseignée ?",
                  key: "education_environnementale_enseigne",
                ),
                if (widget.formData["education_environnementale_enseigne"] ==
                    true) ...[
                  const SizedBox(height: 10),
                  _buildSubOptions(
                    mainKey: "education_environnementale_enseigne",
                    options: [
                      _buildBooleanField(
                        label: "Dans le programme officiel ?",
                        key: "education_environnementale_programme",
                        isSubOption: true,
                      ),
                      _buildBooleanField(
                        label: "En tant que discipline à part ?",
                        key: "education_environnementale_discipline",
                        isSubOption: true,
                      ),
                      _buildBooleanField(
                        label: "Lors des activités parascolaires ?",
                        key: "education_environnementale_parascolaire",
                        isSubOption: true,
                      ),
                    ],
                  ),
                ],
              ],
            ),

            // Section: Règlements
            _buildSection(
              title: "3.2. Règlements en vigueur",
              children: [
                _buildBooleanField(
                  label: "Règlements relatifs à la sécurité physique",
                  key: "reglement_securite_physique",
                ),
                _buildBooleanField(
                  label:
                      "Règlements relatifs à la stigmatisation et discrimination",
                  key: "reglement_discrimination",
                ),
                _buildBooleanField(
                  label: "Règlements relatifs aux harcèlements et abus sexuels",
                  key: "reglement_harcelement",
                ),
              ],
            ),

            // Section: Cellule d'orientation
            _buildSection(
              title: "3.3-3.4. Cellule d'orientation et formation",
              children: [
                _buildBooleanField(
                  label: "Cellule d'orientation avec EVF ?",
                  key: "cellule_orientation_evf",
                ),
                _buildBooleanField(
                  label: "Enseignants formés sur EVF ?",
                  key: "enseignants_evf_formes",
                ),
              ],
            ),

            // Section: Statistiques enseignants formés
            _buildSection(
              title: "3.6. Statistiques des enseignants formés",
              children: [
                _buildNumberField(
                  label: "Nombre total d'enseignants formés",
                  key: "nb_enseignants_evf",
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildNumberField(
                        label: "Hommes formés",
                        key: "nb_enseignants_forme_h",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildNumberField(
                        label: "Femmes formées",
                        key: "nb_enseignants_forme_f",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildNumberField(
                        label: "Hommes dispensant EVF",
                        key: "nb_enseignants_evf_dispense_h",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildNumberField(
                        label: "Femmes dispensant EVF",
                        key: "nb_enseignants_evf_dispense_f",
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Navigation buttons
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

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

  Widget _buildBooleanField({
    required String label,
    required String key,
    bool isSubOption = false,
  }) {
    return CheckboxListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: isSubOption ? 14 : 16,
          color: isSubOption ? Colors.grey[700] : Colors.black,
        ),
      ),
      value: widget.formData[key] ?? false,
      onChanged: (bool? value) {
        setState(() {
          widget.formData[key] = value ?? false;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.only(left: isSubOption ? 40.0 : 0),
    );
  }

  Widget _buildSubOptions({
    required String mainKey,
    required List<Widget> options,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.blueGrey.shade200, width: 2),
        ),
      ),
      child: Column(children: options),
    );
  }

  Widget _buildNumberField({
    required String label,
    required String key,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('Précédent'),
        ),
        ElevatedButton(
          onPressed: () => widget.controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('Suivant'),
        ),
      ],
    );
  }
}
