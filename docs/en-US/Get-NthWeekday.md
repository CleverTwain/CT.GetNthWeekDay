---
external help file: CT.GetNthWeekDay-help.xml
Module Name: CT.GetNthWeekDay
online version:
schema: 2.0.0
---

# Get-NthWeekday

## SYNOPSIS
Gets the Nth occurrence of the specified week day within the month and year provided.

## SYNTAX

```
Get-NthWeekday [[-Ordinal] <String>] [[-WeekDay] <String>] [[-Month] <String>] [[-Year] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Gets the Nth occurrence of the specified week day within the month and year provided.

Other valid occurrences that can be obtained are:
* Previous - Returns the previous occurrence of the specified week day.
* Current - Returns the next occurrence of the specified week day, including today.
* Next - Returns the next occurrence of the specified week day, excluding today.
* Last - Returns the last occurrence of the specified week day in the month specified.

## EXAMPLES

### Example 1
```powershell
PS C:\>Get-NthWeekday -Ordinal 1 -WeekDay Monday -Month 1 -Year 2016

    Monday, January 4, 2016
```

Find the first Monday in January of 2016


### Example 2
```powershell
PS C:\>Get-NthWeekday -1 Monday 1 2016

    Monday, January 25, 2016
```

This command gets the last Monday in January, 2016

### Example 3
```powershell
PS C:\>Get-NthWeekday -Ordinal Next -Day Friday March 2007

    WARNING: Specific months and/or years are ignored when finding a specific weekday or the next occurrence of a weekday

    Friday, March 16, 2018
```

This command finds next Friday.

NOTE - The current month and year is always used when searching for the Next or Every
        weekday. If they are included in the command, they will be ignored!

### Example 4
```powershell
PS C:\>(Get-NthWeekday -Ordinal 2 -WeekDay Wednesday -Month June -Year 2016).AddDays(-1)

    Tuesday, June 7, 2016
```

This command gets the the Tuesday before the second Wednesday in June 2016

### Example 5
```powershell
PS C:\>Get-NthWeekday -Ordinal 2 -WeekDay Tuesday -Month 6 -Year 2016

    Tuesday, June 14, 2016
```

This command gets the second Tuesday of June 2016

If you compare this to the previous example, you can see that the second Tuesday is actually different than the day before the second Wednesday


## PARAMETERS

### -Month
The month to use when finding the particular date.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: January, February, March, April, May, June, July, August, September, October, November, December, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Ordinal
The ordinal (1st, 2nd, etc.) of the day you would like to get.

```yaml
Type: String
Parameter Sets: (All)
Aliases: OccurrenceNumber, Number
Accepted values: 1st, 2nd, 3rd, 4th, 5th, First, Second, Third, Fourth, Fifth, Previous, Next, Last, Current, 1, 2, 3, 4, 5

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WeekDay
The name of the weekday to check for.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Day
Accepted values: Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, All

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Year
Combined with the month specified when looking for the requested weekday occurrence.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.DateTime

## NOTES

If the specified combination is not found, nothing will be returned

## RELATED LINKS
