import React from 'react';
import './App.css';

function App() {
  const [toDoItems, updateToDoItems] = React.useState([]);

  React.useEffect(() => {
    const getToDoItems = async () => {
      const response = await fetch(
        `/backend/v1/to-do`
      );

      const items = await response.json();
      if (items && Array.isArray(items) && items.length) {
        updateToDoItems(items);
      }
    };
    getToDoItems();
  }, []);

  return (
    <div>
      {toDoItems && toDoItems.length
        ? toDoItems.map((item, i) => {
            return (
              <div key={i}>
                {`${item.item_name}`}
                <br />
              </div>
            );
          })
        : 'No items to be done'}
    </div>
  );
}

export default App;
