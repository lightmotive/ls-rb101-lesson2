## 1. Understand the Problem ##
---
-  Inputs: loan amount, APR, loan input
-  Outputs: monthly interest rate, loan input in months, monthly payment

### **Problem Domain:**
- How to convert APR to monthly interest rate: https://smallbusiness.chron.com/convert-annual-interest-rate-monthly-rate-1822.html
  Basically, divide the APR by 12

### **Implicit Requirements:**
- User must enter a positive number for the loan amount.
- User must enter a value greater than or equal to zero for the interest rate.

### **Clarifying Questions:**
1. Will the user enter the loan input in years, or years and months?
     The example provided has input entered as years and months, so we'll go with that.
2. What is the compound frequency?
     One of the expected outputs is "monthly interest rate," so we'll go with monthly compounding to keep it simple for now. Design to make it easy to add different compounding terms.

### **Mental Model:**
- Ask the user to provide a loan amount, APR expressed as a percentage, and the loan input in years and months.
- Determine the monthly interest rate and potentially other compounding terms (fixed 12 for now).
- Determine loan input in months to calculate the monthly payment.
- Show the user the loan input in months and their monthly payment.

### 2. Examples / Test Cases / Edge Cases
---
- Test 1
  - Inputs: 25000, 6%, 5 years
  - Outputs: .005, 60, 483.32
- Test 2
  - Inputs: 300000, 3%, 15 years
  - Outputs: .0025, 180, 2071.74
- Test 3
  - Inputs: 5000, 0%, 0 years 6 months
  - Outputs: 0, 6, 833.33

## 3. Data Structure
---
Use a hash table for the compounding options, including calculations.
Use a YAML configuration file for messages.

## 4. Algorithm
---

### Sub-procedure: numeric_valid?
```
Given a numeric, require_positive, and require_zero_plus

SET require_positive_valid to true
IF require_positive
  SET require_positive_valid to false
  IF numeric is positive
    SET require_positive_valid to true
  ENDIF
ENDIF

SET require_zero_plus_valid to true
IF require_zero_plus
  SET require_zero_plus_valid to false
  IF numeric is zero or greater
    SET require_zero_plus_valid to true
  ENDIF
ENDIF

IF numeric is valid for all options
  RETURN true
ELSE
  RETURN false
ENDIF
```

### Sub-procedure: numeric_validate
```
Given a numeric, require_positive, and require_zero_plus

SET numeric_is_valid
  CALL numeric_valid? with given parameters

IF numeric_is_valid
  RETURN nil
ELSE
  THROW ValidationError that includes specific error message(s)
ENDIF
```

### Sub-procedure: numeric_prompt
```
Given a prompt message, a numeric conversion function, require_positive (optional), and require_zero_plus (optional)

SHOW prompt message

REPEAT
  BEGIN
    GET input as string
    CONVERT input to numeric
      CALL numeric conversion function with input
    CALL numeric_validate with numeric and require... options
    RETURN numeric
  EXCEPTION
    WHEN ValidationError
      SHOW the specific error message(s) followed by the prompt.
    WHEN any other error
      SHOW friendly error message like "That wasn't a valid number." followed by the prompt.
  END
UNTIL input is a valid numeric value according to conversion function and options
```

### Sub-procedure: loan_duration_input_parse
```
Given any input string

PARSE the digits before the letters 'y' for years and 'm' for months using a regular expression
RETURN years and months as an array
```

### Sub-procedure: loan_duration_prompt
```
SHOW prompt message

REPEAT

  GET input as a string like "5y 6m" or "5y" or "6m"
  SET years and months
    CALL loan_duration_input_parse with input
  RETURN total months: years * 12 + months

UNTIL years and/or months is not zero
```

### Sub-procedure: method.interest_rate_prompt
#### Interface
```
- Output: Big Decimal between 0 and 1
```
#### Monthly Compounding Implementation
```
GET interest rate (APR) as a percentage, e.g., "6.5%" and convert to a number
  CALL numeric_prompt that prompts and returns a Big Decimal
SHOW entered interest rate for user confirmation
RETURN interest rate / 100
```

### Sub-procedure: method.duration_prompt
#### Interface
```
Anything
```
#### Monthly Compounding Implementation
```
CALL loan_duration_prompt
```

### Sub-procedure: method.payment
#### Interface
```
- Input: principal as Big Decimal, interest_rate as Big Decimal, duration as Integer
- Output: Float
```
#### Monthly Compounding Implementation
```
Given principal, interest_rate as an APR, and duration as number of months

IF interest_rate is 0
  RETURN principal / duration
ENDIF

CALCULATE monthly_interest_rate as interest_rate / 12
CALCULATE payment with this formula: principal * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)^-duration))

RETURN payment
```

### Sub-procedure: method.show_result
#### Interface
```
- Input: principal, duration, payment
- Output: PRINT to screen or anything else that shows a result to the user
```
#### Monthly Compounding Implementation
```
Given principal, duration as number of months, and the calculated payment

PRINT number of monthly payments and the payment amount
CALCULATE total_interest as (payment * duration) - principal,
PRINT total interest
```

### Main program
```
START

PRINT a welcome prompt

REPEAT
  GET loan_amount as a Big Decimal
    CALL numeric_prompt with message and require a positive number

  SET method from COMPOUND_METHODS constant
    Can swap different compount method interfaces here in the future

  GET interest_rate expressed as a percentage (Big Decimal), e.g., 6.25
    CALL interest_rate_prompt on method
  GET duration as a number of months (integer)
    CALL duration_prompt on method to
  CALCULATE payment
    CALL payment on method

  SHOW result for selected method
    CALL show_result on method with loan_amount, interest_rate, and duration

  SHOW prompt asking if user wants to continue
  GET another_calculation as text input
UNTIL another_calculation is anything other than a string starting with 'y'

END
```

## 5. Code - learning experience and thoughts
Learning experience: by not following the planned logic, I hack-n-slashed in search of a more elegant and robust solution. That took more time than expected. Next time, I'll keep it simple until better functionality is needed.

In this case, I learned more about working with lambdas and RegEx in Ruby while creating a more flexible program.

I can't wait to learn OOP with Ruby! Might use strategy pattern here, but need to master patterns before confidently determining that.

Is this an example of functional programming? According to https://en.wikipedia.org/wiki/Functional_programming, it is impure FP. Neat. But is it the best tool for the job? Need to learn more...
