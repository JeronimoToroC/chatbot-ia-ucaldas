# Arquitectura del Sistema - ChatBot IA Universidad de Caldas

## Versión: 2.0 - Proyecto Completado

---

## 1. Visión General

Sistema de ChatBot basado en arquitectura RAG (Retrieval-Augmented Generation) que responde preguntas sobre Inteligencia Artificial utilizando un corpus curado de 20 documentos confiables. El sistema implementa cuatro workflows principales en N8N Cloud Pro que permiten el procesamiento de documentos, consultas con dos modelos diferentes (GPT-3.5-turbo y Llama 3.1 70B), evaluación automatizada y análisis comparativo.

### Principios de Diseño Implementados

1. **Verificabilidad:** Todas las respuestas incluyen citas bibliográficas en formato [Fuente: nombre_documento.pdf]
2. **Transparencia:** El sistema indica explícitamente cuando no tiene información suficiente
3. **Reproducibilidad:** Workflows exportados en JSON, variables de entorno documentadas, corpus completo disponible
4. **Modularidad:** Cuatro workflows independientes que pueden ejecutarse y modificarse por separado

---

## 2. Stack Tecnológico Implementado

### 2.1 Orquestación y Backend

**N8N Cloud Pro**

- Instancia: semilleroi3.app.n8n.cloud
- 6 workflows implementados (4 principales + 2 integraciones opcionales)
- Webhooks configurados para consultas y evaluación
- Exportación automática a JSON para versionado

### 2.2 Modelos de Lenguaje

**OpenAI GPT-3.5-turbo (Modelo Primario)**

- Configuración:
  - Temperature: 0.3
  - Max tokens: 500
  - Top-p: 1.0
  - Frequency penalty: 0.0
- Uso: Generación de respuestas en Workflow 02
- Resultados: Score global 0.592, Tasa alucinación 1.7%

**Groq Llama 3.1 70B (Modelo Comparativo)**

- Configuración:
  - Model: llama-3.1-70b-versatile
  - Temperature: 0.3
  - Max tokens: 500
- Uso: Generación de respuestas en Workflow 04
- Resultados: Score global 0.642, Tasa alucinación 1.7%

**OpenAI text-embedding-3-small**

- Dimensiones: 1536
- Uso: Vectorización de chunks del corpus y preguntas del usuario
- Aproximadamente 2700 embeddings generados para el corpus completo

### 2.3 Base de Datos Vectorial

**Pinecone Vector Database**

- Índice: chatbot-ia-ucaldas
- Dimensiones: 1536
- Métrica: cosine similarity
- Cloud: AWS us-east-1
- Vectores almacenados: ~2700 chunks
- Metadata incluida: text, doc_id, doc_nombre, doc_index, chunk_index

### 2.4 Frontend

**React + TypeScript**

- Build tool: Vite
- Styling: TailwindCSS + shadcn/ui
- State management: Redux Toolkit
- HTTP client: Axios
- Repositorio separado: chatbot-ia-ucaldas-ui
- Características:
  - Selector de modo breve/extendido
  - Historial de conversación
  - Display de citas bibliográficas
  - Diseño responsive

### 2.5 Almacenamiento y Datos

**Google Drive**

- Almacenamiento de 20 documentos PDF del corpus
- Trigger automático en Workflow 01 para nuevos documentos
- Total: 68.4 MB, ~1273 páginas

---

## 3. Arquitectura de Workflows

### 3.1 Workflow 01: Preparar Corpus

**Archivo:** `n8n_workflows/01_Preparar_Corpus.json`  
**Responsable:** Juan Pablo Valencia  
**Estado:** Completado y funcional

**Flujo completo:**

```
Google Drive Trigger
    ↓ (Detecta nuevos PDFs)
Download File
    ↓ (Descarga PDF completo)
Extract From File
    ↓ (PDF → Texto plano)
Code: Chunking
    ↓ (2400 chars, overlap 400, genera ~135 chunks/documento)
Embeddings OpenAI
    ↓ (text-embedding-3-small, 1536 dimensiones)
Default Data Loader
    ↓ (Prepara formato para Pinecone)
Pinecone Vector Store
    ↓ (Insert con metadata completa)
Success Log
```

