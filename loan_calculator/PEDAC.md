## 1. Understand the Problem ##
---
-  Inputs: loan amount, APR, loan input
-  Outputs: monthly interest rate, loan input in months, monthly payment

### **Problem Domain:**
- How to convert APR to monthly interest rate: https://smallbusiness.chron.com/convert-annual-interest-rate-monthly-rate-1822.html
  Basically, divide the APR by 12

### **Implicit Requirements:**
None

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
```
START

PRINT a welcome prompt

GET loan_amount as a float.
GET APR expressed as a percentage (float), e.g., 6.25.
GET loan_duration_years as an integer.
GET loan_duration_months as an integer.

CALCULATE monthly_interest_rate by dividing APR by the number of compounding terms per year.
  Use a default 12 periods per year for now.
CALCULATE loan_duration_months as (years * 12) + months.
CALCULATE monthly_payment using the provided formula and a design that allows substituting other formulas (hash).

SHOW loan_duration_months and monthly_payment

END
```

## 5. Code - learning experience
Learning experience: by not following the planned logic, I hack-n-slashed in search of a more elegant and robust solution. That took more time than expected. Next time, I'll keep it simple until better functionality is needed.

In this case, I learned more about working with lambdas and RegEx in Ruby while creating a more flexible program.

I can't wait to learn OOP with Ruby! Might use strategy pattern here, but need to master patterns before confidently determining that.

Is this an example of functional programming? According to https://en.wikipedia.org/wiki/Functional_programming, it is impure FP. Neat. But is it the best tool for the job? Need to learn more...
