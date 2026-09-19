import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../widgets/section_label.dart';

class CalculatorSection extends StatelessWidget {
  const CalculatorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.lightBackground,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 105,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;

          if (isMobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIntro(),
                const SizedBox(height: 45),
                const _SolarCalculator(),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 10,
                child: _buildIntro(),
              ),
              const SizedBox(width: 80),
              const Expanded(
                flex: 11,
                child: _SolarCalculator(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIntro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(
          text: 'SOLAR CALCULATOR',
        ),

        const SizedBox(height: 16),

        const Text(
          'Discover Your\nSolar Potential.',
          style: TextStyle(
            color: AppColors.navy,
            fontSize: 45,
            height: 1.08,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),

        const SizedBox(height: 22),

        const Text(
          'See how switching to solar could help reduce your '
          'electricity expenses and move your home or business '
          'towards cleaner energy.',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 16,
            height: 1.75,
          ),
        ),

        const SizedBox(height: 30),

        _infoItem(
          Icons.currency_rupee_rounded,
          'Potentially reduce electricity expenses',
        ),

        const SizedBox(height: 15),

        _infoItem(
          Icons.eco_outlined,
          'Generate clean and renewable energy',
        ),

        const SizedBox(height: 15),

        _infoItem(
          Icons.trending_down_rounded,
          'Reduce dependence on conventional electricity',
        ),

        const SizedBox(height: 35),

        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Text(
                  'Start with your current monthly electricity bill.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoItem(
    IconData icon,
    String text,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.yellow.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColors.navy,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.navy,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SolarCalculator extends StatefulWidget {
  const _SolarCalculator();

  @override
  State<_SolarCalculator> createState() => _SolarCalculatorState();
}

class _SolarCalculatorState extends State<_SolarCalculator> {
  final TextEditingController _billController = TextEditingController();

  double? monthlySavings;
  double? annualSavings;
  double? estimatedSystemSize;

  bool showError = false;

  void calculate() {
    final bill = double.tryParse(
      _billController.text.trim(),
    );

    if (bill == null || bill <= 0) {
      setState(() {
        showError = true;
        monthlySavings = null;
        annualSavings = null;
        estimatedSystemSize = null;
      });
      return;
    }

    // Indicative demo calculation.
    final savings = bill * 0.70;
    final annual = savings * 12;

    // Very rough indicative estimate for demo purposes.
    final systemSize = bill / 1000;

    setState(() {
      showError = false;
      monthlySavings = savings;
      annualSavings = annual;
      estimatedSystemSize = systemSize;
    });
  }

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.black.withOpacity(0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withOpacity(0.10),
            blurRadius: 35,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.yellow,
                      Color(0xFFFFD85C),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.wb_sunny_rounded,
                  color: AppColors.navy,
                  size: 27,
                ),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Solar Savings Estimator',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Get an indicative estimate in seconds',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            'What is your average monthly electricity bill?',
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: _billController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => calculate(),
            style: const TextStyle(
              color: AppColors.navy,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.currency_rupee_rounded,
                color: AppColors.navy,
              ),
              hintText: 'Example: 5000',
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              filled: true,
              fillColor: AppColors.lightBackground,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: AppColors.yellow,
                  width: 2,
                ),
              ),
            ),
          ),

          if (showError) ...[
            const SizedBox(height: 9),
            const Text(
              'Please enter a valid monthly electricity bill.',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.yellow,
                foregroundColor: AppColors.navy,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Calculate My Savings',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 9),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),

          // RESULT
          if (monthlySavings != null) ...[
            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.navy,
                    AppColors.darkNavy,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'YOUR INDICATIVE ESTIMATE',
                    style: TextStyle(
                      color: AppColors.yellow,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Expanded(
                        child: _resultItem(
                          'Monthly Savings',
                          '₹${monthlySavings!.toStringAsFixed(0)}',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _resultItem(
                          'Annual Savings',
                          '₹${annualSavings!.toStringAsFixed(0)}',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  _resultItem(
                    'Indicative System Size',
                    '${estimatedSystemSize!.toStringAsFixed(1)} kW',
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 18),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 15,
                color: Colors.grey,
              ),
              const SizedBox(width: 7),
              const Expanded(
                child: Text(
                  'This calculator provides an indicative estimate only. '
                  'Actual savings and system size depend on electricity '
                  'usage, tariff, location, roof conditions and other factors.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _resultItem(
    String label,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.65),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}