Feature: Operations about user
  
  Background:
    * url 'https://petstore.swagger.io/v2/'

  Scenario: Create User
      * def userInfo =
        """
          {
            "id": 101,
            "username": "nsal",
            "firstName": "Nusran",
            "lastName": "Saleem",
            "email": "nusransaleem@gmail.com",
            "password": "123Qwsc",
            "phone": "0774742051",
            "userStatus": 1
          }
        """
    
      Given path "user"
      And request userInfo 
      When method post
      Then status 200
      * def code = response.code
      * def message = response.message
      Then match code == 200

  