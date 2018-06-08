# What is CT.GetNthWeekDay

Gets the Nth occurrence of the specified week day within the month and year provided.

## Features

* Accepts multiple types of ordinals
  * 1, 2, 3, 4, 5
  * 1st, 2nd, 3rd, 4th, 5th
  * First, Second, Third, Fourth, Fifth
* Other valid occurrences that can be obtained are:
  * Previous - Returns the previous occurrence of the specified week day.
  * Current - Returns the next occurrence of the specified week day, including today.
  * Next - Returns the next occurrence of the specified week day, excluding today.
  * Last - Returns the last occurrence of the specified week day in the month specified.
* Accepts month names or numbers (January or 1, February or 2, etc.)
* Properly handles rolling over to the next year when necessary

Authored by CleverTwain
