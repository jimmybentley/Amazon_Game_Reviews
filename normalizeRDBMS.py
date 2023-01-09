import numpy as np
import pandas as pd
import os

def createSchema(df):
    '''
    takes in dataframe and creates all tables of relational database schema as
    separate .csv files.
    '''
    # makes copy so original df is not affected.
    df = df.copy()
    createReviews(df)
    createStyles(df)
    createStyleReviews(df)
    createImages(df)
    createReviewers(df)

def createReviews(df):
    '''
    takes in dataframe and creates reviews table as .csv file.
    '''
    reviewsTable = df[['overall', 'verified', 'reviewTime', 'reviewer_id', \
'asin', 'reviewText', 'vote']]
    reviewsTable['reviewText'] = reviewsTable['reviewText'].transform(\
lambda x: x.str.replace(',', '').str.replace('\n', ' ').str.replace(r'\\', ''))
    reviewsTable.to_csv('reviews.csv', header=False)

def createStylesTable(df):
    '''
    takes in dataframe and styles table.
    '''
    stylesExpanded = df[~df['style'].isna()][['asin', 'style']]
    stylesValuesCleaned = list(cleanVals(stylesExpanded['style']))
    stylesTable = pd.DataFrame(pd.Series({i: stylesValuesCleaned[i] for i in \
range(len(stylesValuesCleaned))})).rename(columns={0:'Style'})
    stylesTable.index.name = 'style_id'
    return stylesTable

def createStyleReviews(df):
    '''
    takes in dataframe and creates styleReviews table as .csv file.
    '''
    stylesTable = createStylesTable(df)
    stylesExpanded = df[~df['style'].isna()][['asin', 'style']]
    keyVals = {x: y for x, y in zip(stylesExpanded['asin'], stylesExpanded['style'])}
    stylesDict = {val: i for i, val in zip(stylesTable.index, stylesTable['Style'])}
    productsTable = pd.DataFrame(columns=['asin', 'style_id'])

    # getting unique values of style
    history = set()
    for key in keyVals:
        for val in keyVals[key]:
            vals = list(keyVals[key].values())
            for v in vals:
                dct = {'asin': key, 'style_id': stylesDict[str.strip(v).replace(',','')]}
                if str(dct) not in history:
                    history.add(str(dct))
                    row = pd.Series(dct)
                    productsTable = productsTable.append(row,ignore_index=True)

    productsTable.index.name = 'id'
    reviewStyle = df.reset_index().merge(productsTable, on = 'asin', how='left')[['review_id', 'style_id']].dropna().set_index('review_id')
    reviewStyle.to_csv('reviewStyle.csv', header=False)

def createStyles(df):
    '''
    takes in dataframe and creates styles table as .csv file.
    '''
    stylesTable = createStylesTable(df)
    stylesTable.to_csv('styles.csv', header=False)

def createImages(df):
    '''
    takes in dataframe and creates images table as .csv file.
    '''
    allImages = pd.DataFrame(df[~df['image'].isna()]['image'].explode())
    imgs = set()

    for tpl in zip(list(allImages.index), allImages['image']):
        imgs.add(tpl)

    cleanedImages = pd.DataFrame(imgs).sort_values(by=0)
    cleanedImages = cleanedImages.reset_index(drop=True)

    cleanedImages.to_csv('images.csv', header=False)

def createReviewers(df):
    '''
    takes in dataframe and creates reviewers table as .csv file.
    '''
    reviewersTable = df.groupby('reviewer_id')[['reviewerName']].max()
    reviewersTable['reviewerName'] = reviewersTable['reviewerName'].transform\
(lambda x: x.str.replace(',', ''))

    reviewersTable.to_csv('reviewers.csv', header=False)

def cleanVals(ser):
    '''
    cleansVals takes in a series, ser, and returns a set of unique values.
    '''
    history = set()

    for vals in ser:
        valList = list(vals.values())
        for v in valList:
            v = str.strip(v.replace(',', ''))
            if v not in history:
                history.add(v)

    return history
