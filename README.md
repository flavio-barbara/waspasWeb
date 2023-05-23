---
title: "README.md"
author: "Flavio Barbara"
date: "2023-05-23"
output: html_document
editor_options: 
  markdown: 
    wrap: sentence
---

WaspasWEB User's Manual

Introduction

```         
The "WASPAS for Dummies" service is a free and public web page that is a product of the waspasWEB project. This document provides explanations on how to use it. The waspasWEB project is an academic-scientific research project that proposes to implement a decision-making support tool using the WASPAS method, proposed by Zavadskas et al. (2012). The implementation was performed in the R language using the Shiny package for internet publishing and the shinyapps.io hosting service. Non-commercial (academic) use of the resources made available by the waspasWEB project is free of charge. The only thing that is asked in return is to cite this tool as a source when the results are used in publications.
```

To cite the source, please mention: Barbara, Flavio; SANTOS, Marcos dos.
WASPAS in R (v.1) 2023.

Objective

```         
The “WASPAS for Dummies” service is a tool to support multicriteria decision making, or MCDM, that stands for “Multi-Criteria Decision Making”. This type of problem involves a set of alternatives, from which one wants to select the best choice, and a set of evaluation criteria, weighted according to the relative importance that the decision maker considers to be applicable in the decision-making process. There are many methods developed to solve MCDM problems. Soares et al. (2023) cite more than 25 different methods, including AHP, MACBETH, ELECTRE, MELCHIOR, PAMSSEM, EVAMIX, QUALIFLEX, SAPEVO-M, WASPAS and several others. Rani et al. (2020) point out that multicriteria decision-making processes are one of the areas of Operations Research [OP] that grows the most, both in terms of method diversification and their application in the market. For example, one decision maker wants to choose the best automobile that will satisfy his needs; based on these needs, a set of criteria is established: economy, power, transport capacity, comfort items, safety items, price, etc.; once the criteria are defined, a degree of importance must be assigned to each one of them, that is, price may be a more relevant criterion than engine power, but this may be considered more relevant than autonomy. For the mathematical calculations of the method, it is also essential to determine whether the criterion regards to cost or benefit, that is, if the higher is better or if the lower is better. The algorithms need to know whether the maximization or minimization of value is intended, for example, price is a cost criterion, that is, the lower, the better, and autonomy is a benefit criterion, the higher the better.
```

With this information in hands, it is possible to apply mathematical models that classify the most appropriate alternatives for any problem that has this structure.

The WASPAS Method

```         
Proposed by Zavadskas et al. (2012) the WASPAS method, acronym for Weighted Aggregated Sum Product Assessment, is an algorithm to support analysis for decision-making based on multiple criteria that uses two established methods in the market for solving MCDM problems, the Weighted Sum Method (WSM) and the Weighted Product Method (WPM). The WASPAS proposal is the application of a weighting parameter on the classifications obtained in the WSM and WPM methods called lambda (λ). The application of the lambda shows how sensitive the set of alternatives and criteria is to each of the methods (WSM and WPM). The resource that this page presents is the dynamic application of the lambda in a very easy and intuitive way, showing online the change in the ranking as the lambda applied by WASPAS is modified. The lambda (λ) is variable between 0 and 1, i.e., a weighted percentage that determines how much of the WSM classification is used and how much of WPM defines the ranking and applies it to the set of Alternatives versus Criteria. Weighting is done by attributing a percentage to WSM and its complement to WPM. The formula below illustrates the weighting:
```

〖IRT〗\_i=λ×〖IR〗\_i (WSM)+(1-λ)×〖IR〗\_i (WPM)

Where IRTi is the total relative importance of alternative i, obtained by the WASPAS method; IRi(WSM) is its relative importance obtained by the WSM method and IRi(WPM) is its relative importance obtained by the WPM method; λ (Lambda) is a value that varies to push the final ranking closer to the WSM or to the WPM.
For example, a lambda = 0.5 is an arithmetic average of the result obtained by each of the methods, that is, the final classification (WASPAS) is weighted 50% of the WSM and 50% of WPM.
For a lambda equals 1.0 WASPAS works as WSM since we have:

〖IRT〗\_i=1×〖IR〗\_i (WSM)+(1-1)×〖IR〗\_i (WPM)⇒〖IRT〗\_i=1×〖IR〗\_i (WSM)+0×〖IR〗\_i (WPM)

```         
Analogously, for a lambda equals 0.0, WASPAS is the same as WPM, as we have:
```

