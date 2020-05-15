part of 'model.dart';

class Theater extends Equatable {
  final String name;

  Theater(this.name);

  @override
  List<Object> get props => [name];
}

List<Theater> dummyTheaters = <Theater>[
  Theater('Bellanova Country Mall Cinepolis'),
  Theater('Bogor Square XXI'),
  Theater('Botani Square XXI'),
  Theater('Boxies XXI'),
  Theater('BTM Bogor Trade Mall'),
  Theater('Cibinong City XXI'),
  Theater('Cinere'),
  Theater('Ramayana Tajur XXI'),
  Theater('Transmart Bogor XXI'),
];
