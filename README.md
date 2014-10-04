# Rspec Quiz

This credit card validator takes a json object, in a separate file, in this form: 
<pre><code>{
  "number" : "4916177577306385", **Can also be spaced (4916 1775 7730 6385) and dashed (4916-1775-7730-6385)
  "name" : "First Last", **Single string
  "expire_month" : "11", **Two digits in a string
  "expire_year" : "2014", **Four digits in a string matched to a future date
  "zip" : "12345", **Five digits in a string
  "CCV" : 678 **3 Digits
}</code></pre>

You call the class with this syntax, passing in the filename as the only argument:<br/>
*valid_cc = CreditCard.new('path/to/file.json')*


# Assignment Requirements:
Use RSpec and TDD (write test first, then code. Small pieces at a time) to write tests and a class to describe a `CreditCard`. 

The `CreditCard` class should have the following attributes:

- Credit card # (16-digits)
- Expiration Date (two digit month, two digit year)
- CCV (3 digit number on the back)
- Name
- Billing Zip Code (5-digits)

It should have the following methods: 

- `initialize` - Used for creating a new credit card. 
- `valid?` - This checks the validity of the credit card. Check that it has a name, proper length zip code, 16-digit number and an expiration date in the future. 

Do *not* check a real credit card number into version control.

## Bonus

- Use a Luhn algorthm to determine if the credit card number is potentially valid
- Write a `card_type` method that will return Visa, MasterCard, Discover, American Express or Other
- Use SimpleCov to determine code coverage %. 
