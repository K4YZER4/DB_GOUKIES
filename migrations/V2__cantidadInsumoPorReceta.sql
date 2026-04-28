create or replace function receta.cantidadInsumoPorReceta(
    p_idReceta uuid,
    p_nuevaPorcion int
)
returns table (
    idInsumo uuid,
    nombreReceta varchar(30),
    nombreInsumo varchar(50),
    cantidadOriginal numeric(10,2),
    porcionesOriginales int,
    nuevaPorcion int,
    cantidadRecalculada numeric(10,2),
    costoRecalculado numeric(10,2)
)
language sql
as $$
    select
        i.id                            as idInsumo,
        r.nombre                        as nombreReceta,
        i.nombre                        as nombreInsumo,
        ri.cantidad                     as cantidadOriginal,
        r.porciones_totales             as porcionesOriginales,
        p_nuevaPorcion                  as nuevaPorcion,
        ri.cantidad * (
            cast(p_nuevaPorcion as numeric) / cast(r.porciones_totales as numeric)
        )                               as cantidadRecalculada,
        ri.cantidad * (
            cast(p_nuevaPorcion as numeric) / cast(r.porciones_totales as numeric)
        ) * i.precio_unitario           as costoRecalculado
    from receta.receta r
    inner join receta.receta_insumo ri on ri.id_receta = r.id
    inner join receta.insumo i         on ri.id_insumo = i.id
    where r.id = p_idReceta;
$$;