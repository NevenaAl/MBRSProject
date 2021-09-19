import axios, { AxiosResponse } from "axios";
import * as types from "../../types/generated/types";

var path=process.env.REACT_APP_API + '/api/${class.name}s';

export const getAll = ():Promise<AxiosResponse<any>> => {
    return axios.get(path);
}

export const getOne = (id: number):Promise<AxiosResponse<any>> => {
    return axios.get(path + '/' + id);
}

export const add = (${class.name?uncap_first}: types.${class.name}):Promise<AxiosResponse<any>> => {
    return axios.post(path ,${class.name?uncap_first});
}

export const update = (${class.name?uncap_first}: types.${class.name}):Promise<AxiosResponse<any>> => {
    return axios.put(path,${class.name?uncap_first});
}

export const deleteOne = (id: number):Promise<AxiosResponse<any>> => {
    return axios.delete(path + '/' + id);
}