import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ShadowCeoScreen extends StatefulWidget {
  const ShadowCeoScreen({super.key});

  @override
  State<ShadowCeoScreen> createState() => _ShadowCeoScreenState();
}

class _ShadowCeoScreenState extends State<ShadowCeoScreen> {
  bool loading = true;

  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final result = await ApiService.getShadowCEO();

      if (!mounted) return;

      setState(() {
        data = result;
        loading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });
    }
  }

  Color get healthColor {
    final health =
        (data["financial_health"] ?? "").toString();

    if (health == "Excellent") {
      return const Color(0xFF42E695);
    }

    if (health == "Good") {
      return const Color(0xFF00B4FF);
    }

    return const Color(0xFFFF6B6B);
  }

  String get healthText {
    final health =
        (data["financial_health"] ?? "").toString();

    switch (health) {
      case "Excellent":
        return "ممتاز";
      case "Good":
        return "جيد";
      default:
        return "خطر";
    }
  }

  String formatValue(dynamic value) {
    final number =
        double.tryParse(value.toString()) ?? 0;

    if (number == number.roundToDouble()) {
      return number.toStringAsFixed(0);
    }

    return number.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF0B0F1A),

       

        body: loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF5EF2E3),
                ),
              )
            : RefreshIndicator(
                color: const Color(0xFF5EF2E3),
                backgroundColor:
                    const Color(0xFF111A2E),
                onRefresh: loadData,
                child: ListView(
                  padding: const EdgeInsets.all(18),
                  children: [
                    const Row(
  children: [

    Icon(
      Icons.psychology,
      color: Color(0xFF5EF2E3),
      size: 28,
    ),

    SizedBox(width: 10),

    Text(
      "Shadow CEO",
      style: TextStyle(
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.w900,
      ),
    ),
  ],
),

const SizedBox(height: 20),

buildScoreCard(),

const SizedBox(height: 16),

// HERO CARD

Container(
                      padding: const EdgeInsets.symmetric(
  horizontal: 22,
  vertical: 32,
),

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            healthColor,
                            healthColor.withOpacity(
                              .55,
                            ),
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(
                          28,
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.end,
                        children: [

                          const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.end,
                            children: [

                              Text(
                                "Shadow CEO",
                                style: TextStyle(
                                  color:
                                      Colors.white,
                                  fontSize: 24,
                                  fontWeight:
                                      FontWeight
                                          .w900,
                                ),
                              ),

                              SizedBox(width: 10),

                              Icon(
                                Icons.psychology,
                                color:
                                    Colors.white,
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          const Text(
                            "الحالة الحالية",
                            style: TextStyle(
                              color:
                                  Colors.white70,
                            ),
                          ),

                          const SizedBox(
                            height: 6,
                          ),

                          Text(
  healthText,
  style: const TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w900,
  ),
),

const SizedBox(height: 8),

Text(
  "CEO Score: ${data["ceo_score"] ?? 0}/100",
  style: const TextStyle(
    color: Colors.white70,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [

                        Expanded(
                          child: buildStatCard(
                            title: "النقدية",
                            value:
                                formatValue(
                              data["cash"],
                            ),
                            icon:
                                Icons.account_balance_wallet_rounded,
                            color:
                                const Color(
                              0xFF42E695,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 12,
                        ),

                        Expanded(
                          child: buildStatCard(
                            title: "المخزون",
                            value:
                                formatValue(
                              data[
                                  "inventory"],
                            ),
                            icon:
                                Icons.inventory_2_rounded,
                            color:
                                const Color(
                              0xFFFFB84D,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                   Row(
  children: [

    Expanded(
      child: buildBestClientCard(),
    ),

    const SizedBox(width: 12),

    Expanded(
      child: buildTopClientCard(),
    ),
  ],
),

const SizedBox(height: 20),

buildSectionCard(
  title: "🚨 تنبيهات المدير التنفيذي",
  items: data["alerts"] ?? [],
),

                    const SizedBox(height: 18),

                    buildSectionCard(
                      title:
                          "💡 توصيات المدير التنفيذي",
                      items: data[
                              "recommendations"] ??
                          [],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFF111A2E),
        borderRadius:
            BorderRadius.circular(22),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.end,
        children: [

          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color:
                  color.withOpacity(.15),
              borderRadius:
                  BorderRadius.circular(
                14,
              ),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            maxLines: 1,
            overflow:
                TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight:
                  FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionCard({
    required String title,
    required List items,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF111A2E),
        borderRadius:
            BorderRadius.circular(22),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.end,
        children: [

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight:
                  FontWeight.w900,
            ),
          ),

          const SizedBox(height: 14),

          if (items.isEmpty)
            const Text(
              "لا توجد بيانات",
              style: TextStyle(
                color: Colors.white54,
              ),
            ),

          ...items.map(
            (item) => Container(
              width: double.infinity,

              margin:
                  const EdgeInsets.only(
                bottom: 10,
              ),

              padding:
                  const EdgeInsets.all(
                12,
              ),

              decoration:
                  BoxDecoration(
                color: const Color(
                  0xFF172642,
                ),
                borderRadius:
                    BorderRadius
                        .circular(
                  14,
                ),
              ),

              child: Text(
                item.toString(),
                textAlign:
                    TextAlign.right,
                style:
                    const TextStyle(
                  color:
                      Colors.white,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildTopClientCard() {

  final client =
      data["top_debt_client"] ?? {};

  return Container(
    padding: const EdgeInsets.all(18),

    decoration: BoxDecoration(
      color: const Color(0xFF111A2E),
      borderRadius:
          BorderRadius.circular(22),
    ),

    child: Column(
      mainAxisAlignment:
    MainAxisAlignment.spaceBetween,

crossAxisAlignment:
    CrossAxisAlignment.end,
      children: [

        const Text(
          "⚠️ الأكثر مديونية",
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 14),

        Text(
          client["name"]?.toString() ??
              "لا يوجد",
              maxLines: 1,
overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "${client["balance"] ?? 0} ج.م",
          style: const TextStyle(
            color: Color(0xFFFF6B6B),
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    ),
  );
}
Widget buildBestClientCard() {

  final client =
      data["top_paid_client"] ?? {};

  return Container(
    padding: const EdgeInsets.all(18),

    decoration: BoxDecoration(
      color: const Color(0xFF111A2E),
      borderRadius:
          BorderRadius.circular(22),
    ),

    child: Column(
      mainAxisAlignment:
    MainAxisAlignment.spaceBetween,

crossAxisAlignment:
    CrossAxisAlignment.end,
      children: [

        const Text(
          "🏆 افضل عميل",
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 14),

        Text(
          client["name"]?.toString() ??
              "لا يوجد",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "${client["balance"] ?? 0} ج.م",
          style: const TextStyle(
            color: Color(0xFF42E695),
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    ),
  );
}
Widget buildScoreCard() {

  final score =
      int.tryParse(
        data["ceo_score"]
            .toString(),
      ) ??
      0;

  final risk =
      data["risk_level"]
              ?.toString() ??
          "";

  Color scoreColor =
      const Color(0xFFFF6B6B);

  if (score >= 80) {
    scoreColor =
        const Color(0xFF42E695);
  } else if (score >= 60) {
    scoreColor =
        const Color(0xFFFFB84D);
  }

  return Container(
    padding:
        const EdgeInsets.all(20),

    decoration: BoxDecoration(
      color: const Color(0xFF111A2E),
      borderRadius:
          BorderRadius.circular(
        24,
      ),
    ),

    child: Row(
      children: [

        Container(
          width: 90,
          height: 90,

          decoration: BoxDecoration(
            color:
                scoreColor.withOpacity(
              .15,
            ),
            shape: BoxShape.circle,
          ),

          child: Center(
            child: Text(
              "${score}/100",
              style:
                  TextStyle(
                color:
                    scoreColor,
                fontSize: 18,
                fontWeight:
                    FontWeight.w900,
              ),
            ),
          ),
        ),

        const Spacer(),

        Column(
          crossAxisAlignment:
              CrossAxisAlignment.end,
          children: [

            const Text(
              "CEO SCORE",
              style: TextStyle(
                color:
                    Colors.white,
                fontSize: 18,
                fontWeight:
                    FontWeight.w900,
              ),
            ),

            const SizedBox(
              height: 4,
            ),

            Text(
              risk,
              style: TextStyle(
                color:
                    scoreColor,
                fontSize: 14,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
}