const {sequelize} = require ('sequelize')
const User = require('./models/User')(sequelize);
const sequelize = new Sequelize('postgres://postgres:1234cesar@localhost:5432/demo');


module.exports = {
    db: sequelize,
    User,
};

