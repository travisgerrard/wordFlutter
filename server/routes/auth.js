const express = require('express');
const bcryptjs = require('bcryptjs');
const User = require('../models/user');
const jwt = require('jsonwebtoken');

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
  try {
    // get data from client
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: 'User with same email already exists' });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      name,
    });

    user = await user.save();

    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post('/api/signin', async (req, res) => {
  try {
    // get data from client
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: 'User with the email does not exist' });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: 'Password is incorrect' });
    }

    const token = jwt.sign({ id: user._id }, 'passwordKey');

    console.log({ token, ...user._doc });
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post('/tokenIsValid', async (req, res) => {
  try {
    const token = req.header('x-auth-token');
    if (!token) return res.json(false);
    jwt.verify(token, 'passwordKey');
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
