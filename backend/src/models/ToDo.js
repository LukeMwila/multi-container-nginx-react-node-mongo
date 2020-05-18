const { Schema, model } = require('mongoose');

const ToDoSchema = new Schema({
  item_name: {
    type: String,
    required: true
  },
  complete: {
    type: Boolean,
    default: false
  }
});

const ToDo = model('toDo', ToDoSchema);
module.exports = ToDo;