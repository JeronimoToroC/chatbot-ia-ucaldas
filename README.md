# ChatBot IA - Universidad de Caldas

## Proyecto: Sistema de Consulta sobre Inteligencia Artificial con Arquitectura RAG

### Información del Proyecto

**Institución:** Universidad de Caldas  
**Programa:** Ingeniería de Sistemas y Computación  
**Asignatura:** Sistemas Inteligentes I  
**Profesor:** Luis Fernando Castillo Ossa

**Equipo de Desarrollo:**
- Jerónimo Toro C (Código: 20712) - Infraestructura, MLOps, LLM y Evaluación
- Juan Pablo Valencia C (Código: 29169) - Contexto, Aplicación y RAG

**Fechas:**
- Inicio: 15 de octubre de 2025
- Entrega: 22 de noviembre de 2025
- Duración: 38 días

---

## Descripción

ChatBot confiable sobre Inteligencia Artificial que implementa arquitectura RAG (Retrieval-Augmented Generation) para responder preguntas con citas verificables, evitando alucinaciones.

### Objetivos

- Responder preguntas sobre IA con citas verificables
- Evitar alucinaciones mediante RAG
- Lograr Score Global ≥ 0.70
- Mantener Tasa de Alucinación ≤ 10%
- Asegurar Respuestas con Citas ≥ 85%
- Alcanzar IFA ≥ 0.75

---

## Stack Tecnológico

- **Orquestador:** N8N Pro
- **LLM:** OpenAI GPT-3.5-turbo
- **Embeddings:** OpenAI text-embedding-3-small (1536 dimensiones)
- **Vector Store:** Pinecone
- **Control de Versiones:** Git/GitHub

---

## Estructura del Proyecto

\\\
chatbot-ia-ucaldas/
├── README.md
├── .gitignore
├── .env.example
├── docs/                          # Documentación técnica
├── data/
│   ├── corpus/                    # 20 documentos PDF curados
│   └── gold_questions.json        # 60 preguntas de evaluación
├── n8n_workflows/                 # Workflows exportados
│   ├── 01_Preparar_Corpus.json
│   ├── 02_Consulta_RAG.json
│   └── 03_Evaluacion_Gold.json
├── results/                       # Resultados de evaluación
├── config/                        # Configuraciones
├── logs/                          # Logs anonimizados
├── app/                           # Interfaz web (opcional)
└── demo/                          # Videos demostrativos
\\\

---

## Requisitos Previos

- Cuenta N8N Pro
- API Key de OpenAI
- Cuenta Pinecone (free tier)
- Git

---

## Configuración Inicial

1. Clonar el repositorio:
\\\ash
git clone https://github.com/JeronimoToroC/chatbot-ia-ucaldas.git
cd chatbot-ia-ucaldas
\\\

2. Copiar y configurar variables de entorno:
\\\ash
cp .env.example .env
# Editar .env con tus credenciales
\\\

3. Importar workflows en N8N Pro

---

## Uso

(Por completar - se actualizará con instrucciones detalladas)

---

## Resultados Esperados

- **Score Global:** ≥ 0.70
- **Tasa de Alucinación:** ≤ 10%
- **Respuestas con Citas:** ≥ 85%
- **IFA:** ≥ 0.75

---

## Documentación

- [CHANGELOG_IA.md](docs/CHANGELOG_IA.md) - Registro de uso de herramientas IA
- [ARQUITECTURA.md](docs/ARQUITECTURA.md) - Diseño técnico del sistema
- [MANUAL_EJECUCION.md](docs/MANUAL_EJECUCION.md) - Guía paso a paso
- [POLITICAS_TRANSPARENCIA.md](docs/POLITICAS_TRANSPARENCIA.md) - Políticas de privacidad

---

## Licencia

Proyecto académico - Universidad de Caldas 2025

---

## Contacto

**Repositorio:** https://github.com/JeronimoToroC/chatbot-ia-ucaldas  
**Estudiantes:** Jerónimo Toro C & Juan Pablo Valencia C  
**Curso:** Sistemas Inteligentes I
