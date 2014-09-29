import numpy as np
import scipy
import mahotas


f = mahotas.imread('/home/krish/Pictures/labeled-2.png')
f = mahotas.gaussian_filter(f, 4)
f = (f> f.mean())

labeled, n_nucleus = mahotas.label(f)
print('found {} nuclei.'.format(n_nucleus))

sizes = mahotas.labeled.labeled_size(labeled)
too_big = np.where(sizes > 10000)
labeled = mahotas.labeled.remove_regions(labeled, too_big)

labeled = mahotas.labeled.remove_bordering(labeled)

relabeled, n_left = mahotas.labeled.relabel(labeled)
print('After filtering and relabeling, there are {} nuclei left.'.format(n_left))
