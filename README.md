# FALCON_D

## Description

20191109 Repository to develop simpler trading robot. 

## Goal

Develop robot that works just to buy or sell assets once the market is in identified bullish state

Trading strategy based on:

* Asset Technical Analysis (Avoid Negative Swap, current price position must not be below/above 950D Moving Average, not on it's upper/lower region) 
* Market Fundamental Analysis (Trading Pair Selection based on economy differences, avoiding Risky assets affected by big news events e.g. Brexit)
* Trading execution in one direction (buy/sell) which has to be selected by user

### Code source

Original code is taken from: FALCON_F2

### Modifications

2019-09-11 New Version

# Full Strategy Development

## Robot Setup

* only using max 10 charts with pairs that we know (e.g. USD/GBP/EUR/CHF/CAD)

## Decision support for Pairs selection

### Evaluate Swaps
Developing data strategy support writer [StrategySupportWriter.mq4](https://github.com/vzhomeexperiments/Survival/blob/master/StrategySupportWriter.mq4)

* Decomposes symbol name,
* retrieve swap long, short values,
* write data to the csv file
* write other values for each pairs like Moving Averages and their differences, etc

This file can be used to derive decision on applying robot on charts or not... e.g. do not use if there is a too high negative swap

### Fundamental analysis

Trader should also decompose symbol name and to evaluate each currency in terms of economic weakness strenght. This is example to decide when to use Survival robot on the asset 'EURUSD':

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
- JPY pairs are working well
- Both Buy/Sell orders are opened
- Only Sell/Only Buy
- Both Buy/Sell orders are blocked
- Multi positions are possible

# Demo Testing

## FALCON_D

### 2019xxxx Status:

### 2019xxxx Status:

# Robot Behavior observations

Only use it on H1 charts!!!

## Entry

## Exits

## Filters


## Money Management

## Generic observations

- only sell/buy positions selectable
- can use RSI based filter to detect overbought/oversold asset:

* Filter all buy trades when RSI is > 70

`extern int     RSI_NoBuyFilter                  = 70;`

* Filter all sell trades when RSI is < 30

`extern int     RSI_NoSellFilter                 = 30;`

* Removes above mentioned filters:

`extern int     RSI_NoBuyFilter                  = 100;`
`extern int     RSI_NoSellFilter                 = 0;`


