import React from "react";
import { AppBar, makeStyles, Tab, Tabs } from "@material-ui/core";
import { Link, Route, useLocation, Switch } from "react-router-dom";
import Home from "../Home/Home";

<#list classes as class>
import ${class.name}s from "../../containers/generated/${class.name}Preview";
</#list>

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
    width: "100%",
    height:"100vh"
  },
}));

const NavBar: React.VFC = () => {
  const location = useLocation();
  const classes = useStyles();

  return (
    <React.Fragment>
      <div className={classes.root}>
        <AppBar position="sticky" style={{background:"#121232"}}>
          <Tabs
            value={location.pathname}
            variant="scrollable"
            scrollButtons="auto"
          >
            <Tab label="Home" component={Link} to="/" value="/" />
            <#list classes as class>
            <Tab label="${class.name}s" component={Link} to="/${class.name?uncap_first}s" value="/${class.name?uncap_first}s" />
            </#list>
          </Tabs>
        </AppBar>
        <Switch>
          <Route exact path="/" component={Home} />
          <#list classes as class>
          <Route path="/${class.name?uncap_first}s" component={ ${class.name}s } />
          </#list>
        </Switch>
      </div>
    </React.Fragment>
  );
};

export default NavBar;
