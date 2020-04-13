Question 1:

Detail a solution for the following: On the Opportunity object, prevent non-admin users from modifying the Opportunity Name once Probability is greater than 50% and Prevent Opportunity from being deleted if Probability greater than or equal to 75% (Please show code as necessary).

Solution1:

For the first part of this problem, I have created a validation rule (ProbabiltyCheck_NonAdminUsers) inside salesforce on Opportunity object as it is easier to maintain salesforce configuration piece. Please the code of the same below:

"AND($Profile.Name <> 'System Administrator', Probability > 0.50, ISCHANGED(Name))"

For the second half of the problem, I have created a trigger and its helper class, which can be found in: "amazon_challenge/force-app/main/default/"

Please find the components name below:

Trigger:

OpportunityTrigger.trigger

Helper Classes:

OpportunityTriggerHelper.cls
Constants.cls

Test Classes:

OpportunityTriggerTest.cls




Question 2:

Give an example of why you would use a trigger over a workflow or process builder to accomplish an update to a field?

Solution 2:

Usually, Salesforce recommends configurational logic handling or use of out-the-box technologies. But there might be scenarios where a use of trigger might be more useful then any process automation, even in case of update of a field.

  - Triggers provide a much robust solution when the user needs to handle bulk data updates and also provides error handling.
  - Triggers need test classes, which in-turn helps user in creating a code which is ensured to be clean and without errors due to the code coverage and its test 
    classes.
  - Triggers have less CPU times as compared to complex flows and process builders.

  or if there arises a scenario where an already existing trigger needs a logic change, which can be handled by process automation like workflow or process builder, should be avoided as it may run into multiple executions due to the sequence of execution.




Question 3:

Write an Apex method called (leadDuplicateCheck) that will validate if a collection of new leads would create duplicates in the system and returns segregated lists in a map (True: list of non-duplicates & False: list of duplicates). A duplicate lead is defined as same Email, Territory__r.Region__c (text) and Company (text)

Solution 3:

For this problem, I have created a class "DuplicateLeads" which can be found in: "amazon_challenge/force-app/main/default/".

Please find the components name below:

Classes:

DuplicateLeads.cls

Test Classes:

DuplicateLeadsTest.cls