  with participacoes as (
  select 
    *
  From 
    deninscore_silver.participacoes
  )

  , base_companheiros as (
  select
    atleta1.atleta as atleta1,
    atleta2.atleta as atleta2,
    atleta1.data_partida,
    atleta1.resultado as resultado1,
    atleta2.resultado as resultado2
  from
    participacoes as atleta1
    join 
      participacoes as atleta2
        on 1=1
          and atleta1.data_partida = atleta2.data_partida
          and atleta1.time <> atleta2.time -- times opostos
          and atleta1.atleta < atleta2.atleta -- necessário para deduplicar duplas pare no mesmo jogo (ex: 'Rich e Caça' e 'Caça e Rich')
  )

  select
    least(atleta1, atleta2) as atleta1,
    sum(if(resultado1 = 'V',1,0)) as vitorias1,
    count(*) as confrontos,
    sum(if(resultado2 = 'V',1,0)) as derrotas,
    greatest(atleta1, atleta2) as atleta2,
  from
    base_companheiros
  group by
    atleta1,
    atleta2