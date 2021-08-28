const { comprobarJWT } = require('../helpers/jwt');
const {io} = require('../index');
const { usuarioConectado, usuarioDesconectado, grabarMensaje } = require('../controllers/socket');
const usuario = require('../models/usuario');

//Sockets
io.on('connection', async client => {
    //console.log(client.handshake.headers['x-token']);
    const [valido, uid] = comprobarJWT(client.handshake.headers['x-token']);

    //Verificar autenticación
    if(!valido) { return client.disconnect(); }

    //Cliente autenticado
    await usuarioConectado(uid);

    //Ingresar el usuario a una sala en particular
    //Sala global, client.id, 
    client.join(uid);

    //Escuchar del cliente el mensaje personal (chat)
    client.on('mensaje-personal', async (payload) => {
        //TODO: grabar mensaje en bdd
        await grabarMensaje(payload);
        io.to(payload.para).emit('mensaje-personal', payload);
    });


    client.on('disconnect', () => {
        usuarioDesconectado(uid);
    });

  });