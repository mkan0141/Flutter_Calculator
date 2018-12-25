class SyntacticAnalysis {
  String _state;
  int _itr = 0;

  void setExpression(String state){
    _state = state + "\$";
  }

  bool isDigit(String s, int idx) {
    return (s.codeUnitAt(idx) ^ 0x30) <= 9;
  }

  double smallNumber(){
    double ret = 0, dgt = 0.1;
    while(isDigit(_state, _itr)){
      ret += (_state.codeUnitAt(_itr) ^ 0x30) * dgt;
      _itr++; dgt *= 0.1;
    }
    return ret;
  }

  double number(){
    double ret = 0;
    while(isDigit(_state, _itr)){
      ret = ret * 10 + (_state.codeUnitAt(_itr) ^ 0x30);
      _itr++;
    }
    
    if(_state.substring(_itr, _itr + 1) == ".") {
      _itr++;
      ret += smallNumber();
    }
    return ret;
  }

  double term(){
    double ret = factor();
    while(true){
      if(_state.substring(_itr, _itr + 1) == "*"){
        _itr++;
        ret *= factor();
      }else if(_state.substring(_itr, _itr + 1) == "/"){
        _itr++;
        ret /= factor();
      }else{
        break;
      }
    }
    return ret;
  }

  double expression(){
    double ret = term();
    while(true){
      if(_state.substring(_itr, _itr + 1) == "+"){
        _itr++;
        ret += term();
      }else if(_state.substring(_itr, _itr + 1) == "-"){
        _itr++;
        ret -= term();
      }else{
        break;
      }
    }
    return ret;
  }

  double factor(){
    double ret = 0;
    if(_state.substring(_itr, _itr + 1) == "("){
      _itr++;
      ret = expression();
      _itr++;
    }else{
      ret = number();
    }
    return ret;
  }
}