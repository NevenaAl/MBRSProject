package com.example.beapp.generated.interfaces;

import com.example.beapp.generated.dtos.${class.name}DTO;

import java.util.*;

public interface ${class.name}BaseInterface {
    ${class.name}DTO get(Long id);
    List<${class.name}DTO> getAll();
    ${class.name}DTO create(${class.name}DTO ${class.name?uncap_first});
    ${class.name}DTO update(Long id, ${class.name}DTO ${class.name?uncap_first});
    boolean delete(Long id);
} 