**Metadata almacenada por chunk:**

- `text`: Contenido del chunk
- `doc_id`: Identificador del documento (doc_001 a doc_020)
- `doc_nombre`: Nombre del archivo PDF
- `doc_index`: Índice del documento en el corpus
- `chunk_index`: Posición del chunk en el documento
- `embedding`: Vector de 1536 dimensiones

**Resultados:**

- 20 documentos procesados
- ~2700 chunks generados
- 100% de éxito en inserción a Pinecone

---

### 3.2 Workflow 02: Consulta RAG con GPT-3.5

**Archivo:** `n8n_workflows/02_Consulta_RAG.json`  
**Responsable:** Juan Pablo Valencia + Jerónimo Toro  
**Estado:** Completado y funcional

**Flujo completo:**

```
Webhook POST (/consulta-rag)
    ↓ (Recibe: {pregunta, modo})
AI Agent
    ├── Chat Model: OpenAI GPT-3.5-turbo
    ├── Memory: Buffer Window Memory
    └── Tool: Pinecone Vector Store
        ↓ (Recupera top 5 chunks más similares)
Extraer_Fuentes_Y_Formatear (JavaScript)
    ↓ (Extrae fuentes del contexto usado)
Respond to Webhook
    ↓ (Retorna: {respuesta, fuentes})
```

**System Prompt implementado:**
El prompt incluye cuatro estrategias de respuesta según tipo de pregunta:

1. Pregunta específica con contexto → Responde con citas
2. Pregunta general con contexto parcial → Indica qué información tiene
3. Pregunta sin contexto → "No tengo información suficiente"
4. Pregunta fuera de alcance → Explica función especializada

**Modos de respuesta:**

- **Breve:** 50-80 palabras, 2-3 frases máximo
- **Extendido:** Hasta 400 palabras, desarrollo completo con ejemplos

**Reglas de citación:**

- Formato obligatorio: [Fuente: nombre_documento.pdf]
- Prohibición absoluta de inventar información
- No usar conocimiento general si no está en contexto

---

### 3.3 Workflow 03: Evaluación Automatizada

**Archivo:** `n8n_workflows/03_Evaluacion_Automatizada.json`  
**Responsable:** Jerónimo Toro  
**Estado:** Completado y funcional

**Flujo completo:**

```
Webhook POST (/evaluacion)
    ↓
Cargar_Preguntas_Gold (JavaScript)
    ↓ (Lee gold_questions.json - 60 preguntas)
Loop sobre preguntas (1 a 60)
    ├── Consultar_ChatBot (HTTP Request → Workflow 02)
    ├── Evaluar_Respuesta (JavaScript)
    │   ├── Calcular Exactitud (similitud + keywords)
    │   ├── Calcular Cobertura (aspectos + longitud)
    │   ├── Calcular Claridad (estructura + gramática)
    │   ├── Calcular Citas (presencia + formato)
    │   ├── Detectar Alucinación (info sin respaldo)
    │   └── Verificar Seguridad (contenido apropiado)
    └── Calcular Score_r
        ↓ (0.35×E + 0.20×C + 0.15×Cl + 0.20×Ci - 0.10×A - 0.05×S)
Calcular_Resumen_Global (JavaScript)
    ├── Score Global (promedio Score_r)
    ├── Tasa Alucinación (%)
    ├── Porcentaje con Citas (%)
    └── IFA (fórmula completa)
Generar CSV
    ↓
Respond con resultados
```

**Métricas implementadas:**

**Exactitud (peso 0.35):**

- Verificación de palabras clave (60%)
- Verificación de conceptos esperados (40%)
- Método: Similitud semántica + matching de términos

**Cobertura (peso 0.20):**

- Ratio de longitud apropiada (30%)
- Aspectos cubiertos (70%)
- Método: Comparación de extensión y completitud

**Claridad (peso 0.15):**

- Estructura con referencias: +0.15
- Longitud 30-400 palabras: +0.15
- Sin frases confusas: +0.10
- Buena gramática: +0.10

**Citas (peso 0.20):**

- Presencia de fuentes: +0.5
- Formato correcto: +0.3
- Número razonable (1-3): +0.2

**Alucinación (penalización -0.10):**