〖IRT〗\_i=0×〖IR〗\_i (WSM)+(0-1)×〖IR〗\_i (WPM)⇒〖IRT〗\_i=0×〖IR〗\_i (WSM)+1×〖IR〗\_i (WPM)

```         
The “WASPAS for Dummies” service has a feature (slider object) that allows you to dynamically change the lambda value between 0 and 1 (0% to 100%) and check the results in the classification of problem alternatives submitted to the WASPAS method and, of course , as well as the WSM and WPM methods.
```

"WASPAS for Dummies" page structure

The screen of the waspasWEB service page is divided into two: (1) On the right side there is a presentation column with important information and links to supporting files (e.g., this operation manual).
(2) To the left of this display column is the workspace with four tabs.
i.
Input: contains the field for uploading the database to be analyzed.
ii.
View: visualization of input data and button to command the calculation.
iii.
Output: presents the list of alternatives properly ranked.
iv.
Radar Chart: radar-type graphic with classification.

How to use the resources on the "WASPAS for Dummies" page

```         
The first step is to download the spreadsheet with the database model. To do so, just click on the Database Template link: WASPAS_Data_Template.xlsx, (Figure 1) follow the well-known dialog for choosing the folder (directory) where you want to save the file and click on save (Figure 2).
```

Figure 1.
Link to download the database model.
Source: <https://flaviob.shinyapps.io/waspasWeb/>

Figure 2.
Choose the folder and click the "Save" button.

Once the spreadsheet with the data model has been downloaded, edit the file using MS-Excel or LibreOffice Calc for example and save it with a name you deem appropriate.
We will explain later how to fill in the worksheet with data from the multicriteria decision-making problem.
The system will validate the format of the loaded data and show a brief report of what was imported.
If there is no formatting error, the screen that will be displayed is the one shown below (Figure 3).

```         
Figure 3. Database load result presentation screen.
```

Where: Report on the loading process: file name and size, number of criteria and database alternatives; Button that directs to the visualization tab of the imported data; You can click directly on the "View" tab to view the data.

```         
View the data and command the execution of the WASPAS method calculations on the screen shown in the “View” tab as marked in red in (Figure 4). There are scroll bars on the right and bottom that allow you to view all the loaded data.
```

After applying the WASPAS method to the database, the "Output" tab opens automatically and shows the classification made by the WASPAS method and by the 2 underlying methods, WSM and WPM.
There is a "Slider" object on the screen that allows you to very quickly change the lambda values that weight the relative value of each of the underlying methods.
The closer to 0 (Zero) the lambda value is, the greater the weight of the WPM method, and the closer to 1, the greater the relative weight of the ranking obtained by WSM.
The screen shown in the Output tab contains the rankings by the WSM (summation) and WPM (product) methods and the WASPAS ranking, that changes dynamically according to the change of the lambda value in the "slider" object.

Figure 4.
Database content preview screen.

Figure 5.
Slider that allows dynamic visualization of the Lambda WASPAS application in the classification of alternatives of the multicriteria decision-making problem.

The same result is displayed on the "Radar Chart" tab in a graphic format also known as spider web chart, Kiviat diagram and other names.
In this tab there is also a "Slider" object that allows changing the lambda value dynamically (Figure 6).
The Radar Chart slider is synchronized with the Output tab object.
When modifying the lambda value in this component, the slider on the "Output" tab is also changed to the same value, updating the WASPAS ranking.

Figure 6.
Slider and radar chart (spider web).

Database Preparation

```         
After downloading the spreadsheet (WASPAS_Data_Template.xlsx) open it in MS-Excel, LibreOffice Calc or the application of your choice. The worksheet will be the one shown in (Figure 7), but without any color, the colors are merely for didactic purposes.
```

Figure 7.
Template spreadsheet for structuring input data.

The spreadsheet that structures the database of the multicriteria decision-making problem that will be submitted to the WASPAS calculation provided by the "WASPAS for Dummies" page must respect the above structure.
Separated by colors, there are 6 areas in the worksheet: indicators, flags, weights, criteria, alternatives, and Alternative-Criterion values.
Detailing each of them, we have:

Figure 8.
Cells in the upper left corner with the indicators.

In cells (1,1), (2,1) and (3,1) the indicators (Figure 8) of lines 1, 2, and 3 are informed, which must be "F" for "Flags", "W" for Weights, and "C" for "Criteria".
That is, "F" means Cost or Benefit flag, "W" is the Weight (importance of each criterion), this information (metadata) allows the user of the "WASPAS for Dummies" service to inform the data of criteria, weights and cost-benefit in the line that suits you, the service will process each line according to the indicator in the appropriate cell (Figure 9).
Figure 9.
Rows of Flags ("F"), Weights ("W") and Criteria ("C").

