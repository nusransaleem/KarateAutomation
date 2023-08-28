Feature: Everything about your Pets

    Background:
        * url 'https://petstore.swagger.io/v2/'
        
    Scenario: Add a new pet to the store - Specify tags and status
        * def petInfo =
          """
            {
                "id": 111111,
                "category": {
                    "id": 111222,
                    "name": "DOG"
                },
                "name": "doggies",
                "photoUrls": [
                    "string"
                ],
                "tags": [{
                    "id": 112233,
                    "name": "dogaman"
                },
                {
                    "id": 112244,
                    "name": "brown"
                }],
                "status": "available"
            }
          """
       
        Given path "pet"
        And request petInfo 
        When method post
        Then status 200
        * def id = response.id 
        * def category = response.category.name
        * def type = response.tags[0].name
        * def color = response.tags[1].name
        * def status = response.status
        Then match id ==  111111
        Then match category == "DOG"
        Then match type == "dogaman"
        Then match color == "brown"
        Then match status == "available"
        * print 'INFO : ', category,type,color,status

    # Create at least 4 pets with different tags & status
    Scenario: Create at least 4 pets with different tags & status
        * def dogInfo =
        """
        {
            "id": 1111110,
            "category": {
                "id": 222221,
                "name": "DOG"
            },
            "name": "Scooby",
            "photoUrls": [
                "string"
            ],
            "tags": [{
                "id": 333331,
                "name": "Altation"
            },
            {
                "id": 444441,
                "name": "brown"
            }],
            "status": "available"
        }
        """
        Given path "pet"
        And request dogInfo 
        When method post
        Then status 200
        * def id = response.id 
        * def category = response.category.name
        * def type = response.tags[0].name
        * def color = response.tags[1].name
        * def status = response.status
        Then match id ==  1111110
        Then match category == "DOG"
        Then match type == "Altation"
        Then match color == "brown"
        Then match status == "available"
        * print 'INFO : ', category,type,color,status

        * def catInfo =
        """
        {
            "id": 1111112,
            "category": {
                "id": 222222,
                "name": "CAT"
            },
            "name": "Tom",
            "photoUrls": [
                "string"
            ],
            "tags": [{
                "id": 333332,
                "name": "Persian"
            },
            {
                "id": 444442,
                "name": "white"
            }],
            "status": "sold"
        }
        """
        Given path "pet"
        And request catInfo 
        When method post
        Then status 200
        * def id = response.id 
        * def category = response.category.name
        * def type = response.tags[0].name
        * def color = response.tags[1].name
        * def status = response.status
        Then match id ==  1111112
        Then match category == "CAT"
        Then match type == "Persian"
        Then match color == "white"
        Then match status == "sold"
        * print 'INFO : ', category,type,color,status

        * def parrotInfo =
        """
          {
              "id": 1111113,
              "category": {
                  "id": 222223,
                  "name": "Parrot"
              },
              "name": "poly",
              "photoUrls": [
                  "string"
              ],
              "tags": [
              {
                  "id": 444443,
                  "name": "dark green"
              }],
              "status": "pending"
          }
        """
        Given path "pet"
        And request parrotInfo 
        When method post
        Then status 200
        * def id = response.id 
        * def category = response.category.name
        * def color = response.tags[0].name
        * def status = response.status
        Then match id ==  1111113
        Then match category == "Parrot"
        Then match color == "dark green"
        Then match status == "pending"
        * print 'INFO : ', category,color,status


        * def rabbitInfo =
        """
          {
              "id": 1111114,
              "category": {
                  "id": 222225,
                  "name": "RABBIT"
              },
              "name": "rex",
              "photoUrls": [
                  "string"
              ],
              "tags": [
              {
                  "id": 112244,
                  "name": "brown"
              }],
              "status": "available"
          }
        """
        Given path "pet"
        And request rabbitInfo 
        When method post
        Then status 200
        * def id = response.id 
        * def category = response.category.name
        * def color = response.tags[0].name
        * def status = response.status
        Then match id ==  1111114
        Then match category == "RABBIT"
        Then match color == "brown"
        Then match status == "available"
        * print 'INFO : ', category,color,status

    Scenario: Store the id of the new pet in a json file
        * def petId = 
        """
            {"id":1111114}
        """
        * karate.write(petId, "petId.json")
           
    Scenario: Update an existing pet 
        # Update the status available to sold
        # Update color brown to Dark Brown

        * def petUpdateInfo =
          """
            {
                "id": 111111,
                "category": {
                    "id": 111222,
                    "name": "DOG"
                },
                "name": "doggie",
                "photoUrls": [
                    "string"
                ],
                "tags": [{
                    "id": 112233,
                    "name": "dogaman"
                },
                {
                    "id": 112244,
                    "name": "Dark Brown"
                }],
                "status": "sold"
            }
          """
        Given path "pet"
        And request petUpdateInfo 
        When method put
        Then status 200
        * def id = response.id 
        * def category = response.category.name
        * def type = response.tags[0].name
        * def color = response.tags[1].name
        * def status = response.status
        Then match id ==  111111
        Then match category == "DOG"
        Then match type == "dogaman"
        Then match color == "Dark Brown"
        Then match status == "sold"
        * print 'INFO : ', category,type,color,status

    Scenario: Find Pets by status
        * def sleep = function(millis){ java.lang.Thread.sleep(millis) }
        * sleep(5000)
        Given path "pet/findByStatus"
        And param status = "available"
        When method get
        Then status 200
        * def responseString = karate.toString(response)
        Then match responseString contains "111111"
        Then match responseString contains "dogaman"
        Then match responseString contains "DOG"

    Scenario: Find Pets by tags
        * def sleep = function(millis){ java.lang.Thread.sleep(millis) }
        * sleep(1000)
        Given path "pet/findByTags"
        And param tags = "Persian,white"
        When method get
        Then status 200
        * def responseString = karate.toString(response)
        Then match responseString contains "1111112"
        Then match responseString contains "CAT"
        Then match responseString contains "Persian"
        Then match responseString contains "white"