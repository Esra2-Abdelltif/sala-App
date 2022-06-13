abstract class SearchStates
{
  const SearchStates();
}
class InitialSearchStates extends SearchStates{}

class SearchLoadingStates extends SearchStates{}
class SearchSuccessStates extends SearchStates{}
class SearchErrorStates extends SearchStates{
  final String error;
  SearchErrorStates(this.error);
}