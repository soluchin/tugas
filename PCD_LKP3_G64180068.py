import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt

#membaca image melon.jpeg dalam format grayscale
img= cv.imread('C:/Users/Admin/Pictures/melon.jpeg', 0)

#resize gambar agar tidak begitu besar
resize_w= int(img.shape[1]*0.5)
resize_h= int(img.shape[0]*0.5)
dim=(resize_w,resize_h)
img= cv.resize(img, dim, interpolation = cv.INTER_AREA)

#tampilkan gambar original
cv.imshow('original', img)

#fungsi untuk mengambil histogram dari gambar
def imgHist(image, histoName):
	plt.figure(histoName)
	plt.hist(image.ravel(),256)
	plt.show()

#tampilkan histogram dari gambar yang masih original
imgHist(img, 'original')

#fungsi mengambil histogram dari list
def listHist(list_, histoName):
	x= [i for i in range(0,256)]
	plt.figure(histoName)
	plt.bar(x,list_)
	plt.show()

#membuat fungsi contrastStretching
def contrastStretching(image):
	h,w= image.shape
	max_= max(image.ravel())
	min_= min(image.ravel())
	for i in range(h):
		for j in range(w):
			image[i,j]= (image[i,j]-min_)/(max_-min_)*255
	return image

#stretching image
img_cs= contrastStretching(img)
#tampilkan gambar setelah melakukan stretching
cv.imshow('contrast_streching',img)
#tampilkan histogram dari gambar yang sudah di stretching
imgHist(img_cs, 'stretched')

#menghitung jumlah kemunculan pixel
def kemunculan(image):
	y=[0]*256
	for i in image.ravel():
		y[i]+=1
	return y

#menghitung peluang kemunculan
def peluang(image):
	h,w= image.shape
	hxw= h*w
	y= kemunculan(image) #panggil fungsi kemunculan
	x=[i/hxw for i in y]
	return x

#tampilkan histogram normalize
listHist(peluang(img_cs), 'normalized')

#menghitung histogram kumulatif
def kumulatif(image):
	before= peluang(image) #panggil fungsi peluang
	sum_=0
	kumul=[]
	for i in range(256):
		sum_= sum_+before[i]
		kumul.append(sum_)
	return kumul

#tampilkan histogram cumulative
listHist(kumulatif(img_cs), 'cumulative')

#melakukan histogram equalization
def equalize(image):
	knv= image
	h,w= knv.shape
	kumul= kumulatif(knv) #panggil fungsi kumulatif
	equ=[int(x*255) for x in kumul]
	for i in range(h):
		for j in range(w):
			knv[i,j]=equ[knv[i,j]]
	return knv

#equalize gambar yg sudah dilakukan stretching
equ= equalize(img_cs)
#tampilkan gambar yg sudah di equalize
cv.imshow('equalize', equ)
#tampilkan histogram dari gambar yg sudah di equalize
imgHist(equ, 'equalize')

cv.waitKey(0)