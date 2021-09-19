package com.example.demo.generated.dtos;

import lombok.Data;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.List;
import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ${class.name}DTO {
    private Long id;
    <#list properties as property>
    <#if property.type == "LocalDate">
    private String ${property.name};
    <#else>
    private ${property.type} ${property.name};
    </#if>
    </#list>
    <#list class.FMLinkedProperty as property>
    private <#if property.upper == 1>Long<#else>List<Long></#if> ${property.name};
    </#list>
}