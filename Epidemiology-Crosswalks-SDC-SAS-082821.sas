options formdlim="*"; /*Replaces the hard page break in the Output Window with a row of *'s.*/
libname USER "C:\Desktop\Data";

/*************************************************************************************************************************/
/*																														 */
/*	Industry Crosswalks.																								 */
/*																														 */
/*************************************************************************************************************************/

/*************************************************************************************************************************/
/*	Convert U.S. Census Bureau 1980 industry codes to U.S. Census Bureau 1990 industry codes.							 */
/*************************************************************************************************************************/

/*1. Read the user’s dataset into SAS.*/

proc import out=USER.dataset_1
            datafile="C:\Desktop\Data\dataset_1.xlsx"
            dbms=EXCEL replace;
            getnames=yes;
run;

/*2. Generate a random number between zero and one from a uniform distribution for each observation (e.g., person) in the user’s dataset and assign this random number to a new variable.*/

data USER.dataset_2;
   set USER.dataset_1;
   call streaminit(143753); /*143753 is a seed number. Users should replace the seed number each time they generate random numbers.*/
   randnum = rand("Uniform");
run;

/*3. Read into SAS eTable 2. Horizontal Crosswalk to convert U.S. Census Bureau 1980 to 1990 Industry Codes (i.e., tab "eTable 2-Ind-1980-1990-Horiz" in the Excel workbook that contains the crosswalks).*/

proc import out=USER.Crosswalk_Ind_1980_1990_1
            datafile="C:\Desktop\Data\Epidemiology-Crosswalks-SDC-Excel-072621.xlsx"
            dbms=EXCEL replace;
            sheet="eTable 2-Ind-1980-1990-Horiz";
            getnames=yes;
run;

/*4. Sort the user’s dataset by the U.S. Census Bureau 1980 industry codes.*/

proc sort data=USER.dataset_2;
   by Census1980IndustryCode;
run;

/*5. Sort eTable 2 by the U.S. Census Bureau 1980 industry codes.*/

proc sort data=USER.Crosswalk_Ind_1980_1990_1;
   by Census1980IndustryCode_1;
run;

/*6. Merge eTable 2 to the user’s dataset by the U.S. Census Bureau 1980 industry codes.*/

data USER.dataset_3;
   merge USER.dataset_2 (rename = (Census1980IndustryCode = Census1980IndustryCode_1)) USER.Crosswalk_Ind_1980_1990_1;
   by Census1980IndustryCode_1;

/*7. Compare the random number for a particular person (i.e., step 2) to the ConversionLowerBound and ConversionUpperBound variables in eTable 2 and assign the U.S. Census Bureau 1990 industry code that corresponds to the ConversionLowerBound and ConversionUpperBound variables that contain the random number. In other words, eTable 2 shows one U.S. Census Bureau 1980 industry code redistributes to between one and seven U.S. Census Bureau 1990 industry codes.*/

   if Census1980IndustryCode_2 = . then do; /*One U.S. Census 1980 industry code maps/redistributes to one U.S. Census 1990 industry code.*/
      Census1990IndustryCode = Census1990IndustryCode_1;
      Census1990IndustryTitle = Census1990IndustryTitle_1;
   end;
   else if Census1980IndustryCode_3 = . then do; /*One U.S. Census 1980 industry code maps/redistributes to two U.S. Census 1990 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census1990IndustryCode = Census1990IndustryCode_1;
         Census1990IndustryTitle = Census1990IndustryTitle_1;
      end;
      else do;
         Census1990IndustryCode = Census1990IndustryCode_2;
         Census1990IndustryTitle = Census1990IndustryTitle_2;
      end;
   end;
   else if Census1980IndustryCode_4 = . then do; /*One U.S. Census 1980 industry code maps/redistributes to three U.S. Census 1990 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census1990IndustryCode = Census1990IndustryCode_1;
         Census1990IndustryTitle = Census1990IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census1990IndustryCode = Census1990IndustryCode_2;
         Census1990IndustryTitle = Census1990IndustryTitle_2;
      end;
      else do;
         Census1990IndustryCode = Census1990IndustryCode_3;
         Census1990IndustryTitle = Census1990IndustryTitle_3;
      end;
   end;
   else do; /*One U.S. Census 1980 industry code maps/redistributes to seven U.S. Census 1990 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census1990IndustryCode = Census1990IndustryCode_1;
         Census1990IndustryTitle = Census1990IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census1990IndustryCode = Census1990IndustryCode_2;
         Census1990IndustryTitle = Census1990IndustryTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census1990IndustryCode = Census1990IndustryCode_3;
         Census1990IndustryTitle = Census1990IndustryTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census1990IndustryCode = Census1990IndustryCode_4;
         Census1990IndustryTitle = Census1990IndustryTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census1990IndustryCode = Census1990IndustryCode_5;
         Census1990IndustryTitle = Census1990IndustryTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census1990IndustryCode = Census1990IndustryCode_6;
         Census1990IndustryTitle = Census1990IndustryTitle_6;
      end;
      else do;
         Census1990IndustryCode = Census1990IndustryCode_7;
         Census1990IndustryTitle = Census1990IndustryTitle_7;
      end;
   end;
run;

/*************************************************************************************************************************/
/*	Convert U.S. Census Bureau 1990 industry codes to U.S. Census Bureau 2000 industry codes.							 */
/*************************************************************************************************************************/

/*1. Read the user’s dataset into SAS.*/

proc import out=USER.dataset_1
            datafile="C:\Desktop\Data\dataset_1.xlsx"
            dbms=EXCEL replace;
            getnames=yes;
run;

/*2. Generate a random number between zero and one from a uniform distribution for each observation (e.g., person) in the user’s dataset and assign this random number to a new variable.*/

data USER.dataset_2;
   set USER.dataset_1;
   call streaminit(909662); /*909662 is a seed number. Users should replace the seed number each time they generate random numbers.*/
   randnum = rand("Uniform");
run;

/*3. Read into SAS eTable 4. Horizontal Crosswalk to convert U.S. Census Bureau 1990 to 2000 Industry Codes (i.e., tab "eTable 4-Ind-1990-2000-Horiz" in the Excel workbook that contains the crosswalks).*/

proc import out=USER.Crosswalk_Ind_1990_2000_1
            datafile="C:\Desktop\Data\Epidemiology-Crosswalks-SDC-Excel-072621.xlsx"
            dbms=EXCEL replace;
            sheet="eTable 4-Ind-1990-2000-Horiz";
            getnames=yes;
run;

/*4. Sort the user’s dataset by the U.S. Census Bureau 1990 industry codes.*/

proc sort data=USER.dataset_2;
   by Census1990IndustryCode;
run;

/*5. Sort eTable 4 by the U.S. Census Bureau 1990 industry codes.*/

proc sort data=USER.Crosswalk_Ind_1990_2000_1;
   by Census1990IndustryCode_1;
run;

/*6. Merge eTable 4 to the user’s dataset by the U.S. Census Bureau 1990 industry codes.*/

data USER.dataset_3;
   merge USER.dataset_2 (rename = (Census1990IndustryCode = Census1990IndustryCode_1)) USER.Crosswalk_Ind_1990_2000_1;
   by Census1990IndustryCode_1;

/*7. Compare the random number for a particular person (i.e., step 2) to the ConversionLowerBound and ConversionUpperBound variables in eTable 4 and assign the U.S. Census Bureau 2000 industry code that corresponds to the ConversionLowerBound and ConversionUpperBound variables that contain the random number. In other words, eTable 4 shows one U.S. Census Bureau 1990 industry code redistributes to between one and 37 U.S. Census Bureau 2000 industry codes.*/

   if Census1990IndustryCode_2 = . then do; /*One U.S. Census 1990 industry code maps/redistributes to one U.S. Census 2000 industry code.*/
      Census2000IndustryCode = Census2000IndustryCode_1;
      Census2000IndustryTitle = Census2000IndustryTitle_1;
   end;
   else if Census1990IndustryCode_3 = . then do; /*One U.S. Census 1990 industry code maps/redistributes to two U.S. Census 2000 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000IndustryCode = Census2000IndustryCode_1;
         Census2000IndustryTitle = Census2000IndustryTitle_1;
      end;
      else do;
         Census2000IndustryCode = Census2000IndustryCode_2;
         Census2000IndustryTitle = Census2000IndustryTitle_2;
      end;
   end;
   else if Census1990IndustryCode_4 = . then do; /*One U.S. Census 1990 industry code maps/redistributes to three U.S. Census 2000 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000IndustryCode = Census2000IndustryCode_1;
         Census2000IndustryTitle = Census2000IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000IndustryCode = Census2000IndustryCode_2;
         Census2000IndustryTitle = Census2000IndustryTitle_2;
      end;
      else do;
         Census2000IndustryCode = Census2000IndustryCode_3;
         Census2000IndustryTitle = Census2000IndustryTitle_3;
      end;
   end;
   else if Census1990IndustryCode_5 = . then do; /*One U.S. Census 1990 industry code maps/redistributes to four U.S. Census 2000 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000IndustryCode = Census2000IndustryCode_1;
         Census2000IndustryTitle = Census2000IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000IndustryCode = Census2000IndustryCode_2;
         Census2000IndustryTitle = Census2000IndustryTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000IndustryCode = Census2000IndustryCode_3;
         Census2000IndustryTitle = Census2000IndustryTitle_3;
      end;
      else do;
         Census2000IndustryCode = Census2000IndustryCode_4;
         Census2000IndustryTitle = Census2000IndustryTitle_4;
      end;
   end;
   else if Census1990IndustryCode_6 = . then do; /*One U.S. Census 1990 industry code maps/redistributes to five U.S. Census 2000 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000IndustryCode = Census2000IndustryCode_1;
         Census2000IndustryTitle = Census2000IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000IndustryCode = Census2000IndustryCode_2;
         Census2000IndustryTitle = Census2000IndustryTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000IndustryCode = Census2000IndustryCode_3;
         Census2000IndustryTitle = Census2000IndustryTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000IndustryCode = Census2000IndustryCode_4;
         Census2000IndustryTitle = Census2000IndustryTitle_4;
      end;
      else do;
         Census2000IndustryCode = Census2000IndustryCode_5;
         Census2000IndustryTitle = Census2000IndustryTitle_5;
      end;
   end;
   else if Census1990IndustryCode_7 = . then do; /*One U.S. Census 1990 industry code maps/redistributes to six U.S. Census 2000 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000IndustryCode = Census2000IndustryCode_1;
         Census2000IndustryTitle = Census2000IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000IndustryCode = Census2000IndustryCode_2;
         Census2000IndustryTitle = Census2000IndustryTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000IndustryCode = Census2000IndustryCode_3;
         Census2000IndustryTitle = Census2000IndustryTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000IndustryCode = Census2000IndustryCode_4;
         Census2000IndustryTitle = Census2000IndustryTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000IndustryCode = Census2000IndustryCode_5;
         Census2000IndustryTitle = Census2000IndustryTitle_5;
      end;
      else do;
         Census2000IndustryCode = Census2000IndustryCode_6;
         Census2000IndustryTitle = Census2000IndustryTitle_6;
      end;
   end;
   else if Census1990IndustryCode_8 = . then do; /*One U.S. Census 1990 industry code maps/redistributes to seven U.S. Census 2000 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000IndustryCode = Census2000IndustryCode_1;
         Census2000IndustryTitle = Census2000IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000IndustryCode = Census2000IndustryCode_2;
         Census2000IndustryTitle = Census2000IndustryTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000IndustryCode = Census2000IndustryCode_3;
         Census2000IndustryTitle = Census2000IndustryTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000IndustryCode = Census2000IndustryCode_4;
         Census2000IndustryTitle = Census2000IndustryTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000IndustryCode = Census2000IndustryCode_5;
         Census2000IndustryTitle = Census2000IndustryTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000IndustryCode = Census2000IndustryCode_6;
         Census2000IndustryTitle = Census2000IndustryTitle_6;
      end;
      else do;
         Census2000IndustryCode = Census2000IndustryCode_7;
         Census2000IndustryTitle = Census2000IndustryTitle_7;
      end;
   end;
   else if Census1990IndustryCode_9 = . then do; /*One U.S. Census 1990 industry code maps/redistributes to eight U.S. Census 2000 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000IndustryCode = Census2000IndustryCode_1;
         Census2000IndustryTitle = Census2000IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000IndustryCode = Census2000IndustryCode_2;
         Census2000IndustryTitle = Census2000IndustryTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000IndustryCode = Census2000IndustryCode_3;
         Census2000IndustryTitle = Census2000IndustryTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000IndustryCode = Census2000IndustryCode_4;
         Census2000IndustryTitle = Census2000IndustryTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000IndustryCode = Census2000IndustryCode_5;
         Census2000IndustryTitle = Census2000IndustryTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000IndustryCode = Census2000IndustryCode_6;
         Census2000IndustryTitle = Census2000IndustryTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000IndustryCode = Census2000IndustryCode_7;
         Census2000IndustryTitle = Census2000IndustryTitle_7;
      end;
      else do;
         Census2000IndustryCode = Census2000IndustryCode_8;
         Census2000IndustryTitle = Census2000IndustryTitle_8;
      end;
   end;
   else if Census1990IndustryCode_10 = . then do; /*One U.S. Census 1990 industry code maps/redistributes to nine U.S. Census 2000 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000IndustryCode = Census2000IndustryCode_1;
         Census2000IndustryTitle = Census2000IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000IndustryCode = Census2000IndustryCode_2;
         Census2000IndustryTitle = Census2000IndustryTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000IndustryCode = Census2000IndustryCode_3;
         Census2000IndustryTitle = Census2000IndustryTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000IndustryCode = Census2000IndustryCode_4;
         Census2000IndustryTitle = Census2000IndustryTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000IndustryCode = Census2000IndustryCode_5;
         Census2000IndustryTitle = Census2000IndustryTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000IndustryCode = Census2000IndustryCode_6;
         Census2000IndustryTitle = Census2000IndustryTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000IndustryCode = Census2000IndustryCode_7;
         Census2000IndustryTitle = Census2000IndustryTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000IndustryCode = Census2000IndustryCode_8;
         Census2000IndustryTitle = Census2000IndustryTitle_8;
      end;
      else do;
         Census2000IndustryCode = Census2000IndustryCode_9;
        Census2000IndustryTitle = Census2000IndustryTitle_9;
       end;
   end;
   else if Census1990IndustryCode_11 = . then do; /*One U.S. Census 1990 industry code maps/redistributes to 10 U.S. Census 2000 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000IndustryCode = Census2000IndustryCode_1;
         Census2000IndustryTitle = Census2000IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000IndustryCode = Census2000IndustryCode_2;
         Census2000IndustryTitle = Census2000IndustryTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000IndustryCode = Census2000IndustryCode_3;
         Census2000IndustryTitle = Census2000IndustryTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000IndustryCode = Census2000IndustryCode_4;
         Census2000IndustryTitle = Census2000IndustryTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000IndustryCode = Census2000IndustryCode_5;
         Census2000IndustryTitle = Census2000IndustryTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000IndustryCode = Census2000IndustryCode_6;
         Census2000IndustryTitle = Census2000IndustryTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000IndustryCode = Census2000IndustryCode_7;
         Census2000IndustryTitle = Census2000IndustryTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000IndustryCode = Census2000IndustryCode_8;
         Census2000IndustryTitle = Census2000IndustryTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000IndustryCode = Census2000IndustryCode_9;
         Census2000IndustryTitle = Census2000IndustryTitle_9;
      end;
      else do;
         Census2000IndustryCode = Census2000IndustryCode_10;
         Census2000IndustryTitle = Census2000IndustryTitle_10;
      end;
   end;
   else if Census1990IndustryCode_13 = . then do; /*One U.S. Census 1990 industry code maps/redistributes to 12 U.S. Census 2000 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000IndustryCode = Census2000IndustryCode_1;
         Census2000IndustryTitle = Census2000IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000IndustryCode = Census2000IndustryCode_2;
         Census2000IndustryTitle = Census2000IndustryTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000IndustryCode = Census2000IndustryCode_3;
         Census2000IndustryTitle = Census2000IndustryTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000IndustryCode = Census2000IndustryCode_4;
         Census2000IndustryTitle = Census2000IndustryTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000IndustryCode = Census2000IndustryCode_5;
         Census2000IndustryTitle = Census2000IndustryTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000IndustryCode = Census2000IndustryCode_6;
         Census2000IndustryTitle = Census2000IndustryTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000IndustryCode = Census2000IndustryCode_7;
         Census2000IndustryTitle = Census2000IndustryTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000IndustryCode = Census2000IndustryCode_8;
         Census2000IndustryTitle = Census2000IndustryTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000IndustryCode = Census2000IndustryCode_9;
         Census2000IndustryTitle = Census2000IndustryTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000IndustryCode = Census2000IndustryCode_10;
         Census2000IndustryTitle = Census2000IndustryTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000IndustryCode = Census2000IndustryCode_11;
         Census2000IndustryTitle = Census2000IndustryTitle_11;
      end;
      else do;
         Census2000IndustryCode = Census2000IndustryCode_12;
         Census2000IndustryTitle = Census2000IndustryTitle_12;
      end;
   end;
   else if Census1990IndustryCode_14 = . then do; /*One U.S. Census 1990 industry code maps/redistributes to 13 U.S. Census 2000 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000IndustryCode = Census2000IndustryCode_1;
         Census2000IndustryTitle = Census2000IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000IndustryCode = Census2000IndustryCode_2;
         Census2000IndustryTitle = Census2000IndustryTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000IndustryCode = Census2000IndustryCode_3;
         Census2000IndustryTitle = Census2000IndustryTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000IndustryCode = Census2000IndustryCode_4;
         Census2000IndustryTitle = Census2000IndustryTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000IndustryCode = Census2000IndustryCode_5;
         Census2000IndustryTitle = Census2000IndustryTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000IndustryCode = Census2000IndustryCode_6;
         Census2000IndustryTitle = Census2000IndustryTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000IndustryCode = Census2000IndustryCode_7;
         Census2000IndustryTitle = Census2000IndustryTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000IndustryCode = Census2000IndustryCode_8;
         Census2000IndustryTitle = Census2000IndustryTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000IndustryCode = Census2000IndustryCode_9;
         Census2000IndustryTitle = Census2000IndustryTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000IndustryCode = Census2000IndustryCode_10;
         Census2000IndustryTitle = Census2000IndustryTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000IndustryCode = Census2000IndustryCode_11;
         Census2000IndustryTitle = Census2000IndustryTitle_11;
      end;
      else if ConversionLowerBound_12 < randnum <= ConversionUpperBound_12 then do;
         Census2000IndustryCode = Census2000IndustryCode_12;
         Census2000IndustryTitle = Census2000IndustryTitle_12;
      end;
      else do;
         Census2000IndustryCode = Census2000IndustryCode_13;
         Census2000IndustryTitle = Census2000IndustryTitle_13;
      end;
   end;
   else if Census1990IndustryCode_18 = . then do; /*One U.S. Census 1990 industry code maps/redistributes to 17 U.S. Census 2000 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000IndustryCode = Census2000IndustryCode_1;
         Census2000IndustryTitle = Census2000IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000IndustryCode = Census2000IndustryCode_2;
         Census2000IndustryTitle = Census2000IndustryTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000IndustryCode = Census2000IndustryCode_3;
         Census2000IndustryTitle = Census2000IndustryTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000IndustryCode = Census2000IndustryCode_4;
         Census2000IndustryTitle = Census2000IndustryTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000IndustryCode = Census2000IndustryCode_5;
         Census2000IndustryTitle = Census2000IndustryTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000IndustryCode = Census2000IndustryCode_6;
         Census2000IndustryTitle = Census2000IndustryTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000IndustryCode = Census2000IndustryCode_7;
         Census2000IndustryTitle = Census2000IndustryTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000IndustryCode = Census2000IndustryCode_8;
         Census2000IndustryTitle = Census2000IndustryTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000IndustryCode = Census2000IndustryCode_9;
         Census2000IndustryTitle = Census2000IndustryTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000IndustryCode = Census2000IndustryCode_10;
         Census2000IndustryTitle = Census2000IndustryTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000IndustryCode = Census2000IndustryCode_11;
         Census2000IndustryTitle = Census2000IndustryTitle_11;
      end;
      else if ConversionLowerBound_12 < randnum <= ConversionUpperBound_12 then do;
         Census2000IndustryCode = Census2000IndustryCode_12;
         Census2000IndustryTitle = Census2000IndustryTitle_12;
      end;
      else if ConversionLowerBound_13 < randnum <= ConversionUpperBound_13 then do;
         Census2000IndustryCode = Census2000IndustryCode_13;
         Census2000IndustryTitle = Census2000IndustryTitle_13;
      end;
      else if ConversionLowerBound_14 < randnum <= ConversionUpperBound_14 then do;
         Census2000IndustryCode = Census2000IndustryCode_14;
         Census2000IndustryTitle = Census2000IndustryTitle_14;
      end;
      else if ConversionLowerBound_15 < randnum <= ConversionUpperBound_15 then do;
         Census2000IndustryCode = Census2000IndustryCode_15;
         Census2000IndustryTitle = Census2000IndustryTitle_15;
      end;
      else if ConversionLowerBound_16 < randnum <= ConversionUpperBound_16 then do;
         Census2000IndustryCode = Census2000IndustryCode_16;
         Census2000IndustryTitle = Census2000IndustryTitle_16;
      end;
      else do;
         Census2000IndustryCode = Census2000IndustryCode_17;
         Census2000IndustryTitle = Census2000IndustryTitle_17;
      end;
   end;
   else do; /*One U.S. Census 1990 industry code maps/redistributes to 37 U.S. Census 2000 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000IndustryCode = Census2000IndustryCode_1;
         Census2000IndustryTitle = Census2000IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000IndustryCode = Census2000IndustryCode_2;
         Census2000IndustryTitle = Census2000IndustryTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000IndustryCode = Census2000IndustryCode_3;
         Census2000IndustryTitle = Census2000IndustryTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000IndustryCode = Census2000IndustryCode_4;
         Census2000IndustryTitle = Census2000IndustryTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000IndustryCode = Census2000IndustryCode_5;
         Census2000IndustryTitle = Census2000IndustryTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000IndustryCode = Census2000IndustryCode_6;
         Census2000IndustryTitle = Census2000IndustryTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000IndustryCode = Census2000IndustryCode_7;
         Census2000IndustryTitle = Census2000IndustryTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000IndustryCode = Census2000IndustryCode_8;
         Census2000IndustryTitle = Census2000IndustryTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000IndustryCode = Census2000IndustryCode_9;
         Census2000IndustryTitle = Census2000IndustryTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000IndustryCode = Census2000IndustryCode_10;
         Census2000IndustryTitle = Census2000IndustryTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000IndustryCode = Census2000IndustryCode_11;
         Census2000IndustryTitle = Census2000IndustryTitle_11;
      end;
      else if ConversionLowerBound_12 < randnum <= ConversionUpperBound_12 then do;
         Census2000IndustryCode = Census2000IndustryCode_12;
         Census2000IndustryTitle = Census2000IndustryTitle_12;
      end;
      else if ConversionLowerBound_13 < randnum <= ConversionUpperBound_13 then do;
         Census2000IndustryCode = Census2000IndustryCode_13;
         Census2000IndustryTitle = Census2000IndustryTitle_13;
      end;
      else if ConversionLowerBound_14 < randnum <= ConversionUpperBound_14 then do;
         Census2000IndustryCode = Census2000IndustryCode_14;
         Census2000IndustryTitle = Census2000IndustryTitle_14;
      end;
      else if ConversionLowerBound_15 < randnum <= ConversionUpperBound_15 then do;
         Census2000IndustryCode = Census2000IndustryCode_15;
         Census2000IndustryTitle = Census2000IndustryTitle_15;
      end;
      else if ConversionLowerBound_16 < randnum <= ConversionUpperBound_16 then do;
         Census2000IndustryCode = Census2000IndustryCode_16;
         Census2000IndustryTitle = Census2000IndustryTitle_16;
      end;
      else if ConversionLowerBound_17 < randnum <= ConversionUpperBound_17 then do;
         Census2000IndustryCode = Census2000IndustryCode_17;
         Census2000IndustryTitle = Census2000IndustryTitle_17;
      end;
      else if ConversionLowerBound_18 < randnum <= ConversionUpperBound_18 then do;
         Census2000IndustryCode = Census2000IndustryCode_18;
         Census2000IndustryTitle = Census2000IndustryTitle_18;
      end;
      else if ConversionLowerBound_19 < randnum <= ConversionUpperBound_19 then do;
         Census2000IndustryCode = Census2000IndustryCode_19;
         Census2000IndustryTitle = Census2000IndustryTitle_19;
      end;
      else if ConversionLowerBound_20 < randnum <= ConversionUpperBound_20 then do;
         Census2000IndustryCode = Census2000IndustryCode_20;
         Census2000IndustryTitle = Census2000IndustryTitle_20;
      end;
      else if ConversionLowerBound_21 < randnum <= ConversionUpperBound_21 then do;
         Census2000IndustryCode = Census2000IndustryCode_21;
         Census2000IndustryTitle = Census2000IndustryTitle_21;
      end;
      else if ConversionLowerBound_22 < randnum <= ConversionUpperBound_22 then do;
         Census2000IndustryCode = Census2000IndustryCode_22;
         Census2000IndustryTitle = Census2000IndustryTitle_22;
      end;
      else if ConversionLowerBound_23 < randnum <= ConversionUpperBound_23 then do;
         Census2000IndustryCode = Census2000IndustryCode_23;
         Census2000IndustryTitle = Census2000IndustryTitle_23;
      end;
      else if ConversionLowerBound_24 < randnum <= ConversionUpperBound_24 then do;
         Census2000IndustryCode = Census2000IndustryCode_24;
         Census2000IndustryTitle = Census2000IndustryTitle_24;
      end;
      else if ConversionLowerBound_25 < randnum <= ConversionUpperBound_25 then do;
         Census2000IndustryCode = Census2000IndustryCode_25;
         Census2000IndustryTitle = Census2000IndustryTitle_25;
      end;
      else if ConversionLowerBound_26 < randnum <= ConversionUpperBound_26 then do;
         Census2000IndustryCode = Census2000IndustryCode_26;
         Census2000IndustryTitle = Census2000IndustryTitle_26;
      end;
      else if ConversionLowerBound_27 < randnum <= ConversionUpperBound_27 then do;
         Census2000IndustryCode = Census2000IndustryCode_27;
         Census2000IndustryTitle = Census2000IndustryTitle_27;
      end;
      else if ConversionLowerBound_28 < randnum <= ConversionUpperBound_28 then do;
         Census2000IndustryCode = Census2000IndustryCode_28;
         Census2000IndustryTitle = Census2000IndustryTitle_28;
      end;
      else if ConversionLowerBound_29 < randnum <= ConversionUpperBound_29 then do;
         Census2000IndustryCode = Census2000IndustryCode_29;
         Census2000IndustryTitle = Census2000IndustryTitle_29;
      end;
      else if ConversionLowerBound_30 < randnum <= ConversionUpperBound_30 then do;
         Census2000IndustryCode = Census2000IndustryCode_30;
         Census2000IndustryTitle = Census2000IndustryTitle_30;
      end;
      else if ConversionLowerBound_31 < randnum <= ConversionUpperBound_31 then do;
         Census2000IndustryCode = Census2000IndustryCode_31;
         Census2000IndustryTitle = Census2000IndustryTitle_31;
      end;
      else if ConversionLowerBound_32 < randnum <= ConversionUpperBound_32 then do;
         Census2000IndustryCode = Census2000IndustryCode_32;
         Census2000IndustryTitle = Census2000IndustryTitle_32;
      end;
      else if ConversionLowerBound_33 < randnum <= ConversionUpperBound_33 then do;
         Census2000IndustryCode = Census2000IndustryCode_33;
         Census2000IndustryTitle = Census2000IndustryTitle_33;
      end;
      else if ConversionLowerBound_34 < randnum <= ConversionUpperBound_34 then do;
         Census2000IndustryCode = Census2000IndustryCode_34;
         Census2000IndustryTitle = Census2000IndustryTitle_34;
      end;
      else if ConversionLowerBound_35 < randnum <= ConversionUpperBound_35 then do;
         Census2000IndustryCode = Census2000IndustryCode_35;
         Census2000IndustryTitle = Census2000IndustryTitle_35;
      end;
      else if ConversionLowerBound_36 < randnum <= ConversionUpperBound_36 then do;
         Census2000IndustryCode = Census2000IndustryCode_36;
         Census2000IndustryTitle = Census2000IndustryTitle_36;
      end;
      else do;
         Census2000IndustryCode = Census2000IndustryCode_37;
         Census2000IndustryTitle = Census2000IndustryTitle_37;
      end;
   end;
run;

/*************************************************************************************************************************/
/*	Convert U.S. Census Bureau 2000 industry codes to U.S. Census Bureau 2002 industry codes.							 */
/*************************************************************************************************************************/

