import 'package:flutter/material.dart';
import 'package:fluttertask/src/bloc/movie_bloc.dart';
import 'package:fluttertask/src/model/item_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GridView.builder(
                  itemCount: snapshot.data?.results.length,
                  shrinkWrap: true,
                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (9.0 / 17.0)
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 20,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [

                            ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(
                              'https://image.tmdb.org/t/p/w185${snapshot.data
                                  ?.results[index].poster_path}',
                              fit: BoxFit.contain,
                            ),),

                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(snapshot.data?.results[index].original_title.toString() ?? ''),
                            ),

                            Expanded(
                              child: SmoothStarRating(
                                size: 15,
                                starCount: 10,
                                isReadOnly:true,
                                rating:snapshot.data?.results[index].vote_average,
                              ),
                            )

                          ],
                        ),
                      ),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

}