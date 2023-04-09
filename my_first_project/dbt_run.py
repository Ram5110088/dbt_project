from dotenv import load_dotenv
import os


# Convert dbport to an integer
dbport = int(os.getenv('dbport'))