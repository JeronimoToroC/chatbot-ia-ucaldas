# Asignación de Roles y Responsabilidades

## Proyecto ChatBot IA - Universidad de Caldas

---

## Integrantes del Equipo

- **Jerónimo Toro C** - Código: 20712
- **Juan Pablo Valencia C** - Código: 29169

**Profesor:** Luis Fernando Castillo Ossa  
**Asignatura:** Sistemas Inteligentes I

**Duración del proyecto:** Aproximadamente 6 semanas de desarrollo intensivo

---

## Distribución de Roles

### Rol 1: Infraestructura, MLOps y Evaluación

**Responsable:** Jerónimo Toro C

**Áreas de responsabilidad:**

**Infraestructura y Configuración:**
- Administración de cuenta N8N Cloud Pro y credenciales del sistema
- Gestión de API Keys de OpenAI, Pinecone y Groq
- Versionado de workflows y configuraciones en Git
- Aseguramiento de reproducibilidad del entorno

**Sistema de Evaluación:**
- Diseño del conjunto gold de 60 preguntas balanceadas en 6 categorías temáticas
- Implementación del workflow de evaluación automatizada (Workflow 03)
- Desarrollo del sistema de métricas con las seis dimensiones de calidad
- Implementación de la fórmula de Score_r y cálculo del IFA
- Generación de reportes CSV con resultados individuales y globales

**Configuración de Modelos:**
- Configuración de GPT-3.5-turbo como modelo primario
- Configuración de Llama 3.1 70B via Groq para comparaciones
- Gestión de parámetros de inferencia (temperature, max_tokens)
- Documentación de costos y consumo de tokens

**Logging y Monitoreo:**
- Implementación de sistema de logs anonimizados
- Registro de métricas de uso: latencia, tokens, costos
- Exportación de resultados a formatos CSV/JSON

**Entregables principales:**
- Workflow 03: Evaluación Automatizada
- Workflow 04: Consulta RAG con Llama
- Conjunto gold de preguntas (gold_questions.json)
- Cuadernos de métricas (CSVs de resultados)
- Configuración de modelos (llm_config.json)
- Variables de entorno (.env.example)
- Análisis comparativo entre modelos

---

### Rol 2: Contexto, Aplicación y RAG

**Responsable:** Juan Pablo Valencia C

**Áreas de responsabilidad:**

**Curación del Corpus:**
- Selección y justificación de 20 documentos PDF confiables
- Investigación de fuentes institucionales y académicas de calidad
- Documentación de metadatos y relevancia de cada documento
- Extracción de metadata técnica de PDFs

**Pipeline RAG:**
- Implementación del workflow de procesamiento de documentos (Workflow 01)
- Desarrollo de estrategia de chunking (2400 caracteres, overlap 400)
- Configuración de generación de embeddings con text-embedding-3-small
- Configuración y gestión de Pinecone Vector Store
- Optimización de búsqueda y ranking de chunks relevantes

**Sistema de Consulta:**
- Implementación del workflow de consulta RAG (Workflow 02)
- Diseño del flujo completo: embedding → búsqueda → generación → formateo
- Desarrollo del system prompt con estrategias de respuesta
- Implementación de modos breve y extendido
- Sistema de formateo de citas bibliográficas

**Integraciones Opcionales:**
- Configuración de integración con WhatsApp Business API
- Configuración de integración con Telegram Bot API
- Implementación de comandos básicos y políticas de opt-in/opt-out
- Sistema de logs anonimizados sin información personal

**Frontend:**
- Coordinación del desarrollo del frontend en React + TypeScript
- Diseño de experiencia de usuario e interfaz conversacional
- Integración con webhooks de N8N

**Entregables principales:**
- Workflow 01: Preparar Corpus
- Workflow 02: Consulta RAG (GPT)
- Workflow 05: WhatsApp Integration (opcional)
- Workflow 06: Telegram Integration (opcional)
- Corpus curado completo (20 PDFs + justificación)
- Frontend web completo
- Documentación de políticas de transparencia

---

## Competencias Técnicas del Equipo

**Jerónimo Toro C:**
- Python intermedio-avanzado
- Experiencia con APIs REST y autenticación
- Conocimiento de N8N Cloud Pro
- Procesamiento y análisis de datos
- Git y control de versiones
- Diseño de métricas y evaluación de sistemas
- Prompting y configuración de LLMs

**Juan Pablo Valencia C:**
- Python intermedio
- Investigación documental y curación de contenidos
- N8N Cloud Pro
- WhatsApp Business API y Telegram Bot API
- React + TypeScript para frontend
- Conceptos de embeddings y similitud vectorial
- Diseño de interacciones conversacionales

---

## Workflows Implementados

