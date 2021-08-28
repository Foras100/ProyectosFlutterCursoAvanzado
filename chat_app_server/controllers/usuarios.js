const { response } = require("express");
const Usuario = require("../models/usuario");


const getUsuarios = async (req, res = response) => {

    const desde = Number(req.query.desde) || 0;
    //const hasta = Number(req.query.hasta) || 20;

    const usuarios = await Usuario
        .find({ _id: {$ne: req.uid} }) //Filtro todos los usuario que no son el que realiza la peticion
        .sort('-online') //Esto lo ordena de forma descendiente
        .skip(desde) //Paginacion
        .limit(20);

    res.json({
        ok: true,
        usuarios
    });
};

module.exports = {
    getUsuarios
};