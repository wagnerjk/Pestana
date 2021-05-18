package br.com.wagnerkrummenauer.pestanaapi.model;

import javax.persistence.Entity;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDate;

import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

@Entity
public class Pessoa {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="pessoa_id")
	private Long id;
	private String nome;
	private String cpf;
	private int apartamento;
	@Column(name="data_nascimento", columnDefinition = "DATETIME")
	@JsonFormat(pattern = "yyyy-MM-dd",locale = "pt-BR")
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
	private LocalDate dataNascimento;
	private String telefone;
	
}
