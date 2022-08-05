#!/usr/bin/env python3

#   Plots core and noncore snps and indels from vep results
#   Elaine Lee - Minneapolis, MN - Apr 3, 2022


import pandas as pd

df = pd.DataFrame({'Variant Set': ['Core\nSNPs', 'Noncore\nSNPs', 'Core\nIndels', 'Noncore\nIndels'], 'Synonymous': [89593, 101751, 0, 0], 'Inframe Indel': [0, 0, 3966, 6526], 'Missense': [81408, 173845, 0, 0], 'Start or Stop Change': [356, 853, 253, 261], 'Stop Gain': [891, 3740, 196, 701], 'Frameshift': [0, 0, 3698, 17267]})

import matplotlib.pyplot as plt
import seaborn as sns

sns.set(style='white')
sns.set(rc = {'figure.figsize':(15,10)})
sns.set_palette("afmhot_r")

df.set_index('Variant Set').plot(kind='bar', stacked=True, fontsize=18, edgecolor='none')
plt.legend(fontsize=18)
plt.savefig('cowpea_vep.png')
