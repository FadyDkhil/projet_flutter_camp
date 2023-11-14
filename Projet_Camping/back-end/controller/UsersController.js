const User = require('../models/Users.js');

const getAllUsers = async (req, res) => {
    try {
        const users = await User.find({});
        res.status(200).json({ users });
    } catch (err) {
        res.status(500).json({ msg: err });
    }
};

const addUser = async (req, res) => {
    try {
        const user = await User.create(req.body);
        res.status(201).json({ user });
    } catch (err) {
        res.status(500).json({ msg: err });
    }
};

const getUserName = async (req, res) => {
    try {
        // Assuming you have the user ID in the request params
        const userId = req.params.userId; // Replace with your actual way of getting the user ID

        // Query the database to get the user by ID
        const user = await User.findById(userId);

        if (user) {
            // Send the user's name as JSON response
            res.json({ userName: user.name });
        } else {
            res.status(404).json({ error: 'User not found' });
        }
    } catch (error) {
        console.error(error); // Log the error to the console
        res.status(500).json({ error: 'Internal Server Error' });
    }
};


module.exports = {
    getAllUsers,
    addUser,
    getUserName,
};
