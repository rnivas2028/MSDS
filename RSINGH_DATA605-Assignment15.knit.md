---
title: "DATA 605 : Week15- Functions of Several Variables"
author: "Ramnivas Singh"
date: "12/13/2021"
output:
  pdf_document:
    toc: no
    toc_depth: '5'
  html_document:
    theme: default
    highlight: espresso
    toc: no
---


### 1. Find the equation of the regression line for the given points. Round any final values to the nearest hundredth, if necessary.
( 5.6, 8.8 ), ( 6.3, 12.4 ), ( 7, 14.8 ), ( 7.7, 18.2 ), ( 8.4, 20.8 )

Inject the data points for x and y and put into adata frame for use later 

```r
x = c(5.6, 6.3, 7, 7.7, 8.4)
y = c(8.8, 12.4, 14.8, 18.2, 20.8)
df<-data.frame(x,y)
```

Compute the mean of x and y 

```r
x_mean = mean(x)
y_mean = mean(y)
print(paste0("mean x= ", x_mean))
```

```
## [1] "mean x= 7"
```

```r
print(paste0("mean y= ",y_mean))
```

```
## [1] "mean y= 15"
```

Compute the difference between x points and the mean of x and then square that result 

```r
xdiff = x-x_mean
sq_xdiff = (xdiff)^2
sq_xdiff
```

```
## [1] 1.96 0.49 0.00 0.49 1.96
```

Compute the variance of x

```r
var_x = sum(sq_xdiff)/(length(x)-1)
print(paste0("variance of x is ", var_x));
```

```
## [1] "variance of x is 1.225"
```

```r
print(paste0("Variance using r's function is ", var(x)))
```

```
## [1] "Variance using r's function is 1.225"
```

We will also go ahead and take the product of the differences between x-x mean and y-y mean. We need to subtract the mean of y from each data point in y. We do not need to square that result since that is not in the formula required for deriving regression. 

```r
ydiff = y-y_mean
xydiff = xdiff*ydiff
```

Compute the covariance 

```r
xycov = sum(xydiff)/(length(x)-1)
print(paste0("Calculated covariance is ", xycov));
```

```
## [1] "Calculated covariance is 5.215"
```

```r
print(paste0("Covariance using r's function is ", cov(x, y)))
```

```
## [1] "Covariance using r's function is 5.215"
```

Compute coefficient B0 and B1

```r
B1 = xycov/var_x
B0 = y_mean - B1*x_mean
print(paste0("Coefficient B0 is ", B0));
```

```
## [1] "Coefficient B0 is -14.8"
```

```r
print(paste0("Coefficient B1 is ", B1))
```

```
## [1] "Coefficient B1 is 4.25714285714286"
```

Our derived regression line to the nearest hundreth is: 
$$
y=B_0+B_1x\\
y=-14.8+4.26x
$$

Lets check this model using r's built in functions 

```r
mod<-lm(y~x,data=df)
summary(mod)
```

```
## 
## Call:
## lm(formula = y ~ x, data = df)
## 
## Residuals:
##     1     2     3     4     5 
## -0.24  0.38 -0.20  0.22 -0.16 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -14.8000     1.0365  -14.28 0.000744 ***
## x             4.2571     0.1466   29.04 8.97e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.3246 on 3 degrees of freedom
## Multiple R-squared:  0.9965,	Adjusted R-squared:  0.9953 
## F-statistic: 843.1 on 1 and 3 DF,  p-value: 8.971e-05
```

We have verified that we indeed have derived the correct regression equation by hand. Lets check some residuals and diagnostics for our simple models. I am aware that we only have 5 data points however, in terms of method, adding diagnostics to any regression model is simply a good practice. I do not expect the residuals to look good and totally satisfy the regression requirments. 


```r
library(olsrr)
```

```
## 
## Attaching package: 'olsrr'
```

```
## The following object is masked from 'package:datasets':
## 
##     rivers
```

```r
res1<-mod$residuals
hist(res1);
```

