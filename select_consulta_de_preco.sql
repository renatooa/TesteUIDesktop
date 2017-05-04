$sSelect = "select pro_desc, pro_referencia, ppr_procodigo, ppr_prbcodigo, ppr_filcodigo, ppr_precovenda, " _  
& "pfi_custo1 as custogerencial, unp_unidade, unp_quantidade, unp_fatestoque, unp_fatvenda, " _
& "unp_descemb, ppr_precominp, ppr_precominv, unp_varejo, " _
& "(select fab_razao from fabricante where pro_fabcodigo = fab_codigo) as fab_razao, " _
& "(select mrc_desc from marcapro where pro_mrccodigo = mrc_codigo) as mrc_desc, " _
& "(select lop_desc from localizacaopro where pfi_lopcodigo = lop_codigo) as lop_desc " _
& "from produtopreco, unidadepro, produto, produtofilial " _
& "where ppr_procodigo = pro_codigo " _
& "and unp_procodigo = pro_codigo " _
& "and ppr_procodigo = pfi_procodigo " _
& "and ppr_filcodigo = pfi_filcodigo " _
& "and ppr_precovenda <> 0 " _
& "and  unp_padvenda = 1 " _
& "and pro_ativo = 1 " _
& "and pro_codigo = pfi_procodigo and pfi_filcodigo = 1 " _
& "and (pfi_inativo <> 1 or pfi_inativo is null) " _
& "and ppr_filcodigo = 1 and ppr_prbcodigo = 1;"

-- ----------------------------------------------------------------------------------------------------------------------------------

select pro_desc, pro_referencia, ppr_procodigo, ppr_prbcodigo, ppr_filcodigo, ppr_precovenda,  pfi_custo1 
as custogerencial, unp_unidade, unp_quantidade, unp_fatestoque, unp_fatvenda, unp_descemb, ppr_precominp, ppr_precominv, unp_varejo, 
(select fab_razao from fabricante where pro_fabcodigo = fab_codigo) as fab_razao, 
(select mrc_desc from marcapro where pro_mrccodigo = mrc_codigo) as mrc_desc, 
(select lop_desc from localizacaopro where pfi_lopcodigo = lop_codigo) as lop_desc
from produtopreco, unidadepro, produto, produtofilial  
where ppr_procodigo = pro_codigo and unp_procodigo = pro_codigo 
and ppr_procodigo = pfi_procodigo and ppr_filcodigo = pfi_filcodigo 
and ppr_precovenda <> 0 and  unp_padvenda = 1 and pro_ativo = 1 
and pro_codigo = pfi_procodigo and pfi_filcodigo = 1 
and (pfi_inativo <> 1 or pfi_inativo is null)  and ppr_filcodigo = 1 and ppr_prbcodigo = 1

-- ------------------------------------------------------------------------------------------------------------------------------------

SELECT pro_codigo, pfi_procodigo, lpd_procodigo, ppr_procodigo, 
pro_filcodigo, pfi_filcodigo, lpd_filcodigo, ppr_filcodigo, 
(pfi_estoque - pfi_estpenentre), unp_fracminima FROM produto
INNER JOIN  produtofilial ON pro_codigo = pfi_procodigo
INNER JOIN localprod ON pfi_procodigo = lpd_procodigo
INNER JOIN produtopreco ON lpd_procodigo = ppr_procodigo
INNER JOIN unidadepro ON unp_procodigo = ppr_procodigo
WHERE pfi_filcodigo = 1 AND pro_ativo = 1
AND (pfi_estoque - pfi_estpenentre) > 3
AND lpd_estfisico > lpd_estpenentre
AND (pfi_inativo <> 1 OR pfi_inativo IS NULL) AND pfi_libvenda = 1
AND unp_libvenda = 1 AND unp_padvenda = 1
AND ppr_precovenda <> 0 AND ppr_prbcodigo = 1
AND unp_fracminima IN (0.000, 0.001, 0.002, 0.005, 0.00, 0.01, 0.02, 0.05, 0, 0.1, 0.2, 0.5, 1)
AND unp_qminvenda IN (0, 1)
GROUP BY pro_codigo;