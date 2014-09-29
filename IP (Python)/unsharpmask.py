from PIL import Image
from pylab import *
from scipy.ndimage import filters


img = array(Image.open('empire.jpeg'))
blur = filters.gaussian_filter(img,1)
imshow(img)
show()
imshow(blur)
show() 	
sharp_img = abs((img- blur))
imshow(sharp_img)
show()