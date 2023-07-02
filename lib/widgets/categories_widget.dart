import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wafi/config/constanst.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:wafi/services/categories.dart';
import 'package:wafi/services/home.dart';
import 'package:wafi/widgets/navigation_bar.dart';
import 'package:wafi/widgets/snack_bar.dart';

Logger logger = Logger();

class CategoriesWidget extends StatefulWidget {
  final Function setStateCategoryCallback;
  final String categoryValue;
  const CategoriesWidget(this.setStateCategoryCallback, this.categoryValue,
      {super.key});

  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<CategoriesWidget> {
  List categories = [];
  List auxCategories = [];
  bool hasError = false;
  bool isLoading = false;
  bool showCreateAndAssingButtom = false;

  final TextEditingController _searchInputController = TextEditingController();
  _getCategories({int attemp = 1}) {
    logger.d("attemp $attemp");
    setState(() {
      hasError = false;
      isLoading = true;
    });
    getCategoriest().then((value) {
      setState(() {
        categories = value;
        auxCategories = value;
        isLoading = false;
      });
      logger.d("ready categories");
    }).catchError((err) {
      logger.e(err.toString());
      if (attemp != maxAttemps) {
        return _getCategories(attemp: attemp + 1);
      }
      setState(() {
        hasError = true;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    logger.d("getting cat");
    _getCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField(builder: (formContext) {
      return TextFormField(
          onTap: () async {
            if (formContext.mounted) {
              logger.d("inside dialog");
              showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: Colors.white,
                      child: Scaffold(
                        appBar: appBarWidget(context, lang("Categories")),
                        body: Container(
                          color: Colors.white,
                          margin: marginAll,
                          child: Wrap(
                            children: [
                              TextField(
                                autofocus: true,
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      showCreateAndAssingButtom = false;
                                      auxCategories = categories;
                                    });
                                    return;
                                  }
                                  List filter = auxCategories
                                      .where((element) => element?['label']
                                          ?.contains(value.toUpperCase()))
                                      .toList();
                                  if (filter.isNotEmpty) {
                                    setState(() {
                                      auxCategories = filter;
                                    });
                                  } else {
                                    setState(() {
                                      showCreateAndAssingButtom = true;
                                    });
                                  }
                                },
                                controller: _searchInputController,
                                decoration: InputDecoration(
                                    labelText: "${lang("Search")}...",
                                    suffixIcon: const Icon(Icons.search)),
                              ),
                              if (showCreateAndAssingButtom == true)
                                TextButton(
                                    onPressed: () async {
                                      try {
                                        Map category = await CategoryService
                                            .createCategory(
                                                _searchInputController.text,
                                                getSystemLang());
                                        widget
                                            .setStateCategoryCallback(category);
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                      } catch (e) {
                                        SnackBarMessage(context, e.toString());
                                      }
                                    },
                                    child: Text(
                                        lang("Create and assign category")))
                              else
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.1,
                                  child: ListView(
                                    children: auxCategories
                                        .map((e) => TextButton(
                                            onPressed: () {
                                              widget
                                                  .setStateCategoryCallback(e);
                                              Navigator.pop(context);
                                            },
                                            child: Text(e['label'])))
                                        .toList(),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
          readOnly: true,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: widget.categoryValue,
              prefixIcon: const Icon(Icons.category),
              border: const OutlineInputBorder(borderRadius: borderRadiusAll),
              label: Text(lang("Category"))));
    });
  }
}
