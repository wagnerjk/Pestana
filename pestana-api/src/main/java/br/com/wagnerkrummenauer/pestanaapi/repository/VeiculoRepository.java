package br.com.wagnerkrummenauer.pestanaapi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.wagnerkrummenauer.pestanaapi.model.Veiculo;

public interface VeiculoRepository extends JpaRepository<Veiculo, Long> {

	List<Veiculo> findByIdPessoa(Long id);
	
}
