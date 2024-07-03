import fitz  # PyMuPDF
import re
from flask import jsonify
import json

def extract_note_from_pdf(file_path):
    # Ouvrir le fichier PDF
    document = fitz.open(file_path)
    
    # Extraire tout le texte du PDF
    text_content = ""
    for page_num in range(document.page_count):
        page = document.load_page(page_num)
        text_content += page.get_text()
    
    # Utiliser regex pour trouver la note
    match = re.search(r'\b(\d{1,3}|1000)/1000\b', text_content)
    if match:
        note = int(match.group(1))
        return str(note)+'/'+'1000'
    else:
        return json.dumps({'error': 'Note not found in the document'})

# Exemple d'utilisation
file_path = 'test.pdf'
result = extract_note_from_pdf(file_path)
print(result)
