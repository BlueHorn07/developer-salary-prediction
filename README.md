# Developer Salary Prediction

Predict Your Salary! 😎

> 2021-1 POSTCH IMEN472 Statistical Data Mining Team Project

This is a collection of code that our team have written and experimented with.

## Abstract

A salary is one of impoartant thing that we are interested in. [Stackoverflow](https://stackoverflow.com/) conducts [anuual survery for developers](https://insights.stackoverflow.com/survey), so we suggest a project to construct the developer salary model using that survery data. We refine the survey into the dataset by handling outliers and NaN values. We’ve experimented six models of parameteric and non-paremteric. We report what features are important to predict salary, and compare the results. We release our dataset and code in GitHub.

## Models

- Linear Regression
  - Subset Selection
    - Forward Selection
    - Backward Selection
  - Ridge Regression
  - Lasso Regression
- GAM; Generalized Additive Model
- MARS; Multivariate Adaptive Regression Splines
- XGBoost

## Result

|Model|R-square|RMSE|
|:------:|:---:|:---:|
|LS-forward|0.651|25,003.50|
|LS-backward|0.651|24,999.85|
|Ridge|0.650|25,043.36|
|Lasso|0.651|24,994.60|
|GAM|0.628|26,100.10|
|MARS|0.680|24,140.75|
|XGBoost|0.714|22,925.37|

## Members

- Ha Seokyun, 20180775, CSED / [BlueHorn07@Github](https://github.com/BlueHorn07)
- Lee Donghyun, 20180661, MATH / [dlehdgus9887@GitHub](https://github.com/dlehdgus9887)
- Oh Eun, 20212717, IMEN / [oheun96@GitHub](https://github.com/oheun96)

