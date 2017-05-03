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

-- -------------------------------------------------------------------------------------------------------------------------

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