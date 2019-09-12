import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/home/widgets/homebody.dart';
import 'package:flutter_demo/screens/home/widgets/homeheader.dart';
import 'package:flutter_demo/widgets/poke_container.dart';

class Home extends StatefulWidget {
  static const cardHeightFraction = 0.75;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController;
  double _cardHeight;
  bool _showTitle;
  bool _showToolbarColor;

  @override
  void initState() {
    _cardHeight = 0;
    _showTitle = false;
    _showToolbarColor = false;
    _scrollController = ScrollController()..addListener(_onScroll);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);

    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final showTitle = _scrollController.offset > _cardHeight - kToolbarHeight;

    final showToolbarColor = _scrollController.offset > kToolbarHeight;

    if (showTitle != _showTitle || showToolbarColor != _showToolbarColor) {
      setState(() {
        _showTitle = showTitle;
        _showToolbarColor = showToolbarColor;
      });
    }
  }

  Widget _buildCard() {
    return PokeContainer(
      decoration: BoxDecoration(
        color: Colors.deepOrange[400],
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      children: <Widget>[
        SizedBox(height: 85),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Text(
            "What Song,Artist\nare you looking for?",
            style: TextStyle(
              fontSize: 30,
              height: 0.9,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(height: 30),
        HomeHeader(),
        SizedBox(height: 40),
        HomeBody(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    _cardHeight = screenHeight * Home.cardHeightFraction;
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            expandedHeight: _cardHeight,
            floating: true,
            pinned: true,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            backgroundColor: Colors.red,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              centerTitle: true,
              title: _showTitle
                  ? Text(
                      "Pokedex",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : null,
              background: _buildCard(),
            ),
          ),
        ],
        body: Container(),
      ),
    );
  }
}
