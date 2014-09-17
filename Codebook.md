#Course Project for Getting and Cleaning Data
##Codebook for run_analysis.R

###Pre-processed Variables

The original set of variables is composed by the following:
  *30 different volunteers, divided in two random groups
    +21 were assigned to a train group.
    +9 were assigned to a test group.
  *6 different activites for each of the 30 volunteers.
  *561 different observations for each of the 180 different combinations of activities and volunteers.

The set of original observations includes these different variables.
Note: XYZ are 3 different observations for each variable.
  *tBodyAcc-XYZ
  *tGravityAcc-XYZ
  *tBodyAccJerk-XYZ
  *tBodyGyro-XYZ
  *tBodyGyroJerk-XYZ
  *tBodyAccMag
  *tGravityAccMag
  *tBodyAccJerkMag
  *tBodyGyroMag
  *tBodyGyroJerkMag
  *fBodyAcc-XYZ
  *fBodyAccJerk-XYZ
  *fBodyGyro-XYZ
  *fBodyAccMag
  *fBodyAccJerkMag
  *fBodyGyroMag
  *fBodyGyroJerkMag

This observations, in fact, are a combination of variables which are shown next:
  *t = Measurement in the Time domain
  *f = Fast Fourier Transform in the Frequency domain
  *Body = Body Acceleration
  *Gravity = Gravity Acceleration
  *Acc = Measurement made with the Accelerometer
  *Gyro = Measurement made with the Gyroscope
  *X = X component Measurement
  *Y = Y component Measurement
  *Z = Z component measurement
  *Mag = Vector Magnitude Measurement.
  *Jerk = Acceleration's derivate

All measures are normalized to numbers between [-1, 1]

The original set included a huge amount of variables that were estimated from
the first raw data, based on the different combinations shown above. The only ones 
that were used in this program were:
  *mean(): Mean value
  *std(): Standard deviation

The other values weren't important for these study. Even though there are other
"means", we should be aware that to fully describe a statistical distribution
you need the mean and the standard deviation of any given data. The ones that
only include "Mean" don't have a standard deviation associated with them, and
they can't be described by a normal distribution.

Here's a list of all the variables that weren't included in the final tidy data
set. These were estimated for the original set of observations:
  *mad(): Median absolute deviation 
  *max(): Largest value in array
  *min(): Smallest value in array
  *sma(): Signal magnitude area
  *energy(): Energy measure. Sum of the squares divided by the number of values. 
  *iqr(): Interquartile range 
  *entropy(): Signal entropy
  *arCoeff(): Autorregresion coefficients with Burg order equal to 4
  *correlation(): correlation coefficient between two signals
  *maxInds(): index of the frequency component with largest magnitude
  *meanFreq(): Weighted average of the frequency components to obtain a mean frequency
  *skewness(): skewness of the frequency domain signal 
  *kurtosis(): kurtosis of the frequency domain signal 
  *bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
  *angle(): Angle between to vectors.

Some other variables that weren't included in the tidy data set are:
  *gravityMean
  *tBodyAccMean
  *tBodyAccJerkMean
  *tBodyGyroMean
  *tBodyGyroJerkMean
As mentioned above, this doesn't include a Standard Deviation.

###Tidy data set

The tidy data set was processed based in the information given in the pre-processed data.
The variables for the tidy set are:
  *SubjectID: Unique ID for every subject, Integer (1-30)
  *Activities: Activities done by each subject during the measurements, Character
    +"LAYING"
    +"SITTING"
    +"STANDING"
    +"WALKING"
    +"WALKING_DOWNSTAIRS"
    +"WALKING_UPSTAIRS"
  *Domain: Variable that determines whether it's measured for a period of time, or using a Fast Fourier Transform. Integer.
    1. Time
    2. Frequency
    + The mean is numeric. Value is Time if [1, 1.5], and Frequency if [1.5, 2]
  *Acceleration: Variable that determines which acceleration is measured. Integer.
    1. Body
    2. Gravity
    + The mean is numeric. Value is Body if [1, 1.5], and Gravity if [1.5, 2]
  *Device: Variable that determines which device was used for measuring. Integer.
    1. Accelerometer
    2. Gyroscope
    + The mean is numeric. Value is Accelerometer if [1, 1.5], and Gyroscope if [1.5, 2]
  *Jerk: Variable that determines if Jerk was computed. Integer.
    0. No
    1. Yes
    + The mean is numeric. Value is No if [0, 0.5], and Yes if [0.5, 1]
  *Axis: Variable that determines the axis measured. Integer.
    1. X
    2. Y
    3. Z
    4. Magnitude, `sqrt(x^2+y^2+z^2)`
    + The mean is numeric. Value is X if [1, 1.75], Y if [1.75, 2.5], Z if [2.5, 3.25] and Magnitude if [3.25, 4]
  *Statistic: Variable that determines which statistic was computed. Integer.
    1. Mean
    2. Standard Deviation
    + The mean is numeric. Value is Mean if [1, 1.5], and Standard Deviation if [1.5, 2]
  *Measure: The values that were measured for each set of original variables. Numeric.

