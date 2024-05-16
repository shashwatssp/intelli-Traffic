import 'package:flutter/material.dart';
import 'package:intel_traffic/home/screens/live_footage.dart';

class Chauraha {
  final String name;

  Chauraha(this.name);
}

class ChaurahaListPage extends StatelessWidget {
  final List<Chauraha> chaurahas = [
    Chauraha('Subhash Chowk'),
    Chauraha('Bank Road'),
    Chauraha('Gorakhnath'),
    Chauraha('Rustampur'),
    Chauraha('Bhagat Chauraha'),
    Chauraha('Rapti Nagar'),
    Chauraha('Ganesh Chowk'),
    Chauraha('Nehru Chowk'),
    Chauraha('Basharatpur'),
    Chauraha('Rajendra Nagar'),
    Chauraha('Madan Mohan Malviya'),
    Chauraha('Golghar'),
    Chauraha('Ramgarh Tal'),
    Chauraha('Civil Lines'),
    Chauraha('Mohaddipur'),
    Chauraha('Shahpur'),
    Chauraha('Ali Nagar'),
    Chauraha('Sumer Sagar')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chauraha List'),
      ),
      body: ListView.builder(
        itemCount: chaurahas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(chaurahas[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayVideoPage(
                    videoFileName: chaurahas[index].name,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
