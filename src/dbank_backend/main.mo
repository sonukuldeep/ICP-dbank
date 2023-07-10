import Debug "mo:base/Debug";

actor DBank {
  // this is a canister
  var currentValue = 300;
  currentValue := 100;

  Debug.print(debug_show (currentValue));
};
