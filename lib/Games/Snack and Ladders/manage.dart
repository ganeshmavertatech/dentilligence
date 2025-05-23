// import 'package:dentilligence/Games/Snack%20and%20Ladders/SnakesAndLaddersModel.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ManageSnakesLaddersScreen extends StatefulWidget {
//   @override
//   _ManageSnakesLaddersScreenState createState() =>
//       _ManageSnakesLaddersScreenState();
// }

// class _ManageSnakesLaddersScreenState extends State<ManageSnakesLaddersScreen> {
//   final TextEditingController _startController = TextEditingController();
//   final TextEditingController _endController = TextEditingController();
//   final TextEditingController _snakeImageController = TextEditingController();
//   final TextEditingController _ladderImageController = TextEditingController();
//   bool _isSnake = true;

//   @override
//   void initState() {
//     super.initState();
//     final model = Provider.of<SnakesAndLaddersModel>(context, listen: false);
//     _snakeImageController.text = model.snakeImage;
//     _ladderImageController.text = model.ladderImage;
//   }

//   void _addOrUpdateSnakeLadder(SnakesAndLaddersModel model) {
//     int start = int.parse(_startController.text);
//     int end = int.parse(_endController.text);
//     model.addOrUpdateSnakeLadder(_isSnake, start, end);
//     _startController.clear();
//     _endController.clear();
//   }

//   void _updateImages(SnakesAndLaddersModel model) {
//     model.updateImages(
//       _snakeImageController.text,
//       _ladderImageController.text,
//     );
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Images updated successfully')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Manage Snakes and Ladders'),
//       ),
//       body: Consumer<SnakesAndLaddersModel>(
//         builder: (context, model, child) {
//           return SingleChildScrollView(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 // Image Preview Section
//                 Card(
//                   child: Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Current Images',
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Column(
//                               children: [
//                                 Text('Snake'),
//                                 Image.network(
//                                   model.snakeImage,
//                                   width: 50,
//                                   height: 50,
//                                   errorBuilder: (context, error, stackTrace) => 
//                                     Icon(Icons.error, size: 50),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 Text('Ladder'),
//                                 Image.network(
//                                   model.ladderImage,
//                                   width: 50,
//                                   height: 50,
//                                   errorBuilder: (context, error, stackTrace) => 
//                                     Icon(Icons.error, size: 50),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
                
//                 SizedBox(height: 20),
                
//                 // Image URL Input Section
//                 Card(
//                   child: Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Update Images',
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         TextField(
//                           controller: _snakeImageController,
//                           decoration: InputDecoration(labelText: 'Snake Image URL'),
//                         ),
//                         TextField(
//                           controller: _ladderImageController,
//                           decoration: InputDecoration(labelText: 'Ladder Image URL'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () => _updateImages(model),
//                           child: Text('Update Images'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
                
//                 SizedBox(height: 20),
                
//                 // Snake/Ladder Management Section
//                 Card(
//                   child: Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('Snake'),
//                             Switch(
//                               value: !_isSnake,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _isSnake = !value;
//                                 });
//                               },
//                             ),
//                             Text('Ladder'),
//                           ],
//                         ),
//                         TextField(
//                           controller: _startController,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(labelText: 'Start Position'),
//                         ),
//                         TextField(
//                           controller: _endController,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(labelText: 'End Position'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () => _addOrUpdateSnakeLadder(model),
//                           child: Text('Add/Update'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
                
//                 SizedBox(height: 20),
                
//                 // List of Current Snakes/Ladders
//                 Text(
//                   _isSnake ? 'Current Snakes' : 'Current Ladders',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 200,
//                   child: ListView.builder(
//                     itemCount: _isSnake ? model.snakes.length : model.ladders.length,
//                     itemBuilder: (context, index) {
//                       final snakeOrLadder = _isSnake ? model.snakes : model.ladders;
//                       final key = snakeOrLadder.keys.elementAt(index);
//                       final value = snakeOrLadder[key]!;
//                       return ListTile(
//                         title: Text('$key -> $value'),
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () {
//                             model.deleteSnakeLadder(_isSnake, key);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
                
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text('Done'),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }