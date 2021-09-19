package com.example.beapp.generated.services;

import com.example.beapp.generated.models.*;
import com.example.beapp.generated.dtos.*;
import com.example.beapp.user.repositories.*;
import com.example.beapp.user.interfaces.${class.name}Interface;
import java.util.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * [${.now}]
 * This file was generated based on the template "${.current_template_name}".
 * Changes to this file may cause incorrect behavior and will be lost if the code is regenerated.
 */
@Service
public class ${class.name}BaseService implements ${class.name}Interface {
	
	@Autowired
	protected ${class.name}Repository ${class.name?uncap_first}Repository;

	<#list class.FMLinkedProperty as property>
	@Autowired
	protected ${property.name?cap_first}Repository ${property.name?uncap_first}Repository;
	</#list>
	
	@Override
	public ${class.name}DTO get(Long id) {
		Optional<${class.name}> ${class.name?uncap_first} = this.${class.name?uncap_first}Repository.findById(id);
		if(${class.name?uncap_first}.isPresent()) {
			return ${class.name?uncap_first}.get().toDTO();
		}

		return null;
	}
	
	@Override
	public List<${class.name}DTO> getAll() {
		ArrayList<${class.name}DTO> list = new ArrayList<>();
        ArrayList<${class.name}> tempList = (ArrayList<${class.name}>)${class.name?uncap_first}Repository.findAll();
        tempList.forEach(${class.name?uncap_first} -> {
            list.add(${class.name?uncap_first}.toDTO());
        });
        return list;
	}
	
	@Override
	public ${class.name}DTO create(${class.name}DTO ${class.name?uncap_first}DTO) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d/MM/yyyy");
		${class.name} ${class.name?uncap_first} = new ${class.name}(${class.name?uncap_first}DTO.getId()
		<#list properties as property>
		<#if property.type == "LocalDate">
		, LocalDate.parse(${class.name?uncap_first}DTO.get${property.name?cap_first}(), formatter)
		<#else>
		, ${class.name?uncap_first}DTO.<#if property.type == "Boolean">is<#else>get</#if>${property.name?cap_first}()
		</#if>
		</#list>
		<#list class.FMLinkedProperty as property>
		, ${property.type?uncap_first}Repository.get${property.type}ById(${class.name?uncap_first}DTO.get${property.name?cap_first}())
		</#list>
		);
		
		this.${class.name?uncap_first}Repository.save(${class.name?uncap_first});
		return ${class.name?uncap_first}.toDTO();
	}
	
	@Override
	public boolean delete(Long id) {
		${class.name}DTO ${class.name?uncap_first} = this.get(id);
		if (${class.name?uncap_first} != null) {
			this.${class.name?uncap_first}Repository.deleteById(id);
			
			return true;
		}
		
		return false;
	}
	
	@Override
	public ${class.name}DTO update(Long id, ${class.name}DTO ${class.name?uncap_first}) {
		${class.name}DTO old${class.name} = this.get(id);
		
		if(old${class.name} == null) {
			return null;
		}
		
		<#list properties as property>
  		old${class.name}.set${property.name?cap_first}(${class.name?uncap_first}.get${property.name?cap_first}());
		</#list>
		
		return this.create(old${class.name});

	}
}