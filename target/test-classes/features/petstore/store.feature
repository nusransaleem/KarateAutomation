Feature:

Background:
    * url 'https://petstore.swagger.io/v2/'

  Scenario: Place an order
      * def oderInfo =
        """
            {
                "id": 1,
                "petId": 111111,
                "quantity": 1,
                "shipDate": "2023-06-07T19:39:45.664Z",
                "status": "placed",
                "complete": true
              }
        """
    
      Given path "store/order"
      And request oderInfo 
      When method post
      Then status 200
      * def id = response.petId
      * def quantity = response.quantity
      * def status = response.status
      Then match id == 111111
      Then match status == "placed"
      Then match quantity == 1