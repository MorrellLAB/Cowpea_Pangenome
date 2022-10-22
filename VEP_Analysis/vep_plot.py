#!/usr/bin/env python3

#   Plots core and noncore snps and indels from vep results
#   Elaine Lee - Minneapolis, MN - Apr 3, 2022


import pandas as pd

df = pd.DataFrame({'Variant Set': ['Core\nSNPs', 'Noncore\nSNPs', 'Core\nIndels', 'Noncore\nIndels'], 'Synonymous': [77150, 34112, 0, 0], 'Inframe Indel': [0, 0, 3543, 2407], 'Missense': [87414, 65308, 0, 0], 'Start or Stop Change': [326, 385, 67, 59], 'Stop Gain': [1426, 1669, 287, 298], 'Frameshift': [0, 0, 5945, 7329]})

import matplotlib.pyplot as plt
import seaborn as sns

sns.set(style='white')
sns.set(rc = {'figure.figsize':(15,10)})
sns.set_palette("afmhot_r")

df.set_index('Variant Set').plot(kind='bar', stacked=True, fontsize=18, edgecolor='none')
plt.legend(fontsize=18)
plt.savefig('cowpea_vep.png')
