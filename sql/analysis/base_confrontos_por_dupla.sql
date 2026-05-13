  with participacoes as (
  select 
    *
  From 
    deninscore_silver.participacoes
  where
    tipo = 'grupo'
  )

  , base_confrontos as (
  select
    atleta1.atleta as atleta1,
    atleta2.atleta as atleta2,
    atleta1.data_partida,
    atleta1.gols_marcados as gols_marcados1,
    atleta2.gols_marcados as gols_marcados2,
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

, confrontos_atletas as (
  select
    least(atleta1, atleta2) as atleta1,
    sum(gols_marcados1) as gols_marcados1,
    sum(if(resultado1 = 'V',1,0)) as vitorias1,
    count(*) as confrontos,
    array_agg(data_partida) as data_partidas,
    sum(if(resultado2 = 'V',1,0)) as vitorias2,
    sum(gols_marcados2) as gols_marcados2,
    greatest(atleta1, atleta2) as atleta2,
  from
    base_confrontos
  group by
    atleta1,
    atleta2
)

select
  *
  -- concat(atleta1, ' vs ', atleta2) as confronto,
  -- data_partidas
from
  confrontos_atletas
where 1=1
  and (atleta1 = 'Andrey' or atleta1 = 'Gabriel Nascimento')
  and (atleta2 = 'Andrey' or atleta2 = 'Gabriel Nascimento')
  -- and confrontos = 1
  -- and atleta1 not in ('Mike','Heitor','Totti','BS','Gleybe','Guilherme') and atleta2 not in ('Mike','Heitor','Totti','BS','Gleybe','Guilherme') 
order by confrontos desc 