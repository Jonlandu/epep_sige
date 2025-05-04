import 'package:flutter/material.dart';

class Step1ST3 extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;

  const Step1ST3({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _Step1ST3State createState() => _Step1ST3State();
}

class _Step1ST3State extends State<Step1ST3> {
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
            _buildHeader("Administration et Environnement Scolaire"),

            // Section 1: Participation féminine
            _buildSection(
              title: "Participation Féminine",
              children: [
                _buildTwoColumnInput(
                  label1: "Nombre de femmes dans le COPA",
                  key1: "st2_nombre_femmes_copa",
                  label2: "Nombre de femmes dans le COGES",
                  key2: "st2_nombre_femmes_coges",
                ),
                const SizedBox(height: 10),
                _buildTwoColumnInput(
                  label1: "Femmes enseignantes recrutées",
                  key1: "st2_femmes_enseignantes_recrutees",
                  label2: "Enseignants formés pédagogie genre",
                  key2: "st2_enseignants_formes_genre",
                ),
              ],
            ),

            // Section 2: Infrastructure et activités
            _buildSection(
              title: "Infrastructure et Activités",
              children: [
                _buildBooleanSwitch("D'un internat?", "st2_internat"),
                _buildBooleanSwitch("Activités parascolaires organisées?",
                    "st2_activites_parascolaires"),
                _buildBooleanSwitch("Unité Pédagogique opérationnelle?",
                    "st2_unite_pedagogique"),
                _buildBooleanSwitch("Gouvernement d'Elèves opérationnel?",
                    "st2_gouvernement_eleves"),
              ],
            ),

            // Section 3: Documentation
            _buildSection(
              title: "Documentation",
              children: [
                _buildBooleanSwitch(
                    "Manuel de procédure disponible?", "st2_manuel_procedure"),
                _buildBooleanSwitch("Plan de communication disponible?",
                    "st2_plan_communication"),
                _buildTextArea("PV de réunions", "st2_pv_reunions"),
              ],
            ),

            // Section 4: Réseaux et environnement
            _buildSection(
              title: "Réseaux et Environnement",
              children: [
                _buildBooleanSwitch(
                    "Participation aux forums REP?", "st2_participation_rep"),
                _buildBooleanSwitch(
                    "RLD opérationnel?", "st2_reseaux_locaux_directeurs"),
                _buildBooleanSwitch(
                    "Chef participe au RLD?", "st2_chef_participe_rld"),
                _buildBooleanSwitch("Dispose d'arbres?", "st2_dispose_arbres"),
                _buildNumberFormField(
                  label: "Nombre d'arbres plantés",
                  key: "st2_nombre_arbres_plantés",
                ),
                _buildBooleanSwitch(
                    "Coins de déchets disponibles?", "st2_coins_dechets"),
              ],
            ),

            // Section 5: Formation
            _buildSection(
              title: "Formation",
              children: [
                _buildNumberFormField(
                  label: "Enseignants formés premiers soins",
                  key: "st2_enseignants_formes_premiers_soins",
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

  Widget _buildTwoColumnInput({
    required String label1,
    required String key1,
    required String label2,
    required String key2,
  }) {
    return Row(
      children: [
        Expanded(
          child: _buildNumberFormField(label: label1, key: key1),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildNumberFormField(label: label2, key: key2),
        ),
      ],
    );
  }

  Widget _buildNumberFormField({
    required String label,
    required String key,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
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
      ),
    );
  }

  Widget _buildBooleanSwitch(String label, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Switch(
            value: widget.formData[key] ?? false,
            onChanged: (value) {
              setState(() {
                widget.formData[key] = value;
              });
            },
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildTextArea(String label, String key) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          alignLabelWithHint: true,
        ),
        maxLines: 3,
        initialValue: widget.formData[key]?.toString() ?? '',
        onChanged: (value) {
          widget.formData[key] = value;
        },
      ),
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
