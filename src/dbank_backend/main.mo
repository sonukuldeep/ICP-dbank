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
    currentValue -= amount;
    Debug.print(debug_show (currentValue));
  }

  // topUp();
};
