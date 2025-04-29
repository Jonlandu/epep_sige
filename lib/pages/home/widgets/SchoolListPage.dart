import 'package:epsp_sige/models/SchoolModel.dart';
import 'package:epsp_sige/pages/home/widgets/FormPage.dart';
import 'package:epsp_sige/pages/home/widgets/SchoolDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SchoolListPage extends StatefulWidget {
  final List<dynamic> establishments;

  const SchoolListPage({Key? key, required this.establishments})
      : super(key: key);

  @override
  _SchoolListPageState createState() => _SchoolListPageState();
}

class _SchoolListPageState extends State<SchoolListPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  static const int _itemsPerPage = 10;
  bool _isLoading = true;

  //List<SchoolModel> _filteredSchools = [];
  List<SchoolModel> _allSchools = [];
  late List establishments;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    establishments = args['establishments'];
  }

  @override
  void initState() {
    super.initState();
    _allSchools =
        widget.establishments.map((e) => SchoolModel.fromJson(e)).toList();
    //_filteredSchools = _allSchools;
    _isLoading = false;
    _searchController.addListener(_filterSchools);
    //
    print("Establishments: ${widget.establishments}");
  }

  void _filterSchools() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      establishments = _allSchools
          .where((school) =>
              school.nom.toLowerCase().contains(query) ||
              //school.abbreviation.toLowerCase().contains(query) ||
              school.province!.toLowerCase().contains(query))
          .toList();
      _currentPage = 1;
    });
  }

  List<SchoolModel> get _currentPageItems {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    if (startIndex >= establishments.length) return [];
    final endIndex = startIndex + _itemsPerPage;
    List<SchoolModel> ll = convertDynamicListToSchoolModelList(establishments);
    return ll.sublist(
      startIndex,
      endIndex > ll.length ? ll.length : endIndex,
    );
  }

  List<SchoolModel> convertDynamicListToSchoolModelList(
      List<dynamic> dynamicList) {
    return dynamicList.map((item) {
      // Si l'item est déjà une Map, utilisez-le directement
      if (item is Map<String, dynamic>) {
        return SchoolModel.fromJson(item);
      }
      // Sinon, essayez de le convertir en Map
      else if (item is Map) {
        return SchoolModel.fromJson(Map<String, dynamic>.from(item));
      }
      // Si c'est une autre forme de données, lancez une exception
      else {
        throw FormatException(
            'Impossible de convertir l\'élément en SchoolModel');
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    //
    // final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final List<dynamic> establishments = args['establishments'];
    //
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      body: RefreshIndicator(
        onRefresh: () async {
          // You might want to reload establishments here if needed
          setState(() {
            _isLoading = false;
          });
        },
        child: Column(
          children: [
            _buildSearchField(),
            //_buildStatsHeader(),
            Expanded(child: _buildContent()),
            _buildPaginationControls(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: const Text('Répertoire des Écoles',
          style: TextStyle(fontWeight: FontWeight.w600)),
      centerTitle: true,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_alt_outlined),
          onPressed: _showFilterDialog,
          tooltip: 'Filtrer',
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => _showAddSchoolDialog(),
      backgroundColor: Colors.blue.shade700,
      elevation: 4,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(30),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Rechercher une école...',
            prefixIcon: const Icon(Icons.search, color: Colors.blue),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                      _filterSchools();
                    },
                  )
                : null,
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatItem(Icons.school, '${establishments.length}', 'Écoles'),
          // _buildStatItem(
          //     Icons.people,
          //     '${_filteredSchools.fold(0, (sum, school) => sum + (school.studentsCount ?? 0))}',
          //     'Élèves'),
          // _buildStatItem(
          //     Icons.star,
          //     '${_filteredSchools.isEmpty ? 0 : (_filteredSchools.map((e) => e.rating ?? 0).reduce((a, b) => a + b) / _filteredSchools.length).toStringAsFixed(1)}',
          //     'Moyenne'),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.blue.shade700),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900)),
              Text(label,
                  style: TextStyle(fontSize: 12, color: Colors.blue.shade600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (establishments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_outlined, size: 60, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Aucune école trouvée',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
            ),
            if (_searchController.text.isNotEmpty)
              TextButton(
                onPressed: () {
                  _searchController.clear();
                  _filterSchools();
                },
                child: const Text('Réinitialiser la recherche'),
              ),
          ],
        ),
      );
    }

    return ListView.separated(
      controller: _scrollController,
      itemCount: _currentPageItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showSchoolOptions(context, school),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Hero(
                tag: 'school-${school.id}',
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: school.logoUrl != null
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(school.logoUrl!),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        )
                      : null,
                ),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${school.province} ${school.proved} ${school.sousproved}",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Row(
                    //   children: [
                    //     _buildRatingStars(school.rating ?? 0),
                    //     const SizedBox(width: 8),
                    //     Text(
                    //       '${school.studentsCount} élèves',
                    //       style: TextStyle(
                    //         color: Colors.grey.shade600,
                    //         fontSize: 12,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              Icon(
                Icons.more_vert,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          size: 16,
          color: index < rating.floor() ? Colors.amber : Colors.grey.shade400,
        );
      }),
    );
  }

  Widget _buildPaginationControls() {
    final totalPages = (establishments.length / _itemsPerPage).ceil();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            color: _currentPage > 1 ? Colors.blue : Colors.grey,
            onPressed:
                _currentPage > 1 ? () => setState(() => _currentPage--) : null,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$_currentPage / $totalPages',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 20),
            color: _currentPage < totalPages ? Colors.blue : Colors.grey,
            onPressed: _currentPage < totalPages
                ? () => setState(() => _currentPage++)
                : null,
          ),
        ],
      ),
    );
  }

  void _showSchoolOptions(BuildContext context, SchoolModel school) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  school.nom,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.info_outline, color: Colors.blue),
                title: const Text('Détails de l\'école'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToDetail(context, school);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_outlined, color: Colors.orange),
                title: const Text('Modifier l\'école'),
                onTap: () {
                  Navigator.pop(context);
                  _showEditSchoolDialog(school);
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.assignment_outlined, color: Colors.green),
                title: const Text('Accéder au formulaire'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormListPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text('Supprimer l\'école'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(school);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _navigateToDetail(BuildContext context, SchoolModel school) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SchoolDetailPage(school: school),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filtrer les écoles'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFilterOption('Toutes les écoles', true),
              _buildFilterOption('Meilleures notes', false),
              _buildFilterOption('Plus de 1000 élèves', false),
              _buildFilterOption('Proches de moi', false),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Appliquer le filtre ici
              },
              child: const Text('Appliquer'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterOption(String title, bool isSelected) {
    return ListTile(
      title: Text(title),
      trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
      onTap: () {
        Navigator.pop(context);
        // Gérer la sélection du filtre
      },
    );
  }

  void _showAddSchoolDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter une nouvelle école'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Nom de l\'école',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Adresse',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Téléphone',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
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
                Navigator.pop(context);
                // Ajouter l'école ici
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
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
                    labelText: 'Ville',
                    border: OutlineInputBorder(),
                  ),
                  controller:
                      TextEditingController(text: school.qCiteChefferieVillage),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Commune',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(
                      text: school.territoireCommuneVille),
                  keyboardType: TextInputType.phone,
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
                Navigator.pop(context);
                // Mettre à jour l'école ici
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(SchoolModel school) {
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
                // Supprimer l'école ici
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${school.nom} a été supprimée'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child:
                  const Text('Supprimer', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
