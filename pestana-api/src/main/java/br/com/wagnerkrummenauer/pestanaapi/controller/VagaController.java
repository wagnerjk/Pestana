package br.com.wagnerkrummenauer.pestanaapi.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.wagnerkrummenauer.pestanaapi.model.Vaga;
import br.com.wagnerkrummenauer.pestanaapi.repository.VagaRepository;

@RestController
@RequestMapping({"/vaga"})
public class VagaController {

private VagaRepository repository;
	
	public VagaController(VagaRepository vagaRepository) {
		this.repository = vagaRepository;
	}
	
	@GetMapping
	public List<Vaga> findAll() {
		return repository.findAll();
	}
	
	@GetMapping(path = {"/{id}"})
	public ResponseEntity findById(@PathVariable Long id) {
		return repository.findById(id)
				.map(record -> ResponseEntity.ok().body(record))
				.orElse(ResponseEntity.notFound().build());
	}
	
	@GetMapping("/listardados")
	public List<Object[]> listarDadosVagas() {
		return repository.listarDadosVagas();
	}
	
	@PostMapping
	public Vaga create(@RequestBody Vaga vaga) {
		return repository.save(vaga);
	}
	
	@DeleteMapping(path = {"/{id}"})
	public ResponseEntity<?> delete (@PathVariable Long id){
		return repository.findById(id)
				.map(record -> {
					repository.deleteById(id);
					return ResponseEntity.ok().build();
				}).orElse(ResponseEntity.notFound().build());
	}
}
