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

## [19/10/2025] - Jerónimo Toro C

### Herramienta: Claude

### Etapa del Proyecto: Infraestructura - Workflow N8N

### Descripción de la Solicitud:
Diseño y configuración del workflow completo en N8N para procesamiento automático de PDFs: trigger de Google Drive, descarga, extracción de texto, chunking, generación de embeddings y almacenamiento en Pinecone.

### Tiempo de Uso:
2 horas 15 minutos

### Código/Contenido Generado:
- Workflow N8N: 01_Preparar_Corpus.json
- Código JavaScript para chunking inteligente (2400 chars, overlap 400)
- Función de sanitización de nombres de archivos
- Generación automática de doc_id basado en Google Drive ID
- Configuración de nodos: Google Drive Trigger, Download, Extract From File, Code, Embeddings OpenAI, Pinecone Vector Store

### Validaciones Realizadas:
- [x] Testing con PDF de prueba (paolamolina)
- [x] Verificación de chunking correcto (9 chunks generados)
- [x] Validación de embeddings (1536 dimensiones)
- [x] Confirmación de inserción en Pinecone con metadatos completos
- [x] Prueba de trigger automático al subir archivo

### Modificaciones al Output de la IA:
- Ajuste de configuración de Pinecone para usar "Load Specific Data" en lugar de "Load All"
- Corrección de sintaxis en metadatos (remover símbolo "=" inicial)
- Optimización de función sanitizeFileName para manejar caracteres especiales
- Configuración manual de dimensiones en embeddings (1536)

---

## [20/11/2025] - Juan Pablo Valencia C

### Herramienta: Claude

### Etapa del Proyecto: Corpus - Organización Final

### Descripción de la Solicitud:
Renombrado masivo de 20 PDFs del corpus a nomenclatura estandarizada (doc_001 a doc_020), creación de archivos de configuración (.env.example, llm_config.json), y preparación para carga masiva a Google Drive.

### Tiempo de Uso:
45 minutos

### Código/Contenido Generado:
- Script PowerShell: rename_pdfs.ps1 con mapeo completo de nombres
- Archivo .env.example con todas las variables de entorno
- Archivo config/llm_config.json con parámetros del proyecto
- Nomenclatura estandarizada aplicada a 20 documentos

### Validaciones Realizadas:
- [x] Verificación de 20 archivos renombrados correctamente
- [x] Validación de formato JSON en llm_config.json
- [x] Confirmación de variables de entorno en .env.example
- [x] Testing de integridad de archivos post-renombrado

### Modificaciones al Output de la IA:
- Renombrado manual de 4 archivos que fallaron en el script automático
- Ajuste de caracteres especiales en nombres (espacios, acentos)
- Verificación manual de correspondencia con JUSTIFICACION_CORPUS.md

---
