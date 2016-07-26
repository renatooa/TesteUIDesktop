SELECT pro_codigo, ppr_precovenda FROM produto 
INNER JOIN  produtofilial ON pro_codigo = pfi_procodigo
INNER JOIN localprod ON pfi_procodigo = lpd_procodigo
INNER JOIN produtopreco ON lpd_procodigo = ppr_procodigo
WHERE pro_filcodigo = 1 AND pro_ativo = 1 
AND pfi_estoque > 20 AND pfi_libvenda = 1
AND lpd_estfisico > 20 AND ppr_precovenda <> 0
AND ppr_prbcodigo = 1 AND pfi_inativo = 0
GROUP BY pro_codigo;

# ----------------------------------
select * from produto;
desc produto;
desc produtofilial;
desc localprod;
desc dental.produtopreco;

select * from produtopreco where PPR_PROCODIGO = 36 and PPR_FILCODIGO = 1;
