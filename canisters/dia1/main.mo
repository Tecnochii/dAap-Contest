import Float "mo:base/Float";
import Int "mo:base/Int";

actor Calculator {

  var counter : Float = 0.0;

  public shared func add(x : Float) : async Float {

    if (Float.isNaN(x)) {
      return counter;
    };
    counter += x;
    return counter;
  };

  public shared func sub(x : Float) : async Float {

    if (Float.isNaN(x)) {
      return counter;
    };
    counter -= x;
    return counter;
  };

  public shared func mul(x : Float) : async Float {

    if (Float.isNaN(x)) {
      return counter;
    };
    counter *= x;
    return counter;
  };

  public shared func div(x : Float) : async Float {

    if (Float.isNaN(x) or (x == 0)) {
      return counter;
    };

    counter /= x;
    return counter;
  };

  public shared func reset() : async () {
    counter := 0.0;
  };

  public shared query func see() : async Float {
    return counter;
  };

  public shared func power(x : Float) : async Float {
    if (Float.isNaN(x) or ((x == 0) and (counter == 0))) {
      return counter;
    };
    return Float.pow(counter, x);

  };

  public shared func sqrt() : async Float {
    if (counter == 0) {
      return counter;
    };
    return Float.sqrt(counter);

  };

   public shared func floor() : async Int {
    counter := Float.floor(counter);
    
    return Float.toInt(counter);
  };
  
};