With the indicator properly defined, it is necessary that the data in the referred rows are appropriate.
The "F" indicator line should contain only "Flags" that indicate whether the criterion is cost or benefit.
For this, the cells must contain words starting with "C" (cost) or "B" (Benefit).
The row whose indicator is the "W" (Weight) must contain the weights arbitrated by the decision maker in relation to the relative importance of each of the criteria.
The sum of the weights in the "W" row must add up to 1 (100%).
And the indicator line "C" should contain the problem criteria.
These are brief descriptions such as: price, weight, size, capacity, etc.
The area in red is the part where the alternatives to the problem are introduced.
There are no limits to the number of alternatives, just as there are no limits to the number of criteria.
We suggest that in these cells (column 1, rows 4 to n, last alternative) brief descriptions of the alternatives be introduced, as well as in row "C" (criteria).

```         
 Figure 10. Problem Alternative’s Cells [4:n, 1:1]
```

And the most important part is the one that have the values.
The values are, in general, obtained in the market, and refer to the performance of that alternative in relation to the criterion.
For example, the price value of product X, the maximum speed of alternativeY, the boiling temperature of element Z.
The gray hatched values in (Figure 10) are those that will be submitted to the decision support algorithm that are determined by Criteria-Alternatives.
That said, let's get down to practice.
Determine your choice alternatives, determine the criteria by which the alternatives will be ranked, conduct market research on the performance values of the Criteria-Alternatives.
Fill out the worksheet correctly as instructed and go ahead.
Make your decision based on numbers and evidence.
And more important, have an instrument to justify your decision to the stakeholders.

Error Handling

```         
After uploading the data, waspasWEB does some checks and displays error messages if there is any non-standard data. The first validation is about the indicators, if these are not precisely 3 strings (words or a character) starting with “C”, “F” or “W” (they can be lowercase or uppercase) the error below (in red) occurs. Note in the example in Figure 11 that there is spurious data where there should be a character “W” or a word starting with w, for example “Weight”. 
```

Error: Check the indicators in cells [1:3, 1], the strings must be intiated with 'C', 'F' or 'W' In the row whose 1st cell has an "F" indicator.
It must contain only "C" or "B" characters, or words starting with these characters.
If this standard is not respected, the following error occurs (in red), the example in (Figure 12) shows the problem that generated the error.
Error: Vector of flags must contain just strings initiated with B or C (i.e., b, c, B, C, Cost, Benefit, Ben etc.)

Figure 11.
Wrong Indicator.
Figure 12.
Wrong cost-benefit flag.

```         
If the line whose 1st cell contains a “W” indicator contains data that cannot be converted to numerical values, or the sum of these values does not add up to one, errors (a) and (b) below (in red) occur respectively. 
```

(a) Error: Check Weights values, all must be numeric
(b) Error: Values in Vector of Weights must summarize 1 The set of cells used to inform the performance values of the X Alternative Criteria (e.g.: price, term, capacity, autonomy, size, etc.) must only contain data convertible to numerical values, in case there is any alphanumeric or null value in the set, the error message below will be shown. Error: Check Aternatives x Criteria values, all must be numeric These are the inconsistencies in the data that are checked by waspasWEB. When any of the problems listed above occur the system does not allow advancing to the WASPAS calculation ("Calculate WASPAS" button). If another type of inconsistency not listed above occurs, the system will abort the process by commanding the WASPAS calculation. In this case, the input data must be checked to detect any anomalies. If you cannot solve the problem, send an email to [flavio.barbara\@gmail.com](mailto:flavio.barbara@gmail.com){.email}.

Referências Rani, P., Mishra, A.R., Pardasani, K.R.
(2020).
"A novel WASPAS approach for multi-criteria physician selection problem with intuitionistic fuzzy type-2 sets", Soft Computing, 24 (3), pp. 2355-2367.
doi: 10.1007/s00500-019-04065-5.

```         
Soares de Assis, Gustavo & Santos, Marcos & Basilio, Marcio. (2023). “Use of the WASPAS Method to Select Suitable Helicopters for Aerial Activity Carried Out by the Military Police of the State of Rio de Janeiro”. Axioms. 12. 77. 10.3390.

Zavadskas, E.K., Turskis, Z., Antucheviciene, J. and Zakarevicius, A. (2012), “Optimization of weighted aggregated sum product assessment”, Elektronika ir Elektrotechnika, Vol. 122 No. 6, pp. 3-6.
```
