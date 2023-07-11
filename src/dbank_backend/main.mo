import Debug "mo:base/Debug";

actor DBank {
  // this is a canister
  var currentValue = 300;
  currentValue := 100;

  Debug.print(debug_show (currentValue));

  public func topUp(amount : Nat) {
    currentValue += amount;
    Debug.print(debug_show (currentValue));

  };

  public func withdraw(amount : Nat) {
    let tempValue : Int = currentValue - amount;
    if (currentValue >= amount) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    };
  };

  public query func checkBalance() : async Nat {
    return currentValue;
  };
};
