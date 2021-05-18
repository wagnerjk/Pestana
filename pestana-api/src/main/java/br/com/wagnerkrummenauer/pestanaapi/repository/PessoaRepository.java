package br.com.wagnerkrummenauer.pestanaapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.wagnerkrummenauer.pestanaapi.model.Pessoa;

public interface PessoaRepository extends JpaRepository<Pessoa, Long> {

}
