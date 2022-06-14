class FilterModel<T>{
  final String campo;
  final T valor;

  FilterModel(this.campo, this.valor);

}


// new FilterModel<number>('edad',15);
// new FilterModel<string>('especialiadad','Cardiologia')