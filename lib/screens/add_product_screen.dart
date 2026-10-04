import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController quantityController =
      TextEditingController();

  final TextEditingController buyPriceController =
      TextEditingController();

  final TextEditingController sellPriceController =
      TextEditingController();

  final TextEditingController minimumStockController =
      TextEditingController();

  final TextEditingController maximumStockController =
      TextEditingController();

  bool loading = false;

  double get inventoryValue {
    final qty =
        double.tryParse(quantityController.text) ?? 0;

    final buy =
        double.tryParse(buyPriceController.text) ?? 0;

    return qty * buy;
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    buyPriceController.dispose();
    sellPriceController.dispose();
    minimumStockController.dispose();
    maximumStockController.dispose();
    super.dispose();
  }

  Future<void> saveProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    final ok = await ApiService.addProduct(
      name: nameController.text.trim(),
      quantity: int.parse(quantityController.text),
      buyPrice: double.parse(buyPriceController.text),
      sellPrice: double.parse(sellPriceController.text),
      minimumStock:
          int.tryParse(minimumStockController.text) ?? 0,
      maximumStock:
          int.tryParse(maximumStockController.text) ?? 0,
    );

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    if (ok) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("فشل إضافة المنتج"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0B1120),

      appBar: AppBar(
        backgroundColor: const Color(0xff0B1120),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "إضافة منتج جديد",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [ Container(
  width: double.infinity,
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: const Color(0xff111A2E),
    borderRadius: BorderRadius.circular(22),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [

      const Row(
        children: [

          Icon(
            Icons.inventory_2,
            color: Color(0xff5EF2E3),
          ),

          Spacer(),

          Text(
            "معلومات المنتج",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),

      const SizedBox(height: 25),

      buildField(
        controller: nameController,
        label: "اسم المنتج",
        icon: Icons.shopping_bag_outlined,
      ),

      const SizedBox(height: 18),

      buildField(
        controller: quantityController,
        label: "الكمية",
        icon: Icons.numbers,
        keyboard: TextInputType.number,
        onChanged: (_) => setState(() {}),
      ),

      const SizedBox(height: 18),

      buildField(
  controller: buyPriceController,
  label: "سعر الشراء",
  icon: Icons.payments_outlined,
  keyboard: TextInputType.number,
  onChanged: (_) => setState(() {}),
),

const SizedBox(height: 18),

buildField(
  controller: sellPriceController,
  label: "سعر البيع",
  icon: Icons.sell_outlined,
  keyboard: TextInputType.number,
),

const SizedBox(height: 18),

      buildField(
  controller: minimumStockController,
  label: "الحد الأدنى للمخزون",
  icon: Icons.remove_circle_outline,
  keyboard: TextInputType.number,
),

const SizedBox(height: 18),

buildField(
  controller: maximumStockController,
  label: "الحد الأقصى للمخزون",
  icon: Icons.add_circle_outline,
  keyboard: TextInputType.number,
),

    ],
  ),
),

const SizedBox(height: 25),

Container(
  width: double.infinity,
  padding: const EdgeInsets.all(22),
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [
        Color(0xff2A8CFF),
        Color(0xff18B6F6),
      ],
    ),
    borderRadius: BorderRadius.circular(22),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [

      const Text(
        "قيمة المخزون",
        style: TextStyle(
          color: Colors.white70,
        ),
      ),

      const SizedBox(height: 8),

      Text(
        "${inventoryValue.toStringAsFixed(2)} جنيه",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),

    ],
  ),
),

const SizedBox(height: 30),
SizedBox(
  width: double.infinity,
  height: 58,
  child: ElevatedButton(
    onPressed: loading ? null : saveProduct,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff5EF2E3),
      foregroundColor: Colors.black,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    child: loading
        ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.black,
            ),
          )
        : const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.save),
              SizedBox(width: 10),
              Text(
                "حفظ المنتج",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
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

  Widget buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
    ValueChanged<String>? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "هذا الحقل مطلوب";
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
  hintText: label,
  hintStyle: const TextStyle(
    color: Colors.white54,
    fontSize: 13,
  ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xff5EF2E3),
        ),
        filled: true,
        fillColor: const Color(0xff1A2238),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(.08),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color(0xff5EF2E3),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
        