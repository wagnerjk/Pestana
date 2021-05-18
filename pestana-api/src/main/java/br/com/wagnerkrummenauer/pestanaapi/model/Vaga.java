package br.com.wagnerkrummenauer.pestanaapi.model;

import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

@Entity
public class Vaga {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="vaga_id")
	private Long id;
	@Column(name="veiculo_id")
	private Long idVeiculo;
	
}
