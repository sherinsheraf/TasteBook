// recipe_search_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeSearchService {
  final CollectionReference recipesCollection =
      FirebaseFirestore.instance.collection("TasteBook");

  // Method to search recipes based on user input
  Stream<QuerySnapshot> searchRecipes(String query) {
    if (query.isEmpty) {
      // Return all recipes if the search query is empty
      return recipesCollection.snapshots();
    } else {
      // Fetch recipes where the name field starts with the search query
      return recipesCollection
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .snapshots();
    }
  }
}
