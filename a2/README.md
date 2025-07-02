
# CS131 Assignment 2 — Data Collector and Analyzer

## What this command does

This shell tool downloads a dataset file from a given URL and generates a summary. It supports files with `.csv`, `.data`, `.train`, and `.test` extensions. 
If column names are available (in the file or a corresponding `.names` file), the tool lists them and computes basic statistics for numeric columns (min, max, mean, and standard deviation).
If column names are in an unrecognized format, the tool will simply number the columns starting at 1.

---

## How to use

From inside the `cs131/a2` directory, run:

```bash
$ ./datacollector.sh
(note: make sure to run $ chmod 755 datacollector.sh to enable execution)

The tool will ask you to input a dataset URL. Simply paste your desired set URL and press enter.
The results will be generated within a directory with the same name as the dataset.


