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
        r.porcionestotales              as porcionesOriginales,
        p_nuevaPorcion                  as nuevaPorcion,
        ri.cantidad * (
            cast(p_nuevaPorcion as numeric) / cast(r.porcionestotales as numeric)
        )                               as cantidadRecalculada,
        ri.cantidad * (
            cast(p_nuevaPorcion as numeric) / cast(r.porcionestotales as numeric)
        ) * i.preciounitario            as costoRecalculado
    from receta.receta r
    inner join receta.recetainsumo ri on ri.idreceta = r.id
    inner join receta.insumo i         on ri.idinsumo = i.id
    where r.id = p_idReceta;
$$;