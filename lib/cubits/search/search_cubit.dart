import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchCubit extends Cubit<List<DocumentSnapshot>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SearchCubit() : super([]);

  void search(String query) async {
    if (query.isNotEmpty) {
      final snapshot = await _firestore
          .collection('products')
          .where('name', isGreaterThanOrEqualTo: query)
          .get();

      emit(snapshot.docs);
    } else {
      emit([]);
    }
  }
}