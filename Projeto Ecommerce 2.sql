select 'categoriaproduto' as tabela, count(*) as registgros from categoriaproduto
union
select 'cliente', count(*) from cliente
union

select * from cliente;

select a.identificacao, a.nome, c.descricao as formapagamento, b.numero, b.validade 
from cliente a, clienteformapagamento b, formapagamento c
where
c.idformapagamento = b.idformapagamento
and
b.idcliente = a.idcliente;

select a.idpedido, c.codigo as codigoproduto, c.descricao as produto, sum(b.quantidade) as quantidade, 
sum(b.preco * b.quantidade) as venda
from pedido a, pedidoterceiroproduto b, produto c, terceiroproduto d
where
c.idproduto = d.idterceiroproduto
and
d.idterceiroproduto = b.idterceiroproduto
and
b.idpedido = a.idpedido
group by  a.idpedido, c.codigo, c.descricao
order by  a.idpedido, c.codigo, c.descricao;

select c.codigo as codigoproduto, c.descricao as produto, sum(b.quantidade) as quantidade, 
sum(b.preco * b.quantidade) as venda
from pedido a, pedidoterceiroproduto b, produto c, terceiroproduto d
where
c.idproduto = d.idterceiroproduto
and
d.idterceiroproduto = b.idterceiroproduto
and
b.idpedido = a.idpedido
group by  c.codigo, c.descricao
order by  c.codigo, c.descricao;

select (a.codigo || ' - ' || a.descricao) as codigodescricao
from produto a;

select a.*
from produto a
order by a.preco desc;

select c.codigo as codigoproduto, c.descricao as produto, sum(b.quantidade) as quantidade, 
sum(b.preco * b.quantidade) as venda
from pedido a, pedidoterceiroproduto b, produto c, terceiroproduto d
where
c.idproduto = d.idterceiroproduto
and
d.idterceiroproduto = b.idterceiroproduto
and
b.idpedido = a.idpedido
group by  c.codigo, c.descricao
order by  4 desc;

select c.codigo as codigoproduto, c.descricao as produto, sum(b.quantidade) as quantidade, 
sum(b.preco * b.quantidade) as venda
from pedido a, pedidoterceiroproduto b, produto c, terceiroproduto d
where
c.idproduto = d.idterceiroproduto
and
d.idterceiroproduto = b.idterceiroproduto
and
b.idpedido = a.idpedido
group by  c.codigo, c.descricao
having sum(b.quantidade) > 40
order by  4 desc;

select c.codigo as codigoproduto, c.descricao as produto, sum(b.quantidade) as quantidade, 
sum(b.preco * b.quantidade) as venda
from pedido a, pedidoterceiroproduto b, produto c, terceiroproduto d
where
c.idproduto = d.idterceiroproduto
and
d.idterceiroproduto = b.idterceiroproduto
and
b.idpedido = a.idpedido
group by  c.codigo, c.descricao
having sum(b.preco * b.quantidade) < 50000
order by  4 desc;

select a.identificacao, a.nome, count(*) as quantidade
from cliente a, pedido b
where
b.idcliente = a.idcliente
group by a.identificacao, a.nome
order by a.identificacao, a.nome;

select a.identificacao, a.nome, count(b.idpedido) as quantidade
from cliente a left join pedido b
on b.idcliente = a.idcliente
where
b.idpedido is null
group by a.identificacao, a.nome
order by a.identificacao, a.nome;

select a.codigo, a.descricao, count(d.idproduto) as quantidade
from produto a left join (select c.idproduto from pedidoTerceiroProduto b, TerceiroProduto c
                          where c.idterceiroproduto = b.idterceiroproduto) d
on d.idproduto = a.idproduto
where
d.idproduto is null
group by a.codigo, a.descricao
order by a.codigo, a.descricao;
