public class Dogshow {
    public static void updateAccounts() {
        // Get the 5 oldest accounts
        Account[] accounts = [SELECT Id, Description FROM Account ORDER BY CreatedDate ASC LIMIT 5];

        // Set HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://dog.ceo/api/breeds/image/random');
        req.setMethod('GET');

        // Create a new HTTP object to send the request object
        Http http = new Http();
        HTTPResponse res = http.send(req);

        String body = res.getBody();

        Map<String, String> m = (Map<String, String>) JSON.deserialize(jsonStr, Map<String, String>.class);
        String dogUrl = m.get('message');

        // loop through accounts and update the Description field
        for (Account acct : oldAccounts) {
            acct.Description += ' And their favorite dog can be found at ' + dogUrl;
        }

        // save the change you made
        update accounts;
      }
}
