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
        round(rp.cantidad * cast(p.cantidadunitario as numeric), 2)       as cantidadOriginalBase,
        r.porcionestotales                                      as porcionesOriginales,
        p_nuevaPorcion                                          as nuevaPorcion,
        round(rp.cantidad * (
            cast(p_nuevaPorcion as numeric) / cast(r.porcionestotales as numeric)
        ), 2)                                                   as cantidadRecalculadaUnidad,
        round(rp.cantidad * (
            cast(p_nuevaPorcion as numeric) / cast(r.porcionestotales as numeric)
        ) * cast(p.cantidadunitario as numeric), 2)             as cantidadRecalculadaBase,
        round(rp.cantidad * (
            cast(p_nuevaPorcion as numeric) / cast(r.porcionestotales as numeric)
        ) * p.preciomedio, 2)                                   as costoRecalculado
    from receta.receta r
    inner join receta.recetaproducto rp on rp.idreceta   = r.id
    inner join receta.producto        p  on rp.idproducto = p.id
    inner join receta.ingrediente     ing on p.idingrediente = ing.id
    where r.id = p_idReceta;
$$;