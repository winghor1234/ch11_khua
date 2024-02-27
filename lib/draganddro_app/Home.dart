import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String _gestureDetected = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _GestureDetector(),
            Divider(
              color: Colors.black,
              height: 44.0,
            ),
            _Draggable(),
            Divider(
              height: 40.0,
            ),
            _DragTarget(),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
      )),
    );
  }

  GestureDetector _GestureDetector() {
    return GestureDetector(
      onTap: () {
        print('ontap');
        _displayGD('onTap');
      },
      onDoubleTap: () {
        print('doubletap');
        _displayGD('doubletap');
      },
      onLongPress: () {
        print('longpress');
        _displayGD('longpress');
      },
      onPanUpdate: (DragUpdateDetails details) {
        print('onPanUpdate: $details');
        _displayGD('onPanUpdate:\n$details');
      },
      onVerticalDragUpdate: ((DragUpdateDetails details) {
        print('onVerticalDragUpdate: $details');
        _displayGD('onVerticalDragUpdate:\n$details');
      }),
/*       onHorizontalDragUpdate: (DragUpdateDetails details) {
        print('onHorizontalDragUpdate: $details');
        _displayGD('onHorizontalDragUpdate:\n$details');
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        print('onHorizontalDragEnd: $details');
        if (primaryVelocity < 0) {
          print('Dragging Right to Left: ${details.velocity}');
        } else if (primaryVelocity > 0) {
          print('Dragging Left to Right: ${details.velocity}');
        }
      }, */
      child: Column(
        children: [
          Icon(
            Icons.access_alarm,
            size: 98.0,
          ),
          Text('$_gestureDetected')
        ],
      ),
    );
  }

  void _displayGD(String gesture) {
    setState(() {
      _gestureDetected = gesture;
    });
  }

  Draggable<int> _Draggable() {
    return Draggable(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.palette,
            color: Colors.deepOrange,
            size: 48.0,
          ),
          Text(
            'color',
          ),
        ],
      ),
      childWhenDragging: Icon(
        Icons.palette,
        color: Colors.grey,
        size: 48.0,
      ),
      feedback: Icon(
        Icons.brush,
        color: Colors.deepOrange,
        size: 80.0,
      ),
      data: Colors.deepOrange.value,
    );
  }

  DragTarget<int> _DragTarget() {
    return DragTarget<int>(
      onAccept: (colorValue) {},
      builder: (BuildContext context, List<dynamic> acceptedData,
              List<dynamic> rejectedData) =>
          acceptedData.isEmpty
              ? Text(
                  'color',
                  style: TextStyle(color: Colors.deepOrange),
                )
              : Text(
                  'Painting Color: $acceptedData',
                  style: TextStyle(
                    color: Color(acceptedData[0]),
                    fontWeight: FontWeight.bold,
                  ),
                ),
    );
  }
}