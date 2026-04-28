create or replace function receta.cantidadProductoPorReceta(
    p_idReceta uuid,
    p_nuevaPorcion int
)
returns table (
    idProducto uuid,
    nombreReceta varchar(30),
    nombreProducto varchar(50),
    cantidadOriginalUnidad numeric(10,2),
    cantidadOriginalBase numeric(10,2),
    porcionesOriginales int,
    nuevaPorcion int,
    cantidadRecalculadaUnidad numeric(10,2),
    cantidadRecalculadaBase numeric(10,2),
    costoRecalculado numeric(10,2)
)
language sql
as $$
    select
        p.id                                                    as idProducto,
        r.nombre                                                as nombreReceta,
        ing.nombre                                              as nombreProducto,
        rp.cantidad                                             as cantidadOriginalUnidad,
        rp.cantidad * cast(p.cantidad_unitario as numeric)      as cantidadOriginalBase,
        r.porciones_totales                                     as porcionesOriginales,
        p_nuevaPorcion                                          as nuevaPorcion,
        rp.cantidad * (
            cast(p_nuevaPorcion as numeric) / cast(r.porciones_totales as numeric)
        )                                                       as cantidadRecalculadaUnidad,
        rp.cantidad * (
            cast(p_nuevaPorcion as numeric) / cast(r.porciones_totales as numeric)
        ) * cast(p.cantidad_unitario as numeric)                as cantidadRecalculadaBase,
        rp.cantidad * (
            cast(p_nuevaPorcion as numeric) / cast(r.porciones_totales as numeric)
        ) * p.precio_medio                                      as costoRecalculado
    from receta.receta r
    inner join receta.receta_producto rp on rp.id_receta   = r.id
    inner join receta.producto        p  on rp.id_producto = p.id
    inner join receta.ingrediente     ing on p.id_ingrediente = ing.id
    where r.id = p_idReceta;
$$;