/**
 * The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
 * It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
 *
 * This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
 * a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
 * records, and manage data volume using the LIMIT keyword.
 *
 * Topics covered in this class include:
 * - Understanding the structure of a SOQL query.
 * - Crafting basic SELECT statements in SOQL.
 * - Applying filters using the WHERE clause in SOQL.
 * - Fetching related records using Relationship queries.
 * - Controlling the amount of data retrieved using the LIMIT keyword.
 *
 * Users of this class can expect to gain a solid understanding of SOQL in Apex and
 * be prepared to handle data retrieval tasks in Salesforce development.
 *
 * @author Habtamu Redie
 */

public with sharing class SOQL {
	/**
	 * Question 1
	 * Update/Uncomment the template code to create a method
	 * Returns all leads from Salesforce Org
	 * @return List of all leads with Id, LastName, Company, Phone, Email
	 * Update the corresponding test class and testGetAllLeads method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//
	
   public static List<Lead> getAllLeads(){
	   List<Lead> leads =  [SELECT Id, LastName, Company, Phone, Email FROM Lead];
	   return leads;
	    
   }


	/**
	 * Question 2
	 * Update/Uncomment the template code to create a method
	 * Returns all contacts with first name of John.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByFirstName method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//

	public static List<Contact> getContactsByFirstName(){
		List<Contact> cons = [SELECT Id, Name, FirstName, LastName FROM Contact WHERE FirstName = 'John'];
		return cons;
	}
	


	/**
	 * Question 3
	 * Update/Uncomment the template code to create a method
	 * Returns the Contact Id for all contacts with last name of Smith or Jones
	 * @return A list of Contact Ids.
	 * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
      public static List<Id> getContactIdsByLastName(){
		  List<Contact> cons = [SELECT Id, LastName FROM Contact WHERE LastName IN ('Smith', 'Jones')];
		  Set<Id> conIds = new Set<Id>();
		  for(Contact con : cons){
			  conIds.add(con.Id);
		  }
		  return new List<Id>(conIds);
	  }
	/**
	 * Question 4
	 * Update/Uncomment the template code to create a method
	 * Returns List of closed won opportunities for a specific Account.
	 * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Opportunities with important opportunities fields
	 * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}

	public static List<Opportunity>getClosedWonOpportunityCountByAccount(Id accountId){
		if(accountId == null){
			return new List<Opportunity>();
		}
		List<Opportunity> closedWonOpps = [SELECT Id, Name, StageName, CloseDate, Amount, AccountId
		                                   FROM Opportunity 
										   WHERE AccountId = :accountId AND StageName= 'Closed Won'];
		return closedWonOpps;
	}
    
	/**
	 * Question 5
	 * Update/Uncomment the template code to create a method
	 * Returns the total count of Account records.
	 * @return The Integer count of Account records.
	 * Update the corresponding test class and testGetAccountCount method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static Integer getAccountCount(){
		AggregateResult[] results = [SELECT COUNT(Id) accountTotal FROM Account];
		Integer accountCount = (Integer)results[0].get('accountTotal');
		return accountCount;
	}

	/**
	 * Question 6
	 * Update/Uncomment the template code to create a method
	 * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
	 * @return A map of Task Ids to Task records.
	 * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}

	public static Map<Id,Task> getTasksDueNextWeek(){
		Map<Id, Task> taskMap = new Map<Id, Task>();
		Date today = Date.today().addDays(7);
		for(Task t : [SELECT Id, Subject, priority, status, ActivityDate FROM Task WHERE ActivityDate <= :today]){
         	taskMap.put(t.Id, t);
		}
	      return taskMap;

	}

	/**
	 * Question 7
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Contacts that have a example.com domain in their Email.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Contact> getContactsByEmailDomain(){
		return [SELECT Id, Name, FirstName, LastName, Email FROM Contact WHERE Email LIKE '%@example.com'];
	}

	/**
	 * Question 8
	 * Retrieves all Opportunities that have a specific keyword in their Name.
	 * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
	 * @param keyword The keyword to search for in the Opportunity Name.
	 * @return A list of Opportunity records.
	 */
	public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
		if(keyword == null || keyword == ''){
			return new List<Opportunity>();
		}
		List<Opportunity> oppList = [SELECT Id, Name, StageName, CloseDate, Amount FROM Opportunity WHERE Name LIKE :('%' + keyword + '%')];
		return oppList; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 9
	 * Retrieves all Cases that Case Origin is not Web or Email or Blank
	 * @return A list of Case records.
	 */
	public static List<Case> getFilterCaseOrigins() {
		List<Case> caseList = [SELECT Id, CaseNumber, Subject, Origin, Status FROM Case WHERE Origin NOT IN ('Web', 'Email') AND Origin != null];
		return caseList; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 10
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
	 * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
	 * @param leadSource The Lead Source to search for.
	 * @param keyword The keyword to search for in the Lead Title.
	 * @return A list of Lead records.
	 * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
   public static List<Lead> getLeadsBySourceOrTitle(String leadSource, String keyword){
    if((String.isBlank(leadSource)) && (String.isBlank(keyword))){
        return new List<Lead>();
    }
    return [
        SELECT Id, LastName, Company, LeadSource, Title, Phone, Email
        FROM Lead
        WHERE LeadSource = :leadSource
           OR Title LIKE :('%' + keyword + '%')
    ];
}

	/**
	 * Question 11
	 * Returns the names of all Contacts associated with an Account.
	 * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Contact LastName.
	 */
	public static List<String> getContactNamesByAccount(Id accountId) {
		if(accountId == null){
			return new List<String>();
		}
		// Create a list to hold the Contact LastNames
        List<String> contactLastNames = new List<String>();
		// Query the Contacts
		List<Contact> contacts = [SELECT LastName FROM Contact WHERE AccountId = :accountId];
		// Loop through each Contact and add the LastName to the list
		//for () {
		//
		//}
		for(Contact con : contacts){
			contactLastNames.add(con.LastName);
		}

		// Return the list of Contact LastNames
		return contactLastNames; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 12
	 * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
	 * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
	 * @param stage The Stage value to filter Opportunities.
	 * @return The total revenue.
	 */
	public static Decimal getTotalRevenueByStage(String stage) {
		if(stage == null){
			return 0;
		}
		// Use AggregateQuery to get the total revenue
       AggregateResult[] results = [SELECT SUM(Amount) totalRevenue FROM Opportunity WHERE StageName = :stage OR Amount > 10000];
		// Return the total revenue
		Decimal totalRevenue = 0;
		if(!results.isEmpty() && results[0].get('totalRevenue') != null){
             totalRevenue = (Decimal)results[0].get('totalRevenue');
		}
		
		return totalRevenue; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 13
	 * Retrieves the first 10 Accounts ordered by Name.
	 * @return A list of the first 10 Accounts ordered by Name.
	 */
	public static List<Account> getFirstTenAccounts() {
		// Query the Accounts
		List<Account> accounts = [SELECT Id, Name FROM Account ORDER BY Name LIMIT 10];
		return accounts; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 14
	 * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 */
	public static List<Opportunity> getHighValueOpportunities() {
		// Query the Opportunities
		List<Opportunity> oppList = [SELECT Id, Name, Amount, CloseDate FROM Opportunity WHERE Amount >100000 ORDER BY CloseDate LIMIT 5];
		return oppList; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 15
	 * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
	 * @return A list of Contacts
	 */
	public static List<Contact> getBirthdateContacts() {
		// Query the Contacts
		List<Contact> conList = [SELECT Id, Name, Birthdate FROM Contact ORDER BY Birthdate DESC LIMIT 3];
		return conList; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 16
	 * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
	 * @return A list of Cases
	 */
	public static List<Case> getCasesWithStatus() {
		// Query the Cases
		List<Case> caseList = [SELECT Id, CaseNumber, Subject, Status, CreatedDate FROM Case WHERE Status = 'Open' ORDER BY CreatedDate LIMIT 10 OFFSET 5];
		return caseList; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 17
	 * Returns Set of Case Ids for a specific Account.
	 * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A set of Case Ids.
	 */
	public static Set<Id> getCaseIdsByAccount(Id accountId) {
		if(accountId == null){
			return new Set<Id>();
		}	
		// Create a set to hold the Case Ids
         Set<Id> caseIds = new Set<Id>();
		// Query the Cases
		
		// Loop through each Case and add the Id to the set
		//for () {
		//
		//}

		for(Case c : [SELECT Id FROM Case WHERE AccountId = :accountId]){
			caseIds.add(c.Id);
		}

		return caseIds; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 18
	 * Return Map of Account Ids to Account Names Not in a specific Country.
	 * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
	 * @param country The country to filter Accounts.
	 * @return A map of Account Ids to Account Names.
	 */
	public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
		if(country == null || country == ''){
			return new Map<Id, String>();
		}
		// Create a map to hold the Account Ids to Account Names
		Map<Id, String> accountIdsToNames = new Map<Id, String>();

		// Query the Accounts
		List<Account> accList = [SELECT Id, Name FROM Account WHERE BillingCountry != :country];
		// Loop through each Account and add the Id and Name to the map
		for(Account acc : accList){
			accountIdsToNames.put(acc.Id, acc.Name);
		}
		return accountIdsToNames; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 19
	 * Retrieves the Account Name for a given Contact.
	 * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
	 * @param contactId The Id of the Contact.
	 * @return The Account Name of the Contact.
	 */
	public static String getAccountNameForContact(String contactId) {
		if(String.isBlank(contactId)){
			return null;
		}
		// Query the Contact
		List<Contact> conList = [SELECT Account.Name FROM Contact WHERE Id = :contactId LIMIT 1];
		if(conList.isEmpty() || conList[0].Account == null){
			return null;
		}
		Contact con = conList[0];
		return con.Account.Name; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 20
	 * Returns single Account that has related opportunities in the same query
	 * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
	 * @param accountId The ID of the Account.
	 * @return An Account record with related Opportunities.
	 */
	public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
		if(String.isBlank(accountId)){
			return null;
		}
		// Query the Account with related Opportunities
		List<Account> accList = [SELECT Id, Name, (SELECT Id, Name, StageName FROM Opportunities) 
		                        FROM Account WHERE Id = :accountId LIMIT 1];
			if(accList.isEmpty()){
				return null;
			}
		return accList[0]; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 21
	 * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
	 * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
	 * @param Account Id
	 * @return List of contacts with the same Mailing State as the Account Billing State
	 */
	public static List<Contact> getAccountsWithContactsByState(Id accountId) {
	        if(accountId == null){
				return new List<Contact>();
			}
		// Query the Account
           Account acc = [SELECT BillingState FROM Account WHERE Id = :accountId LIMIT 1];
		   if(String.isBlank(acc.BillingState)){
			   return new List<Contact>();
		   }
		// Store the Account's BillingState
           String billingState = acc.BillingState;
		// Query the Contacts
		   List<Contact> contactList = [SELECT Id, FirstName, LastName, MailingState FROM Contact WHERE MailingState = :billingState];
		return contactList; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 22
	 * Extracts email domains from them leads, then finds Accounts with matching website domains
	 * If Lead Email = test@test.com return account with website = www.test.com
	 * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
	 * @param A set of Lead Ids.
	 * @return A list of Accounts with matching email domains.
	 */
	public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
		if(leadIds == null || leadIds.isEmpty()){
			return new List<Account>();
		}
		// Query the Leads
		 List<Lead> leadList = [SELECT Email FROM Lead WHERE Id IN :leadIds];

		// Create a set of email domains from the Leads
         Set<String> emailDomains = new Set<String>();

		// Loop through each Lead
          for(Lead l : leadList){
			  if(String.isBlank(l.Email) || !l.Email.contains('@')){
				  continue;
		  }
		 
		// Add the email domain to the set
         String domain = l.Email.substringAfter('@').toLowerCase();
		    emailDomains.add(domain);
	 }

	 if(emailDomains.isEmpty()){
		 return new List<Account>();
	 }	

	 Set<String> emailDomainPatterns = new Set<String>();

        for (String d : emailDomains) {
              emailDomainPatterns.add('%' + d + '%');
          }

		// Query the Accounts
		List<Account> accountList = [SELECT Id, Name, Website FROM Account 
		                            WHERE Website != null AND Website LIKE :emailDomainPatterns];
		return accountList; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 23
	 * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
	 * Adds a randomized number between 1 to 3 to the quantity of each line item.
	 * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
	 * @param Original Opportunity Id
	 * @param List of cloned Opportunity Ids
	 */
	public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
		if(origOppId == null || cloneOppIds == null || cloneOppIds.isEmpty()){
			return;
		}	
		// Query the original Opportunity Line Items
		List<OpportunityLineItem> originalLineItems = [SELECT Id, OpportunityId, PricebookEntryId, Quantity, UnitPrice 
		                                          FROM OpportunityLineItem WHERE OpportunityId = :origOppId];
		// Create a list to hold the new line items
		List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();
		// Generate a random number between 1 and 3
		Integer randomNum = Integer.valueOf(Math.floor(Math.random() * 3) + 1);
		// Loop through each cloned Opportunity Id
		for(Id cloneOppId : cloneOppIds){
			for(OpportunityLineItem origLineItem : originalLineItems){ // Loop through each original line item
				OpportunityLineItem cloneItem = new OpportunityLineItem(
				OpportunityId = cloneOppId,
				PricebookEntryId = origLineItem.PricebookEntryId,
				Quantity = origLineItem.Quantity + randomNum, // Clone the original line item and add the random number to the quantity
				UnitPrice = origLineItem.UnitPrice
				);
				newLineItems.add(cloneItem);
		}
			
		}
		if(!newLineItems.isEmpty()){
			insert newLineItems; // Insert the new line items
		}
		
	}

	/**
	 * Question 24
	 * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
	 * @return A list of filtered Opportunity
	 */
	public static List<Opportunity> getOpportunityDetailsForClosedWon() {
		// Query the Opportunities
		List<Opportunity> oppList = [SELECT Name, Account.Name, Owner.Name 
		                             FROM Opportunity WHERE StageName = 'Closed Won'];
		return oppList; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 25
	 * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to the Contact on the associated Account with the alphabetically first first name.
	 * Example: if there are two Contacts on the Account, "Billy" and "Abby," the 'Primary_Contact__c' will be set to "Abby."
	 */
	public static void setPrimaryContact() {
		//Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
		List<Opportunity> closedWonOpportunities = getOpportunityDetailsForClosedWon();
		if(closedWonOpportunities.isEmpty()){
			return;
		}
		// Create a set of Account Ids from the Opportunities
		Set<Id> accountIds = new Set<Id>();
		for(Opportunity opp : closedWonOpportunities){
			if(opp.AccountId != null){
				accountIds.add(opp.AccountId);
			}
		}
		// Query the Contacts
		Map<Id, Contact> accountToContactMap = new Map<Id, Contact>();
		List<Contact> contacts = [SELECT Id, FirstName, LastName, AccountId 
		                         FROM Contact WHERE AccountId IN :accountIds ORDER BY FirstName ASC];
		// Loop through each Contact and add the Account Id and Contact to the map
		for(Contact con : contacts){
			if(!accountToContactMap.containsKey(con.AccountId)){
				accountToContactMap.put(con.AccountId, con);
			}
		}
		// Loop through each Opportunity
		 // Assign primary contacts to Opportunities
    List<Opportunity> oppsToUpdate = new List<Opportunity>();
    for (Opportunity opp : closedWonOpportunities) {
        if (accountToContactMap.containsKey(opp.AccountId)) {
            opp.Primary_Contact__c = accountToContactMap.get(opp.AccountId).Id;
            oppsToUpdate.add(opp);
        }
    }

    // Update only Opportunities with assigned contact
    if (!oppsToUpdate.isEmpty()) {
        update oppsToUpdate;
    }
	}
}
