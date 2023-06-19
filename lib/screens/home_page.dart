import 'package:flutter/material.dart';
import 'package:lsp_pt_barokah/screens/about_dev_page.dart';
import 'package:lsp_pt_barokah/screens/karyawan_page.dart';
import 'package:lsp_pt_barokah/screens/laporan_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome Back,',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Admin HRD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AboutDevPage(),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage("lib/assets/images/conti.jpg"),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: kToolbarHeight + 8.0,
              padding:
                  const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: TabBar(
                controller: _tabController,
                indicator: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    color: Colors.white),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                tabs: const [
                  Tab(text: 'Laporan'),
                  Tab(text: 'Karyawan'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  LaporanPage(),
                  KaryawanPage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
