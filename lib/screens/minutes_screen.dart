import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MinutesScreen extends StatefulWidget {
  const MinutesScreen({super.key});

  @override
  State<MinutesScreen> createState() => _MinutesScreenState();
}

class _MinutesScreenState extends State<MinutesScreen> {
  int availableMinutes = 45; // Kullanılabilir dakikalar
  bool hasActiveSession = false;
  int activeSessionMinutes = 0;
  DateTime? sessionStartTime;

  final List<MinutePackage> packages = [
    MinutePackage(
      id: '1',
      minutes: 30,
      price: 25.0,
      description: '30 Dakika Oyun Paketi',
      popular: false,
    ),
    MinutePackage(
      id: '2',
      minutes: 60,
      price: 45.0,
      description: '1 Saat Oyun Paketi',
      popular: true,
    ),
    MinutePackage(
      id: '3',
      minutes: 120,
      price: 80.0,
      description: '2 Saat Oyun Paketi',
      popular: false,
    ),
    MinutePackage(
      id: '4',
      minutes: 180,
      price: 110.0,
      description: '3 Saat Premium Paket',
      popular: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dakikalar'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // TODO: Show usage history
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Mevcut dakikalar kartı
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: hasActiveSession ? AppColors.accent : AppColors.primary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasActiveSession ? 'Aktif Oyun' : 'Mevcut Dakika',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.white.withValues(alpha: 0.9),
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          hasActiveSession
                              ? '$activeSessionMinutes dakika kullanılıyor'
                              : '$availableMinutes dakika mevcut',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    Icon(
                      hasActiveSession ? Icons.play_circle : Icons.access_time,
                      color: AppColors.white,
                      size: 48,
                    ),
                  ],
                ),

                if (hasActiveSession) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Teslimat Kodu',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColors.white.withValues(
                                      alpha: 0.8,
                                    ),
                                  ),
                            ),
                            Text(
                              'KID123',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: _endSession,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            foregroundColor: AppColors.white,
                          ),
                          child: const Text('Oyunu Bitir'),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: availableMinutes > 0 ? _startSession : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.primary,
                      ),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Oyun Başlat'),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Dakika paketleri
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dakika Paketleri',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.8,
                          ),
                      itemCount: packages.length,
                      itemBuilder: (context, index) {
                        final package = packages[index];
                        return _MinutePackageCard(
                          package: package,
                          onPurchase: () => _purchasePackage(package),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startSession() {
    if (availableMinutes <= 0) return;

    setState(() {
      hasActiveSession = true;
      sessionStartTime = DateTime.now();
      activeSessionMinutes = 0;
    });

    // Simulate minute usage
    _simulateMinuteUsage();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Oyun başlatıldı! Teslimat kodu: KID123'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _endSession() {
    setState(() {
      hasActiveSession = false;
      availableMinutes -= activeSessionMinutes;
      activeSessionMinutes = 0;
      sessionStartTime = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Oyun sonlandırıldı'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _simulateMinuteUsage() {
    if (!hasActiveSession) return;

    Future.delayed(const Duration(seconds: 1), () {
      if (hasActiveSession && mounted) {
        setState(() {
          activeSessionMinutes++;
        });

        if (activeSessionMinutes >= availableMinutes) {
          _endSession();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Dakikalarınız tükendi!'),
              backgroundColor: AppColors.warning,
            ),
          );
        } else {
          _simulateMinuteUsage();
        }
      }
    });
  }

  void _purchasePackage(MinutePackage package) {
    // Simulate wallet check
    const walletBalance = 125.50; // Should come from wallet state

    if (walletBalance >= package.price) {
      setState(() {
        availableMinutes += package.minutes;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${package.minutes} dakika başarıyla satın alındı!'),
          backgroundColor: AppColors.success,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Yetersiz bakiye! Lütfen cüzdanınıza para yükleyin.'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}

class _MinutePackageCard extends StatelessWidget {
  final MinutePackage package;
  final VoidCallback onPurchase;

  const _MinutePackageCard({required this.package, required this.onPurchase});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: package.popular ? 8 : 4,
      child: Container(
        decoration: package.popular
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.accent, width: 2),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (package.popular)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'POPÜLER',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              Column(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 40,
                    color: package.popular
                        ? AppColors.accent
                        : AppColors.primary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${package.minutes} dk',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: package.popular
                          ? AppColors.accent
                          : AppColors.primary,
                    ),
                  ),
                  Text(
                    package.description,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              Column(
                children: [
                  Text(
                    '₺${package.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onPurchase,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: package.popular
                            ? AppColors.accent
                            : AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: const Text(
                        'Satın Al',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Model sınıfları
class MinutePackage {
  final String id;
  final int minutes;
  final double price;
  final String description;
  final bool popular;

  MinutePackage({
    required this.id,
    required this.minutes,
    required this.price,
    required this.description,
    this.popular = false,
  });
}
