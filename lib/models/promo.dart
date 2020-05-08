part of 'model.dart';

class Promo extends Equatable {
  final String title;
  final String description;
  final int discount;

  Promo({
    @required this.title,
    @required this.description,
    @required this.discount,
  });

  @override
  List<Object> get props => [title, description, discount];
}

List<Promo> dummyPromos = <Promo>[
  Promo(
    title: 'Student Holiday',
    description: 'Limited only 2 people',
    discount: 50,
  ),
  Promo(
    title: 'Family Club',
    description: 'Limited only 2 people',
    discount: 50,
  ),
  Promo(
    title: 'Student Holiday',
    description: 'Limited only 2 people',
    discount: 50,
  ),
];
