library(rgl)

# Random.Unit returns n dim-dimensional points in the unit interval labeled
# -1 or 1. The label depends on whether or not the sum of the vector's 
# components exceeds the given threshold. That is, -1 if sum(vector) < threshold
# and 1 otherwise.
# mendeklarasikan fungsi Random.Unit
Random.Unit <-function(n, dim, threshold) {
  #membangkitkan bilangan acak sebanyak n dan berdimensi dim
  points <- runif(n * dim)
  #mengubah bentuk points yang masih berbentuk array menjadi matriks berukuran dim
  points <- matrix(points, ncol = dim)
  #memberi label untuk setiap titik berdasarkan threshold yang dimasukkan
  label <- ifelse(apply(points, 1, sum) < threshold, -1, 1)
  #kembalikan matriks yang sudah dilabeli berdasarkan thereshold
  return(cbind(label, x0 = rep(1, n), points))
}

# Classify is our simple classification rule for the perceptron.We simply 
# return the sign of the dot-product of our observations and weights
# mendeklarasikan fungsi classify
Classify <- function(x, weights) {
  # fugsi ini mengembalikan label yang sesuai dengan bobot baru
  return(sign(x %*% weights))
}

# Perceptron is a simple implementation of the perceptron learning algorithm.
# It accepts data of the form data[1] = label, data[2] = x_0 = 1, data[3] = x_1,
# etc. w0 is initilized to -threshold and the weights returned are such that
# sign(w_0 * x_0 + w_1 * x_1 + ... + w_n * x_n) == label
# mendeklarasikan fungsi perceptron
Perceptron <- function(data, threshold) {
  # menghitung nilai w pertama
  w <- c(-threshold, runif(ncol(data) - 2))
  # mengambil banyak bilangan acak
  n <- nrow(data)
  #mengambil label yang sudah ada sebelumnya
  label <- data[ , 1]
  obs <- data[ , 2:ncol(data)]
  #menganggap ada bilangan yang salah diberi label
  misclassfied <- TRUE
  while (misclassfied) {
    #mengubah label bilangan agar label menjadi lebih akurat
    misclassfied <- FALSE
    for (i in 1:n) {
      #jika label awal terdeteksi berbeda dengan yang sudah dikembalikan
      #oleh fungsi classify, maka ubah bobot input
      if (label[i] * Classify(obs[i , ], w) <= 0) {
        w <- w + label[i] * obs[i , ]
        misclassfied <- TRUE
      }
    }
  }
  #mengembalikan bobot
  return(w)
}

# Plot3D is essentially a wrapper for the rgl package's plot3d function.
# It plots the result of a call to Random.Unit with dim = 3
# as well as the plane parameterized by ax + by + cz + d = 0
# mendeklarasikan fungsi plot3D
Plot3D <- function(points, a, b, c, d) {
  #memvisualisasikan program jika dimensi lebih dari 2
  plot3d(points[, 3:5], xlab = "X", ylab = "Y", zlab = "Z",
         pch = ifelse(points[, 1] == 1, 2, 8),
         col = ifelse(points[, 1] == 1, "blue", "red"))
  planes3d(a, b, c, d)
}

# Plot2D plots the result of a call to Random.Unit with dim = 2 as well
# as the line parameterized by y = bx + a, as in the call to abline.
# mendeklarasikan fungsi plot2D
Plot2D <- function(points, a, b) {
  #memvisualisasikan program jika dimensi sama dengan 2
  plot(points[, 3:4], xlab = "X", ylab = "Y",
       pch = ifelse(points[, 1] == 1, 2, 8),
       col = ifelse(points[, 1] == 1, "blue", "red"))
  abline(a, b)
}

# memulai program
THRESHOLD <- 1
pts <- Random.Unit(10, 3, THRESHOLD)
#melihat visualisasi pertama
Plot3D(pts, 1, 1, 1, -THRESHOLD)
#mencoba untuk mengubah bobot dengan memanggil fungsi perceptron
w <- Perceptron(pts, THRESHOLD)
#melihat visualisasi setelah bobot diubah
Plot3D(pts, w[4], w[3], w[2], w[1])

THRESHOLD <- 1.5
pts <- Random.Unit(100, 2, THRESHOLD)
#melihat visualisasi pertama
Plot2D(pts, THRESHOLD, -1)
#mencoba untuk mengubah bobot dengan memanggil fungsi perceptron
w <- Perceptron(pts, THRESHOLD)
#melihat visualisasi setelah bobot diubah
Plot2D(pts, -w[1]/w[3], -w[2]/ w[3])