- Detalles sin citas: -0.5
- Frases generales sin respaldo: -0.3
- Afirmaciones absolutas sin fuente: -0.2

**Seguridad (penalización -0.05):**

- Verificación de palabras inapropiadas
- Lista de términos relacionados con odio, violencia, discriminación

**Salida generada:**

- CSV con 60 filas individuales + resumen global
- Columnas: ID, Categoría, Nivel, Pregunta, Respuesta_Esperada, Respuesta_Obtenida, todas las métricas, Score_R
- Métricas globales al final del CSV

---

### 3.4 Workflow 04: Consulta RAG con Llama 3.1

**Archivo:** `n8n_workflows/04_Consulta_RAG_Llama.json`  
**Responsable:** Jerónimo Toro  
**Estado:** Completado y funcional

**Diferencias con Workflow 02:**

- Reemplaza OpenAI Chat Model por Groq Chat Model
- Model: llama-3.1-70b-versatile
- Mismo system prompt y estrategias de respuesta
- Mismo sistema de recuperación (Pinecone top 5)
- Webhook diferente: /consulta-rag-llama

**Configuración específica de Groq:**

- Temperature: 0.3
- Max tokens: 500
- API: https://api.groq.com/openai/v1

---

### 3.5 Workflows Opcionales (Integraciones)

**Workflow 05: WhatsApp Integration**

- Nodo WhatsApp Business
- Message validation (JavaScript)
- Comandos: /politica, /fuentes, /breve, /extendido, SALIR
- AI Agent conectado a Workflow 02
- Logs anonimizados

**Workflow 06: Telegram Integration**

- Nodo Telegram
- Misma estructura que WhatsApp
- Comandos idénticos
- Integración con Pinecone y OpenAI

---

## 4. Corpus de Conocimientos

### 4.1 Estructura del Corpus

**Total:** 20 documentos PDF  
**Tamaño:** 68.4 MB  
**Páginas:** ~1273  
**Chunks:** ~2700  
**Vectores:** 2700 (1536 dimensiones cada uno)

### 4.2 Distribución por Categorías

**Contexto Institucional (5 documentos):**

- Historia Universidad de Caldas
- Información general programas
- Contribuciones formación
- Currículo integrado
- Autoevaluación Ingeniería

**Fundamentos de IA (3 documentos):**

- Orígenes sistemas inteligentes
- Modelos cognitivos artificiales
- Teoría mente corporizada

**Aplicaciones Prácticas (7 documentos):**

- IA en salud y monitoreo
- Rehabilitación con juegos pervasivos
- Aplicaciones industriales
- Redes de sensores
- Telesalud

**Aspectos Técnicos (4 documentos):**

- Revisión ML/IA (Springer)
- Aplicaciones electrónicas
- Fusión alertas y ontologías
- Habilidades digitales

**Marco Regulatorio (1 documento):**

- Constitución Colombia 2024

### 4.3 Estrategia de Chunking

**Parámetros:**

- Tamaño: 2400 caracteres (~600 tokens)
- Overlap: 400 caracteres (~100 tokens)
- Método: Sin truncamiento de oraciones

**Justificación:**

- 2400 chars: Balance entre contexto y costo
- 400 overlap: Mantiene coherencia entre chunks consecutivos
- Preserva integridad de conceptos que se extienden más allá de límites

---

## 5. Sistema de Evaluación

### 5.1 Conjunto Gold

**Estructura:**

- Total: 60 preguntas
- Distribución: 10 preguntas × 6 categorías
- Niveles: básico, intermedio, avanzado
- Formato JSON con respuestas esperadas y palabras clave

**Categorías:**

1. Conceptos básicos (10)
2. Historia IA (10)
3. ML clásico (10)
4. Deep learning/LLMs (10)
5. Ética y regulación (10)
6. Aplicaciones prácticas (10)

### 5.2 Fórmulas Implementadas

**Score Individual:**

```
Score_r = 0.35×Exactitud + 0.20×Cobertura + 0.15×Claridad + 0.20×Citas - 0.10×Alucinación - 0.05×Seguridad
```

**Métricas Globales:**

