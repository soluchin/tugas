#nomer 1
#konversi nilai reamur ke fahrenheit
cvt_r2f= function(r){
  f= (r*2.25)+ 32
  return(f)
}
cvt_r2f()

#---------------------------------
#nomer 2
#membuat dataframe
country= c('usa', 'india', 'Brazil', 'russian', 'uk', 'france')
cases_cumulative= c(27491574, 10950201, 9921981, 4125598, 4071189, 3453645)
death_cumulative= c(485379, 156014, 240940, 81926, 118933, 82692)
df= data.frame(country, cases_cumulative, death_cumulative)
df

#menghitung rata-rata cases_cumulative
mean(df$cases_cumulative)

#menghitung total death_cumulative
sum(df$death_cumulative)

#mengurutkan nama negara dari A-Z
#menggunakan pckages stringr
str_sort(df$country)

#----------------------------------
#nomer 3
#buatlah fungsi turunan pertama dari fx
fx=function(x){
  x^3+sqrt(x^2+2*x)
}
Deriv(fx)