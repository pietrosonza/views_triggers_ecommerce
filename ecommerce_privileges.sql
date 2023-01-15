-- Criando usuarios em nosso ecommerce

-- cliente
create user 'cliente'@localhost identified by '0123321';
grant all privileges on ecommerce.produtos to 'cliente'@localhost;

-- almoxarife
create user 'almoxarife'@localhost identified by '0123214';
grant all privileges on ecommerce.estoque to 'almoxarife'@localhost;
grant all privileges on ecommerce.produtoestoque to 'almoxarife'@localhost;

-- gerente 
create user 'gerente'@localhost identified by '123451';
grant all privileges on ecommerce.* to 'gerente'@localhost;

-- vendedor
create user 'vendedor'@localhost identified by '000123';
grant all privileges on ecommerce.pedido to 'vendedor'@localhost;
grant all privileges on ecommerce.produtopedido to 'vendedor'@localhost;
grant all privileges on ecommerce.produto to 'vendedor'@localhost;
grant all privileges on ecommerce.cliente to 'vendedor'@localhost;
grant all privileges on ecommerce.clientepf to 'vendedor'@localhost;
grant all privileges on ecommerce.clientepj to 'vendedor'@localhost;

-- fornecedor
create user 'fornecedor'@localhost identified by '000142';
grant all privileges on ecommerce.produtofornecedor to 'fornecedor'@localhost;
grant all privileges on ecommerce.fornecedor to 'fornecedor'@localhost;

flush privileges;

