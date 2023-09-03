import logo from "./logo.svg";
import "./App.css";
import { useState } from "react";

const ServerStatus = Object.freeze({
  OFFLINE: Symbol("offline"),
  ONLINE: Symbol("online"),
});

function App() {
  const [serverStatus, setServerStatus] = useState(ServerStatus.OFFLINE);
  setInterval(async () => {
    try {
      const res = await fetch(process.env.REACT_APP_BACKEND_URL);
      const resData = await res.json();
      if (resData.msg === "healthy") setServerStatus(ServerStatus.ONLINE);
      else setServerStatus(ServerStatus.OFFLINE);
    } catch (error) {
      setServerStatus(ServerStatus.OFFLINE);
    }
  }, 2000);
  return (
    <section className="section">
      <div className="container has-text-centered">
        <img src={logo} className="logo" alt="logo" />
        <div className="backendText my-6 is-size-2 has-text-white">
          The backend is:
          {serverStatus === ServerStatus.OFFLINE ? (
            <span className="mx-1	has-background-danger">Offline</span>
          ) : (
            <span className="mx-1	has-background-success">Online</span>
          )}
        </div>
      </div>
    </section>
  );
}

export default App;
