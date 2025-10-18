import os
import json
from PyPDF2 import PdfReader
from pathlib import Path

def extract_pdf_metadata(pdf_path):
    """Extrae metadatos de un archivo PDF"""
    try:
        reader = PdfReader(pdf_path)
        metadata = reader.metadata
        
        # Obtener información básica
        num_pages = len(reader.pages)
        file_size_mb = os.path.getsize(pdf_path) / (1024 * 1024)
        
        # Función auxiliar para convertir metadatos a string
        def safe_get(meta_dict, key, default='N/A'):
            if not meta_dict:
                return default
            value = meta_dict.get(key, default)
            # Convertir a string si es un objeto complejo
            return str(value) if value else default
        
        return {
            "archivo": os.path.basename(pdf_path),
            "num_paginas": num_pages,
            "tamano_mb": round(file_size_mb, 2),
            "titulo": safe_get(metadata, '/Title'),
            "autor": safe_get(metadata, '/Author'),
            "creador": safe_get(metadata, '/Creator'),
            "productor": safe_get(metadata, '/Producer'),
            "fecha_creacion": safe_get(metadata, '/CreationDate'),
            "fecha_modificacion": safe_get(metadata, '/ModDate')
        }
    except Exception as e:
        return {
            "archivo": os.path.basename(pdf_path),
            "error": str(e)
        }

def main():
    corpus_dir = Path("data/corpus")
    
    # Obtener todos los PDFs
    pdf_files = sorted(corpus_dir.glob("doc_*.pdf"))
    
    print(f"Encontrados {len(pdf_files)} archivos PDF")
    print("Extrayendo metadatos...\n")
    
    metadatos = []
    
    for pdf_file in pdf_files:
        print(f"Procesando: {pdf_file.name}")
        metadata = extract_pdf_metadata(pdf_file)
        metadatos.append(metadata)
    
    # Guardar en JSON
    output_file = "data/corpus/pdf_metadata_extracted.json"
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(metadatos, f, indent=2, ensure_ascii=False)
    
    print(f"\n✓ Metadatos guardados en: {output_file}")
    
    # Mostrar resumen
    total_pages = sum(m.get('num_paginas', 0) for m in metadatos if 'num_paginas' in m)
    total_size = sum(m.get('tamano_mb', 0) for m in metadatos if 'tamano_mb' in m)
    
    print(f"\nResumen:")
    print(f"- Total documentos: {len(metadatos)}")
    print(f"- Total páginas: {total_pages}")
    print(f"- Tamaño total: {round(total_size, 2)} MB")

if __name__ == "__main__":
    main()