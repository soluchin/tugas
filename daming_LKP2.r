#set working directory
setwd("D:/RStuff")

#baca csv
ins<- read.csv('weatherAUS.csv')
str(ins)
#menampilkan shape dari weatherAUS.csv
#dengan fungsi built in dim()
#jumlah data, jumlah atribut
dim(ins)

#ringkasan statistik
summary(ins$bmi)

#pada R ringkasan statistik tidak menampilkan
#standar deviasi
#tampilkan std
sd(ins$age)

#boxplot
boxplot(ins$bmi,
        main='laatihan boxplot',
        ylab='BMI')

#histogram
hist(ins$charges,
     main='latihan histogram',
     ylab='charges')

#scatterplot
plot(x=ins$age,
     y=ins$charges,
     main='latihan scatter',
     xlab='age',
     ylab='charges')

#densitas
plot(density(ins$charges),
     main='belajar R')

#covariance
cov(ins$age, ins$bmi)
cov(ins[, c('age', 'bmi', 'children', 'charges')])

#correlation
cor(ins$age, ins$bmi)
cor(ins[, c('age', 'bmi', 'children', 'charges')])
