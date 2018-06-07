---
external help file: CT.GetNthWeekDay-help.xml
Module Name: CT.GetNthWeekDay
online version:
schema: 2.0.0
---

# Get-NthWeekday

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

```
Get-NthWeekday [[-Ordinal] <String>] [[-WeekDay] <String>] [[-Month] <String>] [[-Year] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

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

## RELATED LINKS
