import 'package:epsp_sige/pages/formsSt1/dynamic_multi_step_form.dart';
import 'package:epsp_sige/pages/formsSt1/saved_forms_screen.dart';
import 'package:epsp_sige/pages/formsSt2/dynamic_multi_step_formSt2.dart';
import 'package:epsp_sige/pages/formsSt3/dynamic_multi_step_formSt3.dart';
import 'package:epsp_sige/utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormListPage extends StatefulWidget {
  const FormListPage({Key? key}) : super(key: key);

  @override
  _FormListPageState createState() => _FormListPageState();
}

class _FormListPageState extends State<FormListPage> {
  String? _selectedYear;
  String _selectedSchool = "CS-BOBOTO";
  bool _isLoading = false;

  final List<String> _years = ['2022-2023', '2023-2024', '2024-2025'];
  final List<Map<String, dynamic>> _forms = [
    {
      'code': 'ST1',
      'title': 'Formulaire Statistique Initial',
      'status': 'En cours',
      'color': Colors.amber,
      'progress': 0.6,
      'lastUpdated': '15 mars 2023'
    },
    {
      'code': 'ST2',
      'title': 'Formulaire Évaluation Mi-parcours',
      'status': 'Complété',
      'color': Colors.green,
      'progress': 1.0,
      'lastUpdated': '2 juin 2023'
    },
    {
      'code': 'ST3',
      'title': 'Formulaire Bilan Final',
      'status': 'Non commencé',
      'color': Colors.redAccent,
      'progress': 0.0,
      'lastUpdated': 'Non soumis'
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // Simule chargement
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _isLoading
            ? _buildLoadingIndicator()
            : _buildContent(context),
        floatingActionButton: FloatingActionButton(
          onPressed: _showSchoolSelection,
          child: const Icon(Icons.school),
          backgroundColor: theme.primaryColor,
          elevation: 4,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('GESTION DES FORMULAIRES TPE', style: TextStyle(fontSize: 15),),
      centerTitle: true,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: _loadData,
          tooltip: 'Actualiser',
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: _showSettings,
          tooltip: 'Options',
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            'Chargement des données...',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSchoolInfo(),
          const SizedBox(height: 24),
          _buildYearSelector(),
          const SizedBox(height: 32),
          ..._forms.map((form) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildFormCard(context, form),
          )),
        ],
      ),
    );
  }

  Widget _buildSchoolInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Établissement sélectionné',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _selectedSchool,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(height: 32),
      ],
    );
  }

  Widget _buildYearSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Année scolaire',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedYear,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              hint: const Text('Sélectionnez une année'),
              items: _years.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedYear = newValue;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard(BuildContext context, Map<String, dynamic> form) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToFormDetail(form),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: form['color'].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      form['code'],
                      style: TextStyle(
                        color: form['color'],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Chip(
                    label: Text(
                      form['status'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: form['color'],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                form['title'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: form['progress'],
                backgroundColor: Colors.grey.shade200,
                color: form['color'],
                minHeight: 6,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dernière mise à jour: ${form['lastUpdated']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey.shade500,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToFormDetail(Map<String, dynamic> form) {
    debugPrint('Form code: ${form['code']}'); // Ajoutez cette ligne
    Widget formWidget;

    switch (form['code']) {
      case 'ST1':
        formWidget = DynamiqueMultiStepForm(); // Votre formulaire ST1
        //formWidget = SavedFormsScreen(); // Votre formulaire ST1
        break;
      case 'ST2':
        formWidget = DynamiqueMultiStepFormST2(); // Votre formulaire ST2
        break;
      case 'ST3':
        formWidget = DynamiqueMultiStepFormST3(); // Votre formulaire ST3
        break;
      default:
        formWidget = DynamiqueMultiStepForm(); // Par défaut
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(form['title']),
          ),
          body: formWidget,
        ),
      ),
    );
  }

  void _showSchoolSelection() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Changer d\'établissement'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) => ListTile(
              title: Text('École ${index + 1}'),
              onTap: () {
                setState(() => _selectedSchool = 'École ${index + 1}');
                Navigator.pop(context);
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.pop(context);
                // Naviguer vers la page des paramètres
              },
            ),
            ListTile(
              leading: const Icon(Icons.newspaper_outlined),
              title: const Text('Formulaire stockés en Local'),
              onTap: () {
                Navigator.pushNamed(context, Routes.SavedFormsScreenRoutes);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Aide'),
              onTap: () {
                Navigator.pop(context);
                // Naviguer vers la page À propos
              },
            ),
          ],
        ),
      ),
    );
  }
}
