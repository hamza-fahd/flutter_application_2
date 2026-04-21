import 'package:flutter/material.dart';

void main() {
  runApp(const MyStoreApp());
}

class MyStoreApp extends StatelessWidget {
  const MyStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'MyStoreApp',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const ProductListScreen(),
    );
  }
}

// --- الصفحة الأولى: قائمة المنتجات ---
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  // قائمة البيانات (المعلومات التي ستظهر في التطبيق)
  final List<String> products = const [
    "Smart Phone",
    "Laptop Pro",
    "Wireless Headphones",
    "Gaming Mouse",
    "Phone Charger"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("متجري الإلكتروني"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      // استخدمنا ListView.builder لتكرار العناصر بشكل تلقائي وأنيق
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card( // إضافة "بطاقة" لكل منتج ليعطي شكلاً احترافياً
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            elevation: 3, 
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.shopping_cart)),
              title: Text(products[index], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text("اضغط لعرض التفاصيل والشراء"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                // عملية الـ Push مع انتظار النتيجة
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(productName: products[index]),
                  ),
                );

                if (!context.mounted) return; // mounted  تعني موجود ومرتبط بهذه الصفحة
                if (result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result), backgroundColor: Colors.teal),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

// --- الصفحة الثانية: تفاصيل المنتج ---
class ProductDetailScreen extends StatelessWidget {
  final String productName;
  const ProductDetailScreen({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(productName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.info_outline, size: 100, color: Colors.teal),
            const SizedBox(height: 20),
            Text("تفاصيل المنتج: $productName", style: const TextStyle(fontSize: 24)),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("هذا المنتج يتميز بجودة عالية وضمان لمدة عامين.", textAlign: TextAlign.center),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context, "تم شراء $productName بنجاح!"),
              icon: const Icon(Icons.check),
              label: const Text("تأكيد الشراء والعودة"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}