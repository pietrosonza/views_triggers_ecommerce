use ecommerce;

-- Trigger para adicionar em uma base de produto entregues quando um pedido for entregue e excluido da base de pedidos.

-- criando tabela para pedidos entregues
create table pedidos_entregues (
	n_idPedido int,
    n_idCliente int,
    n_idPagamento int,
    n_frete float,
    n_idProduto int,
    n_quantidade int,
    n_endereco varchar (50)
    );

delimiter \\
create trigger pedido_entregue before delete on pedido
for each row
	begin
		insert into pedidos_entregues(n_idPedido, n_idCliente, n_idPagamento, n_frete, n_idProduto, n_quantidade, n_endereco)
        values
        (old.idPedido, old.idCliente, old.idPagamento, old.frete, (select idProduto from produtopedido pp inner join pedido p on pp.idPedido = p.idPedido where pp.idPedido = old.idPedido), 
																  (select quantidade from produtopedido pp inner join pedido p on pp.idPedido = p.idPedido where pp.idPedido = old.idPedido),
																  (select endereco from cliente c inner join pedido p on c.idCliente = p.idCliente where c.idCliente = old.idCliente and p.idPedido = old.idPedido));
end \\	
delimiter ;


