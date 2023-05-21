import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Hash "mo:base/Hash";
import Int "mo:base/Int";
import Result "mo:base/Result";
import Debug "mo:base/Debug";
import Option "mo:base/Option";
import Buffer "mo:base/Buffer";
import Array "mo:base/Array";
import Order "mo:base/Order";

actor StudentWall {

    public type Content = {
        #Text : Text;
        #Image : Blob;
        #Video : Blob;
    };
    public type Message = {
        vote : Int;
        content : Content;
        creator : Principal;
    };

    var messageId : Nat = 0;
    let wall = HashMap.HashMap<Nat, Message>(1, Nat.equal, Hash.hash);

    public shared (message) func writeMessage(c : Content) : async Nat {
        messageId += 1;
        let newMessage = {
            vote = 0;
            content = c;
            creator = message.caller;
        };

        wall.put(messageId, newMessage);
        return messageId;
    };

    public shared query func getMessage(messageId : Nat) : async Result.Result< Message, Text> {

        var messageIsFound = wall.get(messageId);
        var messageFoundBuffer = Buffer.Buffer<Message>(0);
        if (messageIsFound != null) {

            for ((key, value) in wall.entries()) {
                if (key == messageId) {
                    messageFoundBuffer.add(value);
                };
            };
                    return #ok(messageFoundBuffer.get(0));

        } else {
            return #err("No message found");
        };

    };

    public shared (message) func updateMessage(messageId : Nat, c : Content) : async Result.Result<(), Text> {
        var messageIsFound = wall.get(messageId);

        if (messageIsFound != null) {
            for ((key, value) in wall.entries()) {
                if (key == messageId) {
                    if (value.creator != message.caller) {
                        return #err("Not same Principal");
                    } else {
                        let updatedMessage = {
                            vote = value.vote;
                            content = c;
                            creator = value.creator;
                        };
                        wall.put(messageId, updatedMessage);
                    };
                };
            };
            return #ok;

        } else {
            return #err("No message found");
        };
    };

    public shared func deleteMessage(messageId : Nat) : async Result.Result<(), Text> {

        var messageIsFound = wall.get(messageId);

        if (messageIsFound != null) {
            wall.delete(messageId);
            return #ok;
        } else {
            return #err("No message found");
        };
    };

    public shared func upVote(messageId : Nat) : async Result.Result<(), Text> {

        var messageIsFound = wall.get(messageId);

        if (messageIsFound != null) {

            for ((key, value) in wall.entries()) {
                if (key == messageId) {

                    let updatedMessage = {
                        vote = value.vote + 1;
                        content = value.content;
                        creator = value.creator;
                    };
                    wall.put(messageId, updatedMessage);

                };
            };

            return #ok;
        } else {
            return #err("No message found");
        };
    };

    public shared func downVote(messageId : Nat) : async Result.Result<(), Text> {

        var messageIsFound = wall.get(messageId);

        if (messageIsFound != null) {

            for ((key, value) in wall.entries()) {
                if (key == messageId) {

                    let updatedMessage = {
                        vote = value.vote - 1;
                        content = value.content;
                        creator = value.creator;
                    };
                    wall.put(messageId, updatedMessage);

                };
            };

            return #ok;
        } else {
            return #err("No message found");
        };
    };

    public query func getAllMessages() : async [Message] {
        var messages_buffer = Buffer.Buffer<Message>(0);

        for (value in wall.vals()) {
            messages_buffer.add(value);
        };

        Buffer.toArray(messages_buffer);
    };

    func compareMessages(a : Message, b : Message) : Order.Order {

        if (a.vote < b.vote) {
            return #greater;
        } else if (a.vote == b.vote) {
            return #equal

        } else {
            return #less;
        };
    };

    public query func getAllMessagesRanked() : async [Message] {
        var messages_buffer = Buffer.Buffer<Message>(0);
        for (value in wall.vals()) {
            messages_buffer.add(value);
        };

        var newArray = Buffer.toArray(messages_buffer);
        let sortedArray = Array.sort(newArray, compareMessages);
        return sortedArray;
    };
};
