const {User} = require('./db');

(async () => {
        await User.sync();
})