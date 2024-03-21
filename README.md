# Shell-Scripting

## Description

This repository contains code used in the CSE337 - Scripting Languages course at Stony Brook University. The scripts are primarily written in zsh (Z shell) and cover various topics and exercises taught throughout the course.

## Installation

This project doesn't require installation in the traditional sense. However, you will need a Unix-like environment with zsh installed to run the scripts.

## Scripts

### 1. File Mover

#### Description:
This script moves C files from a source directory to a destination directory. If the source directory contains more than 3 C files, it prompts the user for confirmation before moving the files.

#### Usage:
```bash
$ prog1.sh <source_directory> <destination_directory>
```

### 2. Data Processor

#### Description:
This script processes data from a specified input file, computes column sums, and writes the results to an output file.

#### Usage:
```bash
$ prog2.sh <input_data_file> <output_file>
```

### 3. Weighted Average Calculator

#### Description:
This script calculates the weighted average of data from a given file. It allows specifying weights for each data point.

#### Usage:
```bash
$ prog3.sh <data_file> [weights...]
```

## Credits

This repository was initially part of the CSE337 - Scripting Languages course at Stony Brook University, taught by Professor Dr. Abid M. Malik. The scripts were developed as part of course assignments and exercises.

## License

This project is licensed under the [MIT License](LICENSE).