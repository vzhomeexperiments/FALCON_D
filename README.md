# FALCON_D

## Description

20191109 Repository to develop simpler trading robot. 

**NB: Use on your own risk!!!**

Implemented based on the FALCON template. Trading robot can be used together with *Decision Support System* as described in the 'Lazy Trading Educational Project'. Robot logic is implemented based on states. States are defined in the custom functions that 'confines' a strategy space in one place. Obviously the best is to understand this robot using Strategy Tester, well only use it for H1 charts!

## Goal

Trading robot based on:

* Asset optimization, selection of best currency pairs
* Analysis of performance using 'forward' test
* Use of R package 'lazytrade' to facilitate and speed up the analysis

### Code source

Original code is taken from: FALCON_F2, some ideas are borrowed from ForexBoat.com course on Forex

# Example of setups

## Robot Setup

* Using just few charts with Assets that we know (e.g. USD/GBP/EUR/AUD)
* NB: Only use it on H1 charts!!!

## Filters

* H1 chart, same parameters as we defined
* Moving Averages filter D950/D1
* RSI filters

## Entry

- Entry is simply decided if the price at Hour X would change more than X pips from the beginning of the day (Hour 0). Price change is in the opposite direction from the trend

## Exits

- Fixed time in minutes e.g. 1440min is 24 hours
- Obviously Hard Stops that can be setup using variety of options e.g. volatility of fixed

## Filters

### User defined

- only sell/buy positions selectable

### Moving Average

- D1 price is above D750 enables buy trades
- D1 price is below D750 enables sell trades

Note: D750/D1 is customizable in External Parameters

### RSI

- can use RSI based filter to detect overbought/oversold asset. Period of the robot is hard coded in the code to be 14 Days:

* Filter all buy trades when RSI is > 70

`extern int     RSI_NoBuyFilter                  = 70;`

* Filter all sell trades when RSI is < 30

`extern int     RSI_NoSellFilter                 = 30;`

* Removes above mentioned filters:

`extern int     RSI_NoBuyFilter                  = 100;`
`extern int     RSI_NoSellFilter                 = 0;`

# Development Check List (on Strategy Tester)

- Time hold order is working
- JPY pairs targets are working well
- Both Buy/Sell orders are opened
- Only Buy | Only Sell
- Both Buy/Sell orders are blocked
- Multi positions are possible

