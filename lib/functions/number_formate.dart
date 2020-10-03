number_formate(var num) {
  int number = int.parse(num);
  if (number > 999) {
    if (number > 99999) {
      int val = (number/100000).round();
       return '${val}M';
    }else{
 int val = (number/1000).round();
  
    return '${val}K';
    }
  } else {
    return number.toString();
  }
}