/*1. Read the user’s dataset into SAS.*/

proc import out=USER.dataset_1
            datafile="C:\Desktop\Data\dataset_1.xlsx"
            dbms=EXCEL replace;
            getnames=yes;
run;

/*2. Generate a random number between zero and one from a uniform distribution for each observation (e.g., person) in the user’s dataset and assign this random number to a new variable.*/

data USER.dataset_2;
   set USER.dataset_1;
   call streaminit(622123); /*622123 is a seed number. Users should replace the seed number each time they generate random numbers.*/
   randnum = rand("Uniform");
run;

/*3. Read into SAS eTable 6. Horizontal Crosswalk to convert U.S. Census Bureau 2000 to 2002 Industry Codes (i.e., tab "eTable 6-Ind-2000-2002-Horiz" in the Excel workbook that contains the crosswalks).*/

proc import out=USER.Crosswalk_Ind_2000_2002_1
            datafile="C:\Desktop\Data\Epidemiology-Crosswalks-SDC-Excel-072621.xlsx"
            dbms=EXCEL replace;
            sheet="eTable 6-Ind-2000-2002-Horiz";
            getnames=yes;
run;

/*4. Sort the user’s dataset by the U.S. Census Bureau 2000 industry codes.*/

proc sort data=USER.dataset_2;
   by Census2000IndustryCode;
run;

/*5. Sort eTable 6 by the U.S. Census Bureau 2000 industry codes.*/

proc sort data=USER.Crosswalk_Ind_2000_2002_1;
   by Census2000IndustryCode_1;
run;

/*6. Merge eTable 6 to the user’s dataset by the U.S. Census Bureau 2000 industry codes.*/

data USER.dataset_3;
   merge USER.dataset_2 (rename = (Census2000IndustryCode = Census2000IndustryCode_1)) USER.Crosswalk_Ind_2000_2002_1;
   by Census2000IndustryCode_1;

/*7. Compare the random number for a particular person (i.e., step 2) to the ConversionLowerBound and ConversionUpperBound variables in eTable 6 and assign the U.S. Census Bureau 2002 industry code that corresponds to the ConversionLowerBound and ConversionUpperBound variables that contain the random number. In other words, eTable 6 shows one U.S. Census Bureau 2000 industry code redistributes to between one and three U.S. Census Bureau 2002 industry codes.*/

   if Census2000IndustryCode_2 = . then do; /*One U.S. Census 2000 industry code maps/redistributes to one U.S. Census 2002 industry code.*/
      Census2002IndustryCode = Census2002IndustryCode_1;
      Census2002IndustryTitle = Census2002IndustryTitle_1;
   end;
   else if Census2000IndustryCode_3 = . then do; /*One U.S. Census 2000 industry code maps/redistributes to two U.S. Census 2002 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2002IndustryCode = Census2002IndustryCode_1;
         Census2002IndustryTitle = Census2002IndustryTitle_1;
      end;
      else do;
         Census2002IndustryCode = Census2002IndustryCode_2;
         Census2002IndustryTitle = Census2002IndustryTitle_2;
      end;
   end;
   else do; /*One U.S. Census 2000 industry code maps/redistributes to three U.S. Census 2002 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2002IndustryCode = Census2002IndustryCode_1;
         Census2002IndustryTitle = Census2002IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2002IndustryCode = Census2002IndustryCode_2;
         Census2002IndustryTitle = Census2002IndustryTitle_2;
      end;
      else do;
         Census2002IndustryCode = Census2002IndustryCode_3;
         Census2002IndustryTitle = Census2002IndustryTitle_3;
      end;
   end;
run;

/*************************************************************************************************************************/
/*	Convert U.S. Census Bureau 2002 industry codes to U.S. Census Bureau 2007 industry codes.							 */
/*************************************************************************************************************************/

/*1. Read the user’s dataset into SAS.*/

proc import out=USER.dataset_1
            datafile="C:\Desktop\Data\dataset_1.xlsx"
            dbms=EXCEL replace;
            getnames=yes;
run;

/*2. Generate a random number between zero and one from a uniform distribution for each observation (e.g., person) in the user’s dataset and assign this random number to a new variable.*/

data USER.dataset_2;
   set USER.dataset_1;
   call streaminit(500523); /*500523 is a seed number. Users should replace the seed number each time they generate random numbers.*/
   randnum = rand("Uniform");
run;

/*3. Read into SAS eTable 8. Horizontal Crosswalk to convert U.S. Census Bureau 2002 to 2007 Industry Codes (i.e., tab "eTable 8-Ind-2002-2007-Horiz" in the Excel workbook that contains the crosswalks).*/

proc import out=USER.Crosswalk_Ind_2002_2007_1
            datafile="C:\Desktop\Data\Epidemiology-Crosswalks-SDC-Excel-072621.xlsx"
            dbms=EXCEL replace;
            sheet="eTable 8-Ind-2002-2007-Horiz";
            getnames=yes;
run;

/*4. Sort the user’s dataset by the U.S. Census Bureau 2002 industry codes.*/

proc sort data=USER.dataset_2;
   by Census2002IndustryCode;
run;

/*5. Sort eTable 8 by the U.S. Census Bureau 2002 industry codes.*/

proc sort data=USER.Crosswalk_Ind_2002_2007_1;
   by Census2002IndustryCode_1;
run;

/*6. Merge eTable 8 to the user’s dataset by the U.S. Census Bureau 2002 industry codes.*/

data USER.dataset_3;
   merge USER.dataset_2 (rename = (Census2002IndustryCode = Census2002IndustryCode_1)) USER.Crosswalk_Ind_2002_2007_1;
   by Census2002IndustryCode_1;

/*7. Compare the random number for a particular person (i.e., step 2) to the ConversionLowerBound and ConversionUpperBound variables in eTable 8 and assign the U.S. Census Bureau 2007 industry code that corresponds to the ConversionLowerBound and ConversionUpperBound variables that contain the random number. In other words, eTable 8 shows one U.S. Census Bureau 2002 industry code redistributes to between one and three U.S. Census Bureau 2007 industry codes.*/

   if Census2002IndustryCode_2 = . then do; /*One U.S. Census 2002 industry code maps/redistributes to one U.S. Census 2007 industry code.*/
      Census2007IndustryCode = Census2007IndustryCode_1;
      Census2007IndustryTitle = Census2007IndustryTitle_1;
   end;
   else if Census2002IndustryCode_3 = . then do; /*One U.S. Census 2002 industry code maps/redistributes to two U.S. Census 2007 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2007IndustryCode = Census2007IndustryCode_1;
         Census2007IndustryTitle = Census2007IndustryTitle_1;
      end;
      else do;
         Census2007IndustryCode = Census2007IndustryCode_2;
         Census2007IndustryTitle = Census2007IndustryTitle_2;
      end;
   end;
   else do; /*One U.S. Census 2002 industry code maps/redistributes to three U.S. Census 2007 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2007IndustryCode = Census2007IndustryCode_1;
         Census2007IndustryTitle = Census2007IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2007IndustryCode = Census2007IndustryCode_2;
         Census2007IndustryTitle = Census2007IndustryTitle_2;
      end;
      else do;
         Census2007IndustryCode = Census2007IndustryCode_3;
         Census2007IndustryTitle = Census2007IndustryTitle_3;
      end;
   end;
run;

/*************************************************************************************************************************/
/*	Convert U.S. Census Bureau 2007 industry codes to U.S. Census Bureau 2012 industry codes.							 */
/*************************************************************************************************************************/

/*1. Read the user’s dataset into SAS.*/

proc import out=USER.dataset_1
            datafile="C:\Desktop\Data\dataset_1.xlsx"
            dbms=EXCEL replace;
            getnames=yes;
run;

/*2. Generate a random number between zero and one from a uniform distribution for each observation (e.g., person) in the user’s dataset and assign this random number to a new variable.*/

data USER.dataset_2;
   set USER.dataset_1;
   call streaminit(984769); /*984769 is a seed number. Users should replace the seed number each time they generate random numbers.*/
   randnum = rand("Uniform");
run;

/*3. Read into SAS eTable 10. Horizontal Crosswalk to convert U.S. Census Bureau 2007 to 2012 Industry Codes (i.e., tab "eTable 10-Ind-2007-2012-Horiz" in the Excel workbook that contains the crosswalks).*/

proc import out=USER.Crosswalk_Ind_2007_2012_1
            datafile="C:\Desktop\Data\Epidemiology-Crosswalks-SDC-Excel-072621.xlsx"
            dbms=EXCEL replace;
            sheet="eTable 10-Ind-2007-2012-Horiz";
            getnames=yes;
run;

/*4. Sort the user’s dataset by the U.S. Census Bureau 2007 industry codes.*/

proc sort data=USER.dataset_2;
   by Census2007IndustryCode;
run;

/*5. Sort eTable 10 by the U.S. Census Bureau 2007 industry codes.*/

proc sort data=USER.Crosswalk_Ind_2007_2012_1;
   by Census2007IndustryCode_1;
run;

/*6. Merge eTable 10 to the user’s dataset by the U.S. Census Bureau 2007 industry codes.*/

data USER.dataset_3;
   merge USER.dataset_2 (rename = (Census2007IndustryCode = Census2007IndustryCode_1)) USER.Crosswalk_Ind_2007_2012_1;
   by Census2007IndustryCode_1;

/*7. Compare the random number for a particular person (i.e., step 2) to the ConversionLowerBound and ConversionUpperBound variables in eTable 10 and assign the U.S. Census Bureau 2012 industry code that corresponds to the ConversionLowerBound and ConversionUpperBound variables that contain the random number. In other words, eTable 10 shows one U.S. Census Bureau 2007 industry code redistributes to between one and two U.S. Census Bureau 2012 industry codes.*/

   if Census2007IndustryCode_2 = . then do; /*One U.S. Census 2007 industry code maps/redistributes to one U.S. Census 2012 industry code.*/
      Census2012IndustryCode = Census2012IndustryCode_1;
      Census2012IndustryTitle = Census2012IndustryTitle_1;
   end;
   else do; /*One U.S. Census 2007 industry code maps/redistributes to two U.S. Census 2012 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2012IndustryCode = Census2012IndustryCode_1;
         Census2012IndustryTitle = Census2012IndustryTitle_1;
      end;
      else do;
         Census2012IndustryCode = Census2012IndustryCode_2;
         Census2012IndustryTitle = Census2012IndustryTitle_2;
      end;
   end;
run;

/*************************************************************************************************************************/
/*	Convert U.S. Census Bureau 2012 industry codes to U.S. Census Bureau 2017 industry codes.							 */
/*************************************************************************************************************************/

