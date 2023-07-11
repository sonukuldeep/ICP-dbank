# DBANK
*some Lessons do not have related docs here since those lesson involved IC setup or backend, frontend setup etc

A heartly thanks to Angella yu. This repo follows her web development course on udemy.

## Acknowledgements
 - Angella Yu
 - Motoko docs
 - My brain

## Installation
The project requires node js and git.

Clone the website using
```npm
git clone 
```

Instructions
```bash
  cd project-directory
```

Start IC instance on seperate terminal
```bash
dfx start
```

Install packages
```bash
npm i
```

Deploy canister
```bash
dfx deploy
```

Start frontend
```bash
npm start
```

In the browser open

```bash
  http://localhost:8080/
```

## Lesson:- 419
### Key points in this lesson
- var keyword is used to store variables. Ex: `var x = 100;`
- To re-assign something we use:- `x := 200;`
- Note the semi-colon at the end of each command
- let keyword is used to store constants `let y = 14141453645767858`
- Constants cannot be changed
- Debug module is used to output to console example:- `Debug.print('Hello');`
- To print numbers we use:- `Debug.print(debug_show(x));`

## Lesson:- 420
## Key points in this lesson

- Nat stands for natural number.  
- Function are by default private
- call a function from terminal:- dfx canister call &lt;canister name&gt; &lt;function name&gt; [props]
- Or use candid ui.
- Get local ICP server canister id:- dfx canister id __Candid_UI
- get program canister id:- dfx canister id &lt;canister name&gt;

## Lesson:- 421
## Key points in this lesson

- Int stands for integer number.  
- if statement syntax:-
```rust
if(x > 10) {
  Debug.print('hello');
}
```

## Lesson:- 422
## Key points in this lesson

- IC has two types of functions/methods  
- Non-committing query calls (any state change is discarded).
- Committing update calls (state changes are persisted).

Query calls are much faster than update calls since they only retrieve the value unlike update mechanism that need to go through the whole consensus mechanism
Syntax:-
```rust
  public query func checkBalance() : async Nat {
    return 123;
  };
```

| Type | Key points to remember |
| -------------- | -------------- |
| Query calls | Update calls |
| Allow the user to query the current state of a canister or call a function that operates on the canister’s state without changing it. | Allow the user to change the state of the canister and have changes persisted. |
| Are synchronous and answered immediately. | Are answered asynchronously. |
| Can be made to any node that holds the canister; the result does not go through consensus. That is, there is an inherent tradeoff between security and performance: the reply from a single node is fast, but might be untrustworthy or inaccurate. | Must pass through consensus to return the result. Because consensus is required, changing the state of a canister, and returning the result can take time. There is an inherent tradeoff between security and performance: the result is trustworthy because two-thirds of the replicas in a subnet must agree on the result, but the call is slow. |
| Do not allow changes to the state of the canister to be persisted, so essentially query calls are read-only operations. | The called canister can invoke functions exposed by other canisters |
| Do not allow the called canister to invoke functions exposed by other canisters as inter-canister calls. (Note that this restriction is temporary and that canisters will be able to invoke functions exposed by other canisters when processing query calls in the future.) |  |


## Lesson:- 423
## Key points in this lesson
### Orthogonal persistence
The Internet Computer persists the memory and other state of your canister as it executes. Thus the state of a Motoko actor, including its in-memory data structures, survive indefinitely. Actor state does not need to be explicitly "restored" and "saved" to external storage, with every message.

### Upgrades
Motoko provides numerous features to help you leverage orthogonal persistence, including language features that allow you to retain a canister’s data as you upgrade the code of the canister.

For example, Motoko lets you declare certain variables as stable. The values of stable variables are automatically preserved across canister upgrades.
Example: 
```rust
actor Counter {

  stable var value = 0;

  public func inc() : async Nat {
    value += 1;
    return value;
  };
}
```
Because value was declared stable, the current state, n, of the service is retained after the upgrade. Counting will continue from n, not restart from 0.

## Lesson:- 424
## Key points in this lesson
lesson code
```rust
import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  // this is a canister
  //var currentValue = 300; // flexsible variable
  stable var currentValue : Float = 300; // stable variable
  stable var startTime = Time.now();

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
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  };
};
```

## Lesson:- 426
## Code from the lesson
main.mo
```rust
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
```

index.js
```js
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
```

## Badges

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/) 
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](http://www.gnu.org/licenses/agpl-3.0)


## Author
- [@sonukuldeep](https://www.github.com/sonukuldeep)


## 🛠 Skills

[![My Skills](https://skillicons.dev/icons?i=js,ts,html,css,tailwind,sass,nodejs,react,nextjs,svelte,vue,flask,rust,python,php,solidity,mongodb,mysql,prisma,figma,threejs,unity,godot)](https://github.com/sonukuldeep)

please open an issue if you need help 