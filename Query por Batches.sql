declare @controle int;
declare @quantidade int;
declare @identidade int;

set @controle = 1; -- irá armazenar o @@rowcount após sucesso
set @quantidade = 1000000; --quantidade de linhas a ser processada
set @identidade = 0; -- identity atual

while (@controle > 0)
begin

  begin try
  
  	begin tran

	--<ações>
	-- where <restrições>
	--   and id > @identidade
	--   and id <= @identidade + @quantidade
	
	commit tran
  
  end try
  
  begin catch

  	if @@trancount >= 1
	begin
	
	  print error_message()
	  rollback tran
	
	end
  	
	throw;
	
  end catch
  
  set @controle = @@rowcount
  set @identidade = @identidade + @quantidade
end