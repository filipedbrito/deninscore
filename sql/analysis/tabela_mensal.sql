select 
  atleta,
  posicao,
  date_trunc(data_partida, month) as mes,
  sum(pontos_partidas) + sum(pontos_capitao) + sum(pontos_motm) + sum(pontos_botm) + sum(pontos_totw) as total_pontos,
  sum(pontos_partidas) as pontos_partidas,
  sum(pontos_capitao) as pontos_capitania,
  sum(pontos_motm) as pontos_motm,
  sum(pontos_botm) as pontos_botm,
  sum(pontos_totw) as pontos_totw,
  sum(coalesce(gols_marcados,0)) + sum(coalesce(assistencias,0)) as participacoes_em_gol,
  sum(coalesce(gols_marcados,0)) as gols,
  sum(coalesce(assistencias,0)) as assistencias,
  sum(coalesce(gols_sofridos,0)) as gols_sofridos,
  count(*) as partidas
from
  deninscore_silver.participacoes
where
  tipo = 'grupo'
group by
  atleta,
  posicao,
  mes
order by
  total_pontos desc