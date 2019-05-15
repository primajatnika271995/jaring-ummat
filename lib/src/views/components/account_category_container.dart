import 'package:flutter/material.dart';

class AccountCategoryContainer extends StatefulWidget {
  final List<String> categories;

  AccountCategoryContainer({Key key, this.categories});

  @override
  State<StatefulWidget> createState() {
    return AccountCategoryContainerState(categories: this.categories);
  }
}

class AccountCategoryContainerState extends State<AccountCategoryContainer> {
  final List<String> categories;
  String categorySelected = 'semua-kategori';

  AccountCategoryContainerState({this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: buildList(),
      
    );
  }

  List<Widget> buildList() {
    List<Widget> widgets = [
      // buttonSearch(),
    ];
    this.categories.forEach((item) => {
      widgets.add(textCategory(item))
    });

    return widgets;
  }

  Widget buttonSearch() {
     return RawMaterialButton(
       
      onPressed: () {},
      
      child: Icon(
        Icons.search,
        color: Colors.white
      ),
      shape: CircleBorder(),
      
      elevation: 2.0,
      fillColor: Color.fromRGBO(255, 221, 73, 1.0),
      padding: EdgeInsets.all(3.0),
      
    );
        
  }

  void setCategorySelected(String name) {
    setState(() {
      categorySelected = name;
    });
  }
  
  Widget textCategory(String name) {
    String categoryNameSelected = name.toLowerCase().replaceAll(' ', '-');
    bool isSelected = categoryNameSelected == categorySelected;
    
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name,
              style: TextStyle(
                // decoration: (isSelected) ? TextDecoration.underline : TextDecoration.none,
                color: (isSelected) ? Colors.black : Colors.grey,
                fontWeight: (isSelected) ? FontWeight.bold : FontWeight.normal
              ),
            ),
          ],
        )
      ),
      onTap: () {
        setCategorySelected(name.toLowerCase().replaceAll(' ', '-'));
      },
    );
  }

}