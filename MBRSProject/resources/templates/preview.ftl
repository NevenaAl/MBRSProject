import {
  Button,
  Card,
  CardContent,
  CardHeader,
  makeStyles,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
} from "@material-ui/core";
import React, { Fragment, useEffect, useState, VFC } from "react";
import ${class.name}Popup from "../../components/generated/${class.name}Popup";
import * as types from "../../types/generated/types";
import { getAll, add, update, deleteOne } from "../../services/generated/${class.name}Service";

<#list  class.FMLinkedProperty as property>
import { getAll as getAll${property.type}s } from "../../services/generated/${property.type}Service";
</#list>

const useStyles = makeStyles((theme) => ({
  card: {
    margin: theme.spacing(4),
  },
}));

const ${class.name}s: VFC = () => {
  const [${class.name?uncap_first}s, set${class.name}s] = useState<types.${class.name}[]>([]);
  const [${class.name?uncap_first}, set${class.name}] = useState<types.${class.name} | undefined>();
  const [openedAdd, setOpenedAdd] = useState(false);
  const [openedEdit, setOpenedEdit] = useState(false);
  const [editedList, setEditedList] = useState(false);
  <#list  class.FMLinkedProperty as property>
  const [${property.type?uncap_first}s, set${property.type}s] = useState<types.${property.type}[]>();
  </#list>

  const classes = useStyles();

  const handleCloseAdd = () => {
    setOpenedAdd(false);
  };

  const handleCloseEdit = () => {
    setOpenedEdit(false);
  };

  const handleOnAddSubmit = (value: types.${class.name}) => {
    add(value).then(
      response => {
        setEditedList(!editedList);
        setOpenedAdd(false);
      },
      error => {
        console.log(error);
      }
    )
  };

  const handleOnEditSubmit = (value: types.${class.name}) => {
    update(value).then(
      response => {
        setEditedList(!editedList);
        setOpenedEdit(false);
      },
      error => {
        console.log(error);
      }
    )
  };

  const handleOnDelete = (id: number) => {
    deleteOne(id).then(
      response => {
        setEditedList(!editedList);
      },
      error => {
        console.log(error);
      }
    )
  };

  const handleOnEdit = (value: types.${class.name}) => {
    set${class.name}(value);
    setOpenedEdit(true);
  };

  const handleOnAdd = () => {
    setOpenedAdd(true);
  };

  useEffect(() => {
    getAll().then(
        response =>{
           set${class.name}s(response.data);
      },
      error => {
        console.log(error);
      }
    )
    <#list  class.FMLinkedProperty as property>
    getAll${property.type}s().then(
      response => {
        set${property.type}s(response.data);
      },
      error => {
        console.log(error);
      }
    )
    </#list>
  }, [editedList]);

  return (
    <Fragment>
      {openedAdd && <#list  class.FMLinkedProperty as property>
  ${property.type?uncap_first}s !== undefined &&
  </#list>(
        <${class.name}Popup
          opened={openedAdd}
          handleClose={handleCloseAdd}
          handleOnSubmit={handleOnAddSubmit}
          ${class.name?uncap_first}={undefined}
          <#list  class.FMLinkedProperty as property>
          ${property.type?uncap_first}s = { ${property.type?uncap_first}s }
          </#list>
        />
      )}
      {openedEdit && ${class.name?uncap_first} !== undefined && <#list  class.FMLinkedProperty as property>
  ${property.type?uncap_first}s !== undefined && </#list>(
        <${class.name}Popup
          opened={openedEdit}
          handleClose={handleCloseEdit}
          handleOnSubmit={handleOnEditSubmit}
          ${class.name?uncap_first}={ ${class.name?uncap_first} }
          <#list  class.FMLinkedProperty as property>
          ${property.type?uncap_first}s = { ${property.type?uncap_first}s }
          </#list>
        />
      )}
      <Card className={classes.card}>
        <CardHeader
          title="${class.name}s"
          action={<Button onClick={() => handleOnAdd()}>Add</Button>}
        />
        <CardContent>
          <TableContainer>
            <Table>
              <TableHead>
                <TableRow>
                <#list properties as property>
                <TableCell align="left">
                    <b>${property.name?cap_first}</b>
                  </TableCell>
                </#list>
                  <TableCell></TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                { ${class.name?uncap_first}s.map((${class.name?uncap_first}) => {
                  return (
                    <TableRow key={ ${class.name?uncap_first}.id}>
                      <#list properties as property>
                        <TableCell align="left">
                            <TableCell>
                              { ${class.name?uncap_first}.${property.name} }
                            </TableCell>
                        </TableCell>
                        </#list>
                      <TableCell>
                        <Button onClick={() => handleOnEdit(${class.name?uncap_first})}>Edit</Button>
                        <Button onClick={() => handleOnDelete(${class.name?uncap_first}.id)}>Delete</Button>
                      </TableCell>
                    </TableRow>
                  );
                })}
              </TableBody>
            </Table>
          </TableContainer>
        </CardContent>
      </Card>
    </Fragment>
  );
};

export default ${class.name}s;
