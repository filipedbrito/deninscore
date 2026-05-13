  with participacoes as (
  select 
    *
  From 
    deninscore_silver.participacoes
  where
    seq_partida > 1 -- primeira partida não teve contagem de gols marcados por atleta
  )

  , base_confrontos as (
  select
    atleta1.atleta as atleta1,
    atleta2.atleta as atleta2,
    atleta1.data_partida,
    atleta1.gols_marcados as gols_marcados_atleta1
  from
    participacoes as atleta1
    join 
      participacoes as atleta2
        on 1=1
          and atleta1.data_partida = atleta2.data_partida
          and atleta1.time <> atleta2.time -- times opostos
          and atleta1.posicao = 'linha'
          and atleta2.posicao = 'gol'
  where 1=1
  )

  select
    atleta1,
    atleta2,
    count(*) as confrontos,
    sum(gols_marcados_atleta1) as gols_marcados_atleta1,
    sum(sum(gols_marcados_atleta1)) over (partition by atleta2) as gols_sofridos_atleta2
  from
    base_confrontos
  where
    coalesce(gols_marcados_atleta1, 0) > 0
  group by
    atleta1,
    atleta2