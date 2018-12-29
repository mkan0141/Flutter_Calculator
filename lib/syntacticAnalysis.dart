class SyntacticAnalysis {
  String _state;
  int _itr = 0;
  bool _is_divide_zero = false;

  void setExpression(String state){
    _state = stateShaping(state) + "\$";
    _itr = 0;
    _is_divide_zero = false;
    print(_state);
  }

  String stateShaping(String state){
    return state.replaceAll("÷", "/")
                .replaceAll('×', '*')
                .replaceAll('+', '+')
                .replaceAll('−', '-');
  }

  bool isDigit(String s, int idx) {
    return (s.codeUnitAt(idx) ^ 0x30) <= 9;
  }

  bool is_divide_zero(){
    return _is_divide_zero;
  }

  double check_zero(double number){
    if(number == 0) {
      _is_divide_zero = true;
      return 1;
    }else{
      return number;
    }
  }

  double parsent(ret){
    while(_state.substring(_itr, _itr + 1) == "%"){
      _itr++;
      ret /= 100;
    }
    return ret;
  }
  double smallNumber(){
    if(_state.substring(_itr, _itr + 1) != ".") return 0.0;
    _itr++;

    double ret = 0.0, dgt = 0.1;
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
    
    ret += smallNumber();
    ret = parsent(ret);
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
        ret /= check_zero(factor());
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
    print("ret: " + ret.toString());
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

void main(){
  SyntacticAnalysis sa = new SyntacticAnalysis();
  sa.setExpression("78*6");
  print(sa.expression());
}