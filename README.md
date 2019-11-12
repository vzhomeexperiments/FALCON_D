# FALCON_D

## Description

20191109 Repository to develop simpler trading robot. 

**NB: Use on your own risk!!!**

Implemented based on the FALCON template. Trading robot can be used together with *Decision Support System* as described in the 'Lazy Trading Educational Project'. Robot logic is implemented based on states. States are defined in the custom functions that 'confines' a strategy space in one place. Obviously the best is to understand this robot using Strategy Tester, well only use it for H1 charts!

## Goal

Develop robot that works just to buy or sell assets once the market is in identified bullish or bearish state

Trading strategy based on:

* Asset Technical Analysis (e.g. Avoid Negative Swap, current price position must not be below/above 950D Moving Average, not on it's upper/lower region) 
* Asset Fundamental Analysis (e.g. Trading Pair Selection based on economy strenght differences, avoiding Risky assets affected by big news events, etc)
* Trading execution that can be enabled conditionally in one or both directions (buy/sell) which has to be selected by user

### Code source

Original code is taken from: FALCON_F2, some ideas are borrowed from ForexBoat course on Forex

# Example of setups

## Robot Setup

* Using just few charts with Assets that we know (e.g. USD/GBP/EUR/CHF)

## Decision support for Pairs selection

### Evaluate Swaps
Developing data strategy support writer [StrategySupportWriter.mq4](https://github.com/vzhomeexperiments/Survival/blob/master/StrategySupportWriter.mq4)

* Decomposes symbol name,
* retrieve swap long, short values,
* write data to the csv file
* write other values for each pairs like Moving Averages and their differences, etc

This file can be used to derive decision on applying robot on charts or not... e.g. one of idea can be to use pair and tradind direction with a positive swap

### Fundamental analysis

Trader may also decompose symbol name and to evaluate each currency in terms of relative economic weakness/strenght. This is example to decide when to use robot on the asset 'EURUSD':

| Base | Economy | Quote | Economy | Decision |
|:----:|---------|-------|---------|----------|
|  EUR | Weak    | USD   | Strong  | Use Sell |

It is recommended to perform such analysis on the bi-weekly basis

### Technical Analysis

Trader should avoid directly deploy this robot on the asset that has reaching it's lowest/upper value on the chart (use D1 chart to evaluate)

## Money Management

* Leverage 1:100
* Lots 0.01 
* stoploss 600 pips
* maximum 1 position at the time
* Starting Account size 1000 CHF 
* 0.01 lots, 1:100 leverage
* gradually increase lot size (0.01 if account < 1500; 0.02 if account > 1500 and < 2500 etc)

| Account | Lots |
|:-------:|------|
|   1000  | 0.01 |
|   1500  | 0.02 |
|   2000  | 0.03 |

## Filters

* H1 chart, same parameters as we defined
* Moving Averages filter D950/D1

# Development Check List (on Strategy Tester)

- Time hold order is working
- JPY pairs targets are working well
- Both Buy/Sell orders are opened
- Only Buy | Only Sell
- Both Buy/Sell orders are blocked
- Multi positions are possible

# Demo Testing

## FALCON_D

### YYYYMMDD Status:

- Write your results

### YYYYMMDD Status:

- Write your results

# Robot Behavior observations

NB: Only use it on H1 charts!!!

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

