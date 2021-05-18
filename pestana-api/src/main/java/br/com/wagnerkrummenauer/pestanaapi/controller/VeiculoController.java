package br.com.wagnerkrummenauer.pestanaapi.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.wagnerkrummenauer.pestanaapi.model.Veiculo;
import br.com.wagnerkrummenauer.pestanaapi.repository.VeiculoRepository;

@RestController
@RequestMapping({"/veiculo"})
public class VeiculoController {

	private VeiculoRepository repository;
	
	public VeiculoController(VeiculoRepository veiculoRepository) {
		this.repository = veiculoRepository;
	}
	
	@GetMapping
	public List<Veiculo> findAll() {
		return repository.findAll();
	}
	
	@GetMapping(path = {"/{id}"})
	public ResponseEntity findById(@PathVariable Long id) {
		return repository.findById(id)
				.map(record -> ResponseEntity.ok().body(record))
				.orElse(ResponseEntity.notFound().build());
	}
	
	@GetMapping(path = {"/pessoa/{idPessoa}"})
	public List<Veiculo> findByIdPessoa(@PathVariable Long idPessoa) {
		return repository.findByIdPessoa(idPessoa);
	}
	
	@PostMapping
	public Veiculo create(@RequestBody Veiculo veiculo) {
		return repository.save(veiculo);
	}
	
	@PutMapping(value = "/{id}")
	public ResponseEntity update(@PathVariable("id") long id, @RequestBody Veiculo veiculo) {
	   return repository.findById(id)
	           .map(record -> {
	        	   record.setIdPessoa(veiculo.getIdPessoa());
	        	   record.setMarca(veiculo.getMarca());
	        	   record.setModelo(veiculo.getModelo());
	        	   record.setPlaca(veiculo.getPlaca());
	        	   record.setAno(veiculo.getAno());
	               Veiculo updated = repository.save(record);
	               return ResponseEntity.ok().body(updated);
	           }).orElse(ResponseEntity.notFound().build());
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
