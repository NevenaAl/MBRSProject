package com.example.demo.generated.repositories;

import com.example.demo.generated.models.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository
public interface ${class.name}BaseRepository extends JpaRepository<${class.name}, Long> {
    ${class.name} get${class.name}ById(Long id);
}