# frozen_string_literal: true

# 1. Understand the Problem
# -------------------------
# -  Inputs: loan amount, APR, loan duration
# -  Outputs: monthly interest rate, loan duration in months, monthly payment

# **Problem Domain:**
# - How to convert APR to monthly interest rate: https://smallbusiness.chron.com/convert-annual-interest-rate-monthly-rate-1822.html
#   Basically, divide the APR by 12

# **Implicit Requirements:**
# None

# **Clarifying Questions:**
# 1. Will the user enter the loan duration in years, or years and months?
#      The example provided has input entered as years and months, so we'll go with that.
# 2. What is the compound frequency?
#      One of the expected outputs is "monthly interest rate," so we'll go with monthly compounding
#      to keep it simple for now. Design to make it easy to add different compounding terms.

# **Mental Model:**
# - Ask the user to provide a loan amount, APR expressed as a percentage, and the loan duration in years and months.
# - Determine the monthly interest rate and potentially other compounding terms (fixed 12 for now).
# - Determine loan duration in months to calculate the monthly payment.
# - Show the user the loan duration in months and their monthly payment.

# 2. Examples / Test Cases / Edge Cases
# -------------------------------------
# - Test 1
#   - Inputs: 25000, 6%, 5 years
#   - Outputs: .005, 60, 483.32
# - Test 2
#   - Inputs: 300000, 3%, 15 years
#   - Outputs: .0025, 180, 2071.74
# - Test 3
#   - Inputs: 5000, 0%, 0 years 6 months
#   - Outputs: 0, 6, 833.33

# 3. Data Structure
# -----------------
# Use a hash table for the compounding options, including calculations.
# Use a YAML configuration file for messages.

# 4. Algorithm
# ------------
# START
#
# PRINT a welcome message
#
# GET loan_amount as an integer
# GET APR expressed as a percentage, e.g., 6.25.
# GET loan_duration_years
# GET loan_duration_months
#
# CALCULATE period_interest_rate by dividing APR by the number of compounding terms per year.
#   Use a default 12 periods per year for now.
# CALCULATE loan_duration_months as (years * 12) + months.
# CALCULATE monthly_payment using the provided formula and a design that allows substituting other formulas.
#
# SHOW loan_duration_months and monthly_payment
#
# END

# 5. Code
# -------
