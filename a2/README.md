
# CS131 Assignment 2 — Data Collector and Analyzer

## What this command does

This shell tool downloads a dataset file from a given URL and generates a summary. It supports files with `.csv`, `.data`, and `.train`, extensions. 
If column names are available (in the file or a corresponding `.names` file), the tool lists them and computes basic statistics for numeric columns (min, max, mean, and standard deviation).
If column names are in an unrecognized format, the tool will simply number the columns starting at 1.

---

## How to use

From inside the `cs131/a2` directory, run:

```bash
./datacollector.sh
```
(note: make sure to run $ chmod 755 datacollector.sh to enable execution)

The tool will ask you to input a dataset URL. Simply paste your desired set URL and press enter.
The results will be generated within a directory with the same name as the dataset.

---

## Example

$ ./datacollector.sh 
Please enter the URL to your desired CSV dataset -> https://archive.ics.uci.edu/static/public/186/wine+quality.zip
Retrieving dataset...
File retrieved: wine+quality.zip
Unzipping...
Archive:  wine+quality.zip
  inflating: wine+quality/winequality-red.csv  
  inflating: wine+quality/winequality-white.csv  
  inflating: wine+quality/winequality.names  

Directory generated: wine+quality ; entering...
Data files to parse: 
        winequality-red.csv
        winequality-white.csv


Parsing file winequality-red.csv -- 
Header detected: fixed acidity;volatile acidity;citric acid;residual sugar;chlorides;free sulfur dioxide;total sulfur dioxide;density;pH;sulphates;alcohol;quality
COLUMN LABELS FOR winequality-red.csv : 
fixed acidity
volatile acidity
citric acid
residual sugar
chlorides
free sulfur dioxide
total sulfur dioxide
density
pH
sulphates
alcohol
quality

Feature summary written to summary-winequality-red.md -- 
# Feature Summary for winequality-red.csv

## Feature Index and Names
1. fixed acidity
2. volatile acidity
3. citric acid
4. residual sugar
5. chlorides
6. free sulfur dioxide
7. total sulfur dioxide
8. density
9. pH
10. sulphates
11. alcohol
12. quality

## Statistics (Numerical Features)
| Index | Feature           | Min   | Max   | Mean  | StdDev |
|-------|-------------------|-------|-------|-------|--------|
| 1     | fixed acidity     | 4.60  | 15.90 | 8.320 | 1.741  |
| 2     | volatile acidity  | 0.12  | 1.58  | 0.528 | 0.179  |
| 3     | citric acid       | 0.00  | 1.00  | 0.271 | 0.195  |
| 4     | residual sugar    | 0.90  | 15.50 | 2.539 | 1.409  |
| 5     | chlorides         | 0.01  | 0.61  | 0.087 | 0.047  |
| 6     | free sulfur dioxide | 1.00  | 72.00 | 15.875 | 10.457 |
| 7     | total sulfur dioxide | 6.00  | 289.00 | 46.468 | 32.885 |
| 8     | density           | 0.99  | 1.00  | 0.997 | 0.002  |
| 9     | pH                | 2.74  | 4.01  | 3.311 | 0.154  |
| 10    | sulphates         | 0.33  | 2.00  | 0.658 | 0.169  |
| 11    | alcohol           | 8.40  | 14.90 | 10.423 | 1.065  |
| 12    | quality           | 3.00  | 8.00  | 5.636 | 0.807  |
|-------|-------------------|-------|-------|-------|--------|


Parsing file winequality-white.csv -- 
Header detected: fixed acidity;volatile acidity;citric acid;residual sugar;chlorides;free sulfur dioxide;total sulfur dioxide;density;pH;sulphates;alcohol;quality
COLUMN LABELS FOR winequality-white.csv : 
fixed acidity
volatile acidity
citric acid
residual sugar
chlorides
free sulfur dioxide
total sulfur dioxide
density
pH
sulphates
alcohol
quality

Feature summary written to summary-winequality-white.md -- 
# Feature Summary for winequality-white.csv

## Feature Index and Names
1. fixed acidity
2. volatile acidity
3. citric acid
4. residual sugar
5. chlorides
6. free sulfur dioxide
7. total sulfur dioxide
8. density
9. pH
10. sulphates
11. alcohol
12. quality

## Statistics (Numerical Features)
| Index | Feature           | Min   | Max   | Mean  | StdDev |
|-------|-------------------|-------|-------|-------|--------|
| 1     | fixed acidity     | 3.80  | 14.20 | 6.855 | 0.844  |
| 2     | volatile acidity  | 0.08  | 1.10  | 0.278 | 0.101  |
| 3     | citric acid       | 0.00  | 1.66  | 0.334 | 0.121  |
| 4     | residual sugar    | 0.60  | 65.80 | 6.391 | 5.072  |
| 5     | chlorides         | 0.01  | 0.35  | 0.046 | 0.022  |
| 6     | free sulfur dioxide | 2.00  | 289.00 | 35.308 | 17.005 |
| 7     | total sulfur dioxide | 9.00  | 440.00 | 138.361 | 42.494 |
| 8     | density           | 0.99  | 1.04  | 0.994 | 0.003  |
| 9     | pH                | 2.72  | 3.82  | 3.188 | 0.151  |
| 10    | sulphates         | 0.22  | 1.08  | 0.490 | 0.114  |
| 11    | alcohol           | 8.00  | 14.20 | 10.514 | 1.230  |
| 12    | quality           | 3.00  | 9.00  | 5.878 | 0.886  |
|-------|-------------------|-------|-------|-------|--------|


