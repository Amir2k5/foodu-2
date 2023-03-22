import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Recommends extends StatefulWidget {
  const Recommends({super.key});

  @override
  State<Recommends> createState() => _RecommendsState();
}

class _RecommendsState extends State<Recommends> {
  TextEditingController dish_id = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        title: Text('Recommendations'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Dish Id:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: dish_id,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
