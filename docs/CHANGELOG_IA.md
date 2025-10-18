## [18/10/2025] - Jerónimo Toro C

### Herramienta: ChatGPT-4

### Etapa del Proyecto: Corpus

### Descripción de la Solicitud:
Desarrollo de script Python para extracción automática de metadatos reales de archivos PDF (páginas, tamaño, autor, fechas, etc.) usando librería PyPDF2.

### Tiempo de Uso:
35 minutos

### Código/Contenido Generado:
- Script Python: extract_pdf_metadata.py
- Manejo de excepciones para PDFs con metadatos complejos
- Archivo JSON con metadatos extraídos: pdf_metadata_extracted.json
- Validación de 20 documentos (1,273 páginas totales, 65.57 MB)

### Validaciones Realizadas:
- [x] Testing del script con todos los PDFs del corpus
- [x] Verificación de datos extraídos vs archivos originales
- [x] Validación de formato JSON generado
- [x] Code review por el compañero

### Modificaciones al Output de la IA:
- Corrección de función safe_get() para manejar objetos IndirectObject de PyPDF2
- Ajuste de manejo de excepciones para documentos con metadatos encriptados
- Conversión forzada a string de todos los valores de metadatos

---