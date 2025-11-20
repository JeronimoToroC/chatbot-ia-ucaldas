# Script para renombrar PDFs a nomenclatura estandarizada

$mappings = @{
    '1.4-HISTORIA-INSTITUCIONAL-UNIVERSIDAD-DE-CALDAS.pdf' = 'doc_001_Historia_Institucional_UCaldas.pdf'
    'Universidad_de_Caldas.pdf' = 'doc_002_Universidad_Caldas_General.pdf'
    'Dialnet-ContribucionesDeLaUniversidadDeCaldasALaFormacionC-7537576.pdf' = 'doc_003_Contribuciones_UCaldas_Formacion.pdf'
    'Approach from Artificial Intelligence to poorly predictive behaviors derived from artificial cognitive models.pdf' = 'doc_004_AI_Cognitive_Models.pdf'
    'HACIA UNA TEORÍA DE LA MENTE CORPORIZADA La influencia de los mecanismos sensomotores en el desarrollo de la cognición.pdf' = 'doc_005_Teoria_Mente_Corporizada.pdf'
    'Dialnet-DigitalSkillsInTheUseOfArtificialIntelligenceTools-9873205.pdf' = 'doc_006_Digital_Skills_AI_Tools.pdf'
    'peerj-cs-1490.pdf' = 'doc_007_PeerJ_AI_Applications.pdf'
    'A Systematic Literature Review About Application of Pervasive Games in Rehabilitation.pdf' = 'doc_008_Pervasive_Games_Rehabilitation.pdf'
    'paolamolina,+02+Artificial+intelligent+device+for+physical+and+mental+state+monitoring+in.pdf' = 'doc_009_AI_Health_Monitoring.pdf'
    'applsci-14-03818.pdf' = 'doc_010_Applied_Sciences_AI_Healthcare.pdf'
    'electronics-10-00799.pdf' = 'doc_011_Electronics_AI_Apps.pdf'
    'ESTUDIO DE REDES DE SENSORES Y APLICACIONES ORIENTADAS A LA RECOLECCIÓN Y ANÁLISIS.pdf' = 'doc_012_Redes_Sensores_Analisis.pdf'
    'Dialnet-FusionYCorrelacionDeAlertasBasadasEnOntologiasSobr-4546828.pdf' = 'doc_013_Fusion_Alertas_Ontologias.pdf'
    's10462-024-10740-3.pdf' = 'doc_014_Springer_AI_ML_Review.pdf'
    'processes-08-00638-v2.pdf' = 'doc_015_Processes_AI_Industrial.pdf'
    'Constitución_2024.pdf' = 'doc_016_Constitucion_Colombia_2024.pdf'
    'OrigenesyDinanicadelosSdeI.pdf' = 'doc_017_Origenes_Sistemas_Inteligentes.pdf'
    'EL_CURRICUL0_INTEGRADO_EN_EL_MODELO_DE_U.pdf' = 'doc_018_Curriculo_Integrado_UCaldas.pdf'
    'Informe_Autoevaluacion_ingenieria_2013.pdf' = 'doc_019_Autoevaluacion_Ingenieria_2013.pdf'
    'Actualización de sitio web y plataforma virtual de aprendizaje  de Telesalud Universidad de Caldas.pdf' = 'doc_020_Telesalud_UCaldas.pdf'
}

foreach ($old in $mappings.Keys) {
    $oldPath = Join-Path 'data\corpus' $old
    $newPath = Join-Path 'data\corpus' $mappings[$old]
    
    if (Test-Path $oldPath) {
        Rename-Item -Path $oldPath -NewName $mappings[$old]
        Write-Host \"Renombrado: $old -> $($mappings[$old])\"
    }
}

Write-Host \"
Proceso completado.\"
