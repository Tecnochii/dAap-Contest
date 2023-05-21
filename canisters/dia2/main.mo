import Result "mo:base/Result";
import Time "mo:base/Time";
import Buffer "mo:base/Buffer";
import Debug "mo:base/Debug";
actor HomeworkDiary {

    public type Time = Time.Time;
    public type Homework = {
        title : Text;
        description : Text;
        dueDate : Time;
        completed : Bool;
    };

    var homeworkDiary = Buffer.Buffer<Homework>(0);

    public shared func addHomework(homework : Homework) : async Nat {
        homeworkDiary.add(homework);
        
        return homeworkDiary.size()-1;
    };

    public shared query func getHomework(id : Nat) : async Result.Result<Homework, Text> {
        var homeworkIsFound = homeworkDiary.getOpt(id);
        if (homeworkIsFound != null) {
            return #ok(homeworkDiary.get(id));
        } else {
            return #err("Homework not found");
        };
    };

    public shared func updateHomework(id : Nat, homework : Homework) : async Result.Result<(), Text> {
        var homeworkIsFound = homeworkDiary.getOpt(id);

        if (homeworkIsFound != null) {
            var homeworkUpdated = homeworkDiary.put(id, homework);

            Debug.print(debug_show (homeworkUpdated));
            #ok;
        } else {
            return #err("Homework not found");
        };
    };

    public shared func markAsCompleted(id : Nat) : async Result.Result<(), Text> {

        var homeworkIsFound = homeworkDiary.getOpt(id);

        if (homeworkIsFound != null) {
            var homeworkFound = homeworkDiary.get(id);
            let homeworkUpdated = {
                title = homeworkFound.title;
                description = homeworkFound.description;
                dueDate = homeworkFound.dueDate;
                completed = true;
            };

            homeworkDiary.put(id, homeworkUpdated);

            #ok;
        } else {
            return #err("Homework not found");
        };
    };

    public shared func deleteHomework(id : Nat) : async Result.Result<(), Text> {
        var homeworkIsFound = homeworkDiary.getOpt(id);

        if (homeworkIsFound != null) {
           ignore homeworkDiary.remove(id);
            #ok;
        }else {
            return #err("Homework not found");
        };
    };

    public shared query func getAllHomework() : async [Homework]{
       Buffer.toArray(homeworkDiary);
    };

     public shared query func getPendingHomework() : async [Homework]{
        var homeworkDiaryClone = Buffer.clone(homeworkDiary);
        homeworkDiaryClone.filterEntries(func(_, x) = x.completed == true);

        return Buffer.toArray(homeworkDiaryClone)
    };

     public shared query func searchHomework(searchTerm: Text) : async [Homework]{

         var homeworkDiaryClone = Buffer.clone(homeworkDiary);
        homeworkDiaryClone.filterEntries(func(_, x) = x.description == searchTerm or x.title == searchTerm);

        return Buffer.toArray(homeworkDiaryClone)
     };
    
};
