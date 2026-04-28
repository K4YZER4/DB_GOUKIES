create or replace function receta.profitInsumosReceta(
    p_idReceta uuid,
    p_nuevaPorcion int
)
returns table (
    precioProduccion numeric(10,2),
    precioVenta numeric(10,2),
    profitPorcentaje numeric(10,2)
)
language sql
as $$
    with costo as (
        select
            coalesce(sum(costoRecalculado), 0) as costoTotal
        from receta.cantidadInsumoPorReceta(p_idReceta, p_nuevaPorcion)
    )
    select
        round(c.costoTotal, 2)                                  as precioProduccion,
        round(c.costoTotal * (r.profit / 100), 2)               as precioVenta,
        round(r.profit, 2)                                      as profitPorcentaje
    from receta.receta r
    cross join costo c
    where r.id = p_idReceta;
$$;