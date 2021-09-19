import * as types from "../../types/generated/types";

export interface ${class.name}PopupProps {
    opened: boolean, 
    ${class.name?uncap_first}: types.${class.name} | undefined,
    <#list class.FMLinkedProperty as property>
        ${property.type?uncap_first}s: types.${property.type}[],
    </#list>
    handleClose: () => void, 
    handleOnSubmit: (${class.name?uncap_first}: types.${class.name}) => void
}