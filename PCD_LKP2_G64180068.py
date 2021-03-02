import cv2 as cv
import numpy as np

### NOMER 1
#baca image melon dalam grayscale
img= cv.imread('C:/Users/Admin/Pictures/Lenna.png',0)

#ubah gambar menjadi format HSV
def my_cvt_hsv(gambar):
	h, w, ch= gambar.shape
	converted= np.zeros(shape= gambar.shape)
	for i in range(h):
		for j in range(w):
			blue, green, red= gambar[i,j]
			max_= max(blue, green, red)
			min_= min(blue, green, red)
			ran_= max_-min_

			val=max_
			if val!= 0:
				sat= ran_/max_
			else:
				sat= 0
			if val== red:
				hue= 60*(green-blue)/ran_
			if val== green:
				hue= 120+(60*(blue-red))/ran_
			if val== blue:
				hue= 240+(60*(red-green))/ran_
			if red==blue==green:
				hue= 0
			if hue<0:
				hue+=360
			converted[i,j]= hue/255,sat,val/255
	return converted

hsv_image= my_cvt_hsv(img)

#bandingkan hasil manual dengan hasil builtin
hsv_builtin= cv.cvtColor(img, cv.COLOR_BGR2HSV)
cv.imshow('hsv_manual', hsv_image)
cv.imshow('hsv_builtin', hsv_builtin)
hue1, sat1, val1= cv.split(hsv_image)
hue2, sat2, val2= cv.split(hsv_builtin)
cv.imshow('h1', hue1)
cv.imshow('s1', sat1)
cv.imshow('v1', val1)
cv.imshow('h2', hue2)
cv.imshow('s2', sat2)
cv.imshow('v2', val2)
cv.waitKey(0)

#ambil masing-masing channel hadi hsv
hue, sat, val= cv.split(hsv_image)


#tresholding setiap pixel
def my_tresh_cvter(ch):
	nch=np.zeros(shape= ch.shape)
	h, w= ch.shape
	#hitung rata-rata masing-masing intensitas pixel
	avg_ch= np.mean(ch)
	for i in range(h):
		for j in range(w):
			if ch[i,j]<avg_ch:
				nch[i,j]=0
			else:
				nch[i,j]=255
	return nch
tresh_hue= my_tresh_cvter(hue)
tresh_sat= my_tresh_cvter(sat)
tresh_val= my_tresh_cvter(val)

#tampilkan hasil setiap channel setelah dilakukan tresholding
cv.imshow('hue', tresh_hue)
cv.imshow('sat', tresh_sat)
cv.imshow('val', tresh_val)
cv.waitKey(0)


#------------------------------------------------------------------------
### NOMOR 2
#baca image lenna dan equ_gray
img1= cv.imread('C:/Users/Admin/Pictures/Lenna.png')
img2= cv.imread('C:/Users/Admin/Pictures/equ_gray.png')

#ubah gambar menjadi grayscale
def my_cvt_gs(gambar):
	h, w, ch= gambar.shape
	converted= np.zeros((h,w,1), np.uint8)
	for i in range(h):
		for j in range(w):
			blue, green, red= gambar[i,j]
			gray = (red * 0.299 + green * 0.587 + blue * 0.114)
			converted[i,j]= gray
	return converted
img1_gs= my_cvt_gs(img1)
img2_gs= my_cvt_gs(img2)

#buat fungsi image diff
def imageDiff(gambar1, gambar2):
	if gambar1.shape == gambar2.shape:
		#hitung rata-rata intensitas pixel
		avg_gambar1= np.mean(gambar1)
		avg_gambar2= np.mean(gambar2)

		gambar1= gambar1.astype(np.float32)
		gambar2= gambar2.astype(np.float32)

		#kalikan 0.5 jika nilai gambar kurang dari rata-rata
		gambar1[gambar1< avg_gambar1]*= 0.5
		gambar2[gambar2< avg_gambar2]*= 0.5
		#kalikan 2 jika nilai pixel lebih dari samadengan rata-rata
		gambar1[gambar1>= avg_gambar1]*= 2
		gambar2[gambar2>= avg_gambar2]*= 2

		gambar1= gambar1.astype(np.int32)
		gambar2= gambar2.astype(np.int32)

		#kurangkan gambar 1 dengan gambar 2
		result= gambar1-gambar2
		#jika hasil pengurangan kurang dari 0 maka ubah menjadi 0
		result[result<0]= 0
		result= result.astype(np.uint8)
		#kembalikan nilai result
		return result
	else:
		print('image shape not match')
		return False

substracted= imageDiff(img1_gs, img2_gs)
cv.imshow('substracted', substracted)
cv.waitKey(0)