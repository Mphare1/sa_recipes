import 'package:flutter/material.dart';
import 'recipe_data.dart';
import 'recipe.dart';
import 'recipe_detail_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RecipeListScreen extends StatefulWidget {
  static const String routeName = '/recipe-list';
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<Recipe> _recipes = RecipeData().getRecipes();
  int _numAdsDisplayed = 0;

  void _navigateToDetailScreen(BuildContext context, Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetailScreen(),
        settings: RouteSettings(arguments: recipe),
      ),
    );
  }

  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;
  @override
  void initState() {
    super.initState();
    // Initialize the banner ad
    _bannerAd = BannerAd(
      adUnitId:
          'ca-app-pub-9058840129897443/4262676427', // Replace with your ad unit id
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    // Dispose the banner ad when the widget is removed from the tree
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LT Recipe app'),
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (BuildContext context, int index) {
                Recipe recipe = _recipes[index];
                if ((index + 1) % 10 == 0 && _numAdsDisplayed < 3) {
                  _numAdsDisplayed++;
                  return _isBannerAdLoaded
                      ? Container(
                          height: 50.0,
                          child: AdWidget(ad: _bannerAd!),
                        )
                      : SizedBox(height: 50.0); // Placeholder for the ad
                } else {
                  return GestureDetector(
                    onTap: () => _navigateToDetailScreen(context, recipe),
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              recipe.imageUrl,
                              width: double.infinity,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              recipe.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              recipe.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '${recipe.duration.inMinutes} min',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  '${recipe.complexity.toString().split('.').last}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ]));
  }
}
