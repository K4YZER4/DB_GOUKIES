create or replace function receta.profitProductosReceta(
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
        from receta.cantidadProductoPorReceta(p_idReceta, p_nuevaPorcion)
    )
    select
        c.costoTotal                                           as precioProduccion,
        c.costoTotal * (r.profit / 100)                        as precioVenta,
        r.profit                                               as profitPorcentaje
    from receta.receta r
    cross join costo c
    where r.id = p_idReceta;
$$;