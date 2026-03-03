import 'package:flutter/material.dart';
import '../models/food.dart';
import 'food_detail_page.dart';

// Shared hardcoded food list — also mutated by AddFoodPage
final List<Food> hardcodedFoods = [
  Food(
    id: 6,
    name: 'Mỳ tôm',
    description: 'Mỳ tôm',
    price: 2,
    manufacturer: 'VN',
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8WrcZnmpYI5RDsMLcZ5w_j44xJ5fSDBaQHQ&s',
  ),
  Food(
    id: 7,
    name: 'Phở',
    description: 'Phở',
    price: 2.5,
    manufacturer: 'VN',
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbGpgL8CYhZ8eTsBAHQNFoH4cAEN5ejCPwAA&s',
  ),
  Food(
    id: 8,
    name: 'Bún chả',
    description: 'Bún chả Hà Nội hương vị xưa',
    price: 2,
    manufacturer: 'Hà Nội, VN',
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4FLvnGIXP9QJZTJ02Mo8DCTw8g5XDcenjlA&s',
  ),
];

class FoodListPage extends StatefulWidget {
  const FoodListPage({super.key});

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  void _navigateToAddFood() async {
    final result = await Navigator.pushNamed(context, '/food/add');
    if (result != null && result is Food) {
      setState(() {}); // re-render after new food added to hardcodedFoods
    }
  }

  void _navigateToFoodDetail(Food food) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FoodDetailPage(food: food)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foods'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Text(
                'U',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      'U',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: hardcodedFoods.isEmpty
          ? const Center(
              child: Text(
                'No foods available',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: hardcodedFoods.length,
              itemBuilder: (context, index) {
                final food = hardcodedFoods[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: food.image != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(food.image!),
                          )
                        : CircleAvatar(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            child: Text(
                              food.name[0].toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                    title: Text(
                      food.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      food.description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.chevron_right, size: 36),
                    onTap: () => _navigateToFoodDetail(food),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddFood,
        tooltip: 'Add Food',
        child: const Icon(Icons.add),
      ),
    );
  }
}
