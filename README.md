# 12HourClk
Design a set of counters suitable for a 12-hour clock system with an AM/PM
indicator. These counters will be driven by a high-frequency clock signal (clk) and
will be incremented by one every time a pulse is received on the 'ena' input,
indicating a one-second interval. A 'reset' input will be used to set the clock to
12:00 AM. The 'pm' signal will be 0 for AM and 1 for PM. The counters include 'hh'
for hours, 'mm' for minutes, and 'ss' for seconds, each represented by two
Binary-Coded Decimal (BCD) digits. It's important to note that the reset operation
takes precedence over the enable operation and can occur even when the enable
signal is not active.
To provide clarity on the operation, consider the following timing diagram which
illustrates the transition from 11:59:59 AM to 12:00:00 PM, as well as the
behavior of synchronous reset and enable signals.
