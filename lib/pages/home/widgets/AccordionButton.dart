import 'package:flutter/material.dart';
import 'package:epsp_sige/utils/Routes.dart';

class BeautifulAccordion extends StatefulWidget {
  const BeautifulAccordion({super.key});

  @override
  State<BeautifulAccordion> createState() => _BeautifulAccordionState();
}

class _BeautifulAccordionState extends State<BeautifulAccordion> {
  final Map<String, Map<String, List<String>>> _provincesData = {
    'Kinshasa': {
      'Lukunga': ['Gombe', 'Ngaliema', 'Mont-Ngafula', 'Lemba'],
      'Tshangu': ['Ndjili', 'Kimbanseke', 'Masina', 'Nsele'],
      'Mont-Amba': ['Matete', 'Lemba', 'Kinsenso'],
      'Funa': ['Bandalungwa', 'Bumbu', 'Makala', 'Selembao'],
      'Plateau': ['La Gombe', 'Kintambo', 'Lingwala']
    },
    'Kongo-Central': {
      'Matadi': ['Matadi', 'Nzanza', 'Mvuzi'],
      'Boma': ['Boma', 'Kalamu', 'Lukula'],
      'Muanda': ['Muanda', 'Kisundi'],
      'Lukala': ['Lukala', 'Kasangulu']
    },
    'Katanga': {
      'Lubumbashi': ['Lubumbashi', 'Kampemba', 'Katuba', 'Annexe'],
      'Likasi': ['Likasi', 'Kambove'],
      'Kolwezi': ['Kolwezi', 'Dilala'],
      'Kipushi': ['Kipushi', 'Kasenga']
    },
  };

  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final Map<String, bool> _provinceExpansionState = {};
  final Map<String, Map<String, bool>> _subdivisionExpansionState = {};

