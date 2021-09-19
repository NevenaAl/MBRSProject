<#list classes as class>
    export type ${class.name} = {
        id: number,
        <#list allProperties?keys as k>
            <#if k == class.name>
            <#list allProperties[k] as property>
            ${property.name}: <#if property.type == "Integer" || property.type == "double">number<#elseif property.type == "String">string<#elseif property.type == "Boolean">boolean<#else>string</#if>,
            </#list>
            </#if>
        </#list>
        <#list class.FMLinkedProperty as property>
            <#if property.upper == -1>
            ${property.name}: number[],
            <#else>
            ${property.name}?: number,
            </#if>
        </#list>
    }
</#list>