![](RSINGH_DATA605-Assignment15_files/figure-latex/unnamed-chunk-9-1.pdf)<!-- --> 

```r
qqnorm(mod$residuals)
qqline(mod$residuals);
```

![](RSINGH_DATA605-Assignment15_files/figure-latex/unnamed-chunk-9-2.pdf)<!-- --> 

```r
plot(fitted(mod), residuals(mod), xlab="fitted", ylab="residuals")
abline(h=0);
```

![](RSINGH_DATA605-Assignment15_files/figure-latex/unnamed-chunk-9-3.pdf)<!-- --> 

```r
ols_test_breusch_pagan(mod)
```

```
## 
##  Breusch Pagan Test for Heteroskedasticity
##  -----------------------------------------
##  Ho: the variance is constant            
##  Ha: the variance is not constant        
## 
##             Data              
##  -----------------------------
##  Response : y 
##  Variables: fitted values of y 
## 
##         Test Summary         
##  ----------------------------
##  DF            =    1 
##  Chi2          =    0.3204615 
##  Prob > Chi2   =    0.5713305
```

### 2. Find all local maxima, local minima, and saddle points for the function given below. Write your answer(s) in the form ( x, y, z ). Separate multiple points with a comma.

$$
f(x,y)=24x-6xy^{2}-8y^{3}
$$

We will be following this tutorial 
http://www.math.ucla.edu/~ronmiech/Calculus_Problems/32A/chap12/section7/819d5/819_5.html

We need to compute the partial derivatives with respect to x and with respect to y. Lets order anything that is not an x,to the front for each term/factor
$$
f(x,y)=24x-y^{2}6x-8y^{3}\\
f_{x}(x, y)=24-6y^{2}
$$

Repeat the same thing but with respect to y 
$$
f(x,y)=24x-6xy^{2}-8y^{3}\\
f_{y}(x, y)=-12xy-24y^{2}
$$

We now need to set each partial derivative equal to zero and solve the resulting system of two equations and two unknowns.
Lets start by solving the first partial derivative with respect to x
$$
f_{x}(x, y)=24-6y^{2}=0\\
24=6y^{2}\\
4=y^{2}\\
-2=y\\
2=y
$$

Solve the partial derivative with respect to y. We also know y is -2 and 2
$$
f_{y}(x, y)=-12xy-24y^{2}=0\\
-12xy=24y^{2}\\
x=-2y\\
x=-2(-2)=4\\
x=-2(2)=-4
$$

We have the following points for (x, y,z) however we need to compute z for each instance
$$
f(x, y)=z=f(x,y)=24x-6xy^{2}-8y^{3}\\
(4, -2, z)\\
(-4, 2, z)
$$

We can use r to compute those z values instead of plugging in by hand

```r
find_z <- function(x,y)
  {
   z = 24*x-6*x*y^2-8*y^3
   return(c(z))
}
print(paste0("When x=4 and y=-2, then z is ",find_z(4,-2)));
```

```
## [1] "When x=4 and y=-2, then z is 64"
```

```r
print(paste0("When x=-4 and y=2, then z is ",find_z(-4,2)))
```

```
## [1] "When x=-4 and y=2, then z is -64"
```

We have the following critical points
$$
(4, -2, 64)\\
(-4, 2, -64)
$$

We now have to test our critical points and determine if they are extrema or a saddle point. A saddle point is where a critical point exists but does not have any extrema. We need to use the second derivative test. 

D is defined as 
$$
D(x,y)=D=f_(xx)(x,y)f_{yy}(x,y)-[f_{xy}(x, y)]^{2}
$$

We need to compute a 2nd order partial derivative with respect to x, with respect to y, and with respect to xy
$$
f_{x}(x, y)=24-6y^{2}\\
f_{xx}(x, y)=0
$$

$$
f_{y}(x, y)=-12xy-24y^{2}\\
f_{yy}(x, y)=-12x-48y
$$

$$
f_{x}(x, y)=24-6y^{2}\\
f_{xy}(x, y)=-12y
$$

