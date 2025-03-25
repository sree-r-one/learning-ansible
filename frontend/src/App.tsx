import React, { useEffect, useState } from "react";

const App = () => {
  const [message, setMessage] = useState<string>("Loading...");

  useEffect(() => {
    const API_URL = import.meta.env.VITE_API_URL;

    fetch(`${API_URL}/hello`)
      .then((res) => res.json())
      .then((data) => {
        setMessage(data.message || "Received response");
      })
      .catch((err) => {
        console.error(err);
        setMessage("Error contacting backend");
      });
  }, []);

  return (
    <div>
      <h1>Hello from Vite + React + TypeScript</h1>
      <p>Backend says: {message}</p>
    </div>
  );
};

export default App;
