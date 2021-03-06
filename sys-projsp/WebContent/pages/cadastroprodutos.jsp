<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet" type="text/css" href="../resources/css/estiloCadastro.css"/>
<link rel="stylesheet" type="text/css" href="../resources/css/estiloTable.css"/>

<!-- mascara funcionar tem que colocar estas bibliotecas abaixo -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    
<link rel="icon" href="../resources/img/icon.png">
<title>Cadastro de Produtos</title>
</head>

<body>
	
	<section>

		<form id="formulario" action="servletProduto" method="post">
		
			<a class="div-a" href="acessoSistema.jsp"><img alt="home" src="../resources/img/home1.png"> Menu</a>
		
				<div class="div-cadastrousuario">
					<h1>[ - Cadastro de Produtos - ]</h1>
				</div>
				
				<div class="div-dadosusuario">
					<h2>[ - Dados do Produto - ]</h2>
				</div>
				
				<div class="div-h4">
					<h4>Campos obrigatórios com (*)</h4>
				</div>
			
				<!-- agrupa os campos do formulário -->
				<fieldset>
					
					<fieldset class="grupo">
					
						<div class="campo">
						
							<label for="id">Código:</label>
							<input type="text" id="id" name="id" style="width: 8em;" readonly="readonly"
							value="${produto.id}">
							
						</div>
					
					</fieldset>
					
					<fieldset class="grupo">
						
						<div class="campo">
						
							<label for="descricao">Descrição:*</label>
							<input type="text" id="descricao" name="descricao" style="width: 30em;"
							value="${produto.descricao}" required="required" autofocus="autofocus">
							
						</div>
						
						<div class="campo">
						
							<label for="quantidade">Quantd.:*</label>
							<input type="number" id="quantidade" name="quantidade" style="width: 8em;"
							min="1" max="2000" onkeypress="$(this).mask('0000')"
							value="${produto.quantidade}" required="required">
							
						</div>
						
						<div class="campo">
						
							<label for="valorcompra">Valor Compra:*</label>
							<input type="text" id="valorcompra" name="valorcompra" style="width: 10em;"
							onkeypress="$(this).mask('###.###.##0,00', {reverse: true});"
							value="${produto.valorCompraEmTexto}" required="required">
							
						</div>
						
						<div class="campo">
						
							<label for="valoritem">Valor Item:*</label>
							<input type="text" id="valoritem" name="valoritem" style="width: 10em;"
							onkeypress="$(this).mask('###.###.##0,00', {reverse: true});"
							value="${produto.valorItemEmTexto}" required="required">
							
						</div>
						
						<div class="campo">
						
							<label for="categorias">Categoria:*</label>
							<select id="categorias" name="id_categoria">
							
								<option disabled="disabled" selected="selected">[- Selecione -]</option>
								
								<c:forEach items="${categorias}" var="cate">
									<option  id="${cate.id}" value="${cate.id}"
									
										<c:if test="${cate.id == produto.categoria}">
		        							<c:out value="selected=\"selected\""/>
		    							</c:if>
									
									>
										
										${cate.descricao}
									</option>
									
								</c:forEach>
								
							</select>
						
						</div>
							
					</fieldset>
					
									
				<button type="submit" class="botao submit" value="Salvar">Salvar</button>
				<button type="submit" class="botao submit" value="Cancelar"
				onclick="document.getElementById('formulario').action = 'servletProduto?acao=reset'">Cancelar</button>
			
			</fieldset>
			
		</form>
		
	</section>
		
		<section>
		
			<div class="caption">Produtos Cadastrados</div>
		
				<div class="tbl-header">
		
					<table>
						
						<thead>
							
							<tr>
								
								<th style="width: 8%; text-align: center;">Código</th>
								<th style="width: 30%; text-align: center;">Descrição</th>
								<th style="width: 8%; text-align: center;">Quantd.</th>
								<th style="width: 10%; text-align: center;">Valor Compra</th>
								<th style="width: 10%; text-align: center;">Valor Item</th>
								<th style="width: 10%; text-align: center;">Categoria</th>
								<th style="width: 8%; text-align: center;">#</th>
								<th style="width: 8%; text-align: center;">#</th>
								
							</tr>
							
						</thead>
						
					</table>
					
				</div>
				
				<div class="tbl-content">
				
				<table>
					
					<tbody>
						
						<c:forEach items="${produtos}" var="produto">
						
							<tr>
								
								<td style="width: 8%;"><c:out value="${produto.id}"></c:out></td>				
								<td style="width: 30%;"><c:out value="${produto.descricao}"></c:out></td>				
								<td style="width: 8%;"><c:out value="${produto.quantidade}"></c:out></td>
								<td style="width: 10%;"><fmt:formatNumber type="currency" maxFractionDigits="2" value="${produto.valorcompra}"/></td>					
								<td style="width: 10%;"><fmt:formatNumber type="currency" maxFractionDigits="2" value="${produto.valoritem}"/></td>					
								<td style="width: 10%;"><c:out value="${produto.categoria}"></c:out></td>				
								
								<td style="width: 8%;"><a href="servletProduto?acao=update&produto=${produto.id}">
									<img alt="update" src="../resources/img/editar.png" title="Atualizar" 
									style="width: 20px; height: 20px;">
								</a></td>	
								
											
								<td style="width: 8%;"><a href="servletProduto?acao=delete&produto=${produto.id}">
									<img alt="delete" src="../resources/img/excluir.png" title="Excluir" 
									style="width: 20px; height: 20px;">
								</a></td>
								
							</tr>
					
						</c:forEach>
					
					</tbody>
					
				</table>
				
			</div>
		
		</section>
		
		
		
	<script type="text/javascript">

		$().ready(function() {
			setTimeout(function () {
				$('#mensagem').hide(); // "foo" é o id do elemento que seja manipular.
			}, 4000); // O valor é representado em milisegundos.
		});

	</script>

</body>

</html>