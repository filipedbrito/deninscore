with participacoes as (
  select * 
  from deninscore_silver.participacoes
),

mes as (
  select
    atleta,
    count(*) as partidas_jogadas
  from participacoes
  group by 1
)

select
  partidas_jogadas,
  count(*) as qt_atletas,
  array_agg(atleta) as lista_atletas, -- 👈 aqui
  (select count(distinct data_partida) from participacoes) as total_partidas,
  round(partidas_jogadas * 100 / (select count(distinct data_partida) from participacoes), 1) as pc_participacao,
  round(count(*) * 100.0 / sum(count(*)) over (), 1) as pc_atletas
from mes
group by 1
order by 1 desc;