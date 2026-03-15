with participacoes as (
select 
  *
From 
  deninscore_silver.participacoes
)

-- etapa que consolida gols sofridos por cada time por partida
, base_placar as (
select
  data_partida,
  time,
  max(gols_sofridos) as gols_sofridos
from
  participacoes
group by 
  data_partida,
  time
)

-- inclui os gols feitos pelo time em cada partida
, placar as (
select
  base.data_partida,
  base.time,
  oponente.gols_sofridos as gols_time,
  base.gols_sofridos as gols_oponente
from
  base_placar as base
  left join base_placar as oponente
    on 1=1 
      and base.data_partida = oponente.data_partida 
      and base.time <> oponente.time
)

-- atrela todas duplas que jogaram juntas por partida, bem como dados resultantes deste evento
, base_companheiros as (
select
  atleta1.atleta as atleta1,
  atleta2.atleta as atleta2,
  atleta1.data_partida,
  atleta1.pontos_partidas as pontos_conquistados,
  3 as pontos_disputados,
  atleta1.resultado,
  coalesce(atleta1.gols_marcados, 0) + coalesce(atleta1.assistencias, 0) + coalesce(atleta2.gols_marcados, 0) + coalesce(atleta2.assistencias, 0) as participacoes_em_gol,
  coalesce(atleta1.gols_sofridos, 0) as gols_sofridos,
  placar.gols_time,
  placar.gols_oponente
from
  participacoes as atleta1
  join 
    participacoes as atleta2
      on 1=1
        and atleta1.data_partida = atleta2.data_partida
        and atleta1.time = atleta2.time
        and atleta1.atleta <> atleta2.atleta
  join placar
    on 1=1
      and atleta1.data_partida = placar.data_partida
      and atleta1.time = placar.time
)

-- consolida todo histórico por duplas companheiras
select
  atleta1,
  atleta2,
  count(*) as partidas_jogadas,
  sum(pontos_conquistados) as pontos_conquistados,
  sum(pontos_disputados) as pontos_disputados,
  sum(if(resultado = 'V',1,0)) as vitorias,
  sum(if(resultado = 'D',1,0)) as derrotas,
  sum(if(resultado = 'E',1,0)) as empates,
  sum(participacoes_em_gol) as participacoes_em_gol,
  sum(gols_time) as gols_time
from
  base_companheiros
group by
  atleta1,
  atleta2