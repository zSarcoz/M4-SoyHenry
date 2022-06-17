const { Model, DataTypes } = require("sequelize");

class User extends Model {}

module.exports = (sequelize) => {
    return User.init({
        firstName: {
            type: DataTypes.STRING(40),
        },
        lastName: {
            type: DataTypes.STRING(40),
        },
        email: {
            type: DataTypes.STRING(100),
        },
    }, { sequelize, tableName: "user" });
};