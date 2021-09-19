import {
  Button,
  Checkbox,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  FormControl,
  FormControlLabel,
  Input,
  InputLabel,
  ListItemText,
  MenuItem,
  Select,
  Switch,
  TextField,
  FormHelperText,
} from "@material-ui/core";
import { useFormik } from "formik";
import React, { VFC } from "react";
import * as yup from "yup";
import { ${class.name}PopupProps } from "../../interfaces/generated/${class.name}Props";
import * as types from "../../types/generated/types";

const validationSchema = yup.object({
  <#list properties as property>
  ${property.name}: yup.<#if property.type == "double" || property.type == "float">number<#elseif property.type == "String" || property.type == "LocalDate">string<#elseif property.type == "Boolean">boolean<#else>string</#if>().required("This field is required.")<#if property.type == "Integer" >.integer().required("This field is required.")</#if >,
  </#list>
  <#list class.FMLinkedProperty as property>
  ${property.name}: <#if property.upper != -1 >yup.number().required("This field is required"),<#else >yup.required("This field is required").array().of(
    yup.number(),),</#if >
  </#list>
});

const ITEM_HEIGHT = 48;
const ITEM_PADDING_TOP = 8;
const MenuProps = {
  PaperProps: {
    style: {
      maxHeight: ITEM_HEIGHT * 4.5 + ITEM_PADDING_TOP,
      width: 250,
    },
  },
};

const ${class.name}Popup: VFC<${class.name}PopupProps> = ({
  opened,
  ${class.name?uncap_first},
  <#list class.FMLinkedProperty as property>
  ${property.type?uncap_first}s,
  </#list>
  handleClose,
  handleOnSubmit,
}) => {
  const formik = useFormik({
    initialValues: {
      id: ${class.name?uncap_first} ? ${class.name?uncap_first}.id : 0,
      <#list properties as property>
      ${property.name}: ${class.name?uncap_first} ? ${class.name?uncap_first}.${property.name} : <#if property.type == "String" || property.type == "LocalDate">''<#elseif property.type == "Boolean" >false<#else>0</#if>,
      </#list>
      <#list class.FMLinkedProperty as property>
      ${property.name}: ${class.name?uncap_first} ? ${class.name?uncap_first}.${property.name} : <#if property.upper == 1 >undefined<#else >[]</#if >,
      </#list>
    },
    validationSchema: validationSchema,
    onSubmit: (values) => {
      handleOnSubmit(values);
    },
  });
  return (
    <Dialog open={opened} onClose={() => handleClose()} scroll={"paper"}>
      <form onSubmit={formik.handleSubmit}>
        <DialogTitle>${class.name}</DialogTitle>
        <DialogContent>
        <#list properties as property>
        <#if property.type == "String" || property.type == "Integer" || property.type == "double" || property.type == "float" || property.type == "LocalDate">
        <TextField
            fullWidth
            <#if property.type == "Integer" || property.type == "double" || property.type == "float" >
            type="number"
            </#if>
            error={formik.touched.${property.name} && Boolean(formik.errors.${property.name})}
            name="${property.name}"
            label="${property.name?cap_first}"
            placeholder="${property.name?cap_first}"
            value={formik.values.${property.name} }
            autoComplete="off"
            helperText={formik.touched.${property.name} && formik.errors.${property.name} }
            onChange={formik.handleChange}
        />
        <#else>
        <FormControlLabel
            control={
            <Switch
                checked={formik.values.${property.name} }
                onChange={formik.handleChange}
                name="${property.name}"
                color="primary"
            />
            }
            label="${property.name?cap_first}"
        />
        </#if>
        </#list>
        <#list class.FMLinkedProperty as property>
        <#if property.upper == -1 >
        <FormControl fullWidth>
            <InputLabel>${property.name?cap_first}</InputLabel>
            <Select
            fullWidth
            name="${property.name}"
            id="${property.name}"
            multiple
            value={formik.values.${property.name} }
            onChange={formik.handleChange}
            input={<Input />}
            renderValue={(selected) => (selected as string[]).join(', ')}
            MenuProps={MenuProps}
            >
            { ${property.type?uncap_first}s.map((${property.type?uncap_first}) => (
                <MenuItem key={ ${property.type?uncap_first}.id} value={ ${property.type?uncap_first}.id}>
                <Checkbox checked={formik.values.${property.name}.includes(${property.type?uncap_first}.id)} />
                <ListItemText primary={ ${property.type?uncap_first}.id} />
                </MenuItem>
            ))}
            </Select>
        </FormControl>
        <#else>
        <FormControl fullWidth>
            <InputLabel>${property.name?cap_first}</InputLabel>
            <Select
            value={formik.values.${property.name} }
            onChange={formik.handleChange}
            name="${property.name}"
            >
            <MenuItem value={0}>
                <em>None</em>
            </MenuItem>
            { ${property.type?uncap_first}s.map((${property.type?uncap_first}) => (
                <MenuItem key={ ${property.type?uncap_first}.id} value={ ${property.type?uncap_first}.id}>
                { ${property.type?uncap_first}.id}
                </MenuItem>
            ))}
            </Select>
            <FormHelperText>Error</FormHelperText>
        </FormControl>
        </#if>
        </#list>
        </DialogContent>
        <DialogActions>
         <Button onClick={() => handleClose()}>
            Cancel
          </Button>
          <Button type="submit" color="primary">
            Submit
          </Button>
        </DialogActions>
      </form>
    </Dialog>
  );
};

export default ${class.name}Popup;
