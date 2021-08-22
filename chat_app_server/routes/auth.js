/*
path: api/login

*/

const { Router } = require('express');
const { check } = require('express-validator');
const { crearUsuario, login, renewToken } = require('../controllers/auth');
const { validarCampos } = require('../middlewares/validar-campos');
const { validarJWT } = require('../middlewares/validar-jwt');
const router = Router();

//Configuramos la srutas
router.post('/new',[
    check('nombre','El nombre es obligatrio').not().isEmpty(),
    check('email','El email es obligatorio').not().isEmpty(),
    check('email','Formato de email incorrecto').isEmail(),
    check('password','La contraseña es obligatoria').not().isEmpty(),
    check('password','La contraseña debe tener al menos 6 carcteres').isLength({ min: 6 }),
    validarCampos,
], crearUsuario);

//Post: /
//Validar email y pass
router.post('/',[
    check('email','El email es obligatorio').not().isEmpty(),
    check('email','Formato de email incorrecto').isEmail(),
    check('password','La contraseña es obligatoria').not().isEmpty(),
    validarCampos
], login);

router.get('/renew', validarJWT, renewToken);

module.exports = router;