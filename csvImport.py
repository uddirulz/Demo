# First, import the .csv file
import pandas as pd
import openpyxl as op

df = pd.read_csv("res.csv")
# Calculate the 90th percentile by grouping data
# df_percentile = df.groupby('label')['elapsed'].quantile(0.9).reset_index()
df['90th Percentile'] = df.groupby('label')['elapsed'].transform(lambda x: x.quantile(0.9))
# df['API'] = df.label.str.extract('.*_(.*?)_T.*')
# print(df['API'])

# Now, open the book you are going to overwrrite.csv
book = op.load_workbook("Report Template.xlsx")

writer = pd.ExcelWriter("Report Template.xlsx", engine='openpyxl', mode='a', if_sheet_exists="overlay") 
writer.workbook = book

## ExcelWriter for some reason uses writer.sheets to access the sheet.
## If you leave it empty it will not know that sheet Main is already there
## and will create a new sheet.

# writer.sheets = dict((ws.title, ws) for ws in book.worksheets)

df.to_excel(writer, sheet_name="Sheet1", index=False)
# df_percentile.to_excel(writer, sheet_name="Sheet2", index=False)

writer.close()
