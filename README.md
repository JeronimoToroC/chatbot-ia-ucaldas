# ChatBot IA - Universidad de Caldas

Sistema de Consulta sobre Inteligencia Artificial con Arquitectura RAG

---

## Información del Proyecto

**Institución:** Universidad de Caldas  
**Programa:** Ingeniería de Sistemas y Computación  
**Asignatura:** Sistemas Inteligentes I  
**Profesor:** Luis Fernando Castillo Ossa  
**Fecha de Entrega:** 28 de octubre de 2025

**Equipo de Desarrollo:**

- Jerónimo Toro C (Código: 20712) - Infraestructura, MLOps y Evaluación
- Juan Pablo Valencia C (Código: 29169) - Contexto, Aplicación y RAG

**Repositorios:** 

- https://github.com/JeronimoToroC/chatbot-ia-ucaldas
- https://github.com/JPValencia22/chatbot-ia-ucaldas-ui (Frontend)

---

## Descripción

ChatBot confiable sobre Inteligencia Artificial que implementa arquitectura RAG (Retrieval-Augmented Generation) para responder preguntas con citas verificables, evitando alucinaciones. El sistema está diseñado para proporcionar información precisa sobre conceptos, historia, aplicaciones, marcos regulatorios y ética en IA, basándose en un corpus curado de 20 documentos confiables.

### Características Principales

- Respuestas fundamentadas en corpus de documentos verificados
- Citas bibliográficas automáticas en todas las respuestas
- Dos modos de respuesta: breve (50-80 palabras) y extendido (hasta 400 palabras)
- Evaluación automatizada con conjunto gold de 60 preguntas
- Comparación de desempeño entre GPT-3.5-turbo y Llama 3.1 70B
- Integraciones opcionales con WhatsApp y Telegram
- Interfaz web moderna desarrollada en React + TypeScript

---

## Arquitectura del Sistema

El sistema está compuesto por cuatro workflows principales implementados en N8N Cloud Pro:

**Workflow 01 - Procesamiento de Documentos:**
Carga PDFs desde Google Drive, realiza chunking (2400 caracteres, overlap 400), genera embeddings con text-embedding-3-small y almacena en Pinecone Vector Database.

**Workflow 02 - Consulta RAG con GPT-3.5:**
Recibe preguntas vía webhook, genera embedding de la pregunta, recupera contexto relevante de Pinecone (top 5 chunks), construye prompt con instrucciones de citación y genera respuesta usando gpt-3.5-turbo.

**Workflow 03 - Evaluación Automatizada:**
Procesa 60 preguntas del conjunto gold, envía cada pregunta al Workflow 02, calcula seis métricas (exactitud, cobertura, claridad, citas, alucinación, seguridad), aplica la fórmula de Score_r y genera métricas globales con reporte en CSV.

**Workflow 04 - Consulta RAG con Llama 3.1:**
Implementación idéntica al Workflow 02 pero utilizando llama-3.1-70b-versatile a través de Groq API para comparación de modelos.

---

## Stack Tecnológico

**Orquestación y Backend:**

- N8N Cloud Pro (semilleroi3.app.n8n.cloud)
- Google Drive para almacenamiento de documentos

**Modelos de Lenguaje:**

- OpenAI gpt-3.5-turbo (generación de texto)
- OpenAI text-embedding-3-small (embeddings, 1536 dimensiones)
- Groq llama-3.1-70b-versatile (modelo alternativo de comparación)

**Base de Datos Vectorial:**

- Pinecone Vector Database
  - Índice: chatbot-ia-ucaldas
  - Métrica: cosine similarity
  - ~2700 vectores almacenados

**Frontend:**

- React 18 + TypeScript
- Vite (build tool)
- TailwindCSS (styling)
- Redux Toolkit (state management)
- Axios (HTTP client)

**Integraciones:**

- WhatsApp Cloud API
- Telegram Bot API

---

## Estructura del Proyecto

