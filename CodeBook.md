# CODE BOOK
## SECTION 1

### Introduction
The __Human Activity Recognition Using Smartphones Data Set__ is a result of experiments carried out with a group of 30 volunteers (age: 19-48 years), where their activities were recorded. Their activities included:  
* Walking
* Walking upstairs
* Walking downstairs
* Sitting
* Standing
* Laying  

As a procedure, all the volunteers were asked to wear a smartphone (Samsung
Galaxy S II) on their waist. Then the scientists captured 3-axial linear 
acceleration and 3-axial angular velocity at a constant rate of 50Hz, using 
embedded accelerometer and gyroscope. The obtained dataset has been randomly 
partitioned into two sets.  
_70% volunteers (tarining data)_  
_30% volunteers (test data)_ 

__Below are the attributes provided for each record in the dataset__
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## SECTION 2

### Creating tidy data

The dataset was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, and unzipped into the working folder. The codes in *'run_analysis.R'* assumes that the unzipped folder *'getdata-projectfiles-UCI HAR Dataset'* containing the datasets are in the working directory. The following are the steps involved in the process of creating a tidy dataset.  
**Note:** data files are denoted in **_bold Italics_**; R objects in **bold**; and R functions in _Italics_.

__STEP 1:__ Merging the training and the test sets to create one dataset
- Read the text files (__*X_train.txt*__,__*X_test.txt*__,__*y_train.txt*__,__*y_test.txt*__,__*subject_train.txt*__,__*subject_test.txt*__) using _read.table_ and create corresponding dataframes (__X_train__,__X_test__,__Y_train__,__Y_test__,__Subject_train__,__Subject_test__)
- Merge the relevant dataframes from training and test sets (by rows) using _rbind_  
**X_train + X_test = X_Values_data**  
**Y_train + Y_test = Y_Values_data**  
**Subject_train + Subject_test = Subject_ID**  

__STEP 2:__ Extracts the measurements on the mean and standard deviation for each variable
- Read the text file (__*features.txt*__) using _read.table_ to create a dataframe called __features__.
- Select only the values corresponding to mean and standard deviation using _grep_ and store the filtered row indices in __features_refined__.
- Subset the __X_Values_data__ using the indices from __features_refined__ specified as column. By doing this, 66 columns are retained from the original 561 columns of __X_Values_data__.
- rename the column names of __X_Values_data__ based on the __features__ dataframe using _names_, where the row indices are provided by __features_refined__.
- Further cleanup of the variable names to remove '()' using _gsub_.
- Convert all the characters in variable names to lower case using _tolower_.

__STEP 3:__ Uses descriptive activity names to name the activities in the data set
- Read the text file (__*activity.txt*__) using _read.table_ to create a dataframe called __activity__.
- Convert the characters in activity names to lower case and remove '()' using _tolower_ and _gsub_.
- Replace 'activity code' with 'activity names' in __Y_Values_data__.
- Name the column activity in __Y_Values_data__ using *names*.

__STEP 4:__ Appropriately labels the data set with descriptive activity names
- Rename the column in **Subject_ID** as 'subject' using *names*.
- Create the first tidy data set by column binding **Subject_ID**,**Y_Values_data** and **X_Values_data** using _cbind_.
- Now, Write a __*.txt*__ file called **_"clean_data.txt"_** in the working directory using _write.table_.

__STEP 5:__ Creates a Second independent tidy data set with the average of each variable for each activity and each subject
- Create a vector of unique subject ID using _unique_.
- Get the total number of subjects using _length_.
- Get the total number of activities using _length_.
- Retain the number of columns of **_Clean_data_** using _dim_.
- Now, create the second independent tidy data set (**result**) with the average of each variable for each activity and each subject.
- Finally, write a __*.txt*__ file called **_"data_set_with_the_averages.txt"_** based on **result** dataframe, using _write.table_.

## SECTION 3

### Variable names and explanations

The **_"data_set_with_the_averages.txt"_** contains **180 Rows** and **68 Columns**.

**Column 1:** _subject id_

**Column 2:** _activity type_  

The **columns 3** to **8** follow a specific naming convention.
The column name can be divided into three parts:  
For example, in "tbodyacc.mean.x"

**Part 1** is *tbodyacc*

- First letter 't' denotes 'time'
- 'bodyacc' is accelerometer measurement of subject body

**Part 2** is *mean* or *std*

- This is the average value of the means or standard deviations of accelerator measurements of the subjects

