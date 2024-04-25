FOR readInputFile_driver.s, make sure to add newNode function where testing is (putstring) #line53

Update: i believe we will actually need to add the newNode function somewhere EOLINE is #115 to make this work we would want to pass the headptr from the rasm4_driver to readInputFile_driver (x0) and push/pop stack to pass this as a parameter to addNode
