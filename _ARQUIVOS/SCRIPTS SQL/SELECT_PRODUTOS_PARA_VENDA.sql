select pro_codigo from produto 
inner join  produtofilial on pro_codigo = pfi_procodigo
inner join localprod on pfi_procodigo = lpd_procodigo
inner join produtopreco on lpd_procodigo = ppr_procodigo
where pro_filcodigo = 1 and pro_ativo = 1 
and pfi_estoque > 20 and pfi_libvenda = 1 
and lpd_estfisico > 20 and ppr_precovenda <> 0
group by pro_codigo;

# ----------------------------------
select * from produto;
desc produto;
desc produtofilial;
desc localprod;
desc dental.produtopreco;
