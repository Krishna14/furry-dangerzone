from PIL import Image
from numpy import *
from scipy.ndimage import filters
from pylab import *
im = array(Image.open('empire.jpeg'))
im2 = filters.gaussian_filter(im,0)

im = array(Image.open('empire.jpeg'))
imx = zeros(im.shape)
filters.sobel(im,1,imx)

imy = zeros(im.shape)
filters.sobel(im,0,imy)

magnitude = sqrt(imx**2 + imy**2)

"""sigma = 5 #standard deviation

imx = zeros(im.shape)
filters.gaussian_filter(im, (sigma,sigma), (0,1), imx)

imy = zeros(im.shape)
filters.gaussian_filter(im, (sigma,sigma), (1,0), imy)"""
figure()
imshow(im)
figure()
imshow(abs(imx))
figure()
imshow(abs(imy))
figure()
imshow(abs(magnitude))
show()