```
chatbot-ia-ucaldas/
├── README.md
├── .gitignore
├── .env.example
│
├── config/
│   └── llm_config.json              # Configuración de modelos y parámetros
│
├── data/
│   ├── gold_questions.json          # 60 preguntas de evaluación
│   └── corpus/                      # 20 documentos PDF curados
│       ├── doc_001_Historia_Institucional_UCaldas.pdf
│       ├── doc_002_Universidad_Caldas_General.pdf
│       ├── ...
│       ├── doc_020_Telesalud_UCaldas.pdf
│       ├── drive_id_mapping.json
│       ├── JUSTIFICACION_CORPUS.md
│       └── pdf_metadata_extracted.json
│
├── docs/
│   ├── ARQUITECTURA.md              # Diseño técnico del sistema
│   ├── CHANGELOG_IA.md              # Registro de uso de herramientas IA
│   ├── POLITICAS_TRANSPARENCIA.md   # Políticas de privacidad y uso
│   └── reporte_tecnico.md           # Reporte técnico completo del proyecto
│
├── n8n_workflows/
│   ├── 01_Preparar_Corpus.json
│   ├── 02_Consulta_RAG.json
│   ├── 03_Evaluacion_Automatizada.json
│   ├── 04_Consulta_RAG_Llama.json
│   ├── 05_WhatsApp_Integration.json
│   └── 06_Telegram_Integration.json
│
├── results/
│   ├── evaluacion_chatbot_gpt_2025-12-03.csv
│   ├── evaluacion_chatbot_llama_2025-12-03.csv
│   └── metrics_report.csv
│
├── scripts/
│   ├── evaluate.py                  # Script de evaluación
│   ├── extract_pdf_metadata.py      # Extracción de metadatos de PDFs
│   ├── map_drive_ids.py             # Mapeo de IDs de Google Drive
│   └── rename_pdfs.ps1              # Renombrado masivo de PDFs
│
├── logs/                            # Logs anonimizados del sistema
└── demo/                            # Videos demostrativos
```

---

## Requisitos Previos

- Cuenta N8N Cloud Pro
- API Key de OpenAI
- Cuenta Pinecone (free tier suficiente)
- API Key de Groq (para evaluación con Llama)
- Cuenta Google Cloud (para Google Drive API)
- Node.js 18+ y npm (para frontend)
- Git

---

## Instalación y Configuración

### 1. Clonar el Repositorio

```bash
git clone https://github.com/JeronimoToroC/chatbot-ia-ucaldas.git
cd chatbot-ia-ucaldas
```

### 2. Configurar Variables de Entorno

```bash
cp .env.example .env
```

Editar `.env` con tus credenciales:

```env
# OpenAI
OPENAI_API_KEY=sk-...

# Pinecone
PINECONE_API_KEY=...
PINECONE_ENVIRONMENT=us-east-1
PINECONE_INDEX_NAME=chatbot-ia-ucaldas

# Groq (para Llama)
GROQ_API_KEY=...

# N8N
N8N_WEBHOOK_URL=https://semilleroi3.app.n8n.cloud/webhook/...

# Google Drive
GOOGLE_DRIVE_FOLDER_ID=...

# WhatsApp/Telegram (opcional)
WHATSAPP_TOKEN=...
TELEGRAM_BOT_TOKEN=...
```

### 3. Importar Workflows en N8N

1. Acceder a tu instancia de N8N Cloud Pro
2. Ir a **Workflows** → **Import from File**
3. Importar cada archivo JSON de la carpeta `n8n_workflows/`:

   - `01_Preparar_Corpus.json`
   - `02_Consulta_RAG.json`
   - `03_Evaluacion_Automatizada.json`
   - `04_Consulta_RAG_Llama.json`
   - (Opcional) `05_WhatsApp_Integration.json`
   - (Opcional) `06_Telegram_Integration.json`

4. Configurar credenciales en cada workflow:
   - OpenAI API Key
   - Pinecone API Key
   - Groq API Key
   - Google Drive OAuth

### 4. Preparar el Corpus

1. Subir los 20 PDFs de `data/corpus/` a una carpeta de Google Drive
2. Copiar el ID de la carpeta y configurarlo en el Workflow 01
3. Ejecutar **Workflow 01: Preparar Corpus**
4. Verificar en Pinecone que se hayan creado ~2700 vectores

### 5. Configurar Frontend

El frontend está en un repositorio separado. Para instalarlo:

```bash
# Clonar repositorio del frontend
git clone https://github.com/JeronimoToroC/chatbot-ia-ucaldas-ui.git
cd chatbot-ia-ucaldas-ui

# Instalar dependencias
npm install

# Configurar variables de entorno
cp .env.example .env
# Editar .env con la URL del webhook de N8N

# Ejecutar en desarrollo
npm run dev

# Build para producción
npm run build
```

