const ToDo = require('../models/ToDo');

const create = async (req, res, next) => {
  const toDoProps = req.body;
  try {
    const toDo = await ToDo.create(toDoProps);
    res.status(201).send(toDo);
  } catch (e) {
    next();
  }
};

const get = async (req, res, next) => {
  try {
    const toDo = await ToDo.find();
    res.status(200).send(toDo);
  } catch (e) {
    next();
  }
};

const getById = async (req, res, next) => {
  const toDoId = req.params.id;
  try {
    const toDo = await ToDo.findById({ _id: toDoId });
    res.status(200).send(toDo);
  } catch (e) {
    next();
  }
};

const edit = async (req, res, next) => {
  const toDoId = req.params.id;
  const toDoProps = req.body;
  try {
    await ToDo.findByIdAndUpdate({ _id: toDoId }, toDoProps);
    const toDo = await ToDo.findById({ _id: toDoId });
    res.status(200).send(toDo);
  } catch (e) {
    next();
  }
};

const deleteToDo = async (req, res, next) => {
  const toDoId = req.params.id;
  try {
    const toDo = await ToDo.findByIdAndRemove({ _id: toDoId });
    res.status(204).send(toDo);
  } catch (e) {
    next();
  }
};

const ToDoController = {
  create,
  get,
  getById,
  edit,
  deleteToDo
};

module.exports = ToDoController;