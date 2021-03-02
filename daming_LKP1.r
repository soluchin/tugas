tahun<- c(2012:2020)
jumlah<- c(1265.24, 1580.5, 2273, 1862.85, 2360.5, 2450.5, 3356.65, 
           3598.44, 3893.54)
penghasilan<- c(1132.87, 1424.245, 2045.75, 1673.656, 2127.445,
                2208.545, 3029.98, 3234, 3584.52)
df<- data.frame(tahun, jumlah, penghasilan)
df
#write.csv(df,"~/latihan1.csv", row.names = FALSE)

plot(jumlah,type="o",col="blue", xlab='Tahun', ylab='',
     axes= FALSE)
lines(penghasilan, type = "o", col = "red", ann=FALSE)
axis(1, at=c(1:9), lab=tahun)
axis(2, at=500*0:max(jumlah))
legend('topleft', c('jumlah','penghasilan'), fill=c('blue', 'red'))
box()