  @override
  void initState() {
    super.initState();
    // Initialize expansion states
    for (var province in _provincesData.keys) {
      _provinceExpansionState[province] = false;
      _subdivisionExpansionState[province] = {};
      for (var subdivision in _provincesData[province]!.keys) {
        _subdivisionExpansionState[province]![subdivision] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredProvinces = _provincesData.keys.where((province) {
      if (_searchQuery.isEmpty) return true;
      return province.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          _provincesData[province]!.keys.any((subdivision) =>
              subdivision.toLowerCase().contains(_searchQuery.toLowerCase())) ||
          _provincesData[province]!.values.any((communes) => communes.any(
                  (commune) => commune.toLowerCase().contains(_searchQuery.toLowerCase())));
    }).toList();

    return Column(
      children: [
        _buildEnhancedSearchBar(),
        const SizedBox(height: 10),
        _buildActiveFiltersChips(),
        const SizedBox(height: 10),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildStatsCard()),
              SliverToBoxAdapter(child: _buildDivider()),
              if (filteredProvinces.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 60, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          'Aucun résultat trouvé',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          'Essayez avec d\'autres termes',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final province = filteredProvinces[index];
                      return _buildProvinceCard(province, index);
                    },
                    childCount: filteredProvinces.length,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(30),
        shadowColor: Colors.blue.withOpacity(0.2),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Rechercher province, sous-division, commune...',
            hintStyle: TextStyle(color: Colors.grey.shade500),
            prefixIcon: Icon(Icons.search, color: Colors.blue.shade700),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
              icon: Icon(Icons.clear, color: Colors.grey.shade600),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                });
              },
            )
                : IconButton(
              icon: Icon(Icons.filter_list_rounded, color: Colors.blue.shade700),
              onPressed: _showAdvancedFilterDialog,
            ),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveFiltersChips() {
    // This would show active filters if we had any
    // For now it's just a placeholder for future implementation
    return const SizedBox.shrink();
  }

  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
      BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 10,
      offset: const Offset(0, 4),
      ),],
    gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.blue.shade50, Colors.white],
    ),
    ),
    child: Column(
    children: [
    const Text(
    'STATISTIQUES NATIONALES',
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    ),
    ),
    const SizedBox(height: 16),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    _buildStatItem(Icons.school, '26', 'Provinces'),
    _buildStatItem(Icons.account_balance, '145', 'Sous-divisions'),
    _buildStatItem(Icons.location_city, '386', 'Communes'),
    _buildStatItem(Icons.people, '25M+', 'Élèves'),
    ],
    ),
    ],
    ),
    );
    }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade100.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 24, color: Colors.blue.shade800),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'PROVINCES',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProvinceCard(String province, int index) {
    final subdivisions = _provincesData[province]!;
    final isExpanded = _provinceExpansionState[province] ?? false;

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: isExpanded ? 4 : 2,
      color: isExpanded ? Colors.blue.shade50 : Colors.white,
      child: ExpansionTile(
        key: Key(province),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _provinceExpansionState[province] = expanded;
          });
        },
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: Colors.blue.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          province,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isExpanded ? Colors.blue.shade900 : Colors.black87,
          ),
        ),
        subtitle: Text(
          '${subdivisions.length} sous-divisions',
          style: TextStyle(
            color: isExpanded ? Colors.blue.shade700 : Colors.grey.shade600,
          ),
        ),
        trailing: Icon(
          isExpanded ? Icons.expand_less : Icons.expand_more,
          color: isExpanded ? Colors.blue.shade800 : Colors.grey,
        ),
        children: subdivisions.keys.map((subdivision) {
          return _buildSubdivisionCard(province, subdivision);
        }).toList(),
      ),
    );
  }

  Widget _buildSubdivisionCard(String province, String subdivision) {
    final communes = _provincesData[province]![subdivision]!;
    final isExpanded = _subdivisionExpansionState[province]![subdivision] ?? false;

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Card(
        elevation: isExpanded ? 3 : 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: isExpanded ? Colors.blue.shade100.withOpacity(0.3) : Colors.grey.shade50,
        child: ExpansionTile(
          key: Key('$province-$subdivision'),
          initiallyExpanded: isExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _subdivisionExpansionState[province]![subdivision] = expanded;
            });
          },
          leading: CircleAvatar(
            radius: 14,
            backgroundColor: Colors.blue.shade200,
            child: Icon(
              Icons.arrow_drop_down,
              size: 20,
              color: Colors.blue.shade800,
            ),
          ),
          title: Text(
            subdivision,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isExpanded ? Colors.blue.shade800 : Colors.black87,
            ),
          ),
          subtitle: Text(
            '${communes.length} communes',
            style: TextStyle(
              fontSize: 12,
              color: isExpanded ? Colors.blue.shade700 : Colors.grey.shade600,
            ),
          ),
          trailing: Icon(
            isExpanded ? Icons.expand_less : Icons.expand_more,
            color: isExpanded ? Colors.blue.shade800 : Colors.grey,
            size: 20,
          ),
          children: communes.map((commune) {
            return _buildCommuneTile(province, subdivision, commune);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCommuneTile(String province, String subdivision, String commune) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 16, bottom: 4),
      child: ListTile(
        leading: Icon(Icons.location_on, size: 20, color: Colors.blue.shade600),
        title: Text(commune),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.blue.shade700),
          onPressed: () => _navigateToSchools('$province > $subdivision > $commune'),
        ),
        onTap: () => _navigateToSchools('$province > $subdivision > $commune'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  void _navigateToSchools(String location) {
    Navigator.pushNamed(
      context,
      Routes.SchoolListPageRoutes,
      arguments: {'location': location},
    );
  }

  void _showAdvancedFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(20),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Filtres Avancés',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFilterSection(
                    title: 'Type d\'établissement',
                    options: const [
                      'Écoles primaires',
                      'Écoles secondaires',
                      'Universités',
                      'Instituts supérieurs'
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildFilterSection(
                    title: 'Statut',
                    options: const [
                      'Public',
                      'Privé',
                      'Conventionné',
                      'Confessionnel'
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildFilterSection(
                    title: 'Infrastructures',
                    options: const [
                      'Avec bibliothèque',
                      'Avec laboratoire',
                      'Avec terrain de sport',
                      'Avec cantine'
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Réinitialiser'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Apply filters here
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.blue.shade800,
                          ),
                          child: const Text('Appliquer', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterSection({required String title, required List<String> options}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            return FilterChip(
              label: Text(option),
              selected: false,
              onSelected: (bool value) {
                // Handle filter selection
              },
              selectedColor: Colors.blue.shade100,
              checkmarkColor: Colors.blue,
              labelStyle: const TextStyle(color: Colors.black87),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              showCheckmark: true,
            );
          }).toList(),
        ),
      ],
    );
  }
}