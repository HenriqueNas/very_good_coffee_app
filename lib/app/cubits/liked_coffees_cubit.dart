import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/app/app.dart';

const kLikedCoffeesKey = 'coffee_list';

class LikedCoffeesCubit extends Cubit<List<CoffeeModel>> {
  LikedCoffeesCubit() : super([]) {
    _loadFromLocalStorage();
  }

  final _localStorage = Dependencies.instance<LocalStorage>();

  @override
  void emit(List<CoffeeModel> state) {
    super.emit(state);
    _saveToLocalStorage();
  }

  void addCoffee(CoffeeModel coffee) {
    assert(
      coffee.rating.isLike,
      'Coffee must be liked to be added',
    );

    final coffeeList = state;
    emit([...coffeeList, coffee]);
  }

  void removeCoffee(CoffeeModel coffee) {
    final coffeeList = state;
    final newCoffeeList = coffeeList.where((c) => c != coffee).toList();
    emit(newCoffeeList);
  }

  void clearCoffeeList() {
    emit([]);
  }

  List<CoffeeModel> get likedCoffees => state;

  void _saveToLocalStorage() {
    final coffeeMapList = state.map((coffee) => coffee.toMap()).toList();
    _localStorage.write(kLikedCoffeesKey, coffeeMapList);
  }

  Future<void> _loadFromLocalStorage() async {
    final coffeeMapList = await _localStorage.read<List<dynamic>>(
      kLikedCoffeesKey,
    );
    final coffeeModels = coffeeMapList?.map((map) {
      return CoffeeModel.fromMap(map as Map<String, dynamic>);
    }).toList();
    super.emit(coffeeModels ?? []);
  }
}
