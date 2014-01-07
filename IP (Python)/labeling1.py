import mahotas
import numpy as np
from pylab import imshow, show

regions = np.zeros((8,8), bool)

regions[:3,:3] = 1
regions[6:,6:] = 1
labeled, nr_objects = mahotas.label(regions)

imshow(labeled, interpolation='nearest')

sizes = mahotas.labeled_size(labeled)
print 'Background Size', sizes[0]
print 'Size Of First Region', sizes[1]

array = np.random.random_sample(regions.shape)
sums = mahotas.labeled_sum(array, labeled)
print 'Sum Of frist Region', sums[1]