### Workflow 01: Preparar Corpus
**Responsable:** Juan Pablo Valencia  
**Función:** Procesar PDFs, generar chunks, crear embeddings y almacenar en Pinecone

### Workflow 02: Consulta RAG (GPT-3.5)
**Responsable:** Juan Pablo Valencia + Jerónimo Toro  
**Función:** Recibir pregunta, buscar contexto, generar respuesta con GPT-3.5-turbo

### Workflow 03: Evaluación Automatizada
**Responsable:** Jerónimo Toro  
**Función:** Evaluar sistema con 60 preguntas gold y calcular métricas

### Workflow 04: Consulta RAG (Llama 3.1)
**Responsable:** Jerónimo Toro  
**Función:** Variante del Workflow 02 usando Llama 3.1 70B via Groq

### Workflow 05: WhatsApp Integration (Opcional)
**Responsable:** Juan Pablo Valencia  
**Función:** Integración con WhatsApp Business API

### Workflow 06: Telegram Integration (Opcional)
**Responsable:** Juan Pablo Valencia  
**Función:** Integración con Telegram Bot API

---

## Protocolo de Uso de Herramientas IA

### Herramientas Utilizadas

**Claude (Anthropic):**
- Diseño de workflows en N8N
- Debugging de código JavaScript
- Análisis de resultados de evaluación

**ChatGPT (OpenAI):**
- Diseño del system prompt
- Generación del conjunto gold de preguntas
- Documentación técnica

**GitHub Copilot:**
- Escritura de código JavaScript para métricas
- Autocompletado de funciones en workflows

### Proceso de Validación

Todo código y contenido generado por herramientas IA fue:
- Revisado manualmente por el equipo
- Probado funcionalmente end-to-end
- Ajustado según necesidades específicas del proyecto
- Documentado en CHANGELOG_IA.md

Ver documentación detallada del uso de IA en `docs/CHANGELOG_IA.md` y en el anexo del reporte técnico.

---

## Actividades Conjuntas

### Integración de Componentes
Ambos integrantes trabajaron conjuntamente en la integración de workflows, pruebas end-to-end del sistema completo y ajuste de parámetros basados en resultados de evaluación.

### Documentación Final
Redacción colaborativa del reporte técnico, síntesis del CHANGELOG_IA, documentación del repositorio y preparación de materiales de presentación.

---

## Estrategia de Branching

**Ramas principales:**
- `main` - Código estable en producción
- `develop` - Integración continua del desarrollo

**Ramas de features implementadas:**
- `feature/documentacion-completa`
- `feature/workflow-consulta-rag`
- `feature/workflow-evaluacion-automatizada`
- `feature/workflow-preparar-corpus`

**Formato de commits:**
- `[INFRA]` - Infraestructura (Jerónimo)
- `[EVAL]` - Evaluación (Jerónimo)
- `[CORPUS]` - Corpus (Juan Pablo)
- `[RAG]` - Pipeline RAG (Juan Pablo)
- `[DOCS]` - Documentación (Ambos)
- `[FIX]` - Correcciones
- `[TEST]` - Pruebas

---

## Fórmulas de Evaluación

### Score por Respuesta Individual

```
Score_r = 0.35×Exactitud + 0.20×Cobertura + 0.15×Claridad + 0.20×Citas - 0.10×Alucinación - 0.05×Seguridad
```

**Componentes:**
- **Exactitud (0-1):** Corrección factual y presencia de conceptos clave
- **Cobertura (0-1):** Completitud semántica y extensión apropiada
- **Claridad (0-1):** Estructura gramatical y coherencia
- **Citas (0-1):** Presencia y formato de referencias bibliográficas
- **Alucinación (0-1):** Información inventada o sin respaldo
- **Seguridad (0-1):** Cumplimiento de políticas éticas

### Score Global

```
Score_Global = Promedio(Score_r de todas las preguntas)
```

### Índice Final de Adecuación (IFA)

```
IFA = Score_r×0.6 + (1 - Tasa_Alucinación/100)×0.2 + (Porcentaje_Citas/100)×0.2
```

---

## Criterios de Aprobación

Un proyecto es considerado adecuado si cumple:
- Score Global ≥ 0.70
- Tasa de Alucinación ≤ 10%
- Respuestas con Citas ≥ 85%
- IFA ≥ 0.75

---

## Distribución de Puntos del Proyecto

- **Ingeniería y reproducibilidad:** 20 puntos
- **Diseño de RAG y curación:** 20 puntos
- **Evaluación rigurosa:** 20 puntos
- **Comparativa de LLMs:** 20 puntos
- **Producto y UX:** 10 puntos
- **Reporte y presentación:** 10 puntos
- **Contribución por rol:** 10 puntos
- **Integración WhatsApp/Telegram:** +10 puntos extra

**Total posible:** 110 puntos

---