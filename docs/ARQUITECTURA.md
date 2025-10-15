# Arquitectura del Sistema - ChatBot IA Universidad de Caldas

## Versión: 1.0
## Fecha: 15 de octubre de 2025

---

## 1. Visión General

Sistema de ChatBot basado en arquitectura RAG (Retrieval-Augmented Generation) que responde preguntas sobre Inteligencia Artificial utilizando un corpus curado de documentos confiables.

### Principios de Diseño

1. **Verificabilidad:** Todas las respuestas deben incluir citas a fuentes
2. **Transparencia:** Indicar claramente cuando no hay información suficiente
3. **Reproducibilidad:** Sistema completamente replicable por terceros
4. **Modularidad:** Workflows independientes e intercambiables

---

## 2. Stack Tecnológico

### 2.1 Decisiones Técnicas Fundamentales

#### Orquestador: N8N Pro

**Justificación:**
- Integración nativa con OpenAI y Pinecone (nodos pre-construidos)
- Workflows visuales que facilitan debugging y documentación
- Capacidad de exportar/importar workflows en JSON
- No requiere infraestructura adicional (cloud-hosted)
- Ideal para prototipado académico con timeframe limitado

**Alternativas consideradas y descartadas:**
- LangChain (Python): Mayor complejidad de setup, requiere infraestructura local
- Haystack: Curva de aprendizaje más alta
- Custom Python: Tiempo de desarrollo excesivo (4+ semanas)

#### LLM: OpenAI GPT-3.5-turbo

**Justificación:**
- Balance óptimo entre calidad, velocidad y costo
- API estable y bien documentada
- Soporte nativo en N8N
- Costo estimado: \.002 por consulta con contexto RAG

**Parámetros de configuración:**
- Temperature: 0.3 (respuestas consistentes, poca creatividad)
- Max tokens: 500 (respuestas concisas)
- Top-p: 1.0
- Frequency penalty: 0.0

#### Embeddings: text-embedding-3-small

**Justificación:**
- Dimensionalidad: 1536 (balance entre precisión y costo)
- Costo: \.00002 por 1K tokens (10x más barato que ada-002)
- Rendimiento superior en benchmarks de similitud semántica
- Compatible con free tier de Pinecone

#### Vector Store: Pinecone

**Justificación:**
- Free tier: 1 index, 100K vectores (suficiente para ~2700 chunks)
- Latencia: <100ms en percentil 95
- Integración directa con N8N (nodo nativo)
- Métrica cosine optimizada para embeddings de OpenAI

**Configuración del índice:**
- Nombre: chatbot-ia-ucaldas
- Dimensiones: 1536
- Métrica: cosine
- Cloud: AWS us-east-1
- Pods: 1 (free tier)

---

## 3. Arquitectura de Workflows

### 3.1 Workflow 1: Preparar Corpus

**Responsable:** Juan Pablo Valencia  
**Archivo:** \
8n_workflows/01_Preparar_Corpus.json\

**Función:** Procesar documentos PDF y almacenarlos como vectores en Pinecone.

**Flujo de datos:**

\\\
Google Drive: Get Files (20 PDFs)
    ↓
Extract From File (PDF → Text)
    ↓
Code: Estructurar Documentos (doc_id, doc_nombre, doc_index)
    ↓
Code: Chunking (2400 chars, overlap 400)
    ↓
Embeddings: OpenAI text-embedding-3-small
    ↓
Merge: Combinar chunk data + embeddings
    ↓
Pinecone Vector Store: Insert
    ↓
Log: Registro de chunks insertados
\\\

**Decisiones de chunking:**
- Tamaño: 2400 caracteres (aprox. 600 tokens, costo óptimo)
- Overlap: 400 caracteres (mantiene contexto entre chunks)
- Sin truncamiento de oraciones (preserva coherencia)

---

### 3.2 Workflow 2: Consulta RAG

**Responsable:** Juan Pablo Valencia + Jerónimo Toro  
**Archivo:** \
8n_workflows/02_Consulta_RAG.json\

