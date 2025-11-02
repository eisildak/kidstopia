import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double currentBalance = 125.50; // Örnek bakiye
  List<WalletTransaction> transactions = [
    WalletTransaction(
      id: '1',
      type: TransactionType.deposit,
      amount: 100.0,
      description: 'Kredi kartı ile yükleme',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    WalletTransaction(
      id: '2',
      type: TransactionType.purchase,
      amount: -25.0,
      description: '30 dakika satın alma',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    WalletTransaction(
      id: '3',
      type: TransactionType.deposit,
      amount: 50.50,
      description: 'Banka kartı ile yükleme',
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cüzdanım'),
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
              const SizedBox(height: 30),
              
              // Büyük Bakiye Kartı
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Bakiye Başlığı
                    const Text(
                      'CÜZDANIM',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                        letterSpacing: 1.5,
                      ),
                    ),
                    
                    Container(
                      height: 3,
                      width: 60,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    
                    // Bakiye Miktarı
                    Text(
                      '${currentBalance.toInt()}₺',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    const Text(
                      'Kullanılabilir Bakiye',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grey600,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Son hizmet bilgisi
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Son hizmet aldığınız Kayseri',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            'Meysu şube paket fiyatları:',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.grey600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '60 Dk: 430₺',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _showDepositDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.primary,
                        ),
                        icon: const Icon(Icons.add, size: 20),
                        label: const Text('Para Yükle'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Hızlı yükleme tutarları
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hızlı Yükleme',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _QuickAmountButton(
                      amount: 25,
                      onTap: () => _quickDeposit(25),
                    ),
                    const SizedBox(width: 8),
                    _QuickAmountButton(
                      amount: 50,
                      onTap: () => _quickDeposit(50),
                    ),
                    const SizedBox(width: 8),
                    _QuickAmountButton(
                      amount: 100,
                      onTap: () => _quickDeposit(100),
                    ),
                    const SizedBox(width: 8),
                    _QuickAmountButton(
                      amount: 200,
                      onTap: () => _quickDeposit(200),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Son işlemler
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Son İşlemler',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: transactions.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        return _TransactionTile(transaction: transaction);
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

  void _showDepositDialog() {
    showDialog(
      context: context,
      builder: (context) => _DepositDialog(
        onDeposit: (amount) {
          setState(() {
            currentBalance += amount;
            transactions.insert(
              0,
              WalletTransaction(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                type: TransactionType.deposit,
                amount: amount,
                description: 'Kredi kartı ile yükleme',
                date: DateTime.now(),
              ),
            );
          });
        },
      ),
    );
  }

  void _quickDeposit(double amount) {
    setState(() {
      currentBalance += amount;
      transactions.insert(
        0,
        WalletTransaction(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: TransactionType.deposit,
          amount: amount,
          description: 'Hızlı yükleme',
          date: DateTime.now(),
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('₺${amount.toStringAsFixed(2)} başarıyla yüklendi'),
        backgroundColor: AppColors.success,
      ),
    );
  }
}

class _QuickAmountButton extends StatelessWidget {
  final double amount;
  final VoidCallback onTap;

  const _QuickAmountButton({required this.amount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onTap,
        child: Text('₺${amount.toInt()}'),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final WalletTransaction transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isDeposit = transaction.type == TransactionType.deposit;
    final color = isDeposit ? AppColors.success : AppColors.error;
    final icon = isDeposit ? Icons.add : Icons.remove;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.1),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        transaction.description,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        _formatDate(transaction.date),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Text(
        '${isDeposit ? '+' : ''}₺${transaction.amount.abs().toStringAsFixed(2)}',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Bugün';
    } else if (difference == 1) {
      return 'Dün';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class _DepositDialog extends StatefulWidget {
  final Function(double) onDeposit;

  const _DepositDialog({required this.onDeposit});

  @override
  State<_DepositDialog> createState() => _DepositDialogState();
}

class _DepositDialogState extends State<_DepositDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Para Yükle'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tutar (₺)',
                hintText: '0.00',
                prefixIcon: Icon(Icons.attach_money),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen bir tutar girin';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Geçerli bir tutar girin';
                }
                if (amount > 1000) {
                  return 'Maksimum yükleme tutarı ₺1.000';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final amount = double.parse(_controller.text);
              widget.onDeposit(amount);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Yükle'),
        ),
      ],
    );
  }
}

// Model sınıfları
enum TransactionType { deposit, purchase }

class WalletTransaction {
  final String id;
  final TransactionType type;
  final double amount;
  final String description;
  final DateTime date;

  WalletTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
  });
}
