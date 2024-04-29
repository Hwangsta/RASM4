FOR readInputFile_driver.s, make sure to add newNode function where testing is (putstring) #line53

Update: i believe we will actually need to add the newNode function somewhere EOLINE is #115 to make this work we would want to pass the headptr from the rasm4_driver to readInputFile_driver (x0) and push/pop stack to pass this as a parameter to addNode (FINISHED)

UPDATE: When testing viewLinkedList (traversal and print), we are running into the issue of the linked list not being initiated. Headptr -> nothing
Check addNode.s to see why the list was not initiated. Maybe its an issue with headptr (main) being different from the local variable (addNode) as the local variable has its own address. (FINISHED)

UPDATE: When we implement code for user to enter a string, make sure to pass headptr, tailptr, dbNumNodes, and dbStrBytes into the fxn

COMPLETED option <3> deleting a node based off an index #

CAN USE NUMNODES IN RASM4_DRIVER TO CHECK IF THE INDEX # INPUT BY THE USER (<3>) IS BEYOND THE # OF NODES. CAN THROW AN ERROR MSG AND REPROMPT THE USER