El frontend se conectará automáticamente al Workflow 02 mediante la URL del webhook configurada.

---

## Uso del Sistema

### Consulta Web

1. Acceder a la interfaz web del frontend
2. Seleccionar modo de respuesta (Breve o Extendido)
3. Escribir pregunta sobre Inteligencia Artificial
4. El sistema devolverá respuesta con citas bibliográficas

**Ejemplo de consulta:**

```
Pregunta: ¿Qué es la Inteligencia Artificial?

Respuesta (Modo Breve):
La Inteligencia Artificial es un campo de la informática que desarrolla
sistemas capaces de realizar tareas que normalmente requieren inteligencia
humana, como aprendizaje, razonamiento y resolución de problemas.

[Fuente: doc_017_Origenes_Sistemas_Inteligentes.pdf]
```

### Evaluación del Sistema

Para ejecutar la evaluación completa con el conjunto gold de 60 preguntas:

1. Abrir N8N y navegar al **Workflow 03: Evaluación Automatizada**
2. Hacer clic en **Execute Workflow**
3. Esperar a que procese las 60 preguntas (~3-5 minutos)
4. Descargar archivo CSV con resultados desde el output del workflow
5. Revisar métricas globales:
   - Score Global
   - Tasa de Alucinación
   - Porcentaje con Citas
   - IFA (Índice Final de Adecuación)

### Integraciones WhatsApp/Telegram (Opcional)

**Comandos disponibles:**

- `/politica` - Muestra política de uso y privacidad
- `/fuentes` - Lista las fuentes del corpus
- `/breve` - Cambia a modo de respuesta breve
- `/extendido` - Cambia a modo de respuesta extendido
- `SALIR` - Opt-out del servicio

---

## Corpus de Conocimientos

El sistema se basa en 20 documentos PDF cuidadosamente seleccionados (68.4 MB, ~2700 chunks):

**Contexto Institucional (5 documentos):**

- Historia institucional Universidad de Caldas
- Información general de programas
- Contribuciones a la formación
- Currículo integrado
- Autoevaluación de Ingeniería

**Fundamentos de IA (3 documentos):**

- Orígenes de los sistemas inteligentes
- Modelos cognitivos artificiales
- Teoría de la mente corporizada

**Aplicaciones Prácticas (7 documentos):**

- IA en salud y monitoreo
- IA en rehabilitación
- IA en aplicaciones industriales
- Redes de sensores
- Telesalud

**Aspectos Técnicos (4 documentos):**

- Revisión de ML y IA (Springer)
- Aplicaciones electrónicas
- Fusión de alertas y ontologías
- Habilidades digitales

**Marco Regulatorio (1 documento):**

- Constitución de Colombia 2024

Ver justificación detallada en `data/corpus/JUSTIFICACION_CORPUS.md`

---

## Protocolo de Evaluación

### Conjunto Gold

60 preguntas distribuidas en 6 categorías:

- Conceptos básicos (10 preguntas)
- Historia de la IA (10 preguntas)
- Machine Learning clásico (10 preguntas)
- Deep Learning y LLMs (10 preguntas)
- Ética y regulación (10 preguntas)
- Aplicaciones prácticas (10 preguntas)

### Métricas

Cada respuesta se evalúa con seis métricas:

**Exactitud (peso 0.35):** Similitud semántica con respuesta esperada, presencia de palabras clave y conceptos fundamentales.

**Cobertura (peso 0.20):** Completitud de aspectos tratados y extensión apropiada.

**Claridad (peso 0.15):** Estructura gramatical, coherencia y formato.

**Citas (peso 0.20):** Presencia y formato correcto de referencias bibliográficas.

**Alucinación (penalización -0.10):** Detección de información inventada o sin respaldo.

**Seguridad (penalización -0.05):** Ausencia de contenido inapropiado.

**Fórmula de Score:**

```
Score_r = 0.35×Exactitud + 0.20×Cobertura + 0.15×Claridad + 0.20×Citas - 0.10×Alucinación - 0.05×Seguridad
```

**Índice Final de Adecuación (IFA):**

```
IFA = Score_r×0.6 + (1-Tasa_Alucinación/100)×0.2 + (Porcentaje_Citas/100)×0.2
```

### Criterios de Aprobación

