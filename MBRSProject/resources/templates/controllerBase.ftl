package com.example.beapp.generated.controllers;

import com.example.beapp.user.services.${class.name}Service;
import com.example.beapp.generated.models.${class.name};
import com.example.beapp.generated.dtos.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

public class ${class.name}BaseController {

    @Autowired
    private ${class.name}Service ${class.name?uncap_first}Service;

    @GetMapping(value="/{id}", produces = "application/json")
    public ResponseEntity<?> get${class.name}(@PathVariable Long id) {
        return new ResponseEntity<>(${class.name?uncap_first}Service.get(id), HttpStatus.OK);
    }

    @GetMapping(produces = "application/json")
    public ResponseEntity<?> getAll${class.name}s() {
        return new ResponseEntity<>(${class.name?uncap_first}Service.getAll(), HttpStatus.OK);
    }

    @PostMapping(consumes = "application/json")
    public ResponseEntity<?> create${class.name}(@RequestBody ${class.name}DTO ${class.name?uncap_first}DTO) {
        return new ResponseEntity<>(${class.name?uncap_first}Service.create(${class.name?uncap_first}DTO), HttpStatus.CREATED);
    }

    @PutMapping(consumes = "application/json")
    public ResponseEntity<?> update${class.name}(@RequestBody ${class.name}DTO ${class.name?uncap_first}DTO) {
        return new ResponseEntity<>(${class.name?uncap_first}Service.update(${class.name?uncap_first}DTO.getId(), ${class.name?uncap_first}DTO), HttpStatus.OK);
    }

    @DeleteMapping(value="/{id}")
    public ResponseEntity<?> delete${class.name}(@PathVariable Long id) {
        ${class.name?uncap_first}Service.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}