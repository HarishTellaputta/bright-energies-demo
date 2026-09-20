import 'package:flutter/material.dart';

import 'core/app_colors.dart';
import 'core/company_info.dart';

import 'widgets/navbar.dart';
import 'widgets/whatsapp_button.dart';

import 'sections/hero_section.dart';
import 'sections/trust_bar_section.dart';
import 'sections/about_section.dart';
import 'sections/installation_section.dart';
import 'sections/solutions_section.dart';
import 'sections/why_solar_section.dart';
import 'sections/projects_section.dart';
import 'sections/reviews_section.dart';
import 'sections/process_section.dart';
import 'sections/calculator_section.dart';
import 'sections/cta_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';
import 'pages/quotation_page.dart';
import 'admin/admin_page.dart';

void main() {
  runApp(const BrightEnergiesApp());
}

class BrightEnergiesApp extends StatelessWidget {
  const BrightEnergiesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: CompanyInfo.name,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellow),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey solutionsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  void scrollTo(GlobalKey key) {
    final targetContext = key.currentContext;

    if (targetContext == null) {
      return;
    }

    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      alignment: 0.05,
    );
  }

  void openQuotationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuotationPage()),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(82),
        child: AppNavbar(
          onHome: () => scrollTo(homeKey),
          onSolutions: () => scrollTo(solutionsKey),
          onProjects: () => scrollTo(projectsKey),
          onAbout: () => scrollTo(aboutKey),
          onContact: () => scrollTo(contactKey),

          onAdmin: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminPage()),
            );
          },
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeroSection(
                sectionKey: homeKey,
                onContact: () => scrollTo(contactKey),
                onSolutions: () => scrollTo(solutionsKey),
                onQuote: openQuotationPage,
              ),

              const TrustBarSection(),

              AboutSection(sectionKey: aboutKey),

              const InstallationSection(),

              SolutionsSection(sectionKey: solutionsKey),

              const WhySolarSection(),

              ProjectsSection(sectionKey: projectsKey),

              const ReviewsSection(),

              const ProcessSection(),

              const CalculatorSection(),

              CtaSection(onContact: () => scrollTo(contactKey)),

              ContactSection(sectionKey: contactKey),

              FooterSection(
                onHome: () => scrollTo(homeKey),
                onSolutions: () => scrollTo(solutionsKey),
                onProjects: () => scrollTo(projectsKey),
                onAbout: () => scrollTo(aboutKey),
                onContact: () => scrollTo(contactKey),
              ),

              // Prevents bottom content from sitting behind
              // the floating WhatsApp button.
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      floatingActionButton: WhatsAppButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('WhatsApp number will be connected here.'),
            ),
          );
        },
      ),
    );
  }
}
