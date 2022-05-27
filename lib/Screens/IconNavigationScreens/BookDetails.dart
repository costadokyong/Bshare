import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatefulWidget {
  var booksInfo = [];
  BookDetails({Key? key, required this.booksInfo}) : super(key: key);

  @override
  State<BookDetails> createState() => BookDetailsState(booksInfo: booksInfo);
}

class BookDetailsState extends State<BookDetails> {
  var booksInfo = [];

  BookDetailsState({required this.booksInfo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(booksInfo[1]),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(booksInfo[0]),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const CircleAvatar(
                      backgroundImage: (AssetImage('images/avatar.png')),
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          booksInfo[6],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Text(
                          booksInfo[5],
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                indent: 20.0,
                endIndent: 20.0,
                height: 5.0,
                thickness: 1.0,
                color: Colors.blue,
              ),
              Row(children: [
                const SizedBox(
                  width: 20,
                ),
                const Icon(Icons.description, size: 30, color: Colors.blue),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    booksInfo[3],
                    softWrap: true,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ]),
              const Divider(
                indent: 20.0,
                endIndent: 20.0,
                height: 5.0,
                thickness: 1.0,
                color: Colors.blue,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(Icons.price_change_rounded,
                      size: 30, color: Colors.blue),
                  const SizedBox(
                    width: 10,
                  ),
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      booksInfo[2].toString() + '₩',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                indent: 20.0,
                endIndent: 20.0,
                height: 5.0,
                thickness: 1.0,
                color: Colors.blue,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.school,
                    size: 30,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      booksInfo[4],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
          Positioned(
            bottom: 4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 56),
                      minimumSize: const Size(100, 50),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
