getwd()
setwd("D:/rstuff")

#baca dataset
data<- data.frame(read.csv("dataheart.csv"))
new_data<- data.frame(read.csv("datadiabetes.csv"))

#nomer 1
#cek missing value dari setiap data frame
md.pattern(data)
md.pattern(new_data)

# Mengisi value Na dengan mean dari masing-masing atribut
data$trestbps[is.na(data$trestbps)]<- mean(data$trestbps, na.rm = TRUE)
data$chol[is.na(data$chol)]<- mean(data$chol, na.rm = TRUE)
data$thalach[is.na(data$thalach)]<- mean(data$thalach, na.rm = TRUE)
data$oldpeak[is.na(data$oldpeak)]<- mean(data$oldpeak, na.rm = TRUE)

# cek missing value
md.pattern(data)

#------------------------------------------------------------------------------

#nomer 2
#diskretisasi atribut chol dengan 4 bin
data$discretize_chol<- cut(data$chol, 4, include.lowest = TRUE)
data$discretize_chol

#diskretisasi atribut oldpeak dengan 3 bin
data$discretize_oldpeak<- cut(data$oldpeak, 3, include.lowest = TRUE)
data$discretize_oldpeak

#------------------------------------------------------------------------------

#nomer 3
#sum dari atribut chol, trestbps, thalach
Sum = data.frame(data$chol, data$trestbps, data$thalach)
# Jumlahkan ketiga atribut tersebut dan tambahkan atribut tersebut ke 'data'
data$Sum <- rowSums(Sum, na.rm = TRUE )
# Summary atribut 'Sum' sebelum dilakukan normalisasi
summary(data$Sum)

# Lakukan normalisasi
for (i in 1:length(data$Sum)) {
  data$Sum[i] = (data$Sum[i]-min(data$Sum))/(max(data$Sum)-min(data$Sum))
}
# Summary atribut 'Sum' setelah dilakukan normalisasi
summary(data$Sum)

#------------------------------------------------------------------------------

#nomer 4
#masukkan atribut-atribut baru yang sudah dibuat keadalam new_data
new_data$discretize_chol<- data$discretize_chol
new_data$discretize_oldpeak<- data$discretize_oldpeak
new_data$sum<- data$Sum
