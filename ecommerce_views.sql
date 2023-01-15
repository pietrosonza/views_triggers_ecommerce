-- Criando views do meu ecommerce

-- ID cliente, Nome cliente, PJ ou PF

-- VIEW: clientes_geral, vendas_totais, ticket_medio, acima_media

create view clientes_geral as
	select * from 
		( select pf.idCliente ID, pf.pNome Nome,
		case
			when pf.cpf <> ' ' then 'PF' 
			else null
		end Tipo
		from clientepf pf
		UNION ALL
		select pj.idCliente ID, pj.razaoSocial Nome,
		case
			when pj.cnpj <> ' ' then 'PJ'
			else null
		end Tipo
		from clientepj pj) clientes_geral;
        


-- Histórico de todos os pedidos (ID, Nome, Tipo, Produto, Quantidade, Valor total) -- Utilizando a View no join (interessante)

create view vendas_totais as
	select c.ID, c.Nome, c.Tipo, pt.pNome Produto, pp.quantidade Qt, (p.frete + (pp.quantidade * pt.valor)) valor_total from clientes_geral c
		inner join pedido p
		on c.ID = p.idCliente
		inner join produtopedido pp
		on p.idPedido = pp.idPedido
		inner join produto pt
		on pp.idProduto = pt.idProduto
		order by valor_total desc;
        
-- Qual o ticked médio de nossa empresa
create view ticket_medio as
	select (sum(p.valor * pe.quantidade) / count(*)) ticket_medio from produto p
		inner join produtopedido pe
		on p.idProduto = pe.idProduto;
        select * from ticket_medio;

-- Quais vendas foram acima da média
create view acima_media as
	select pp.idPedido, pt.pNome Produto, pp.quantidade Qt, (pt.valor * pp.quantidade) valor from pedido pd
		inner join produtopedido pp
		on pd.idPedido = pp.idPedido
		inner join produto pt
		on pp.idProduto = pt.idProduto
		where (pt.valor * pp.quantidade) > (select * from ticket_medio);

