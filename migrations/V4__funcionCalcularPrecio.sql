create or replace function receta.sumCostoListaEscalada(
    p_costos numeric[],
    p_factor numeric
)
returns numeric(10,2)
language sql
as $$
    select
        coalesce(sum(c * p_factor), 0)
    from unnest(p_costos) as c;
$$;