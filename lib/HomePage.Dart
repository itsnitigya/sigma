import 'package:flutter/material.dart';
import 'Networking.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _filter = new TextEditingController();
  final makecall = new MakeCall();

  String searchString = "";

  _MyHomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          searchString = "";
        });
      } else {
        setState(() {
          searchString = _filter.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: makecall.getCall(this.searchString), // async work
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start');
          case ConnectionState.waiting:
            return SimpleDialog(
                backgroundColor: Colors.black54,
                children: <Widget>[
                  Center(
                    child: Column(children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Please Wait....",
                        style: TextStyle(color: Colors.blueAccent),
                      )
                    ]),
                  )
                ]);
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return snapshot.data.length == 0
                  ? Center(
                      child: Text(
                        'Page is Empty!',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              top: 20.0, bottom: 0.0, left: 5.0, right: 5.0),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  //color: Colors.black,
                                  color: Colors.white,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                )
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Card(
                            //elevation: 2.0,
                            //color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: SizedBox(
                                height: 220,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  //color: Colors.blue,
                                  elevation: 0.0,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, left: 10),
                                          child: RaisedButton(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                side: BorderSide(
                                                    color: Colors.grey)),
                                            color: Colors.white,
                                            onPressed: () {},
                                            child: Text(
                                              '${snapshot.data[index].title}'
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        snapshot.data[index].meta != null
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8,
                                                  left: 10,
                                                ),
                                                child: Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth: 350),
                                                    child: Text(
                                                      '${snapshot.data[index].meta}',
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 15.0),
                                                    )),
                                              )
                                            : Container(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            left: 10,
                                          ),
                                          child: Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 350),
                                              child: Text(
                                                '${snapshot.data[index].description}',
                                                maxLines: 4,
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 15.0),
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, left: 10),
                                          child: Text(
                                            'Spaces',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: new TextField(
          controller: _filter,
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search),
            hintText: 'Search...',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _filter.clear();
                },
                child: Icon(Icons.close),
              )),
        ],
      ),
      body: SafeArea(
        child: Column(children: [
          new Expanded(
              child: Padding(
            padding: EdgeInsets.all(12),
            child: Container(child: futureBuilder //ListView,,
                ),
          )),
        ]),
      ),
    );
  }
}