**Part 3** is *x* or *y* or *z*

- These are the three axials of measurements.

The **columns 9** to **14** follow a specific naming convention.
The column name can be divided into three parts:  
For example, in "tgravityacc.mean.x"

**Part 1** is *tgravityacc*

- First letter 't' denotes 'time'
- 'gravityacc' is the magnitude of the three-dimensional signals calculated using the Euclidean norm for gravity

**Part 2** is *mean* or *std*

- This is the average value of the means or standard deviations of accelerator measurements of the subjects

**Part 3** is *x* or *y* or *z*

- These are the three axials of measurements.

The **columns 15** to **20** follow a specific naming convention.
The column name can be divided into three parts:  
For example, in "tbodyaccjerk.mean.x"

**Part 1** is *tbodyaccjerk*

- First letter 't' denotes 'time'
- 'bodyaccjerk' is the body linear acceleration and angular velocity derived in time to obtain Jerk signals

**Part 2** is *mean* or *std*

- This is the average value of the means or standard deviations of accelerator measurements of the subjects

**Part 3** is *x* or *y* or *z*

- These are the three axials of measurements.

The **columns 21** to **26** follow a specific naming convention.
The column name can be divided into three parts:  
For example, in "tbodygyro.mean.x"

**Part 1** is *tbodygyro*

- First letter 't' denotes 'time'
- 'bodygyro' is the measurements from Gyroscope

**Part 2** is *mean* or *std*

- This is the average value of the means or standard deviations of accelerator measurements of the subjects

**Part 3** is *x* or *y* or *z*

- These are the three axials of measurements.

The **columns 27** to **32** follow a specific naming convention.
The column name can be divided into three parts:  
For example, in "tbodygyrojerk.mean.x"

**Part 1** is *tbodygyrojerk*

- First letter 't' denotes 'time'
- 'bodygyrojerk' is the body linear acceleration and angular velocity derived in time to obtain Jerk signals  

**Part 2** is *mean* or *std*

- This is the average value of the means or standard deviations of accelerator measurements of the subjects  

**Part 3** is *x* or *y* or *z*

- These are the three axials of measurements.

The **columns 43** to **48** follow a specific naming convention.
The column name can be divided into three parts:  
For example, in "fbodyacc.mean.x"

**Part 1** is *fbodyacc*

- First letter 'f' denotes 'Fast Fourier Transform (FFT)' applied to some of the signals
- 'bodyacc' is accelerometer measurement of subject body

**Part 2** is *mean* or *std*

- This is the average value of the means or standard deviations of accelerator measurements of the subjects

**Part 3** is *x* or *y* or *z*

- These are the three axials of measurements.

The **columns 49** to **54** follow a specific naming convention.
The column name can be divided into three parts:  
For example, in "fbodyaccjerk.mean.x"

**Part 1** is *fbodyaccjerk*

- First letter 'f' denotes 'Fast Fourier Transform (FFT)' applied to some of the signals
- 'bodyaccjerk' is the body linear acceleration and angular velocity derived in time to obtain Jerk signals

**Part 2** is *mean* or *std*

- This is the average value of the means or standard deviations of accelerator measurements of the subjects

**Part 3** is *x* or *y* or *z*

- These are the three axials of measurements.

The **columns 55** to **60** follow a specific naming convention.
The column name can be divided into three parts:  
For example, in "fbodygyro.mean.x"

**Part 1** is *fbodygyro*

- First letter 'f' denotes 'Fast Fourier Transform (FFT)' applied to some of the signals
- 'bodygyro' is the measurements from Gyroscope

**Part 2** is *mean* or *std*

- This is the average value of the means or standard deviations of accelerator measurements of the subjects

**Part 3** is *x* or *y* or *z*

- These are the three axials of measurements.

In the next set of **Columns** numbered from **33** to **42** and from **61** to **68**, has only two parts.
For example, in "tbodygyrojerkmag.mean"

**Part 1** is *tbodygyrojerkmag*

- If the first letter is 't' then it denotes 'time' and if the first letter is 'f' then it denotes 'Fast Fourier Transform (FFT)' applied to some of the signals
- If 'bodygyro' then it is the measurements from Gyroscope, and if 'bodyacc' then it is the measurements from Accelerometer.
- If only 'mag' then it is magnitude measured from signals, and if 'jerkmag' then it is the magnitude of jerk measured from signals.

**Part 2** is *mean* or *std*

- This is the average value of the means or standard deviations of accelerator measurements of the subjects