/*1. Read the user’s dataset into SAS.*/

proc import out=USER.dataset_1
            datafile="C:\Desktop\Data\dataset_1.xlsx"
            dbms=EXCEL replace;
            getnames=yes;
run;

/*2. Generate a random number between zero and one from a uniform distribution for each observation (e.g., person) in the user’s dataset and assign this random number to a new variable.*/

data USER.dataset_2;
   set USER.dataset_1;
   call streaminit(845755); /*845755 is a seed number. Users should replace the seed number each time they generate random numbers.*/
   randnum = rand("Uniform");
run;

/*3. Read into SAS eTable 12. Horizontal Crosswalk to convert U.S. Census Bureau 2012 to 2017 Industry Codes (i.e., tab "eTable 12-Ind-2012-2017-Horiz" in the Excel workbook that contains the crosswalks).*/

proc import out=USER.Crosswalk_Ind_2012_2017_1
            datafile="C:\Desktop\Data\Epidemiology-Crosswalks-SDC-Excel-072621.xlsx"
            dbms=EXCEL replace;
            sheet="eTable 12-Ind-2012-2017-Horiz";
            getnames=yes;
run;

/*4. Sort the user’s dataset by the U.S. Census Bureau 2012 industry codes.*/

proc sort data=USER.dataset_2;
   by Census2012IndustryCode;
run;

/*5. Sort eTable 12 by the U.S. Census Bureau 2012 industry codes.*/

proc sort data=USER.Crosswalk_Ind_2012_2017_1;
   by Census2012IndustryCode_1;
run;

/*6. Merge eTable 12 to the user’s dataset by the U.S. Census Bureau 2012 industry codes.*/

data USER.dataset_3;
   merge USER.dataset_2 (rename = (Census2012IndustryCode = Census2012IndustryCode_1)) USER.Crosswalk_Ind_2012_2017_1;
   by Census2012IndustryCode_1;

/*7. Compare the random number for a particular person (i.e., step 2) to the ConversionLowerBound and ConversionUpperBound variables in eTable 12 and assign the U.S. Census Bureau 2017 industry code that corresponds to the ConversionLowerBound and ConversionUpperBound variables that contain the random number. In other words, eTable 12 shows one U.S. Census Bureau 2012 industry code redistributes to between one and four U.S. Census Bureau 2017 industry codes.*/

   if Census2012IndustryCode_2 = . then do; /*One U.S. Census 2012 industry code maps/redistributes to one U.S. Census 2017 industry code.*/
      Census2017IndustryCode = Census2017IndustryCode_1;
      Census2017IndustryTitle = Census2017IndustryTitle_1;
   end;
   else if Census2012IndustryCode_3 = . then do; /*One U.S. Census 2012 industry code maps/redistributes to two U.S. Census 2017 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2017IndustryCode = Census2017IndustryCode_1;
         Census2017IndustryTitle = Census2017IndustryTitle_1;
      end;
      else do;
         Census2017IndustryCode = Census2017IndustryCode_2;
         Census2017IndustryTitle = Census2017IndustryTitle_2;
      end;
   end;
   else do; /*One U.S. Census 2012 industry code maps/redistributes to four U.S. Census 2017 industry codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2017IndustryCode = Census2017IndustryCode_1;
         Census2017IndustryTitle = Census2017IndustryTitle_1;
      end;
      else if ConversionLowerBound_2 <= randnum <= ConversionUpperBound_2 then do;
         Census2017IndustryCode = Census2017IndustryCode_2;
         Census2017IndustryTitle = Census2017IndustryTitle_2;
      end;
      else if ConversionLowerBound_3 <= randnum <= ConversionUpperBound_3 then do;
         Census2017IndustryCode = Census2017IndustryCode_3;
         Census2017IndustryTitle = Census2017IndustryTitle_3;
      end;
      else do;
         Census2017IndustryCode = Census2017IndustryCode_4;
         Census2017IndustryTitle = Census2017IndustryTitle_4;
      end;
   end;
run;

/*************************************************************************************************************************/
/*																														 */
/*	Occupation Crosswalks.																								 */
/*																														 */
/*************************************************************************************************************************/

/*************************************************************************************************************************/
/*	Convert U.S. Census Bureau 1980 occupation codes to U.S. Census Bureau 1990 occupation codes.						 */
/*************************************************************************************************************************/

/*1. Read the user’s dataset into SAS.*/

proc import out=USER.dataset_1
            datafile="C:\Desktop\Data\dataset_1.xlsx"
            dbms=EXCEL replace;
            getnames=yes;
run;

/*2. Generate a random number between zero and one from a uniform distribution for each observation (e.g., person) in the user’s dataset and assign this random number to a new variable.*/

data USER.dataset_2;
   set USER.dataset_1;
   call streaminit(590331); /*590331 is a seed number. Users should replace the seed number each time they generate random numbers.*/
   randnum = rand("Uniform");
run;

/*3. Read into SAS eTable 14. Horizontal Crosswalk to convert U.S. Census Bureau 1980 to 1990 Occupation Codes (i.e., tab "eTable 14-Occ-1980-1990-Horiz" in the Excel workbook that contains the crosswalks).*/

proc import out=USER.Crosswalk_Occ_1980_1990_1
            datafile="C:\Desktop\Data\Epidemiology-Crosswalks-SDC-Excel-072621.xlsx"
            dbms=EXCEL replace;
            sheet="eTable 14-Occ-1980-1990-Horiz";
            getnames=yes;
run;

/*4. Sort the user’s dataset by the U.S. Census Bureau 1980 occupation codes.*/

proc sort data=USER.dataset_2;
   by Census1980OccupationCode;
run;

/*5. Sort eTable 14 by the U.S. Census Bureau 1980 occupation codes.*/

proc sort data=USER.Crosswalk_Occ_1980_1990_1;
   by Census1980OccupationCode_1;
run;

/*6. Merge eTable 14 to the user’s dataset by the U.S. Census Bureau 1980 occupation codes.*/

data USER.dataset_3;
   merge USER.dataset_2 (rename = (Census1980OccupationCode = Census1980OccupationCode_1)) USER.Crosswalk_Occ_1980_1990_1;
   by Census1980OccupationCode_1;

/*7. Compare the random number for a particular person (i.e., step 2) to the ConversionLowerBound and ConversionUpperBound variables in eTable 14 and assign the U.S. Census Bureau 1990 occupation code that corresponds to the ConversionLowerBound and ConversionUpperBound variables that contain the random number. In other words, eTable 14 shows one U.S. Census Bureau 1980 occupation code redistributes to between one and three U.S. Census Bureau 1990 occupation codes.*/

   if Census1980OccupationCode_2 = . then do; /*One U.S. Census 1980 occupation code maps/redistributes to one U.S. Census 1990 occupation code.*/
      Census1990OccupationCode = Census1990OccupationCode_1;
      Census1990OccupationTitle = Census1990OccupationTitle_1;
   end;
   else if Census1980OccupationCode_3 = . then do; /*One U.S. Census 1980 occupation code maps/redistributes to two U.S. Census 1990 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census1990OccupationCode = Census1990OccupationCode_1;
         Census1990OccupationTitle = Census1990OccupationTitle_1;
      end;
      else do;
         Census1990OccupationCode = Census1990OccupationCode_2;
         Census1990OccupationTitle = Census1990OccupationTitle_2;
      end;
   end;
   else do; /*One U.S. Census 1980 occupation code maps/redistributes to three U.S. Census 1990 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census1990OccupationCode = Census1990OccupationCode_1;
         Census1990OccupationTitle = Census1990OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census1990OccupationCode = Census1990OccupationCode_2;
         Census1990OccupationTitle = Census1990OccupationTitle_2;
      end;
      else do;
         Census1990OccupationCode = Census1990OccupationCode_3;
         Census1990OccupationTitle = Census1990OccupationTitle_3;
      end;
   end;
run;

/*************************************************************************************************************************/
/*	Convert U.S. Census Bureau 1990 occupation codes to U.S. Census Bureau 2000 occupation codes.						 */
/*************************************************************************************************************************/

/*1. Read the user’s dataset into SAS.*/

proc import out=USER.dataset_1
            datafile="C:\Desktop\Data\dataset_1.xlsx"
            dbms=EXCEL replace;
            getnames=yes;
run;

/*2. Generate a random number between zero and one from a uniform distribution for each observation (e.g., person) in the user’s dataset and assign this random number to a new variable.*/

data USER.dataset_2;
   set USER.dataset_1;
   call streaminit(466281); /*466281 is a seed number. Users should replace the seed number each time they generate random numbers.*/
   randnum = rand("Uniform");
run;

/*3. Read into SAS eTable 16. Horizontal Crosswalk to convert U.S. Census Bureau 1990 to 2000 Occupation Codes (i.e., tab "eTable 16-Occ-1990-2000-Horiz" in the Excel workbook that contains the crosswalks).*/

proc import out=USER.Crosswalk_Occ_1990_2000_1
            datafile="C:\Desktop\Data\Epidemiology-Crosswalks-SDC-Excel-072621.xlsx"
            dbms=EXCEL replace;
            sheet="eTable 16-Occ-1990-2000-Horiz";
            getnames=yes;
run;

/*4. Sort the user’s dataset by the U.S. Census Bureau 1990 occupation codes.*/

proc sort data=USER.dataset_2;
   by Census1990OccupationCode;
run;

/*5. Sort eTable 16 by the U.S. Census Bureau 1990 occupation codes.*/

proc sort data=USER.Crosswalk_Occ_1990_2000_1;
   by Census1990OccupationCode_1;
run;

/*6. Merge eTable 16 to the user’s dataset by the U.S. Census Bureau 1990 occupation codes.*/

data USER.dataset_3;
   merge USER.dataset_2 (rename = (Census1990OccupationCode = Census1990OccupationCode_1)) USER.Crosswalk_Occ_1990_2000_1;
   by Census1990OccupationCode_1;