**Función:** Recibir pregunta, buscar contexto relevante, generar respuesta con citas.

**Flujo de datos:**

\\\
Webhook/Manual Trigger: Pregunta del usuario
    ↓
Embeddings: OpenAI (pregunta → vector 1536D)
    ↓
Pinecone Vector Store: Search (top-5, cosine)
    ↓
Code: Construir prompt con contexto + instrucciones de citación
    ↓
OpenAI Chat: GPT-3.5-turbo
    ↓
Code: Formatear respuesta con citas [Fuente: doc_nombre]
    ↓
Return: Respuesta al usuario
\\\

**Template de prompt:**
(Por definir en implementación - Semana 2-3)

---

### 3.3 Workflow 3: Evaluación Gold

**Responsable:** Jerónimo Toro  
**Archivo:** \
8n_workflows/03_Evaluacion_Gold.json\

**Función:** Evaluar chatbot con 60 preguntas y calcular métricas automáticamente.

**Flujo de datos:**

\\\
Manual Trigger
    ↓
Read File: gold_questions.json (60 preguntas)
    ↓
Split In Batches (10 preguntas/batch)
    ↓
    Loop:
        Execute Workflow: 02_Consulta_RAG
        ↓
        Code: Calcular métricas por respuesta
        (Exactitud, Cobertura, Claridad, Citas, Alucinación, Seguridad)
        ↓
    End Loop
    ↓
Aggregate: Calcular Score Global, Tasa Alucinación, Tasa Citas, IFA
    ↓
Write File: results/evaluacion_gold_60preguntas.csv
\\\

**Métricas implementadas:**
(Por definir algoritmos específicos - Semana 3-4)

---

## 4. Modelo de Datos

### 4.1 Estructura de Chunks en Pinecone

\\\json
{
  "id": "doc001_chunk_042",
  "values": [0.123, -0.456, ...],  // 1536 dimensiones
  "metadata": {
    "text": "Contenido del chunk...",
    "doc_id": "doc_001",
    "doc_nombre": "UNESCO_AI_Ethics_2023.pdf",
    "doc_index": 1,
    "chunk_index": 42,
    "chunk_size": 2387
  }
}
\\\

### 4.2 Estructura de Pregunta Gold

\\\json
{
  "id": 1,
  "categoria": "conceptos_basicos",
  "pregunta": "¿Qué es la Inteligencia Artificial?",
  "respuesta_esperada": "Sistema capaz de realizar tareas que requieren inteligencia humana...",
  "fuentes_relevantes": ["doc_001", "doc_005", "doc_012"],
  "criterios_evaluacion": {
    "keywords_minimos": ["sistema", "inteligencia", "humana"],
    "debe_citar": true
  }
}
\\\

---

## 5. Consideraciones de Rendimiento

### 5.1 Costos Estimados

**Por consulta:**
- Embedding de pregunta: \.000004
- Búsqueda Pinecone: \ (free tier)
- Generación GPT-3.5-turbo (500 tokens): \.0015
- **Total por consulta: ~\.002**

**Evaluación completa (60 preguntas):**
- Costo estimado: \.12

### 5.2 Latencia

**Objetivo:** <3 segundos por consulta

**Desglose:**
- Embedding: ~200ms
- Búsqueda Pinecone: ~100ms
- Generación LLM: ~2000ms
- Procesamiento: ~200ms
- **Total esperado: ~2.5s**

---

## 6. Roadmap de Implementación

**Semana 1 (15-21 Oct):** Infraestructura + Curación corpus  
**Semana 2 (22-28 Oct):** Workflow Preparar Corpus  
**Semana 3 (29 Oct-4 Nov):** Workflow Consulta RAG  
**Semana 4 (5-11 Nov):** Workflow Evaluación Gold  
**Semana 5 (12-18 Nov):** Refinamiento + Documentación  
**Semana 6 (19-22 Nov):** Entregables finales

---

_Documento vivo - se actualiza con implementación_
