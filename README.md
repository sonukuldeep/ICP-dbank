# dbank

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
- Get local dfinity server canister id:- dfx canister id __Candid_UI
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
