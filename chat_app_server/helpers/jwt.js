const jwt = require('jsonwebtoken');

const generarJWT = (uid) => {

    return new Promise((resolve, reject) => {
        const payload = { uid };
        jwt.sign(payload, process.env.jwt_key,{
            expiresIn: '24H'
        }, (err, token) => {
            if(err){
                //no se pudo crear el token
                reject('No se pudo generar el JWT');
            }
            else{
                //Token!!
                resolve(token);
            }
        });
    });
};

module.exports = {
    generarJWT
};