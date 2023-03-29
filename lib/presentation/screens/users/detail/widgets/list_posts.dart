import 'package:flutter/material.dart';

class ListPostsWidget extends StatefulWidget {
  const ListPostsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ListPostsWidget> createState() => _ListPostsWidgetState();
}

class _ListPostsWidgetState extends State<ListPostsWidget> {
  int? _selectPost;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Colors.grey[200],
      child: _selectPost == null
          ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return _item(index);
              },
            )
          : _detailPost(),
    );
  }

  Widget _item(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectPost = index;
        });
      },
      child: _detailPost(),
    );
  }

  Widget _detailPost() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: const Text(
                  'Titulo de post',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF2e2c3f),
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: _selectPost != null
                    ? () {
                        setState(() {
                          _selectPost = null;
                        });
                      }
                    : null,
                child: Icon(
                  _selectPost != null ? Icons.close : Icons.file_copy,
                  color: Colors.grey,
                  size: 20.0,
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            height: _selectPost != null ? null : 50.0,
            child: Text(
              'Este es el contenido del post',
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
              maxLines: _selectPost != null ? null : 2,
              overflow: _selectPost != null ? null : TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
