import 'package:draggable_home/draggable_home.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:temparty/app/pages/search/search_controller.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final String title;
  const SearchPage({Key? key, this.title = 'SearchPage'}) : super(key: key);
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final SearchController controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: GradientText(
          'Temparty',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
          colors: const [
            Colors.purpleAccent,
            Colors.deepPurpleAccent,
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.deepPurpleAccent,
            ),
          ),
        ),
      ],
      centerTitle: false,
      curvedBodyRadius: 8,
      headerExpandedHeight: 0.20,
      fullyStretchable: false,
      backgroundColor: Colors.white,
      appBarColor: Colors.white,
      headerWidget: headerWidget(context),
      body: [],
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: Image(
          width: 140,
          image: AssetImage('assets/images/temparty.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