/*7. Compare the random number for a particular person (i.e., step 2) to the ConversionLowerBound and ConversionUpperBound variables in eTable 16 and assign the U.S. Census Bureau 2000 occupation code that corresponds to the ConversionLowerBound and ConversionUpperBound variables that contain the random number. In other words, eTable 16 shows one U.S. Census Bureau 1990 occupation code redistributes to between one and 36 U.S. Census Bureau 2000 occupation codes.*/

   if Census1990OccupationCode_2 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to one U.S. Census 2000 occupation code.*/
      Census2000OccupationCode = Census2000OccupationCode_1;
      Census2000OccupationTitle = Census2000OccupationTitle_1;
   end;
   else if Census1990OccupationCode_3 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to two U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
   end;
   else if Census1990OccupationCode_4 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to three U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
   end;
   else if Census1990OccupationCode_5 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to four U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
   end;
   else if Census1990OccupationCode_6 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to five U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
   end;
   else if Census1990OccupationCode_7 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to six U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
   end;
   else if Census1990OccupationCode_8 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to seven U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
   end;
   else if Census1990OccupationCode_9 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to eight U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
   end;
   else if Census1990OccupationCode_10 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to nine U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_9;
         Census2000OccupationTitle = Census2000OccupationTitle_9;
      end;
   end;
   else if Census1990OccupationCode_11 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to 10 U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000OccupationCode = Census2000OccupationCode_9;
         Census2000OccupationTitle = Census2000OccupationTitle_9;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_10;
         Census2000OccupationTitle = Census2000OccupationTitle_10;
      end;
   end;
   else if Census1990OccupationCode_12 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to 11 U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000OccupationCode = Census2000OccupationCode_9;
         Census2000OccupationTitle = Census2000OccupationTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000OccupationCode = Census2000OccupationCode_10;
         Census2000OccupationTitle = Census2000OccupationTitle_10;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_11;
         Census2000OccupationTitle = Census2000OccupationTitle_11;
      end;
   end;
   else if Census1990OccupationCode_13 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to 12 U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000OccupationCode = Census2000OccupationCode_9;
         Census2000OccupationTitle = Census2000OccupationTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000OccupationCode = Census2000OccupationCode_10;
         Census2000OccupationTitle = Census2000OccupationTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000OccupationCode = Census2000OccupationCode_11;
         Census2000OccupationTitle = Census2000OccupationTitle_11;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_12;
         Census2000OccupationTitle = Census2000OccupationTitle_12;
      end;
   end;
   else if Census1990OccupationCode_14 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to 13 U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000OccupationCode = Census2000OccupationCode_9;
         Census2000OccupationTitle = Census2000OccupationTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000OccupationCode = Census2000OccupationCode_10;
         Census2000OccupationTitle = Census2000OccupationTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000OccupationCode = Census2000OccupationCode_11;
         Census2000OccupationTitle = Census2000OccupationTitle_11;
      end;
      else if ConversionLowerBound_12 < randnum <= ConversionUpperBound_12 then do;
         Census2000OccupationCode = Census2000OccupationCode_12;
         Census2000OccupationTitle = Census2000OccupationTitle_12;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_13;
         Census2000OccupationTitle = Census2000OccupationTitle_13;
      end;
   end;
   else if Census1990OccupationCode_15 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to 14 U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000OccupationCode = Census2000OccupationCode_9;
         Census2000OccupationTitle = Census2000OccupationTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000OccupationCode = Census2000OccupationCode_10;
         Census2000OccupationTitle = Census2000OccupationTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000OccupationCode = Census2000OccupationCode_11;
         Census2000OccupationTitle = Census2000OccupationTitle_11;
      end;
      else if ConversionLowerBound_12 < randnum <= ConversionUpperBound_12 then do;
         Census2000OccupationCode = Census2000OccupationCode_12;
         Census2000OccupationTitle = Census2000OccupationTitle_12;
      end;
      else if ConversionLowerBound_13 < randnum <= ConversionUpperBound_13 then do;
         Census2000OccupationCode = Census2000OccupationCode_13;
         Census2000OccupationTitle = Census2000OccupationTitle_13;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_14;
         Census2000OccupationTitle = Census2000OccupationTitle_14;
      end;
   end;
   else if Census1990OccupationCode_19 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to 18 U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000OccupationCode = Census2000OccupationCode_9;
         Census2000OccupationTitle = Census2000OccupationTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000OccupationCode = Census2000OccupationCode_10;
         Census2000OccupationTitle = Census2000OccupationTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000OccupationCode = Census2000OccupationCode_11;
         Census2000OccupationTitle = Census2000OccupationTitle_11;
      end;
      else if ConversionLowerBound_12 < randnum <= ConversionUpperBound_12 then do;
         Census2000OccupationCode = Census2000OccupationCode_12;
         Census2000OccupationTitle = Census2000OccupationTitle_12;
      end;
      else if ConversionLowerBound_13 < randnum <= ConversionUpperBound_13 then do;
         Census2000OccupationCode = Census2000OccupationCode_13;
         Census2000OccupationTitle = Census2000OccupationTitle_13;
      end;
      else if ConversionLowerBound_14 < randnum <= ConversionUpperBound_14 then do;
         Census2000OccupationCode = Census2000OccupationCode_14;
         Census2000OccupationTitle = Census2000OccupationTitle_14;
      end;
      else if ConversionLowerBound_15 < randnum <= ConversionUpperBound_15 then do;
         Census2000OccupationCode = Census2000OccupationCode_15;
         Census2000OccupationTitle = Census2000OccupationTitle_15;
      end;
      else if ConversionLowerBound_16 < randnum <= ConversionUpperBound_16 then do;
         Census2000OccupationCode = Census2000OccupationCode_16;
         Census2000OccupationTitle = Census2000OccupationTitle_16;
      end;
      else if ConversionLowerBound_17 < randnum <= ConversionUpperBound_17 then do;
         Census2000OccupationCode = Census2000OccupationCode_17;
         Census2000OccupationTitle = Census2000OccupationTitle_17;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_18;
         Census2000OccupationTitle = Census2000OccupationTitle_18;
      end;
   end;
   else if Census1990OccupationCode_20 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to 19 U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000OccupationCode = Census2000OccupationCode_9;
         Census2000OccupationTitle = Census2000OccupationTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000OccupationCode = Census2000OccupationCode_10;
         Census2000OccupationTitle = Census2000OccupationTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000OccupationCode = Census2000OccupationCode_11;
         Census2000OccupationTitle = Census2000OccupationTitle_11;
      end;
      else if ConversionLowerBound_12 < randnum <= ConversionUpperBound_12 then do;
         Census2000OccupationCode = Census2000OccupationCode_12;
         Census2000OccupationTitle = Census2000OccupationTitle_12;
      end;
      else if ConversionLowerBound_13 < randnum <= ConversionUpperBound_13 then do;
         Census2000OccupationCode = Census2000OccupationCode_13;
         Census2000OccupationTitle = Census2000OccupationTitle_13;
      end;
      else if ConversionLowerBound_14 < randnum <= ConversionUpperBound_14 then do;
         Census2000OccupationCode = Census2000OccupationCode_14;
         Census2000OccupationTitle = Census2000OccupationTitle_14;
      end;
      else if ConversionLowerBound_15 < randnum <= ConversionUpperBound_15 then do;
         Census2000OccupationCode = Census2000OccupationCode_15;
         Census2000OccupationTitle = Census2000OccupationTitle_15;
      end;
      else if ConversionLowerBound_16 < randnum <= ConversionUpperBound_16 then do;
         Census2000OccupationCode = Census2000OccupationCode_16;
         Census2000OccupationTitle = Census2000OccupationTitle_16;
      end;
      else if ConversionLowerBound_17 < randnum <= ConversionUpperBound_17 then do;
         Census2000OccupationCode = Census2000OccupationCode_17;
         Census2000OccupationTitle = Census2000OccupationTitle_17;
      end;
      else if ConversionLowerBound_18 < randnum <= ConversionUpperBound_18 then do;
         Census2000OccupationCode = Census2000OccupationCode_18;
         Census2000OccupationTitle = Census2000OccupationTitle_18;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_19;
         Census2000OccupationTitle = Census2000OccupationTitle_19;
      end;
   end;
   else if Census1990OccupationCode_21 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to 20 U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000OccupationCode = Census2000OccupationCode_9;
         Census2000OccupationTitle = Census2000OccupationTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000OccupationCode = Census2000OccupationCode_10;
         Census2000OccupationTitle = Census2000OccupationTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000OccupationCode = Census2000OccupationCode_11;
         Census2000OccupationTitle = Census2000OccupationTitle_11;
      end;
      else if ConversionLowerBound_12 < randnum <= ConversionUpperBound_12 then do;
         Census2000OccupationCode = Census2000OccupationCode_12;
         Census2000OccupationTitle = Census2000OccupationTitle_12;
      end;
      else if ConversionLowerBound_13 < randnum <= ConversionUpperBound_13 then do;
         Census2000OccupationCode = Census2000OccupationCode_13;
         Census2000OccupationTitle = Census2000OccupationTitle_13;
      end;
      else if ConversionLowerBound_14 < randnum <= ConversionUpperBound_14 then do;
         Census2000OccupationCode = Census2000OccupationCode_14;
         Census2000OccupationTitle = Census2000OccupationTitle_14;
      end;
      else if ConversionLowerBound_15 < randnum <= ConversionUpperBound_15 then do;
         Census2000OccupationCode = Census2000OccupationCode_15;
         Census2000OccupationTitle = Census2000OccupationTitle_15;
      end;
      else if ConversionLowerBound_16 < randnum <= ConversionUpperBound_16 then do;
         Census2000OccupationCode = Census2000OccupationCode_16;
         Census2000OccupationTitle = Census2000OccupationTitle_16;
      end;
      else if ConversionLowerBound_17 < randnum <= ConversionUpperBound_17 then do;
         Census2000OccupationCode = Census2000OccupationCode_17;
         Census2000OccupationTitle = Census2000OccupationTitle_17;
      end;
      else if ConversionLowerBound_18 < randnum <= ConversionUpperBound_18 then do;
         Census2000OccupationCode = Census2000OccupationCode_18;
         Census2000OccupationTitle = Census2000OccupationTitle_18;
      end;
      else if ConversionLowerBound_19 < randnum <= ConversionUpperBound_19 then do;
         Census2000OccupationCode = Census2000OccupationCode_19;
         Census2000OccupationTitle = Census2000OccupationTitle_19;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_20;
         Census2000OccupationTitle = Census2000OccupationTitle_20;
      end;
   end;
   else if Census1990OccupationCode_26 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to 25 U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000OccupationCode = Census2000OccupationCode_9;
         Census2000OccupationTitle = Census2000OccupationTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000OccupationCode = Census2000OccupationCode_10;
         Census2000OccupationTitle = Census2000OccupationTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000OccupationCode = Census2000OccupationCode_11;
         Census2000OccupationTitle = Census2000OccupationTitle_11;
      end;
      else if ConversionLowerBound_12 < randnum <= ConversionUpperBound_12 then do;
         Census2000OccupationCode = Census2000OccupationCode_12;
         Census2000OccupationTitle = Census2000OccupationTitle_12;
      end;
      else if ConversionLowerBound_13 < randnum <= ConversionUpperBound_13 then do;
         Census2000OccupationCode = Census2000OccupationCode_13;
         Census2000OccupationTitle = Census2000OccupationTitle_13;
      end;
      else if ConversionLowerBound_14 < randnum <= ConversionUpperBound_14 then do;
         Census2000OccupationCode = Census2000OccupationCode_14;
         Census2000OccupationTitle = Census2000OccupationTitle_14;
      end;
      else if ConversionLowerBound_15 < randnum <= ConversionUpperBound_15 then do;
         Census2000OccupationCode = Census2000OccupationCode_15;
         Census2000OccupationTitle = Census2000OccupationTitle_15;
      end;
      else if ConversionLowerBound_16 < randnum <= ConversionUpperBound_16 then do;
         Census2000OccupationCode = Census2000OccupationCode_16;
         Census2000OccupationTitle = Census2000OccupationTitle_16;
      end;
      else if ConversionLowerBound_17 < randnum <= ConversionUpperBound_17 then do;
         Census2000OccupationCode = Census2000OccupationCode_17;
         Census2000OccupationTitle = Census2000OccupationTitle_17;
      end;
      else if ConversionLowerBound_18 < randnum <= ConversionUpperBound_18 then do;
         Census2000OccupationCode = Census2000OccupationCode_18;
         Census2000OccupationTitle = Census2000OccupationTitle_18;
      end;
      else if ConversionLowerBound_19 < randnum <= ConversionUpperBound_19 then do;
         Census2000OccupationCode = Census2000OccupationCode_19;
         Census2000OccupationTitle = Census2000OccupationTitle_19;
      end;
      else if ConversionLowerBound_20 < randnum <= ConversionUpperBound_20 then do;
         Census2000OccupationCode = Census2000OccupationCode_20;
         Census2000OccupationTitle = Census2000OccupationTitle_20;
      end;
      else if ConversionLowerBound_21 < randnum <= ConversionUpperBound_21 then do;
         Census2000OccupationCode = Census2000OccupationCode_21;
         Census2000OccupationTitle = Census2000OccupationTitle_21;
      end;
      else if ConversionLowerBound_22 < randnum <= ConversionUpperBound_22 then do;
         Census2000OccupationCode = Census2000OccupationCode_22;
         Census2000OccupationTitle = Census2000OccupationTitle_22;
      end;
      else if ConversionLowerBound_23 < randnum <= ConversionUpperBound_23 then do;
         Census2000OccupationCode = Census2000OccupationCode_23;
         Census2000OccupationTitle = Census2000OccupationTitle_23;
      end;
      else if ConversionLowerBound_24 < randnum <= ConversionUpperBound_24 then do;
         Census2000OccupationCode = Census2000OccupationCode_24;
         Census2000OccupationTitle = Census2000OccupationTitle_24;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_25;
         Census2000OccupationTitle = Census2000OccupationTitle_25;
      end;
   end;
   else if Census1990OccupationCode_30 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to 29 U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000OccupationCode = Census2000OccupationCode_9;
         Census2000OccupationTitle = Census2000OccupationTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000OccupationCode = Census2000OccupationCode_10;
         Census2000OccupationTitle = Census2000OccupationTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000OccupationCode = Census2000OccupationCode_11;
         Census2000OccupationTitle = Census2000OccupationTitle_11;
      end;
      else if ConversionLowerBound_12 < randnum <= ConversionUpperBound_12 then do;
         Census2000OccupationCode = Census2000OccupationCode_12;
         Census2000OccupationTitle = Census2000OccupationTitle_12;
      end;
      else if ConversionLowerBound_13 < randnum <= ConversionUpperBound_13 then do;
         Census2000OccupationCode = Census2000OccupationCode_13;
         Census2000OccupationTitle = Census2000OccupationTitle_13;
      end;
      else if ConversionLowerBound_14 < randnum <= ConversionUpperBound_14 then do;
         Census2000OccupationCode = Census2000OccupationCode_14;
         Census2000OccupationTitle = Census2000OccupationTitle_14;
      end;
      else if ConversionLowerBound_15 < randnum <= ConversionUpperBound_15 then do;
         Census2000OccupationCode = Census2000OccupationCode_15;
         Census2000OccupationTitle = Census2000OccupationTitle_15;
      end;
      else if ConversionLowerBound_16 < randnum <= ConversionUpperBound_16 then do;
         Census2000OccupationCode = Census2000OccupationCode_16;
         Census2000OccupationTitle = Census2000OccupationTitle_16;
      end;
      else if ConversionLowerBound_17 < randnum <= ConversionUpperBound_17 then do;
         Census2000OccupationCode = Census2000OccupationCode_17;
         Census2000OccupationTitle = Census2000OccupationTitle_17;
      end;
      else if ConversionLowerBound_18 < randnum <= ConversionUpperBound_18 then do;
         Census2000OccupationCode = Census2000OccupationCode_18;
         Census2000OccupationTitle = Census2000OccupationTitle_18;
      end;
      else if ConversionLowerBound_19 < randnum <= ConversionUpperBound_19 then do;
         Census2000OccupationCode = Census2000OccupationCode_19;
         Census2000OccupationTitle = Census2000OccupationTitle_19;
      end;
      else if ConversionLowerBound_20 < randnum <= ConversionUpperBound_20 then do;
         Census2000OccupationCode = Census2000OccupationCode_20;
         Census2000OccupationTitle = Census2000OccupationTitle_20;
      end;
      else if ConversionLowerBound_21 < randnum <= ConversionUpperBound_21 then do;
         Census2000OccupationCode = Census2000OccupationCode_21;
         Census2000OccupationTitle = Census2000OccupationTitle_21;
      end;
      else if ConversionLowerBound_22 < randnum <= ConversionUpperBound_22 then do;
         Census2000OccupationCode = Census2000OccupationCode_22;
         Census2000OccupationTitle = Census2000OccupationTitle_22;
      end;
      else if ConversionLowerBound_23 < randnum <= ConversionUpperBound_23 then do;
         Census2000OccupationCode = Census2000OccupationCode_23;
         Census2000OccupationTitle = Census2000OccupationTitle_23;
      end;
      else if ConversionLowerBound_24 < randnum <= ConversionUpperBound_24 then do;
         Census2000OccupationCode = Census2000OccupationCode_24;
         Census2000OccupationTitle = Census2000OccupationTitle_24;
      end;
      else if ConversionLowerBound_25 < randnum <= ConversionUpperBound_25 then do;
         Census2000OccupationCode = Census2000OccupationCode_25;
         Census2000OccupationTitle = Census2000OccupationTitle_25;
      end;
      else if ConversionLowerBound_26 < randnum <= ConversionUpperBound_26 then do;
         Census2000OccupationCode = Census2000OccupationCode_26;
         Census2000OccupationTitle = Census2000OccupationTitle_26;
      end;
      else if ConversionLowerBound_27 < randnum <= ConversionUpperBound_27 then do;
         Census2000OccupationCode = Census2000OccupationCode_27;
         Census2000OccupationTitle = Census2000OccupationTitle_27;
      end;
      else if ConversionLowerBound_28 < randnum <= ConversionUpperBound_28 then do;
         Census2000OccupationCode = Census2000OccupationCode_28;
         Census2000OccupationTitle = Census2000OccupationTitle_28;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_29;
         Census2000OccupationTitle = Census2000OccupationTitle_29;
      end;
   end;
   else if Census1990OccupationCode_33 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to 32 U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000OccupationCode = Census2000OccupationCode_9;
         Census2000OccupationTitle = Census2000OccupationTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000OccupationCode = Census2000OccupationCode_10;
         Census2000OccupationTitle = Census2000OccupationTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000OccupationCode = Census2000OccupationCode_11;
         Census2000OccupationTitle = Census2000OccupationTitle_11;
      end;
      else if ConversionLowerBound_12 < randnum <= ConversionUpperBound_12 then do;
         Census2000OccupationCode = Census2000OccupationCode_12;
         Census2000OccupationTitle = Census2000OccupationTitle_12;
      end;
      else if ConversionLowerBound_13 < randnum <= ConversionUpperBound_13 then do;
         Census2000OccupationCode = Census2000OccupationCode_13;
         Census2000OccupationTitle = Census2000OccupationTitle_13;
      end;
      else if ConversionLowerBound_14 < randnum <= ConversionUpperBound_14 then do;
         Census2000OccupationCode = Census2000OccupationCode_14;
         Census2000OccupationTitle = Census2000OccupationTitle_14;
      end;
      else if ConversionLowerBound_15 < randnum <= ConversionUpperBound_15 then do;
         Census2000OccupationCode = Census2000OccupationCode_15;
         Census2000OccupationTitle = Census2000OccupationTitle_15;
      end;
      else if ConversionLowerBound_16 < randnum <= ConversionUpperBound_16 then do;
         Census2000OccupationCode = Census2000OccupationCode_16;
         Census2000OccupationTitle = Census2000OccupationTitle_16;
      end;
      else if ConversionLowerBound_17 < randnum <= ConversionUpperBound_17 then do;
         Census2000OccupationCode = Census2000OccupationCode_17;
         Census2000OccupationTitle = Census2000OccupationTitle_17;
      end;
      else if ConversionLowerBound_18 < randnum <= ConversionUpperBound_18 then do;
         Census2000OccupationCode = Census2000OccupationCode_18;
         Census2000OccupationTitle = Census2000OccupationTitle_18;
      end;
      else if ConversionLowerBound_19 < randnum <= ConversionUpperBound_19 then do;
         Census2000OccupationCode = Census2000OccupationCode_19;
         Census2000OccupationTitle = Census2000OccupationTitle_19;
      end;
      else if ConversionLowerBound_20 < randnum <= ConversionUpperBound_20 then do;
         Census2000OccupationCode = Census2000OccupationCode_20;
         Census2000OccupationTitle = Census2000OccupationTitle_20;
      end;
      else if ConversionLowerBound_21 < randnum <= ConversionUpperBound_21 then do;
         Census2000OccupationCode = Census2000OccupationCode_21;
         Census2000OccupationTitle = Census2000OccupationTitle_21;
      end;
      else if ConversionLowerBound_22 < randnum <= ConversionUpperBound_22 then do;
         Census2000OccupationCode = Census2000OccupationCode_22;
         Census2000OccupationTitle = Census2000OccupationTitle_22;
      end;
      else if ConversionLowerBound_23 < randnum <= ConversionUpperBound_23 then do;
         Census2000OccupationCode = Census2000OccupationCode_23;
         Census2000OccupationTitle = Census2000OccupationTitle_23;
      end;
      else if ConversionLowerBound_24 < randnum <= ConversionUpperBound_24 then do;
         Census2000OccupationCode = Census2000OccupationCode_24;
         Census2000OccupationTitle = Census2000OccupationTitle_24;
      end;
      else if ConversionLowerBound_25 < randnum <= ConversionUpperBound_25 then do;
         Census2000OccupationCode = Census2000OccupationCode_25;
         Census2000OccupationTitle = Census2000OccupationTitle_25;
      end;
      else if ConversionLowerBound_26 < randnum <= ConversionUpperBound_26 then do;
         Census2000OccupationCode = Census2000OccupationCode_26;
         Census2000OccupationTitle = Census2000OccupationTitle_26;
      end;
      else if ConversionLowerBound_27 < randnum <= ConversionUpperBound_27 then do;
         Census2000OccupationCode = Census2000OccupationCode_27;
         Census2000OccupationTitle = Census2000OccupationTitle_27;
      end;
      else if ConversionLowerBound_28 < randnum <= ConversionUpperBound_28 then do;
         Census2000OccupationCode = Census2000OccupationCode_28;
         Census2000OccupationTitle = Census2000OccupationTitle_28;
      end;
      else if ConversionLowerBound_29 < randnum <= ConversionUpperBound_29 then do;
         Census2000OccupationCode = Census2000OccupationCode_29;
         Census2000OccupationTitle = Census2000OccupationTitle_29;
      end;
      else if ConversionLowerBound_30 < randnum <= ConversionUpperBound_30 then do;
         Census2000OccupationCode = Census2000OccupationCode_30;
         Census2000OccupationTitle = Census2000OccupationTitle_30;
      end;
      else if ConversionLowerBound_31 < randnum <= ConversionUpperBound_31 then do;
         Census2000OccupationCode = Census2000OccupationCode_31;
         Census2000OccupationTitle = Census2000OccupationTitle_31;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_32;
         Census2000OccupationTitle = Census2000OccupationTitle_32;
      end;
   end;
   else if Census1990OccupationCode_34 = . then do; /*One U.S. Census 1990 occupation code maps/redistributes to 33 U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000OccupationCode = Census2000OccupationCode_9;
         Census2000OccupationTitle = Census2000OccupationTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000OccupationCode = Census2000OccupationCode_10;
         Census2000OccupationTitle = Census2000OccupationTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000OccupationCode = Census2000OccupationCode_11;
         Census2000OccupationTitle = Census2000OccupationTitle_11;
      end;
      else if ConversionLowerBound_12 < randnum <= ConversionUpperBound_12 then do;
         Census2000OccupationCode = Census2000OccupationCode_12;
         Census2000OccupationTitle = Census2000OccupationTitle_12;
      end;
      else if ConversionLowerBound_13 < randnum <= ConversionUpperBound_13 then do;
         Census2000OccupationCode = Census2000OccupationCode_13;
         Census2000OccupationTitle = Census2000OccupationTitle_13;
      end;
      else if ConversionLowerBound_14 < randnum <= ConversionUpperBound_14 then do;
         Census2000OccupationCode = Census2000OccupationCode_14;
         Census2000OccupationTitle = Census2000OccupationTitle_14;
      end;
      else if ConversionLowerBound_15 < randnum <= ConversionUpperBound_15 then do;
         Census2000OccupationCode = Census2000OccupationCode_15;
         Census2000OccupationTitle = Census2000OccupationTitle_15;
      end;
      else if ConversionLowerBound_16 < randnum <= ConversionUpperBound_16 then do;
         Census2000OccupationCode = Census2000OccupationCode_16;
         Census2000OccupationTitle = Census2000OccupationTitle_16;
      end;
      else if ConversionLowerBound_17 < randnum <= ConversionUpperBound_17 then do;
         Census2000OccupationCode = Census2000OccupationCode_17;
         Census2000OccupationTitle = Census2000OccupationTitle_17;
      end;
      else if ConversionLowerBound_18 < randnum <= ConversionUpperBound_18 then do;
         Census2000OccupationCode = Census2000OccupationCode_18;
         Census2000OccupationTitle = Census2000OccupationTitle_18;
      end;
      else if ConversionLowerBound_19 < randnum <= ConversionUpperBound_19 then do;
         Census2000OccupationCode = Census2000OccupationCode_19;
         Census2000OccupationTitle = Census2000OccupationTitle_19;
      end;
      else if ConversionLowerBound_20 < randnum <= ConversionUpperBound_20 then do;
         Census2000OccupationCode = Census2000OccupationCode_20;
         Census2000OccupationTitle = Census2000OccupationTitle_20;
      end;
      else if ConversionLowerBound_21 < randnum <= ConversionUpperBound_21 then do;
         Census2000OccupationCode = Census2000OccupationCode_21;
         Census2000OccupationTitle = Census2000OccupationTitle_21;
      end;
      else if ConversionLowerBound_22 < randnum <= ConversionUpperBound_22 then do;
         Census2000OccupationCode = Census2000OccupationCode_22;
         Census2000OccupationTitle = Census2000OccupationTitle_22;
      end;
      else if ConversionLowerBound_23 < randnum <= ConversionUpperBound_23 then do;
         Census2000OccupationCode = Census2000OccupationCode_23;
         Census2000OccupationTitle = Census2000OccupationTitle_23;
      end;
      else if ConversionLowerBound_24 < randnum <= ConversionUpperBound_24 then do;
         Census2000OccupationCode = Census2000OccupationCode_24;
         Census2000OccupationTitle = Census2000OccupationTitle_24;
      end;
      else if ConversionLowerBound_25 < randnum <= ConversionUpperBound_25 then do;
         Census2000OccupationCode = Census2000OccupationCode_25;
         Census2000OccupationTitle = Census2000OccupationTitle_25;
      end;
      else if ConversionLowerBound_26 < randnum <= ConversionUpperBound_26 then do;
         Census2000OccupationCode = Census2000OccupationCode_26;
         Census2000OccupationTitle = Census2000OccupationTitle_26;
      end;
      else if ConversionLowerBound_27 < randnum <= ConversionUpperBound_27 then do;
         Census2000OccupationCode = Census2000OccupationCode_27;
         Census2000OccupationTitle = Census2000OccupationTitle_27;
      end;
      else if ConversionLowerBound_28 < randnum <= ConversionUpperBound_28 then do;
         Census2000OccupationCode = Census2000OccupationCode_28;
         Census2000OccupationTitle = Census2000OccupationTitle_28;
      end;
      else if ConversionLowerBound_29 < randnum <= ConversionUpperBound_29 then do;
         Census2000OccupationCode = Census2000OccupationCode_29;
         Census2000OccupationTitle = Census2000OccupationTitle_29;
      end;
      else if ConversionLowerBound_30 < randnum <= ConversionUpperBound_30 then do;
         Census2000OccupationCode = Census2000OccupationCode_30;
         Census2000OccupationTitle = Census2000OccupationTitle_30;
      end;
      else if ConversionLowerBound_31 < randnum <= ConversionUpperBound_31 then do;
         Census2000OccupationCode = Census2000OccupationCode_31;
         Census2000OccupationTitle = Census2000OccupationTitle_31;
      end;
      else if ConversionLowerBound_32 < randnum <= ConversionUpperBound_32 then do;
         Census2000OccupationCode = Census2000OccupationCode_32;
         Census2000OccupationTitle = Census2000OccupationTitle_32;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_33;
         Census2000OccupationTitle = Census2000OccupationTitle_33;
      end;
   end;
   else do; /*One U.S. Census 1990 occupation code maps/redistributes to 36 U.S. Census 2000 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2000OccupationCode = Census2000OccupationCode_1;
         Census2000OccupationTitle = Census2000OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 < randnum <= ConversionUpperBound_2 then do;
         Census2000OccupationCode = Census2000OccupationCode_2;
         Census2000OccupationTitle = Census2000OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 < randnum <= ConversionUpperBound_3 then do;
         Census2000OccupationCode = Census2000OccupationCode_3;
         Census2000OccupationTitle = Census2000OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 < randnum <= ConversionUpperBound_4 then do;
         Census2000OccupationCode = Census2000OccupationCode_4;
         Census2000OccupationTitle = Census2000OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 < randnum <= ConversionUpperBound_5 then do;
         Census2000OccupationCode = Census2000OccupationCode_5;
         Census2000OccupationTitle = Census2000OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 < randnum <= ConversionUpperBound_6 then do;
         Census2000OccupationCode = Census2000OccupationCode_6;
         Census2000OccupationTitle = Census2000OccupationTitle_6;
      end;
      else if ConversionLowerBound_7 < randnum <= ConversionUpperBound_7 then do;
         Census2000OccupationCode = Census2000OccupationCode_7;
         Census2000OccupationTitle = Census2000OccupationTitle_7;
      end;
      else if ConversionLowerBound_8 < randnum <= ConversionUpperBound_8 then do;
         Census2000OccupationCode = Census2000OccupationCode_8;
         Census2000OccupationTitle = Census2000OccupationTitle_8;
      end;
      else if ConversionLowerBound_9 < randnum <= ConversionUpperBound_9 then do;
         Census2000OccupationCode = Census2000OccupationCode_9;
         Census2000OccupationTitle = Census2000OccupationTitle_9;
      end;
      else if ConversionLowerBound_10 < randnum <= ConversionUpperBound_10 then do;
         Census2000OccupationCode = Census2000OccupationCode_10;
         Census2000OccupationTitle = Census2000OccupationTitle_10;
      end;
      else if ConversionLowerBound_11 < randnum <= ConversionUpperBound_11 then do;
         Census2000OccupationCode = Census2000OccupationCode_11;
         Census2000OccupationTitle = Census2000OccupationTitle_11;
      end;
      else if ConversionLowerBound_12 < randnum <= ConversionUpperBound_12 then do;
         Census2000OccupationCode = Census2000OccupationCode_12;
         Census2000OccupationTitle = Census2000OccupationTitle_12;
      end;
      else if ConversionLowerBound_13 < randnum <= ConversionUpperBound_13 then do;
         Census2000OccupationCode = Census2000OccupationCode_13;
         Census2000OccupationTitle = Census2000OccupationTitle_13;
      end;
      else if ConversionLowerBound_14 < randnum <= ConversionUpperBound_14 then do;
         Census2000OccupationCode = Census2000OccupationCode_14;
         Census2000OccupationTitle = Census2000OccupationTitle_14;
      end;
      else if ConversionLowerBound_15 < randnum <= ConversionUpperBound_15 then do;
         Census2000OccupationCode = Census2000OccupationCode_15;
         Census2000OccupationTitle = Census2000OccupationTitle_15;
      end;
      else if ConversionLowerBound_16 < randnum <= ConversionUpperBound_16 then do;
         Census2000OccupationCode = Census2000OccupationCode_16;
         Census2000OccupationTitle = Census2000OccupationTitle_16;
      end;
      else if ConversionLowerBound_17 < randnum <= ConversionUpperBound_17 then do;
         Census2000OccupationCode = Census2000OccupationCode_17;
         Census2000OccupationTitle = Census2000OccupationTitle_17;
      end;
      else if ConversionLowerBound_18 < randnum <= ConversionUpperBound_18 then do;
         Census2000OccupationCode = Census2000OccupationCode_18;
         Census2000OccupationTitle = Census2000OccupationTitle_18;
      end;
      else if ConversionLowerBound_19 < randnum <= ConversionUpperBound_19 then do;
         Census2000OccupationCode = Census2000OccupationCode_19;
         Census2000OccupationTitle = Census2000OccupationTitle_19;
      end;
      else if ConversionLowerBound_20 < randnum <= ConversionUpperBound_20 then do;
         Census2000OccupationCode = Census2000OccupationCode_20;
         Census2000OccupationTitle = Census2000OccupationTitle_20;
      end;
      else if ConversionLowerBound_21 < randnum <= ConversionUpperBound_21 then do;
         Census2000OccupationCode = Census2000OccupationCode_21;
         Census2000OccupationTitle = Census2000OccupationTitle_21;
      end;
      else if ConversionLowerBound_22 < randnum <= ConversionUpperBound_22 then do;
         Census2000OccupationCode = Census2000OccupationCode_22;
         Census2000OccupationTitle = Census2000OccupationTitle_22;
      end;
      else if ConversionLowerBound_23 < randnum <= ConversionUpperBound_23 then do;
         Census2000OccupationCode = Census2000OccupationCode_23;
         Census2000OccupationTitle = Census2000OccupationTitle_23;
      end;
      else if ConversionLowerBound_24 < randnum <= ConversionUpperBound_24 then do;
         Census2000OccupationCode = Census2000OccupationCode_24;
         Census2000OccupationTitle = Census2000OccupationTitle_24;
      end;
      else if ConversionLowerBound_25 < randnum <= ConversionUpperBound_25 then do;
         Census2000OccupationCode = Census2000OccupationCode_25;
         Census2000OccupationTitle = Census2000OccupationTitle_25;
      end;
      else if ConversionLowerBound_26 < randnum <= ConversionUpperBound_26 then do;
         Census2000OccupationCode = Census2000OccupationCode_26;
         Census2000OccupationTitle = Census2000OccupationTitle_26;
      end;
      else if ConversionLowerBound_27 < randnum <= ConversionUpperBound_27 then do;
         Census2000OccupationCode = Census2000OccupationCode_27;
         Census2000OccupationTitle = Census2000OccupationTitle_27;
      end;
      else if ConversionLowerBound_28 < randnum <= ConversionUpperBound_28 then do;
         Census2000OccupationCode = Census2000OccupationCode_28;
         Census2000OccupationTitle = Census2000OccupationTitle_28;
      end;
      else if ConversionLowerBound_29 < randnum <= ConversionUpperBound_29 then do;
         Census2000OccupationCode = Census2000OccupationCode_29;
         Census2000OccupationTitle = Census2000OccupationTitle_29;
      end;
      else if ConversionLowerBound_30 < randnum <= ConversionUpperBound_30 then do;
         Census2000OccupationCode = Census2000OccupationCode_30;
         Census2000OccupationTitle = Census2000OccupationTitle_30;
      end;
      else if ConversionLowerBound_31 < randnum <= ConversionUpperBound_31 then do;
         Census2000OccupationCode = Census2000OccupationCode_31;
         Census2000OccupationTitle = Census2000OccupationTitle_31;
      end;
      else if ConversionLowerBound_32 < randnum <= ConversionUpperBound_32 then do;
         Census2000OccupationCode = Census2000OccupationCode_32;
         Census2000OccupationTitle = Census2000OccupationTitle_32;
      end;
      else if ConversionLowerBound_33 < randnum <= ConversionUpperBound_33 then do;
         Census2000OccupationCode = Census2000OccupationCode_33;
         Census2000OccupationTitle = Census2000OccupationTitle_33;
      end;
      else if ConversionLowerBound_34 < randnum <= ConversionUpperBound_34 then do;
         Census2000OccupationCode = Census2000OccupationCode_34;
         Census2000OccupationTitle = Census2000OccupationTitle_34;
      end;
      else if ConversionLowerBound_35 < randnum <= ConversionUpperBound_35 then do;
         Census2000OccupationCode = Census2000OccupationCode_35;
         Census2000OccupationTitle = Census2000OccupationTitle_35;
      end;
      else do;
         Census2000OccupationCode = Census2000OccupationCode_36;
         Census2000OccupationTitle = Census2000OccupationTitle_36;
      end;
   end;
run;

/*************************************************************************************************************************/
/*	Convert U.S. Census Bureau 2000 occupation codes to U.S. Census Bureau 2002 occupation codes.						 */
/*************************************************************************************************************************/

