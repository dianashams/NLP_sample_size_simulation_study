
# Datasets
near0coeff = c(563,816,770,857,819,751,813,764,805,728,790)
highcoeff = c(183,74,118,64,80,103,77,127,86,116,98)
auc_max = c(0.83,0.61,0.73, 0.71,0.80,0.63,0.65,0.71,0.72,0.65,0.67)
auc_300 = c(0.63,0.59,0.67,0.67,0.79,0.58,0.62,0.67,0.70,0.61,0.64)
good = c(1,0,1,1,1,0,0,1,1,0,0)

df = data.frame(good, near0coeff, highcoeff, auc_max, auc_300)
rownames(df) = c("orignial", "53081",  "51881",  "42731",
                 "41401",  "25000",  "5990",  "5849", 
                 "4280",  "4019",  "2724")
df
clipr::write_clip(df)

################ all datasets ################

# nill model
summary(glm(auc_max ~ auc_300, data = df, family ="gaussian"))
#           Estimate Std. Error t value Pr(>|t|)  
# (Intercept)    0.186      0.187    0.99    0.347  
# auc_300        0.791      0.286    2.77    0.022 *

# diff(aux_max,auc_300) ~ on the number of strong predictors
summary(glm(auc_max ~ offset(auc_300) + I(highcoeff/100), data = df, family ="gaussian"))
  # Estimate Std. Error t value Pr(>|t|)    
  # (Intercept)       -0.0882     0.0279   -3.16   0.0116 *  
  # I(highcoeff/100)   0.1341     0.0260    5.15   0.0006 ***

# diff(aux_max,auc_300) ~ on the number of noise predictors
summary(glm(auc_max ~ offset(auc_300) + I(near0coeff/100), data = df, family ="gaussian"))
  # Estimate Std. Error t value Pr(>|t|)    
  # (Intercept)        0.52089    0.06942    7.50 0.000037 ***
  # I(near0coeff/100) -0.06123    0.00897   -6.83 0.000077 ***

# diff(aux_max,auc_300) ~ on both
summary(glm(auc_max ~ offset(auc_300) + I(highcoeff/100)+ I(near0coeff/100), data = df, family ="gaussian"))
  # Estimate Std. Error t value Pr(>|t|)  
  # (Intercept)         0.5925     0.3181    1.86    0.100 .
  # I(highcoeff/100)   -0.0171     0.0738   -0.23    0.823  
  # I(near0coeff/100)  -0.0683     0.0318   -2.15    0.064 .

# Checking correlation between the number of high and noise predictors 
# (if there are any connection)
summary(glm(formula = highcoeff ~ I(near0coeff/100), family = "gaussian", data = df))
  # Estimate Std. Error t value   Pr(>|t|)    
  # (Intercept)         419.32      33.14   12.65 0.00000049 ***
  # I(near0coeff/100)   -41.13       4.28   -9.61 0.00000498 ***
# -41 per 100 of near0; 
#  texts with less noisy data also have more strong predictors

############# Without the "original"  data###################
summary(glm(auc_max ~ offset(auc_300), data = df[-1,], family ="gaussian"))
# Estimate Std. Error t value  Pr(>|t|)    
# (Intercept)   0.03400     0.00476    7.14     0.000054***  

# diff(aux_max,auc_300) ~ on the number of strong predictors
summary(glm(auc_max ~ offset(auc_300) + I(highcoeff/100), data = df[-1,], family ="gaussian"))
  # Estimate Std. Error t value Pr(>|t|)  
  # (Intercept)      -0.00511    0.01948   -0.26    0.800  
  # I(highcoeff/100)  0.04147    0.02019    2.05    0.074 .

# diff(aux_max,auc_300) ~ on the number of noise predictors
summary(glm(auc_max ~ offset(auc_300) + I(near0coeff/100), data = df[-1,], family ="gaussian"))
  # Estimate Std. Error t value Pr(>|t|)  
  # (Intercept)         0.1920     0.0949    2.02    0.078 .
  # I(near0coeff/100)  -0.0200     0.0120   -1.67    0.134  