Find extrema and saddle points using the following criteria. 
If D>0 and fxx>0, then local min
if D>0 and fxx<0 then local max
If D<0 then saddle point 
$$
D(x,y)=D=f_(xx)(x,y)f_{yy}(x,y)-[f_{xy}(x, y)]^{2}\\
D=(0)(-12x-48y)-[-12y]^{2}\\
D=-144y^{2}
$$

D<0 for any point, hence we can conclude that our two points are saddle points. 

### 3. A grocery store sells two brands of a product, the "house" brand and a "name" brand. The manager estimates that if she sells the "house" brand for x dollars and the "name" brand for y dollars, she will be able to sell 81 - 21x + 17y units of the "house" brand and 40 + 11x - 23y units of the "name" brand.

Step 1. Find the revenue function R(x,y). 
We can perform some algebra by distributing and combining similar terms where possible 
$$
 R(x,y) = (81- 21x + 17y)x + (40 + 11x - 23y)y\\
 R(x, y)=81x - 21x^2 + 28yx + 40y - 23y^2
$$

Step 2. What is the revenue if she sells the "house" brand for $2.30 and the "name" brand for $4.10?

```r
find_r <- function(x,y)
  {
   r = 81 * x - 21* x^2 + 28 *y*x + 40*y  - 23*y^2
   return(c(r))
  }
print(paste0("The revenue is ", find_r(2.3,4.1)))
```

```
## [1] "The revenue is 116.62"
```


### 4. A company has a plant in Los Angeles and a plant in Denver. The firm is committed to produce a total of 96 units of a product each week. The total weekly cost is given by C(x, y), where x is the number of units produced in Los Angeles and y is the number of units produced in Denver. How many units should be produced in each plant to minimize the total weekly cost?

lets take some of the concepts used in the previous 2 problems and apply it to solve this problem. 
http://links.uwaterloo.ca/math227docs/set4.pdf

Cost function
$$
c(x,y)=\frac{1}{6}x^{2}+\frac{1}{6}y^{2}+7x+25y+700\\
$$

We can assume that x+y=total number of units
$$
x+y=96\\
x=96-y
$$

This relationship allows us to convert C(x,y) into a univariate function. Substitute the above relationship and simplify using algebra. 
$$
c(x,y)=\frac{1}{6}x^{2}+\frac{1}{6}y^{2}+7x+25y+700\\
=\frac{1}{6}(96-y)^{2}+\frac{1}{6}y^{2}+7(96-y)+25y+700\\
C(y)=\frac{1}{3}y^{2}-14y+2908
$$

Optimize 
$$
C'(y)=\frac{2}{3}y-14=0\\
\frac{2}{3}y=14\\
2y=42\\
y=21
$$

$$
x=96-y=96-21=75
$$
We found that we need 75 units in La and 21 units in Denver in order to minimize the cost.

### 5.  Evaluate the double integral on the given region.

$$
\iint_R { { e }^{ 8x+3y }dA } \\
2\le x \le 4\\
2 \le y \le 4
$$
Work with the inner integral first and integrate with respect to x

$$
 \iint _{ 2 }^{ 4 }{ { e }^{ 8x+3y }dxdy } \\
 \iint _{ 2 }^{ 4 }{ { e }^{ 8x }{e}^{3y}dxdy } \\
 \int _{ 2 }^{ 4 } ({e}^{3y}) \int _{ 2 }^{ 4 }(e^{8x})dx dy\\
  \int _{ 2 }^{ 4 } ({e}^{3y})(\frac{e^{32}-e^{16}}{8})dy\\
  \frac{e^{32}-e^{16}}{8}\int _{ 2 }^{ 4 } ({e}^{3y})dy\\
 [ \frac{e^{32}-e^{16}}{8}][\frac{e^{12}-e^{6}}{3}]\\
 e^{16}e^{6}(\frac{e^{16}-1}{8})(\frac{e^{2}-1}{3})\\
 \frac{e^{16}e^{6}}{24}(e^{16}-1)(e^{2}-1)
$$