/*1. Read the user’s dataset into SAS.*/

proc import out=USER.dataset_1
            datafile="C:\Desktop\Data\dataset_1.xlsx"
            dbms=EXCEL replace;
            getnames=yes;
run;

/*2. Generate a random number between zero and one from a uniform distribution for each observation (e.g., person) in the user’s dataset and assign this random number to a new variable.*/

data USER.dataset_2;
   set USER.dataset_1;
   call streaminit(662857); /*662857 is a seed number. Users should replace the seed number each time they generate random numbers.*/
   randnum = rand("Uniform");
run;

/*3. Read into SAS eTable 18. Horizontal Crosswalk to convert U.S. Census Bureau 2000 to 2002 Occupation Codes (i.e., tab "eTable 18-Occ-2000-2002-Horiz" in the Excel workbook that contains the crosswalks).*/

proc import out=USER.Crosswalk_Occ_2000_2002_1
            datafile="C:\Desktop\Data\Epidemiology-Crosswalks-SDC-Excel-072621.xlsx"
            dbms=EXCEL replace;
            sheet="eTable 18-Occ-2000-2002-Horiz";
            getnames=yes;
run;

/*4. Sort the user’s dataset by the U.S. Census Bureau 2000 occupation codes.*/

proc sort data=USER.dataset_2;
   by Census2000OccupationCode;
