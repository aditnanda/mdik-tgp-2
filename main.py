import os
import pandas as pd
from sqlalchemy import create_engine, text
import re

# Proses Extract
def extract_data(folder_path, num_files):
    file_list = [file for file in os.listdir(folder_path) if file.endswith('.json')]
    
    all_films_df = pd.DataFrame()
    for index, file in enumerate(file_list):
        if index >= num_files:
            break
        
        file_path = os.path.join(folder_path, file)
        df = pd.read_json(file_path)
        all_films_df = pd.concat([all_films_df, df], ignore_index=True)
    
    return all_films_df

# Proses Transform
def clean_numeric_value(value): #cleansing atribut dan ambil numeric saja
    if isinstance(value, str):
        value = ''.join(filter(str.isdigit, value))
        if value == '':
            return 0
        else:
            return float(value)
    return float(value)

def extract_director(row): #mengambil nama director untuk move ke tabel director
    director = row['director']
    if isinstance(director, dict):
        return {'_id': row['_id'], 'name': director.get('name', '')}
    else:
        return {'_id': row['_id'], 'name': ''}
    
def extract_casts(row): #mengambil nama cast untuk move ke tabel cast
    casts = row['cast']
    if isinstance(casts, list):
        return [{'_id': row['_id'], 'name': cast.get('name', '')} for cast in casts]
    else:
        return []

def extract_year(year): #untuk slicing tahun saja
    if isinstance(year, str):
        match = re.search(r'\b\d{4}\b', year)
        if match:
            return match.group()
    return 1970

def transform_data(all_films_df):
    films_columns = ['_id', 'name', 'poster_url', 'year', 'runtime', 'ratingValue', 'summary_text', 'ratingCount']
    films_data = all_films_df[films_columns].copy()
    
    films_data['runtime'] = films_data['runtime'].apply(clean_numeric_value)
    films_data['ratingValue'] = films_data['ratingValue'].apply(clean_numeric_value)
    films_data['ratingCount'] = films_data['ratingCount'].apply(clean_numeric_value)
    films_data['year'] = films_data['year'].apply(extract_year)
    
    directors_data = all_films_df.apply(extract_director, axis=1)
    directors_df = pd.DataFrame(directors_data.tolist())
    
    casts_data = all_films_df.apply(extract_casts, axis=1)
    casts_flat_list = [item for sublist in casts_data for item in sublist]
    casts_df = pd.DataFrame(casts_flat_list)
    
    genres_data = all_films_df.apply(lambda x: [{'_id': x['_id'], 'name': genre} for genre in x['genre']], axis=1)
    genres_flat_list = [item for sublist in genres_data for item in sublist]
    genres_df = pd.DataFrame(genres_flat_list)
    
    return films_data, directors_df, casts_df, genres_df

# Proses Load
def load_data_to_mysql(films_data, directors_df, casts_df, genres_df):
    engine = create_engine('mysql+mysqlconnector://root@localhost/db_mdik_tgp_2')
    
    films_data.to_sql('films', con=engine, if_exists='append', index=False)
    directors_df.to_sql('film_directors', con=engine, if_exists='append', index=False)
    casts_df.to_sql('film_casts', con=engine, if_exists='append', index=False)
    genres_df.to_sql('film_genres', con=engine, if_exists='append', index=False)

# Proses Extract
folder_path = 'data/'
num_files_to_extract = 1000
all_films_df = extract_data(folder_path, num_files_to_extract)

# Proses Transform
films_data, directors_df, casts_df, genres_df = transform_data(all_films_df)

# Proses Load
load_data_to_mysql(films_data, directors_df, casts_df, genres_df)
