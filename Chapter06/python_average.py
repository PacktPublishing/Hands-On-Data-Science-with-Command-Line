import sys
import pandas as pd

df = pd.read_csv(sys.stdin,sep='\t')
print 'star rating mean',df['star_rating'].mean()
print 'helpful votes mean', df['helpful_votes'].mean()