run;

/*5. Sort eTable 18 by the U.S. Census Bureau 2000 occupation codes.*/

proc sort data=USER.Crosswalk_Occ_2000_2002_1;
   by Census2000OccupationCode_1;
run;

/*6. Merge eTable 18 to the user’s dataset by the U.S. Census Bureau 2000 occupation codes.*/

data USER.dataset_3;
   merge USER.dataset_2 (rename = (Census2000OccupationCode = Census2000OccupationCode_1)) USER.Crosswalk_Occ_2000_2002_1;
   by Census2000OccupationCode_1;

/*7. Compare the random number for a particular person (i.e., step 2) to the ConversionLowerBound and ConversionUpperBound variables in eTable 18 and assign the U.S. Census Bureau 2002 occupation code that corresponds to the ConversionLowerBound and ConversionUpperBound variables that contain the random number. In other words, eTable 18 shows one U.S. Census Bureau 2000 occupation code redistributes to one U.S. Census Bureau 2002 occupation code.*/

   /*No U.S. Census Bureau 2000 occupation code maps/redistributes to more than one U.S. Census Bureau 2002 occupation code, so no code is needed for this step.*/

run;

/*************************************************************************************************************************/
/*	Convert U.S. Census Bureau 2002 occupation codes to U.S. Census Bureau 2010 occupation codes.						 */
/*************************************************************************************************************************/

/*1. Read the user’s dataset into SAS.*/

proc import out=USER.dataset_1
            datafile="C:\Desktop\Data\dataset_1.xlsx"
            dbms=EXCEL replace;
            getnames=yes;
run;

/*2. Generate a random number between zero and one from a uniform distribution for each observation (e.g., person) in the user’s dataset and assign this random number to a new variable.*/

data USER.dataset_2;
   set USER.dataset_1;
   call streaminit(694483); /*694483 is a seed number. Users should replace the seed number each time they generate random numbers.*/
   randnum = rand("Uniform");
run;

/*3. Read into SAS eTable 20. Horizontal Crosswalk to convert U.S. Census Bureau 2002 to 2010 Occupation Codes (i.e., tab "eTable 20-Occ-2002-2010-Horiz" in the Excel workbook that contains the crosswalks).*/

proc import out=USER.Crosswalk_Occ_2002_2010_1
            datafile="C:\Desktop\Data\Epidemiology-Crosswalks-SDC-Excel-072621.xlsx"
            dbms=EXCEL replace;
            sheet="eTable 20-Occ-2002-2010-Horiz";
            getnames=yes;
run;

/*4. Sort the user’s dataset by the U.S. Census Bureau 2002 occupation codes.*/

proc sort data=USER.dataset_2;
   by Census2002OccupationCode;
run;

/*5. Sort eTable 20 by the U.S. Census Bureau 2002 occupation codes.*/

proc sort data=USER.Crosswalk_Occ_2002_2010_1;
   by Census2002OccupationCode_1;
run;

/*6. Merge eTable 20 to the user’s dataset by the U.S. Census Bureau 2002 occupation codes.*/

data USER.dataset_3;
   merge USER.dataset_2 (rename = (Census2002OccupationCode = Census2002OccupationCode_1)) USER.Crosswalk_Occ_2002_2010_1;
   by Census2002OccupationCode_1;

