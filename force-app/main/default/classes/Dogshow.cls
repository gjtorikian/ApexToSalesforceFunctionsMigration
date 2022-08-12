public class Dogshow {
    public static void updateAccounts() {
        // Get the 5 oldest accounts
        Account[] accounts = [SELECT Id, Description FROM Account ORDER BY CreatedDate ASC LIMIT 5];

        // Set up the function
        functions.Function dogshowFunction = functions.Function.get('ApexToSalesforceFunctionsMigration.dogshowfunction');

        // Create a list to hold the record data
        List<Map<String, String>> jsonObj = new List<Map<String, String>>();
        for (Account account : accounts) {
            Map<String, Object> obj = new Map<String, Object>();

            obj.put('id', account.Id);
            obj.put('Description', account.Description);

            // Add an object to the record list
            jsonObj.add(obj);
        }
        // Send the record list to the function
        functions.FunctionInvocation invocation = dogshowFunction.invoke(JSON.Serialize(jsonObj));

        // if the function had a return value, it would be available here
        invocation.getResponse();
      }
}
