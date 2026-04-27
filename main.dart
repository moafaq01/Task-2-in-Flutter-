import 'package:flutter/material.dart';

void main() {
  runApp(const PremiumCoffeeApp());
}

// نموذج بيانات المنتج
class Coffee {
  final String name;
  final String description;
  final double price;
  final IconData icon;

  Coffee({
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
  });
}

class PremiumCoffeeApp extends StatelessWidget {
  const PremiumCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أروما كافيه',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4A373), // لون ذهبي مائل للبني الفاتح للتميز
          secondary: Color(0xFFFAEDCD),
          surface: Color(0xFF1E1E1E),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        fontFamily: 'Roboto',
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: const FullLoginScreen(), // صفحة تسجيل الدخول المتكاملة
    );
  }
}

// ---------------------------------------------------------------------------
// 1. شاشة تسجيل الدخول المتكاملة
// ---------------------------------------------------------------------------
class FullLoginScreen extends StatefulWidget {
  const FullLoginScreen({super.key});

  @override
  State<FullLoginScreen> createState() => _FullLoginScreenState();
}

class _FullLoginScreenState extends State<FullLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      // إذا كانت البيانات صحيحة، ننتقل للشاشة الرئيسية باستخدام pushReplacement
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2C1E16), Color(0xFF121212)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // الشعار
                    const Icon(Icons.coffee_rounded, size: 80, color: Color(0xFFD4A373)),
                    const SizedBox(height: 20),
                    const Text(
                      'أهلاً بعودتك',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'سجل دخولك لمتابعة طلب قهوتك المفضلة',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 50),

                    // حقل البريد الإلكتروني
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        labelStyle: const TextStyle(color: Colors.white54),
                        prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFFD4A373)),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال البريد الإلكتروني';
                        }
                        if (!value.contains('@')) {
                          return 'الرجاء إدخال بريد إلكتروني صحيح';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // حقل كلمة المرور
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        labelStyle: const TextStyle(color: Colors.white54),
                        prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFFD4A373)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white54,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال كلمة المرور';
                        }
                        if (value.length < 6) {
                          return 'يجب أن لا تقل كلمة المرور عن 6 أحرف';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // زر "نسيت كلمة المرور"
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          // محاكاة استعادة كلمة المرور
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم إرسال رابط استعادة كلمة المرور')),
                          );
                        },
                        child: const Text('نسيت كلمة المرور؟', style: TextStyle(color: Color(0xFFD4A373))),
                      ),
                    ),
                    
                    const SizedBox(height: 20),

                    // زر تسجيل الدخول
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4A373),
                        foregroundColor: const Color(0xFF121212),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                      ),
                      child: const Text('تسجيل الدخول', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // إنشاء حساب جديد
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('ليس لديك حساب؟', style: TextStyle(color: Colors.white70)),
                        TextButton(
                          onPressed: () {},
                          child: const Text('سجل الآن', style: TextStyle(color: Color(0xFFD4A373), fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. الشاشة الرئيسية
// ---------------------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية 👋', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'أهلاً بك في عالم القهوة المختصة',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            
            // زر الانتقال إلى قائمة المنتجات
            _buildActionCard(
              context,
              title: 'تصفح القائمة',
              subtitle: 'اختر قهوتك المفضلة',
              icon: Icons.coffee_maker_rounded,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            // زر الانتقال إلى التفاصيل العامة
            _buildActionCard(
              context,
              title: 'عن التطبيق',
              subtitle: 'تعرف على خدماتنا وجودتنا',
              icon: Icons.info_outline_rounded,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, {required String title, required String subtitle, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 30),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. شاشة التفاصيل العامة
// ---------------------------------------------------------------------------
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عن التطبيق')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_cafe_rounded, size: 80, color: Color(0xFFD4A373)),
              const SizedBox(height: 30),
              const Text(
                'نحن نقدم لك أفضل تجربة لطلب القهوة أونلاين. نختار حبوب البن بعناية فائقة ونوفر خيارات متنوعة لترضي ذوقك.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, height: 1.5),
              ),
              const SizedBox(height: 50),
              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context), // العودة باستخدام pop
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('العودة'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFD4A373),
                  side: const BorderSide(color: Color(0xFFD4A373)),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 4. شاشة قائمة المنتجات
// ---------------------------------------------------------------------------
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Coffee> coffees = [
      Coffee(name: 'إسبريسو', description: 'قهوة مركزة وغنية', price: 12.0, icon: Icons.coffee_rounded),
      Coffee(name: 'كابتشينو', description: 'مزيج الإسبريسو والحليب المبخر', price: 16.0, icon: Icons.local_cafe_rounded),
      Coffee(name: 'لاتيه كراميل', description: 'لاتيه بلمسة من الكراميل الحلو', price: 20.0, icon: Icons.emoji_food_beverage_rounded),
      Coffee(name: 'فلات وايت', description: 'إسبريسو قوي مع حليب مخملي', price: 18.0, icon: Icons.coffee_maker_rounded),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('قائمة القهوة')),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: coffees.length,
        itemBuilder: (context, index) {
          final coffee = coffees[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4A373).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(coffee.icon, color: const Color(0xFFD4A373), size: 30),
              ),
              title: Text(coffee.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('${coffee.price} ريال', style: const TextStyle(color: Color(0xFFD4A373), fontWeight: FontWeight.bold)),
              ),
              trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
              onTap: () async {
                // الانتظار للحصول على النتيجة من شاشة التفاصيل (push and wait)
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoffeeDetailScreen(coffee: coffee),
                  ),
                );

                // استلام النتيجة وعرضها
                if (result != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.white),
                          const SizedBox(width: 10),
                          Text(result.toString(), style: const TextStyle(fontFamily: 'Roboto')),
                        ],
                      ),
                      backgroundColor: Colors.green.shade700,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
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

// ---------------------------------------------------------------------------
// 5. شاشة تفاصيل المنتج
// ---------------------------------------------------------------------------
class CoffeeDetailScreen extends StatelessWidget {
  final Coffee coffee;

  const CoffeeDetailScreen({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل المنتج')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4A373).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD4A373).withValues(alpha: 0.2),
                          blurRadius: 50,
                          spreadRadius: 10,
                        )
                      ],
                    ),
                    child: Icon(coffee.icon, size: 100, color: const Color(0xFFD4A373)),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    coffee.name,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${coffee.price} ريال',
                    style: const TextStyle(fontSize: 24, color: Color(0xFFD4A373), fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    coffee.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // إغلاق الشاشة وإرجاع النتيجة (pop with data)
                      Navigator.pop(context, 'تمت إضافة "${coffee.name}" بنجاح!');
                    },
                    icon: const Icon(Icons.add_shopping_cart_rounded),
                    label: const Text('إضافة إلى السلة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4A373),
                      foregroundColor: const Color(0xFF121212),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
