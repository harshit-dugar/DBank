import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

//actor is a keyword in motoko for class
actor DBank{
  stable var currentVal: Float = 100; //stable means persistent it will not be same when we re run 
  currentVal := 100;
  Debug.print(debug_show(currentVal));

  stable var startTime = Time.now();
  startTime := Time.now();
  Debug.print(debug_show(startTime));

  //private function
  public func topUp(amount: Float){ //they are called update methods
    currentVal += amount;
    Debug.print(debug_show(currentVal));
  };
  public func withdraw(amount: Float){
    if(currentVal >= amount){
      currentVal -= amount;
      Debug.print(debug_show(currentVal));
    }else{
      Debug.print("Not enough amonut");
    }
  };
  //update methods are called by the canister and are faster
  public query func checkValue(): async Float{
    return currentVal;
  };

  //topUp(); //calling
  public func compound(){
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentVal := currentVal * (1.01 **Float.fromInt(timeElapsedS));
    startTime := currentTime;
  }
}