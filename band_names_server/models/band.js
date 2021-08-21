const {v4:uuidV4} = require('uuid');


class Band{

    constructor(name = 'no_name'){

        this.id = uuidV4(); //Crea identificador unico
        this.name = name;
        this.votes = 0;
    }
}

module.exports = Band;