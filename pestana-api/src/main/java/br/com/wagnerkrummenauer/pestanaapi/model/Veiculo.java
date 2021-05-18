package br.com.wagnerkrummenauer.pestanaapi.model;

import javax.persistence.Entity;

import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

@Entity
public class Veiculo {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="veiculo_id")
	private Long id;
	@Column(name="pessoa_id")
	private Long idPessoa;
	private String marca;
	private String modelo;
	private String placa;
	private int ano;
	
}