# Checking correlation between the number of high and noise predictors 
# (if there are any connection)
summary(glm(highcoeff ~ I(near0coeff/100), data = df[-1,], family ="gaussian"))
  # Estimate Std. Error t value Pr(>|t|)    
  # (Intercept)         484.66      72.59    6.68  0.00016 ***
  # I(near0coeff/100)   -49.33       9.16   -5.38  0.00066 ***


# => statistical power of this analysis is rather low, still, 
#' 1) more highly definite coefficients , or 
#' 2) less near 0 coefficients  => steeper learning curve, i.e. there is a potential to improve 
#' Conclusions: 
#' a) running a simple analysis of the key words can indicate how steep the learning curve may be
#' b) data cleaning techniques of identifying the parts of larger documents can make the difference
m0 = glm(auc_max ~ offset(auc_300), data = df[-1,], family ="gaussian")
m0_full = glm(auc_max ~ offset(auc_300) , data = df, family ="gaussian")
m1 = glm(auc_max ~ offset(auc_300) + I(highcoeff/100), data = df[-1,], family ="gaussian")
m1_full = glm(auc_max ~ offset(auc_300) + I(highcoeff/100), data = df, family ="gaussian")
m2 = glm(auc_max ~ offset(auc_300) + I(near0coeff/100), data = df[-1,], family ="gaussian")
m2_full = glm(auc_max ~ offset(auc_300) + I(near0coeff/100), data = df, family ="gaussian")

m3 = glm(highcoeff ~ I(near0coeff/100), data = df[-1,], family ="gaussian")
m3_full = glm(highcoeff ~ I(near0coeff/100), data = df, family ="gaussian")

# Plots
par(mfrow = c(2,2))

plot(highcoeff, auc_max-auc_300, col = ifelse(good,"blue","red"), main = "Learning curve vs # strong words")
lines(highcoeff[order(highcoeff)], predict(m1, df[order(highcoeff),])-auc_300[order(highcoeff)], col = 1, lty = 3)
lines(highcoeff[order(highcoeff)], predict(m1_full, df[order(highcoeff),])-auc_300[order(highcoeff)], col = 2, lty = 3)

plot(near0coeff, auc_max-auc_300, col = ifelse(good,"blue","red"),main = "Learning curve vs # noise words")
lines(near0coeff[order(near0coeff)], predict(m2, df[order(near0coeff),])-auc_300[order(near0coeff)], col = 1, lty = 3)
lines(near0coeff[order(near0coeff)], predict(m2_full, df[order(near0coeff),])-auc_300[order(near0coeff)], col = 2, lty = 3)

plot(auc_300, auc_max, col = ifelse(good,"blue","red"), main = "AUC at n=300 and n=10k")
lines(auc_300, predict(m0, df), col = 1, lty = 3)
lines(auc_300, predict(m0_full, df), col = 2, lty = 3)

plot(near0coeff, highcoeff, col = ifelse(good,"blue","red"),main =  "Strong vs noise words' count")
lines(near0coeff[order(near0coeff)], predict(m3, df[order(near0coeff),])-auc_300[order(near0coeff)], col = 1, lty = 3)
lines(near0coeff[order(near0coeff)], predict(m3_full, df[order(near0coeff),])-auc_300[order(near0coeff)], col = 2, lty = 3)

legend(
  "bottomleft",
  legend = c(
    "All datasets",
    "Without original",
    "AUC_max>0.80",
    "AUC_max<=0.80"
  ),
  col = c(1, 2, "blue", "red"),
  pch = c(NA, NA, 19, 19),
  lty = c(3, 3, 1, 1),
  lwd = c(1,1,NA,NA),
  bty = "n"
)