###Transformation from raw to tidy data
  
  *The subjectID remained the same from the raw to the tidy data.
  *The Activity was changed from integer to character to make it easier to read.
  *All the variables shown next were chosen and modified:

tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z
tBodyAcc-std()-X, tBodyAcc-std()-Y, tBodyAcc-std()-Z
tGravityAcc-mean()-X, tGravityAcc-mean()-Y, tGravityAcc-mean()-Z
tGravityAcc-std()-X, tGravityAcc-std()-Y, tGravityAcc-std()-Z
tBodyAccJerk-mean()-X, tBodyAccJerk-mean()-Y, tBodyAccJerk-mean()-Z
tBodyAccJerk-std()-X, tBodyAccJerk-std()-Y, tBodyAccJerk-std()-Z
tBodyGyro-mean()-X, tBodyGyro-mean()-Y, tBodyGyro-mean()-Z
tBodyGyro-std()-X, tBodyGyro-std()-Y, tBodyGyro-std()-Z
tBodyGyroJerk-mean()-X, tBodyGyroJerk-mean()-Y, tBodyGyroJerk-mean()-Z
tBodyGyroJerk-std()-X, tBodyGyroJerk-std()-Y, tBodyGyroJerk-std()-Z
tBodyAccMag-mean(), tBodyAccMag-std()
tGravityAccMag-mean(), tGravityAccMag-std()
tBodyAccJerkMag-mean(), tBodyAccJerkMag-std()
tBodyGyroMag-mean(), tBodyGyroMag-std()
tBodyGyroJerkMag-mean(), tBodyGyroJerkMag-std()
fBodyAcc-mean()-X, fBodyAcc-mean()-Y, fBodyAcc-mean()-Z
fBodyAcc-std()-X, fBodyAcc-std()-Y, fBodyAcc-std()-Z
fBodyAccJerk-mean()-X, fBodyAccJerk-mean()-Y, fBodyAccJerk-mean()-Z
fBodyAccJerk-std()-X, fBodyAccJerk-std()-Y, fBodyAccJerk-std()-Z
fBodyGyro-mean()-X, fBodyGyro-mean()-Y, fBodyGyro-mean()-Z
fBodyGyro-std()-X, fBodyGyro-std()-Y, fBodyGyro-std()-Z
fBodyAccMag-mean(), fBodyAccMag-std()
fBodyAccJerkMag-mean(), fBodyAccJerkMag-std()
fBodyGyroMag-mean(), fBodyGyroMag-std()
fBodyGyroJerkMag-mean(), fBodyGyroJerkMag-std()

Each of these variables is formed by a combination of 4 to 6 tidy data variables, 
_Variable = Domain.Acceleration.Device.Jerk.Axis.Statistic_
The values that each tidy data variable can handle were mentioned before.
If the pre-processed variables weren't in this way, it had to be manipulated so 
it appears in this way. For example:
_tBodyAcc-mean()-X_ is changed to _t.Body.Accelerometer.No.X.mean_ so it includes 
all 6 tidy data variables. Then again, it needs to be modified to only the values
that form it, to _1.1.1.0.1.1_. This was done to all the variables. This 6 
variables were transformed from character to integer to better apply the mean
at the end of the program.

Next, the tidy data variables were gathered and then separated with tidyr, so
each variable was assigned a column. Finally, by using `melt` and `dcast` the 
data was averaged by SubjectID and by Activity. There are 30 SubjectID and 6 
Activities. This means there are a 180 total observations, proving this new
dataset `tidy_data.txt` is __indeed a tidy data set__, because there is an 
observation for each entry.