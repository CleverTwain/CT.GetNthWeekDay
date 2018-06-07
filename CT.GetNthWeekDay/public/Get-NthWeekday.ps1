function Get-NthWeekday
{
    <#
.SYNOPSIS
    Gets the Nth occurrence of the specified week day within the month and year provided.

.DESCRIPTION
    Gets the Nth occurrence of the specified week day within the month and year provided.
    Other valid occurrences that can be obtained are:
        Previous - Returns the previous occurrence of the specified week day.
        Current - Returns the next occurrence of the specified week day, including today.
        Next - Returns the next occurrence of the specified week day, excluding today.
        Last - Returns the last occurrence of the specified week day in the month specified.

.PARAMETER Ordinal
    The ordinal of the day you would like to get.
    Accepts 1st, 2nd, 3rd, 4th, 5th, Previous, Current, Next, and Last in the following formats
        Words (First, Second, etc.)
        Numbers (1, 2, 3, etc.)
        Numerical Ordinals (1st, 2nd, 3rd, etc.)

.PARAMETER WeekDay
    The name of the weekday to check for. (Monday, Tuesday, etc.)

.PARAMETER Month
    The month that should be used when searching for the specified weekday.
    Accepts numbers and names (e.g. 1 or January)

.PARAMETER Year
    The year that should be used when searching for the specified weekday.

.EXAMPLE Find the first Monday in January of 2016
    PS C:\>Get-NthWeekday -Ordinal 1 -WeekDay Monday -Month 1 -Year 2016

        Monday, January 4, 2016

    This command gets the first Monday in January, 2016

.EXAMPLE Find the last Monday in January of 2016
    PS C:\>Get-NthWeekday -1 Monday 1 2016

        Monday, January 25, 2016

    This command gets the last Monday in January, 2016

.EXAMPLE Find next Friday in March of 2007
    PS C:\>Get-NthWeekday -Ordinal Next -Day Friday March 2007

        WARNING: Specific months and/or years are ignored when finding a specific weekday or the next occurrence of a weekday

        Friday, March 16, 2018

    This command finds next Friday.
    NOTE - The current month and year is always used when searching for the Next or Every
        weekday. If they are included in the command, they will be ignored!

.EXAMPLE
    PS C:\>(Get-NthWeekday -Ordinal 2 -WeekDay Wednesday -Month June -Year 2016).AddDays(-1)

        Tuesday, June 7, 2016

    This command gets the the Tuesday before the second Wednesday in June 2016

.EXAMPLE
    PS C:\>Get-NthWeekday -Ordinal 2 -WeekDay Tuesday -Month 6 -Year 2016

        Tuesday, June 14, 2016

    This command gets the second Tuesday of June 2016
    If you compare this to the previous example, you can see that the second Tuesday is actually
    different than the day before the second Wednesday

.NOTES
    If the specified combination is not found, nothing will be returned
#>
    [CmdletBinding(
    )]
    [Alias()]
    [OutputType([datetime])]
    Param
    (
        [Parameter(
            HelpMessage = 'The ordinal (1st, 2nd, etc.) of the day you would like to get.'
        )]
        [ValidateSet("1st", "2nd", "3rd", "4th", "5th", "First", "Second", "Third", "Fourth", "Fifth", "Previous", "Next", "Last", "Current", "1", "2", "3", "4", "5")]
        [Alias('OccurrenceNumber', 'Number')]
        [string]
        $Ordinal = 'Current',

        [Parameter(
            HelpMessage = 'The name of the weekday to check for.'
        )]
        [ValidateSet("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "All")]
        [Alias('Day')]
        [string]
        $WeekDay = (Get-Date).DayOfWeek,

        [Parameter(
            HelpMessage = 'The month to use when finding the particular date.'
        )]
        [ValidateSet("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12")]
        [string]
        $Month,

        [Parameter(
            HelpMessage = 'Combined with the month specified when looking for the requested weekday occurrence.'
        )]
        [ValidateRange(0, 9999)]
        [int]
        $Year
    )

    Begin
    {

        $AllDaysInMonth = @()
        $AllOccurrences = @()
        $Return = $null

        if ($WeekDay -eq 'All')
        {
            $WeekDay = (Get-Date).DayOfWeek
        }

        if ($Ordinal -in ('Previous', 'Next', 'Current') -and ($Month -or $Year))
        {
            Write-Warning -Message "Specific months and/or years are ignored when finding the 'Previous', 'Next', or 'Current' WeekDay"
            $Month = (Get-Date).Month
            $Year = (Get-Date).Year
        }

        Switch ($Ordinal)
        {
            {$_ -eq 1 -or $_ -eq '1st' -or $_ -eq 'First'}
            {
                Write-Debug "Ordinal is 1 or 1st or First"
                $Ordinal = 'first'
                $OccurrenceNumber = 1
            }
            {$_ -eq 2 -or $_ -eq '2nd' -or $_ -eq 'Second'}
            {
                Write-Debug "Ordinal is 2 or 2nd or Second"
                $Ordinal = 'second'
                $OccurrenceNumber = 2
            }
            {$_ -eq 3 -or $_ -eq '3rd' -or $_ -eq 'Third'}
            {
                Write-Debug "Ordinal is 3 or 3rd or Third"
                $Ordinal = 'third'
                $OccurrenceNumber = 3
            }
            {$_ -eq 4 -or $_ -eq '4th' -or $_ -eq 'Fourth'}
            {
                Write-Debug "Ordinal is 4 or 4th or Four"
                $Ordinal = 'fourth'
                $OccurrenceNumber = 4
            }
            {$_ -eq 5 -or $_ -eq '5th' -or $_ -eq 'Fifth'}
            {
                Write-Debug "Ordinal is 5 or 5th or Fifth"
                $Ordinal = 'fifth'
                $OccurrenceNumber = 5
            }
            'Last'
            {
                Write-Debug "Ordinal is Last"
                $OccurrenceNumber = -1
            }
        }

        Switch ($Month)
        {
            {$_ -eq 1 -or $_ -eq 'January'}
            {
                $MonthName = 'January'
                $Month = 1
            }
            {$_ -eq 2 -or $_ -eq 'February'}
            {
                $MonthName = 'February'
                $Month = 2
            }
            {$_ -eq 3 -or $_ -eq 'March'}
            {
                $MonthName = 'March'
                $Month = 3
            }
            {$_ -eq 4 -or $_ -eq 'April'}
            {
                $MonthName = 'April'
                $Month = 4
            }
            {$_ -eq 5 -or $_ -eq 'May'}
            {
                $MonthName = 'May'
                $Month = 5
            }
            {$_ -eq 6 -or $_ -eq 'June'}
            {
                $MonthName = 'June'
                $Month = 6
            }
            {$_ -eq 7 -or $_ -eq 'July'}
            {
                $MonthName = 'July'
                $Month = 7
            }
            {$_ -eq 8 -or $_ -eq 'August'}
            {
                $MonthName = 'August'
                $Month = 8
            }
            {$_ -eq 9 -or $_ -eq 'September'}
            {
                $MonthName = 'September'
                $Month = 9
            }
            {$_ -eq 10 -or $_ -eq 'October'}
            {
                $MonthName = 'October'
                $Month = 10
            }
            {$_ -eq 11 -or $_ -eq 'November'}
            {
                $MonthName = 'November'
                $Month = 11
            }
            {$_ -eq 12 -or $_ -eq 'December'}
            {
                $MonthName = 'December'
                $Month = 12
            }
            default
            {
                $MonthName = Get-Date -Format MMMM
                $Month = (Get-Date).Month
            }
        }

        if (!($Year))
        {
            $Year = (Get-Date).Year
        }

        Write-Debug "Ordinal was set to $Ordinal"
        Write-Debug "WeekDay was set to $WeekDay"
        Write-Debug "MonthName was set to $MonthName"
        Write-Debug "Month was set to $Month"
        Write-Debug "Year was set to $Year"

        switch ($Ordinal)
        {
            'Previous'
            {
                Write-Verbose "Finding previous $WeekDay"
                $Counter = -8
            }
            'Current'
            {
                Write-Verbose "Finding current $WeekDay"
                $Counter = -1
            }
            'Next'
            {
                Write-Verbose "Finding the next $WeekDay starting from $((Get-Date).Month)/$((Get-Date).Day)/$((Get-Date).Year)"
                $Counter = 0
            }
            default
            {
                $Date = Get-Date -Year $Year -Month $Month -Day 1
                While ($Date.Month -eq $Month)
                {
                    $AllDaysInMonth += [pscustomobject]@{
                        Date      = $Date.Date
                        DayOfWeek = $Date.DayOfWeek
                    }
                    $Date = $Date.AddDays(1)
                }

                $AllOccurrences = $AllDaysInMonth | Where-Object {$_.DayOfWeek -eq $WeekDay}
                Write-Verbose -Message "There are $($AllOccurrences.Count) occurrences of $WeekDay in $MonthName of $Year.  Selecting the $Ordinal one."
            }
        }

        if ($AllOccurrences)
        {
            Write-Debug "Choosing from $($AllOccurrences.Date)"
            if ($OccurrenceNumber -eq -1)
            {
                $Return = $AllOccurrences | Select-Object -Last 1
            }
            else
            {
                $Return = $AllOccurrences | Select-Object -First 1 -Skip ($OccurrenceNumber - 1)
            }
        }
        else
        {
            While ($Date.DayOfWeek -ne $WeekDay)
            {
                ++$Counter
                $Date = (Get-Date).AddDays($Counter)
                $Return = [pscustomobject]@{
                    Date      = $Date
                    DayOfWeek = $Date.DayOfWeek
                }
            }
        }

        if (! $Return)
        {
            Write-Verbose "There is no $Ordinal $WeekDay in $MonthName, $Year"
        }
        else
        {
            Get-Date -Date $Return.Date -DisplayHint Date
        }
    }
}