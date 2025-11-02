import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';
import 'wallet_screen.dart';
import 'minutes_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userPhone;

  const HomeScreen({super.key, required this.userPhone});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const DashboardScreen(),
      const WalletScreen(),
      const MinutesScreen(),
      ProfileScreen(userPhone: widget.userPhone),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey500,
        backgroundColor: AppColors.white,
        elevation: 8,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Cüzdan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Dakikalar',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoş Geldiniz'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.accent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.background, AppColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Merkez Logo ve Dairesel Menü
              SizedBox(
                height: 400,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Arka plan daire
                    Container(
                      width: 350,
                      height: 350,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                    ),

                    // Merkez Logo
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: AppColors.white, width: 4),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'KIDSTOPIA',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            "children's workshops",
                            style: TextStyle(
                              color: AppColors.white.withValues(alpha: 0.9),
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Dairesel Menü Öğeleri
                    ..._buildCircularMenuItems(context),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Alt Kart Slider
              SizedBox(
                height: 160,
                child: PageView(
                  children: [
                    _buildPromotionCard(
                      'HEDİYE DAKİKA\nKAZAN!',
                      'KALAN KULLANILABİLİR DAKİKANIZ',
                      '14',
                      const LinearGradient(
                        colors: [Color(0xFF7B68EE), Color(0xFF9370DB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    _buildPromotionCard(
                      'ÖZEL İNDİRİM',
                      'YENİ ÜYE KAMPANYASI',
                      '%50',
                      const LinearGradient(
                        colors: [Color(0xFFFF6B6B), Color(0xFF4ECDC4)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCircularMenuItems(BuildContext context) {
    final menuItems = [
      {'icon': Icons.account_balance_wallet, 'label': 'CÜZDANIM', 'angle': 0.0},
      {'icon': Icons.videocam, 'label': 'YAYRUYU İZLE', 'angle': math.pi / 4},
      {'icon': Icons.info, 'label': 'BİLGİLERİM', 'angle': math.pi / 2},
      {
        'icon': Icons.location_on,
        'label': 'ŞUBELERİMİZ',
        'angle': 3 * math.pi / 4,
      },
      {'icon': Icons.smart_toy, 'label': 'AIO', 'angle': math.pi},
      {'icon': Icons.store, 'label': 'BAYILIK', 'angle': 5 * math.pi / 4},
      {'icon': Icons.games, 'label': 'OYUNLAR', 'angle': 3 * math.pi / 2},
      {
        'icon': Icons.campaign,
        'label': 'KAMPANYALAR',
        'angle': 7 * math.pi / 4,
      },
    ];

    return menuItems.map((item) {
      final angle = item['angle'] as double;
      final radius = 140.0;
      final x = radius * math.cos(angle);
      final y = radius * math.sin(angle);

      return Positioned(
        left: 175 + x - 40,
        top: 175 + y - 40,
        child: CircularMenuItem(
          icon: item['icon'] as IconData,
          label: item['label'] as String,
          onTap: () {
            _handleMenuItemTap(context, item['label'] as String);
          },
        ),
      );
    }).toList();
  }

  void _handleMenuItemTap(BuildContext context, String label) {
    switch (label) {
      case 'CÜZDANIM':
        // Navigate to wallet
        break;
      case 'YAYRUYU İZLE':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LiveStreamScreen()),
        );
        break;
      case 'BİLGİLERİM':
        // Navigate to info
        break;
      default:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$label sayfası yakında!')));
    }
  }

  Widget _buildPromotionCard(
    String title,
    String subtitle,
    String value,
    Gradient gradient,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Dairesel Menü Öğesi Widget'ı
class CircularMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const CircularMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary.withValues(alpha: 0.9),
          border: Border.all(color: AppColors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.white, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// Canlı Yayın Ekranı
class LiveStreamScreen extends StatelessWidget {
  const LiveStreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yayruyu İzle'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.accent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.background, AppColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Büyük X İkonu
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.white,
                    size: 60,
                  ),
                ),

                const SizedBox(height: 40),

                // Başlık
                const Text(
                  'YAYRUYU İZLE',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),

                const SizedBox(height: 20),

                // Açıklama Metni
                const Text(
                  'Sadece Şubelerimizden Oyun\nHizmeti Alırken Canlı İzleme\nSağlayabilirsiniz!',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.text,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // Telefon numarası
                const Text(
                  'Herhangi bir şubemizden şu anda\n5535727776 numarası üzerinden oyun\nhizmeti almadığınız için kamera gösterimi\nsağlanamıyor.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grey600,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // En Yakın Şube Butonu
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Şube bulma sayfasına git
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Şube arama özelliği yakında!'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.location_on),
                    label: const Text('SIZE EN YAKIN/UYGUN ŞUBEYİ BUL'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
