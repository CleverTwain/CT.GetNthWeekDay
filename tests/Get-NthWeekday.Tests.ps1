Describe 'Get-NthWeekday' {
    It "Given no parameters, returns the current date" {
        $CurrentDate = Get-NthWeekday
        $CurrentDate.Date | Should Be (Get-Date).Date
    }

    It "Returns a DateTime object" {
        $CurrentDate = Get-NthWeekday
        ($CurrentDate.GetType()).Name | Should Be (Get-Date).GetType().Name
    }

    Context "Using Integers" {
        It 'Gets the correct date when using numerical months' {
            $TestDate = Get-NthWeekday -Ordinal 1 -WeekDay Monday -Month 1 -Year 2016
            (Get-Date -Month 1 -Day 4 -Year 2016).Date | Should Be $TestDate.Date
        }

        It 'Gets the correct date when using numerical ordinals' {
            $TestDate = Get-NthWeekday -Ordinal 1 -WeekDay Monday -Month January -Year 2016
            (Get-Date -Month 1 -Day 4 -Year 2016).Date | Should Be $TestDate.Date
        }
    }

    Context "Using Strings" {
        It 'Gets the correct date when the month is a string' {
            $TestDate = Get-NthWeekday -Ordinal 1 -WeekDay Monday -Month January -Year 2016
            (Get-Date -Month 1 -Day 4 -Year 2016).Date | Should Be $TestDate.Date
        }

        It 'Gets the correct date when the ordinal is a partial string (1st)' {
            $TestDate = Get-NthWeekday -Ordinal 1st -WeekDay Monday -Month January -Year 2016
            (Get-Date -Month 1 -Day 4 -Year 2016).Date | Should Be $TestDate.Date
        }

        It 'Gets the correct date when the ordinal is a full string (first)' {
            $TestDate = Get-NthWeekday -Ordinal First -WeekDay Monday -Month January -Year 2016
            (Get-Date -Month 1 -Day 4 -Year 2016).Date | Should Be $TestDate.Date
        }
    }

    Context "Advanced Options" {
        It 'Returns the PREVIOUS Wednesday' {

            $TestDate = Get-Date
            switch ($TestDate.DayOfWeek) {
                'Sunday' {
                    $CheckDate = $TestDate.AddDays(-4)
                }
                'Monday' {
                    $CheckDate = $TestDate.AddDays(-5)
                }
                'Tuesday' {
                    $CheckDate = $TestDate.AddDays(-6)
                }
                'Wednesday' {
                    $CheckDate = $TestDate.AddDays(-7)
                }
                'Thursday' {
                    $CheckDate = $TestDate.AddDays(-1)
                }
                'Friday' {
                    $CheckDate = $TestDate.AddDays(-2)
                }
                'Saturday' {
                    $CheckDate = $TestDate.AddDays(-3)
                }
            }
            (Get-NthWeekday -Ordinal Previous -WeekDay 'Wednesday').Date | Should Be $CheckDate.Date
        }
        It 'Returns the NEXT Wednesday' {

            $TestDate = Get-Date
            switch ($TestDate.DayOfWeek) {
                'Sunday' {
                    $CheckDate = $TestDate.AddDays(3)
                }
                'Monday' {
                    $CheckDate = $TestDate.AddDays(2)
                }
                'Tuesday' {
                    $CheckDate = $TestDate.AddDays(1)
                }
                'Wednesday' {
                    $CheckDate = $TestDate.AddDays(7)
                }
                'Thursday' {
                    $CheckDate = $TestDate.AddDays(6)
                }
                'Friday' {
                    $CheckDate = $TestDate.AddDays(5)
                }
                'Saturday' {
                    $CheckDate = $TestDate.AddDays(4)
                }
            }
            (Get-NthWeekday -Ordinal Next -WeekDay 'Wednesday').Date | Should Be $CheckDate.Date
        }
        It 'Returns the CURRENT Wednesday' {

            $TestDate = Get-Date
            switch ($TestDate.DayOfWeek) {
                'Sunday' {
                    $CheckDate = $TestDate.AddDays(3)
                }
                'Monday' {
                    $CheckDate = $TestDate.AddDays(2)
                }
                'Tuesday' {
                    $CheckDate = $TestDate.AddDays(1)
                }
                'Wednesday' {
                    $CheckDate = $TestDate
                }
                'Thursday' {
                    $CheckDate = $TestDate.AddDays(6)
                }
                'Friday' {
                    $CheckDate = $TestDate.AddDays(5)
                }
                'Saturday' {
                    $CheckDate = $TestDate.AddDays(4)
                }
            }
            (Get-NthWeekday -Ordinal Current -WeekDay 'Wednesday').Date | Should Be $CheckDate.Date
        }
        It 'Returns the LAST Wednesday of the current month' {

            $CheckDate = Get-Date -Day 27 -Month 6 -Year 2018
            (Get-NthWeekday -Ordinal Last -WeekDay 'Wednesday' -Month June -Year 2018).Date | Should Be $CheckDate.Date
        }
    }
}