/*7. Compare the random number for a particular person (i.e., step 2) to the ConversionLowerBound and ConversionUpperBound variables in eTable 20 and assign the U.S. Census Bureau 2010 occupation code that corresponds to the ConversionLowerBound and ConversionUpperBound variables that contain the random number. In other words, eTable 20 shows one U.S. Census Bureau 2002 occupation code redistributes to between one and six U.S. Census Bureau 2010 occupation codes.*/

   if Census2002OccupationCode_2 = . then do; /*One U.S. Census 2002 occupation code maps/redistributes to one U.S. Census 2010 occupation code.*/
      Census2010OccupationCode = Census2010OccupationCode_1;
      Census2010OccupationTitle = Census2010OccupationTitle_1;
   end;
   else if Census2002OccupationCode_3 = . then do; /*One U.S. Census 2002 occupation code maps/redistributes to two U.S. Census 2010 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2010OccupationCode = Census2010OccupationCode_1;
         Census2010OccupationTitle = Census2010OccupationTitle_1;
      end;
      else do;
         Census2010OccupationCode = Census2010OccupationCode_2;
         Census2010OccupationTitle = Census2010OccupationTitle_2;
      end;
   end;
   else if Census2002OccupationCode_4 = . then do; /*One U.S. Census 2002 occupation code maps/redistributes to three U.S. Census 2010 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2010OccupationCode = Census2010OccupationCode_1;
         Census2010OccupationTitle = Census2010OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 <= randnum <= ConversionUpperBound_2 then do;
         Census2010OccupationCode = Census2010OccupationCode_2;
         Census2010OccupationTitle = Census2010OccupationTitle_2;
      end;
      else do;
         Census2010OccupationCode = Census2010OccupationCode_3;
         Census2010OccupationTitle = Census2010OccupationTitle_3;
      end;
   end;
   else if Census2002OccupationCode_5 = . then do; /*One U.S. Census 2002 occupation code maps/redistributes to four U.S. Census 2010 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2010OccupationCode = Census2010OccupationCode_1;
         Census2010OccupationTitle = Census2010OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 <= randnum <= ConversionUpperBound_2 then do;
         Census2010OccupationCode = Census2010OccupationCode_2;
         Census2010OccupationTitle = Census2010OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 <= randnum <= ConversionUpperBound_3 then do;
         Census2010OccupationCode = Census2010OccupationCode_3;
         Census2010OccupationTitle = Census2010OccupationTitle_3;
      end;
      else do;
         Census2010OccupationCode = Census2010OccupationCode_4;
         Census2010OccupationTitle = Census2010OccupationTitle_4;
      end;
   end;
   else if Census2002OccupationCode_6 = . then do; /*One U.S. Census 2002 occupation code maps/redistributes to five U.S. Census 2010 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2010OccupationCode = Census2010OccupationCode_1;
         Census2010OccupationTitle = Census2010OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 <= randnum <= ConversionUpperBound_2 then do;
         Census2010OccupationCode = Census2010OccupationCode_2;
         Census2010OccupationTitle = Census2010OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 <= randnum <= ConversionUpperBound_3 then do;
         Census2010OccupationCode = Census2010OccupationCode_3;
         Census2010OccupationTitle = Census2010OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 <= randnum <= ConversionUpperBound_4 then do;
         Census2010OccupationCode = Census2010OccupationCode_4;
         Census2010OccupationTitle = Census2010OccupationTitle_4;
      end;
      else do;
         Census2010OccupationCode = Census2010OccupationCode_5;
         Census2010OccupationTitle = Census2010OccupationTitle_5;
      end;
   end;
   else do; /*One U.S. Census 2002 occupation code maps/redistributes to six U.S. Census 2010 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2010OccupationCode = Census2010OccupationCode_1;
         Census2010OccupationTitle = Census2010OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 <= randnum <= ConversionUpperBound_2 then do;
         Census2010OccupationCode = Census2010OccupationCode_2;
         Census2010OccupationTitle = Census2010OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 <= randnum <= ConversionUpperBound_3 then do;
         Census2010OccupationCode = Census2010OccupationCode_3;
         Census2010OccupationTitle = Census2010OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 <= randnum <= ConversionUpperBound_4 then do;
         Census2010OccupationCode = Census2010OccupationCode_4;
         Census2010OccupationTitle = Census2010OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 <= randnum <= ConversionUpperBound_5 then do;
         Census2010OccupationCode = Census2010OccupationCode_5;
         Census2010OccupationTitle = Census2010OccupationTitle_5;
      end;
      else do;
         Census2010OccupationCode = Census2010OccupationCode_6;
         Census2010OccupationTitle = Census2010OccupationTitle_6;
      end;
   end;
run;

/*************************************************************************************************************************/
/*	Convert U.S. Census Bureau 2010 occupation codes to U.S. Census Bureau 2018 occupation codes.						 */
/*************************************************************************************************************************/

/*1. Read the user’s dataset into SAS.*/

proc import out=USER.dataset_1
            datafile="C:\Desktop\Data\dataset_1.xlsx"
            dbms=EXCEL replace;
            getnames=yes;
run;

/*2. Generate a random number between zero and one from a uniform distribution for each observation (e.g., person) in the user’s dataset and assign this random number to a new variable.*/

data USER.dataset_2;
   set USER.dataset_1;
   call streaminit(10483); /*10483 is a seed number. Users should replace the seed number each time they generate random numbers.*/
   randnum = rand("Uniform");
run;

/*3. Read into SAS eTable 22. Horizontal Crosswalk to convert U.S. Census Bureau 2010 to 2018 Occupation Codes (i.e., tab "eTable 22-Occ-2010-2018-Horiz" in the Excel workbook that contains the crosswalks).*/

proc import out=USER.Crosswalk_Occ_2010_2018_1
            datafile="C:\Desktop\Data\Epidemiology-Crosswalks-SDC-Excel-072621.xlsx"
            dbms=EXCEL replace;
            sheet="eTable 22-Occ-2010-2018-Horiz";
            getnames=yes;
run;

/*4. Sort the user’s dataset by the U.S. Census Bureau 2010 occupation codes.*/

proc sort data=USER.dataset_2;
   by Census2010OccupationCode;
run;

/*5. Sort eTable 22 by the U.S. Census Bureau 2010 occupation codes.*/

proc sort data=USER.Crosswalk_Occ_2010_2018_1;
   by Census2010OccupationCode_1;
run;

/*6. Merge eTable 22 to the user’s dataset by the U.S. Census Bureau 2010 occupation codes.*/

data USER.dataset_3;
   merge USER.dataset_2 (rename = (Census2010OccupationCode = Census2010OccupationCode_1)) USER.Crosswalk_Occ_2010_2018_1;
   by Census2010OccupationCode_1;

/*7. Compare the random number for a particular person (i.e., step 2) to the ConversionLowerBound and ConversionUpperBound variables in eTable 22 and assign the U.S. Census Bureau 2018 occupation code that corresponds to the ConversionLowerBound and ConversionUpperBound variables that contain the random number. In other words, eTable 22 shows one U.S. Census Bureau 2010 occupation code redistributes to between one and seven U.S. Census Bureau 2018 occupation codes.*/

   if Census2010OccupationCode_2 = . then do; /*One U.S. Census 2010 occupation code maps/redistributes to one U.S. Census 2018 occupation code.*/
      Census2018OccupationCode = Census2018OccupationCode_1;
      Census2018OccupationTitle = Census2018OccupationTitle_1;
   end;
   else if Census2010OccupationCode_3 = . then do; /*One U.S. Census 2010 occupation code maps/redistributes to two U.S. Census 2018 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2018OccupationCode = Census2018OccupationCode_1;
         Census2018OccupationTitle = Census2018OccupationTitle_1;
      end;
      else do;
         Census2018OccupationCode = Census2018OccupationCode_2;
         Census2018OccupationTitle = Census2018OccupationTitle_2;
      end;
   end;
   else if Census2010OccupationCode_4 = . then do; /*One U.S. Census 2010 occupation code maps/redistributes to three U.S. Census 2018 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2018OccupationCode = Census2018OccupationCode_1;
         Census2018OccupationTitle = Census2018OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 <= randnum <= ConversionUpperBound_2 then do;
         Census2018OccupationCode = Census2018OccupationCode_2;
         Census2018OccupationTitle = Census2018OccupationTitle_2;
      end;
      else do;
         Census2018OccupationCode = Census2018OccupationCode_3;
         Census2018OccupationTitle = Census2018OccupationTitle_3;
      end;
   end;
   else if Census2010OccupationCode_5 = . then do; /*One U.S. Census 2010 occupation code maps/redistributes to four U.S. Census 2018 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2018OccupationCode = Census2018OccupationCode_1;
         Census2018OccupationTitle = Census2018OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 <= randnum <= ConversionUpperBound_2 then do;
         Census2018OccupationCode = Census2018OccupationCode_2;
         Census2018OccupationTitle = Census2018OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 <= randnum <= ConversionUpperBound_3 then do;
         Census2018OccupationCode = Census2018OccupationCode_3;
         Census2018OccupationTitle = Census2018OccupationTitle_3;
      end;
      else do;
         Census2018OccupationCode = Census2018OccupationCode_4;
         Census2018OccupationTitle = Census2018OccupationTitle_4;
      end;
   end;
   else if Census2010OccupationCode_6 = . then do; /*One U.S. Census 2010 occupation code maps/redistributes to five U.S. Census 2018 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2018OccupationCode = Census2018OccupationCode_1;
         Census2018OccupationTitle = Census2018OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 <= randnum <= ConversionUpperBound_2 then do;
         Census2018OccupationCode = Census2018OccupationCode_2;
         Census2018OccupationTitle = Census2018OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 <= randnum <= ConversionUpperBound_3 then do;
         Census2018OccupationCode = Census2018OccupationCode_3;
         Census2018OccupationTitle = Census2018OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 <= randnum <= ConversionUpperBound_4 then do;
         Census2018OccupationCode = Census2018OccupationCode_4;
         Census2018OccupationTitle = Census2018OccupationTitle_4;
      end;
      else do;
         Census2018OccupationCode = Census2018OccupationCode_5;
         Census2018OccupationTitle = Census2018OccupationTitle_5;
      end;
   end;
   else if Census2010OccupationCode_7 = . then do; /*One U.S. Census 2010 occupation code maps/redistributes to six U.S. Census 2018 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2018OccupationCode = Census2018OccupationCode_1;
         Census2018OccupationTitle = Census2018OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 <= randnum <= ConversionUpperBound_2 then do;
         Census2018OccupationCode = Census2018OccupationCode_2;
         Census2018OccupationTitle = Census2018OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 <= randnum <= ConversionUpperBound_3 then do;
         Census2018OccupationCode = Census2018OccupationCode_3;
         Census2018OccupationTitle = Census2018OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 <= randnum <= ConversionUpperBound_4 then do;
         Census2018OccupationCode = Census2018OccupationCode_4;
         Census2018OccupationTitle = Census2018OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 <= randnum <= ConversionUpperBound_5 then do;
         Census2018OccupationCode = Census2018OccupationCode_5;
         Census2018OccupationTitle = Census2018OccupationTitle_5;
      end;
      else do;
         Census2018OccupationCode = Census2018OccupationCode_6;
         Census2018OccupationTitle = Census2018OccupationTitle_6;
      end;
   end;
   else do; /*One U.S. Census 2010 occupation code maps/redistributes to seven U.S. Census 2018 occupation codes.*/
      if ConversionLowerBound_1 <= randnum <= ConversionUpperBound_1 then do;
         Census2018OccupationCode = Census2018OccupationCode_1;
         Census2018OccupationTitle = Census2018OccupationTitle_1;
      end;
      else if ConversionLowerBound_2 <= randnum <= ConversionUpperBound_2 then do;
         Census2018OccupationCode = Census2018OccupationCode_2;
         Census2018OccupationTitle = Census2018OccupationTitle_2;
      end;
      else if ConversionLowerBound_3 <= randnum <= ConversionUpperBound_3 then do;
         Census2018OccupationCode = Census2018OccupationCode_3;
         Census2018OccupationTitle = Census2018OccupationTitle_3;
      end;
      else if ConversionLowerBound_4 <= randnum <= ConversionUpperBound_4 then do;
         Census2018OccupationCode = Census2018OccupationCode_4;
         Census2018OccupationTitle = Census2018OccupationTitle_4;
      end;
      else if ConversionLowerBound_5 <= randnum <= ConversionUpperBound_5 then do;
         Census2018OccupationCode = Census2018OccupationCode_5;
         Census2018OccupationTitle = Census2018OccupationTitle_5;
      end;
      else if ConversionLowerBound_6 <= randnum <= ConversionUpperBound_6 then do;
         Census2018OccupationCode = Census2018OccupationCode_6;
         Census2018OccupationTitle = Census2018OccupationTitle_6;
      end;
      else do;
         Census2018OccupationCode = Census2018OccupationCode_7;
         Census2018OccupationTitle = Census2018OccupationTitle_7;
      end;
   end;
run;
