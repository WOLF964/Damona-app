import 'package:flutter/material.dart';

void main() {
  runApp(const DamonaApp());
}

class DamonaApp extends StatelessWidget {
  const DamonaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Damona - Wild Rift Companion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF00D2FF),
        cardColor: const Color(0xFF1E1E1E),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00D2FF),
          secondary: Color(0xFFD4AF37),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class Champion {
  final String name;
  final String title;
  final String lane;
  final String tier;
  final String imageUrl;
  final String early;
  final String mid;
  final String late;
  final List<String> coreBuild;
  final List<String> situationalItems;
  final List<String> counters;
  final List<String> synergedWith;

  Champion({
    required this.name,
    required this.title,
    required this.lane,
    required this.tier,
    required this.imageUrl,
    required this.early,
    required this.mid,
    required this.late,
    required this.coreBuild,
    required this.situationalItems,
    required this.counters,
    required this.synergedWith,
  });
}

final List<Champion> sampleChampions = [
  Champion(
    name: 'Ahri',
    title: 'La Guadaña de Nueve Colas',
    lane: 'Mid',
    tier: 'A',
    imageUrl: 'https://ddragon.leagueoflegends.com/cdn/14.20.1/img/champion/Ahri.png',
    early: 'Regular',
    mid: 'Excelente',
    late: 'Fuerte',
    coreBuild: ['Eco de Luden', 'Botas de Lucidez', 'Orbe del Infinito', 'Sombrero Mortífero de Rabadon', 'Báculo del Vacío', 'Encantamiento de Protocinturón'],
    situationalItems: ['Morellonomicón (Cortacuras)', 'Velo de la Santitriz'],
    counters: ['Yasuo', 'Zed', 'Fizz'],
    synergedWith: ['Jarvan IV', 'Vi', 'Lee Sin'],
  ),
  Champion(
    name: 'Galio',
    title: 'El Coloso de Petricita',
    lane: 'Soporte',
    tier: 'S+',
    imageUrl: 'https://ddragon.leagueoflegends.com/cdn/14.20.1/img/champion/Galio.png',
    early: 'Fuerte',
    mid: 'Excelente',
    late: 'Regular',
    coreBuild: ['Impulsor Cósmico', 'Botas de Lucidez', 'Encantamiento de Locket', 'Báculo del Vacío', 'Sombrero Mortífero de Rabadon', 'Coraza del Muerto'],
    situationalItems: ['Morellonomicón (Cortacuras)', 'Presagio de Randuin'],
    counters: ['Vayne', 'Olaf', 'Fiora'],
    synergedWith: ['Camille', 'Jarvan IV', 'Malphite'],
  ),
  Champion(
    name: 'Jinx',
    title: 'La Bala Perdida',
    lane: 'Dúo',
    tier: 'S',
    imageUrl: 'https://ddragon.leagueoflegends.com/cdn/14.20.1/img/champion/Jinx.png',
    early: 'Débil',
    mid: 'Fuerte',
    late: 'Excelente',
    coreBuild: ['Matagigantes', 'Botas Codiciosas', 'Filo Infinito', 'Huracán de Runaan', 'Recordatorio Mortal', 'Encantamiento de Mercurio'],
    situationalItems: ['Ángel Guardián', 'Sombra de Filo'],
    counters: ['Draven', 'Lucian', 'Blitzcrank'],
    synergedWith: ['Lulu', 'Thresh', 'Nami'],
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLane = 'Todos';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Champion> filteredList = sampleChampions.where((c) {
      bool matchesLane = selectedLane == 'Todos' || c.lane == selectedLane;
      bool matchesSearch = c.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesLane && matchesSearch;
    }).toList()..sort((a, b) => a.name.compareTo(b.name));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 2,
        title: Row(
          children: const [
            Icon(Icons.shield, color: Color(0xFFD4AF37)),
            SizedBox(width: 8),
            Text('DAMONA', style: TextStyle(fontWeight: FontWeight.black, letterSpacing: 1.5, color: Color(0xFF00D2FF))),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD4AF37)),
            ),
            child: const Text('v7.3b', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (val) => setState(() => searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Buscar campeón...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: ['Todos', 'Barón', 'Jungla', 'Mid', 'Dúo', 'Soporte'].map((lane) {
                bool isSelected = selectedLane == lane;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: FilterChip(
                    label: Text(lane),
                    selected: isSelected,
                    selectedColor: const Color(0xFF00D2FF),
                    backgroundColor: const Color(0xFF1E1E1E),
                    labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.white, fontWeight: FontWeight.bold),
                    onSelected: (bool value) {
                      setState(() {
                        selectedLane = lane;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final champion = filteredList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChampionDetailScreen(champion: champion)),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white12),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 6, offset: const Offset(0, 3)),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                champion.imageUrl,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 50, color: Color(0xFF00D2FF)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(champion.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(champion.title, style: const TextStyle(color: Colors.grey, fontSize: 11), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4AF37),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              champion.tier,
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.black, fontSize: 11),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChampionDetailScreen extends StatelessWidget {
  final Champion champion;
  const ChampionDetailScreen({super.key, required this.champion});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1E1E1E),
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(champion.imageUrl, width: 30, height: 30),
              ),
              const SizedBox(width: 10),
              Text(champion.name),
            ],
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFF00D2FF),
            labelColor: Color(0xFF00D2FF),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Builds'),
              Tab(text: 'Matchups'),
              Tab(text: 'Curva'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text('🛡️ Ruta de Compra Core:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00D2FF))),
                const SizedBox(height: 8),
                ...champion.coreBuild.map((item) => Card(color: const Color(0xFF1E1E1E), child: ListTile(leading: const Icon(Icons.shield, color: Color(0xFFD4AF37)), title: Text(item)))),
                const SizedBox(height: 16),
                const Text('🔄 Ítems Situacionales:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
                const SizedBox(height: 8),
                ...champion.situationalItems.map((item) => Card(color: const Color(0xFF1E1E1E), child: ListTile(leading: const Icon(Icons.swap_horiz, color: Colors.cyanAccent), title: Text(item)))),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text('❌ Counters (Débil contra):', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                const SizedBox(height: 8),
                ...champion.counters.map((c) => Card(color: const Color(0xFF1E1E1E), child: ListTile(leading: const Icon(Icons.close, color: Colors.redAccent), title: Text(c)))),
                const SizedBox(height: 16),
                const Text('🤝 Sinergias Recomendadas:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                const SizedBox(height: 8),
                ...champion.synergedWith.map((s) => Card(color: const Color(0xFF1E1E1E), child: ListTile(leading: const Icon(Icons.check, color: Colors.greenAccent), title: Text(s)))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(color: const Color(0xFF1E1E1E), child: ListTile(title: const Text('Juego Temprano (Early Game)'), trailing: Text(champion.early, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00D2FF))))),
                  Card(color: const Color(0xFF1E1E1E), child: ListTile(title: const Text('Juego Medio (Mid Game)'), trailing: Text(champion.mid, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00D2FF))))),
                  Card(color: const Color(0xFF1E1E1E), child: ListTile(title: const Text('Juego Tardío (Late Game)'), trailing: Text(champion.late, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00D2FF))))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
