#!/usr/bin/env python3

#   Plots core and noncore snps and indels from vep results
#   Elaine Lee - Minneapolis, MN - Apr 3, 2022


import pandas as pd

df = pd.DataFrame({'Variant Set': ['Core\nSNPs', 'Noncore\nSNPs', 'Core\nIndels', 'Noncore\nIndels'], 'Synonymous': [89298, 100112, 0, 0], 'Inframe Indel': [0, 0, 3960, 6447], 'Missense': [81135, 170812, 0, 0], 'Start or Stop Change': [356, 836, 252, 297], 'Stop Gain': [889, 3662, 196, 687], 'Frameshift': [0, 0, 3672, 16908]})

import matplotlib.pyplot as plt
import seaborn as sns

sns.set(style='white')
sns.set(rc = {'figure.figsize':(15,10)})
sns.set_palette("afmhot_r")

df.set_index('Variant Set').plot(kind='bar', stacked=True, fontsize=18, edgecolor='none')
plt.legend(fontsize=18)
plt.savefig('cowpea_vep.png')
