import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/navigation_drawer.dart';
import '../../widgets/navigation_botton.dart';
import '../user/user.dart';
import '../auth/change_password.dart';
import '../auth/login.dart';

class HomeScreen extends StatefulWidget{
  final String username;
  final String password;

  const HomeScreen({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContent(username: widget.username),
      UserScreen(username: widget.username, password: widget.password),
      const ChangePasswordScreen(),
    ];
  }

  void _onDrawerItemSelected(int index){
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
    _scaffoldKey.currentState?.closeDrawer();
  }

  void _logout(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
    );
  }
  
  @override
  Widget build(BuildContext contexr){
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: _gettitle(),
        showbackButton: false,
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: CustomDrawer(
        username: widget.username,
        currentIndex: _currentIndex,
        onItemSelected: _onDrawerItemSelected,
        onLogout: _logout,
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}