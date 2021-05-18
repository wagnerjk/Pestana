package br.com.wagnerkrummenauer.pestanaapi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import br.com.wagnerkrummenauer.pestanaapi.model.Vaga;

public interface VagaRepository extends JpaRepository<Vaga, Long> {
	
	@Query(
			value = "SELECT va.vaga_id, p.nome, p.apartamento, p.telefone, ve.veiculo_id, ve.marca, ve.modelo " + 
					"FROM vaga va " + 
					"INNER JOIN veiculo ve ON ve.veiculo_id = va.veiculo_id " + 
					"INNER JOIN pessoa p ON p.pessoa_id = ve.pessoa_id " + 
					"ORDER BY va.vaga_id", nativeQuery = true
	)
	List<Object[]> listarDadosVagas();

}
