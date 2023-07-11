import Debug "mo:base/Debug";

actor DBank {
  // this is a canister
  //var currentValue = 300; // flexsible variable
  stable var currentValue = 300; // stable variable

  Debug.print(debug_show (currentValue));

  public func topUp(amount : Nat): async () {
    currentValue += amount;
    Debug.print(debug_show (currentValue));

  };

  public func withdraw(amount : Nat): async () {
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
