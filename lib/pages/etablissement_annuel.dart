import 'package:epsp_sige/models/SchoolModel.dart';
import 'package:epsp_sige/pages/home/widgets/FormPage.dart';
import 'package:epsp_sige/pages/home/widgets/SchoolDetailPage.dart';
import 'package:epsp_sige/utils/Constantes.dart';
import 'package:epsp_sige/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EtablissementAnnuel extends StatelessWidget {
  final int idAnnee;
  final box = GetStorage();
  final Requete requete = Requete();

  EtablissementAnnuel(this.idAnnee, {Key? key}) : super(key: key);

  Future<List<SchoolModel>> _fetchSchools() async {
    final user = box.read("user") ?? {};
    final response = await requete.getE(
        "identifications/etablissement_annuel?sousProvedId=${user["sousProvedId"]}&anneeId=$idAnnee");

    if (response.isOk) {
      return (response.body as List).map((e) => SchoolModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste d\'Ecoles', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<SchoolModel>>(
        future: _fetchSchools(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          return SchoolListView(
            schools: snapshot.data ?? [],
            annee: idAnnee,
          );
        },
      ),
    );
  }
}

class SchoolListView extends StatefulWidget {
  final List<SchoolModel> schools;
  final int annee;

  const SchoolListView({
    required this.schools,
    required this.annee,
    Key? key,
  }) : super(key: key);

  @override
  _SchoolListViewState createState() => _SchoolListViewState();
}

class _SchoolListViewState extends State<SchoolListView> {
  final TextEditingController _searchController = TextEditingController();
  final int _itemsPerPage = 10;
  int _currentPage = 1;
  late List<SchoolModel> _filteredSchools;

  @override
  void initState() {
    super.initState();
    _filteredSchools = widget.schools;
    _searchController.addListener(_filterSchools);
  }

  void _filterSchools() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSchools = widget.schools.where((school) =>
      school.nom.toLowerCase().contains(query) ||
          (school.province?.toLowerCase().contains(query) ?? false)).toList();
      _currentPage = 1;
    });
  }

  List<SchoolModel> get _currentPageItems {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    if (startIndex >= _filteredSchools.length) return [];
    final endIndex = startIndex + _itemsPerPage;
    return _filteredSchools.sublist(
      startIndex,
      endIndex > _filteredSchools.length ? _filteredSchools.length : endIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(child: _buildSchoolList()),
        if (_filteredSchools.length > _itemsPerPage) _buildPagination(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Rechercher une école...',
          prefixIcon: const Icon(Icons.search, color: Colors.blue),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        ),
      ),
    );
  }

  Widget _buildSchoolList() {
    if (_filteredSchools.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_outlined, size: 60, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              _searchController.text.isEmpty
                  ? 'Aucune école disponible'
                  : 'Aucun résultat trouvé',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _currentPageItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final school = _currentPageItems[index];
        return _buildSchoolCard(school);
      },
    );
  }

  Widget _buildSchoolCard(SchoolModel school) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Constantes.nomEtab = school.nom;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormListPage(
                widget.annee,
                school.nom,
                school: school,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.school, color: Colors.blue[700]),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      school.nom,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      school.adresse ?? '',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                onSelected: (value) => _handleMenuSelection(value, school, context),
                itemBuilder: (BuildContext context) {
                  return {'Détails', 'Modifier'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuSelection(String value, SchoolModel school, BuildContext context) {
    switch (value) {
      case 'Détails':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SchoolDetailPage(school: school),
          ),
        );
        break;
      case 'Modifier':
        _showEditSchoolDialog(school);
        break;
    }
  }

  void _showEditSchoolDialog(SchoolModel school) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier l\'école'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Nom de l\'école',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: school.nom),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Adresse',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: school.adresse),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                // Logique de modification ici
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('École modifiée avec succès')),
                );
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(SchoolModel school, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: Text('Êtes-vous sûr de vouloir supprimer ${school.nom} ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Logique de suppression ici
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${school.nom} a été supprimée'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPagination() {
    final totalPages = (_filteredSchools.length / _itemsPerPage).ceil();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0).add(const EdgeInsets.only(bottom: 24.0)),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: _currentPage > 1
                        ? () => setState(() => _currentPage--)
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: List.generate(totalPages, (index) {
                      final page = index + 1;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: InkWell(
                          onTap: () => setState(() => _currentPage = page),
                          child: Container(
                            width: 36,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _currentPage == page
                                  ? Colors.blue
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                              border: _currentPage == page
                                  ? null
                                  : Border.all(color: Colors.grey[300]!),
                            ),
                            child: Text(
                              '$page',
                              style: TextStyle(
                                color: _currentPage == page
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: _currentPage < totalPages
                        ? () => setState(() => _currentPage++)
                        : null,
                  ),
                ],
              ),
            ),
          ),
          if (totalPages > 10)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Page $_currentPage sur $totalPages',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}