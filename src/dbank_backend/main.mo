import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  // this is a canister
  //var currentValue = 300; // flexsible variable
  stable var currentValue : Float = 300; // stable variable
  stable var startTime = Time.now();

  public func reset() : async () {
    currentValue := 300;
    startTime := Time.now();
  };

  Debug.print(debug_show (currentValue));
  Debug.print(debug_show (startTime));

  public func topUp(amount : Float) : async () {
    currentValue += amount;
    Debug.print(debug_show (currentValue));

  };

  public func withdraw(amount : Float) : async () {
    let tempValue = currentValue - amount;
    if (currentValue >= amount) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    };
  };

  public query func checkBalance() : async Float {
    return currentValue;
  };

  public func compound() : async () {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    if (timeElapsedS < 60) {
      Debug.print("Cannot call compound so frequently. Skipping...")
    } else {
      currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
      startTime := currentTime;
    };
  };
};
