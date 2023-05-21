import TrieMap "mo:base/TrieMap";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Account "account";

import Result "mo:base/Result";
import Principal "mo:base/Principal";

actor MotoCoin {

    let principalsCanister = actor ("rww3b-zqaaa-aaaam-abioa-cai") : actor {
        getAllStudentsPrincipal : query () -> async [Principal];
    };

    var ledger = TrieMap.TrieMap<Account.Account, Nat>(Account.accountsEqual, Account.accountsHash);

    public shared query func name() : async Text {
        return "MotoCoin";
    };

    public shared query func symbol() : async Text {
        return "MOC";
    };

    public shared query func totalSupply() : async Nat {
        var counter : Nat = 0;

        for (token in ledger.vals()) {
            counter += token;
        };

        return counter;

    };

    public shared query func balanceOf(account : Account.Account) : async Nat {

        for ((acc, token) in ledger.entries()) {
            if (acc == account) {
                return token

            };
        };
        0;
    };

    public shared func transfer(from : Account.Account, to : Account.Account, amount : Nat) : async Result.Result<(), Text> {

        let fromToken = ledger.get(from);
        let toToken = ledger.get(to);

        switch (fromToken) {
            case (null) { return #err "from not found" };
            case (_) {};
        };

        switch (toToken) {
            case (null) { return #err "to not found" };
            case (_) {};
        };

        switch (fromToken) {

            case (?fromTokenR) {
                switch (toToken) {
                    case (?toTokenR) {
                        if (fromTokenR > toTokenR) {
                            ledger.put(from, fromTokenR - amount);
                            ledger.put(to, toTokenR + amount);
                        } else {
                            return #err "Dont have enough amount";
                        };

                    };
                    case (_) {};
                };
            };
            case (_) {};
        };

        #ok

    };

    public shared func airdrop() : async Result.Result<(), Text> {

        var principalsArr = await principalsCanister.getAllStudentsPrincipal();

        for (principal in principalsArr.vals()) {

                let account = {
                    owner= principal;
                    subaccount = null;
                };
                ledger.put(account, 0)
        };

        for ((acc, token) in ledger.entries()) {
            ledger.put(acc, token + 100);
        };

        return #ok;
    };

};
