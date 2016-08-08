SELECT pro_codigo, ppr_precovenda, pfi_inativo, lpd_estfisico, LPD_ESTINICIAL, pfi_estoque FROM produto 
INNER JOIN  produtofilial ON pro_codigo = pfi_procodigo AND pro_filcodigo = pfi_filcodigo
INNER JOIN localprod ON pfi_procodigo = lpd_procodigo AND lpd_filcodigo = pfi_filcodigo
INNER JOIN produtopreco ON lpd_procodigo = ppr_procodigo AND lpd_filcodigo = ppr_filcodigo
WHERE pro_filcodigo = 1 AND pro_ativo = 1 
AND pfi_estpenconfi = 0 AND pfi_estpenentra = 0 AND pfi_estpenentre = 0
AND lpd_estpenconfi = 0 AND lpd_estpenentra = 0 AND lpd_estpenentre = 0
AND pfi_estoque > 20 AND pfi_libvenda = 1
AND lpd_estfisico > 20 AND ppr_precovenda <> 0
AND ppr_prbcodigo = 1 AND pfi_inativo = 0
GROUP BY pro_codigo;

# ----------------------------------
select * from produto;
desc produto;
desc produtofilial;
desc localprod;
desc produtopreco;

select * from produtopreco where PPR_PROCODIGO = 36 and PPR_FILCODIGO = 1;
