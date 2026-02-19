create or replace view deninscore_silver.participacoes as
select
    date(data) as data_partida,
    trim(atleta) as atleta,
    lower(trim(posicao)) as posicao,
    lower(trim(tipo)) as tipo,
    upper(trim(time)) as time,
    upper(trim(resultado)) as resultado,
    safe_cast(gols_marcados as int64) as gols_marcados,
    safe_cast(gols_sofridos as int64) as gols_sofridos,
    cast(capitao as bool) as capitao,
    cast(motm as bool) as motm,
    cast(botm as bool) as botm,
    cast(totw as bool) as totw,
        case
        when resultado = 'V' then 3
        when resultado = 'E' then 1
        when resultado = 'D' then 0
        else null 
    end as pontos_partidas,
    case
        when capitao = true and resultado = 'V' then 3
        when capitao = true and resultado = 'D' then -1
        else 0
    end as pontos_capitao,
    if(motm = true, 1, 0) as pontos_motm,
    if(botm = true, -1, 0) as pontos_botm,
    if(totw = true, 1, 0) as pontos_totw
from
    deninscore_raw.raw_participacoes