FOR readInputFile_driver.s, make sure to add newNode function where testing is (putstring) #line53

Update: i believe we will actually need to add the newNode function somewhere EOLINE is #115 to make this work we would want to pass the headptr from the rasm4_driver to readInputFile_driver (x0) and push/pop stack to pass this as a parameter to addNode (FINISHED)

UPDATE: When testing viewLinkedList (traversal and print), we are running into the issue of the linked list not being initiated. Headptr -> nothing
Check addNode.s to see why the list was not initiated. Maybe its an issue with headptr (main) being different from the local variable (addNode) as the local variable has its own address.
