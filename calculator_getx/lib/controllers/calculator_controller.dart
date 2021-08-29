import 'package:get/get.dart';

class CalculatorController extends GetxController {

  RxString firstNumber  = '10'.obs;
  RxString secondNumber = '20'.obs;
  RxString mathResult   = '30'.obs;
  RxString operation    = '+'.obs;

  void resetAll(){
    this.firstNumber.value  = '0';
    this.secondNumber.value = '0';
    this.mathResult.value   = '0';
    this.operation.value    = '+';
  }

  void changeNegativePositive(){
    if(this.mathResult.startsWith('-')){
      this.mathResult.value = this.mathResult.value.replaceFirst('-', '');
    }
    else{
      this.mathResult.value = '-' + this.mathResult.value;
    }

  }

  void addNumber(String number){
    if(this.mathResult.value == '0'){
      this.mathResult.value = number;
      return;
    }
    if(this.mathResult.value == '-0'){
      this.mathResult.value = '-' + number;
      return;
    }

    this.mathResult.value = mathResult.value + number;
  }

  void addDecimalPoint(){
    if(this.mathResult.contains('.')) return;

    if(this.mathResult.startsWith('0')){
      this.mathResult.value = '0.';
    }
    else{
      this.mathResult.value = this.mathResult.value + '.';
    }
  }

  void selectOperation(String newOperation){
    this.operation.value = newOperation;
    this.firstNumber.value = this.mathResult.value;
    this.mathResult.value = '0';
  }

  void deleteLastEntry(){
    if(this.mathResult.value.replaceAll('-', '').length > 1){
      this.mathResult.value = this.mathResult.value.substring(0,this.mathResult.value.length - 1);
    }
    else{
      this.mathResult.value = '0';
    }
  }

  calculateResult(){
    double num1 = double.parse(this.firstNumber.value);
    double num2 = double.parse(this.mathResult.value);
    
    this.secondNumber.value = this.mathResult.value;

    switch (this.operation.value) {
      case '+':
        this.mathResult.value = '${num1 + num2}';
      break;
      case '-':
        this.mathResult.value = '${num1 - num2}';
      break;
      case 'X':
        this.mathResult.value = '${num1 * num2}';
      break;
      case '/':
        this.mathResult.value = '${num1 / num2}';
      break;
      default:
      return;
    }

    if(this.mathResult.value.endsWith('.0')){
      this.mathResult.value = this.mathResult.value.substring(0,this.mathResult.value.length - 2);
    }
  }
}