- Score Global ≥ 0.70
- Tasa de Alucinación ≤ 10%
- Porcentaje con Citas ≥ 85%
- IFA ≥ 0.75

---

## Resultados Obtenidos

### GPT-3.5-turbo

- **Score Global:** 0.592
- **Tasa de Alucinación:** 1.7%
- **Porcentaje con Citas:** 63.8%
- **IFA:** 0.679
- **Estado:** No cumple criterios de aprobación

### Llama 3.1 70B (via Groq)

- **Score Global:** 0.642
- **Tasa de Alucinación:** 1.7%
- **Porcentaje con Citas:** 56.9%
- **IFA:** 0.695
- **Estado:** No cumple criterios de aprobación

### Análisis Comparativo

Llama 3.1 superó a GPT-3.5-turbo en exactitud (+0.077) y claridad (+0.030), pero obtuvo menor porcentaje de citas (-6.9%). Ambos modelos mantuvieron tasas de alucinación excepcionalmente bajas (1.7%). Ninguno cumplió con los criterios de aprobación, principalmente debido a bajo porcentaje de citas y exactitud insuficiente.

Ver análisis detallado en `docs/reporte_tecnico.md` y resultados completos en `results/`.

---

## Documentación

- **[README.md](README.md)** - Este archivo
- **[ARQUITECTURA.md](docs/ARQUITECTURA.md)** - Diseño técnico del sistema
- **[CHANGELOG_IA.md](docs/CHANGELOG_IA.md)** - Registro detallado de uso de herramientas IA
- **[POLITICAS_TRANSPARENCIA.md](docs/POLITICAS_TRANSPARENCIA.md)** - Políticas de privacidad y uso de datos
- **[ROLES_Y_RESPONSABILIDADES.md](ROLES_Y_RESPONSABILIDADES.md)** - División de trabajo del equipo
- **[reporte_tecnico.md](docs/reporte_tecnico.md)** - Reporte técnico completo del proyecto
- **[JUSTIFICACION_CORPUS.md](data/corpus/JUSTIFICACION_CORPUS.md)** - Justificación de selección de documentos

---

## Uso de Herramientas de IA

En cumplimiento con los requisitos de transparencia del proyecto, se utilizaron las siguientes herramientas de IA:

**Claude (Anthropic):**

- Diseño de workflows en N8N
- Debugging de código JavaScript
- Análisis de resultados de evaluación

**ChatGPT (OpenAI):**

- Diseño del system prompt
- Generación del conjunto gold de preguntas
- Documentación técnica

**GitHub Copilot (Microsoft):**

- Escritura de código JavaScript para métricas

**Proceso de Validación:**

- Revisión manual de todo el código generado
- Pruebas funcionales end-to-end
- Verificación de resultados contra especificaciones

Ver detalles completos en `docs/CHANGELOG_IA.md` y en el anexo del reporte técnico.

---

## Limitaciones Conocidas

- El sistema no cumple con todos los criterios de aprobación establecidos
- Porcentaje de citas bibliográficas por debajo del umbral requerido (85%)
- Exactitud insuficiente en algunas categorías, especialmente conceptos básicos
- El corpus no incluye algunos documentos de referencia mencionados en especificaciones originales (UNESCO AI Ethics, AI Act completo)
- Desempeño irregular en preguntas sobre definiciones fundamentales

---

## Trabajo Futuro

**Mejoras prioritarias identificadas:**

- Aumentar número de chunks recuperados de Pinecone (de 5 a 10-15)
- Reforzar system prompt para forzar inclusión consistente de citas
- Optimizar chunking para mantener definiciones completas
- Enriquecer corpus con documentos más específicos sobre conceptos básicos
- Implementar re-ranking de chunks recuperados
- Explorar fine-tuning del prompt con ejemplos de respuestas ideales

---

## Licencia

Proyecto académico desarrollado para la asignatura Sistemas Inteligentes I, Universidad de Caldas, 2025.

---

## Contacto

**Repositorio:** https://github.com/JeronimoToroC/chatbot-ia-ucaldas  
**Estudiantes:**

- Jerónimo Toro C (Código: 20712)
- Juan Pablo Valencia C (Código: 29169)

**Profesor:** Luis Fernando Castillo Ossa  
**Asignatura:** Sistemas Inteligentes I  
**Universidad de Caldas**

---