```
Score_Global = Σ(Score_r) / 60
Tasa_Alucinación = (preguntas_con_alucinación / 60) × 100
Porcentaje_Citas = (preguntas_con_citas / 60) × 100
IFA = Score_r×0.6 + (1 - Tasa_Alucinación/100)×0.2 + (Porcentaje_Citas/100)×0.2
```

---

## 6. Resultados del Sistema

### 6.1 GPT-3.5-turbo

**Métricas Globales:**

- Score Global: 0.592
- Tasa Alucinación: 1.7%
- Porcentaje con Citas: 63.8%
- IFA: 0.679

**Métricas Promedio:**

- Exactitud: 0.552
- Cobertura: 0.913
- Claridad: 0.901
- Citas: 0.638

**Cumplimiento de Criterios:**

- Score ≥ 0.70: ❌ No cumple (déficit 0.108)
- Alucinación ≤ 10%: ✅ Cumple
- Citas ≥ 85%: ❌ No cumple (déficit 21.2%)
- IFA ≥ 0.75: ❌ No cumple (déficit 0.071)

### 6.2 Llama 3.1 70B

**Métricas Globales:**

- Score Global: 0.642
- Tasa Alucinación: 1.7%
- Porcentaje con Citas: 56.9%
- IFA: 0.695

**Métricas Promedio:**

- Exactitud: 0.629
- Cobertura: 0.893
- Claridad: 0.931
- Citas: 0.569

**Cumplimiento de Criterios:**

- Score ≥ 0.70: ❌ No cumple (déficit 0.058)
- Alucinación ≤ 10%: ✅ Cumple
- Citas ≥ 85%: ❌ No cumple (déficit 28.1%)
- IFA ≥ 0.75: ❌ No cumple (déficit 0.055)

### 6.3 Análisis Comparativo

**Llama 3.1 supera a GPT-3.5 en:**

- Exactitud (+0.077)
- Claridad (+0.030)
- Score Global (+0.050)
- IFA (+0.016)

**GPT-3.5 supera a Llama 3.1 en:**

- Citas (+0.069)
- Cobertura (+0.020)

**Ambos modelos:**

- Mantienen tasa de alucinación idéntica (1.7%)
- Fallan en cumplir criterios de aprobación
- Problema principal: bajo porcentaje de citas

---

## 7. Consideraciones de Rendimiento

### 7.1 Latencia

**Por consulta (promedio):**

- Embedding pregunta: ~200ms
- Búsqueda Pinecone: ~100ms
- Generación LLM: ~2000ms
- Procesamiento: ~200ms
- **Total: ~2.5 segundos**

### 7.2 Costos

**Por consulta:**

- Embedding pregunta: $0.000004
- Búsqueda Pinecone: $0 (free tier)
- Generación GPT-3.5: ~$0.0015
- **Total GPT-3.5: ~$0.002**

**Evaluación completa (60 preguntas):**

- GPT-3.5: ~$0.12
- Llama 3.1 (Groq): ~$0.016

---

## 8. Limitaciones Identificadas

### 8.1 Limitaciones del Sistema

1. **Bajo porcentaje de citas:** Principal causa de no aprobación
2. **Exactitud insuficiente:** Especialmente en conceptos básicos
3. **Recuperación limitada:** Solo top 5 chunks puede ser insuficiente
4. **Fragmentación de definiciones:** Chunking separa conceptos completos
5. **Corpus incompleto:** Falta documentación de referencia clave

### 8.2 Limitaciones de los Modelos

**GPT-3.5-turbo:**

- No sigue consistentemente instrucciones de citación
- Tiende a omitir fuentes en respuestas confiadas

**Llama 3.1 70B:**

- Peor adherencia a formato de citas que GPT
- Mayor confianza resulta en menos atribución

---

## 9. Mejoras Futuras Propuestas

1. **Aumentar chunks recuperados** de 5 a 10-15
2. **Reforzar system prompt** con ejemplos de respuestas ideales
3. **Implementar re-ranking** de chunks recuperados
4. **Optimizar chunking** para mantener definiciones completas
5. **Enriquecer corpus** con documentos más específicos
6. **Experimentar con fine-tuning** del prompt
7. **Implementar validación** de citas post-generación

---

_Documento de arquitectura - Versión final - Sistema completado_
