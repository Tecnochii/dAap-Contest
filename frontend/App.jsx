import React from "react"
import Home from "./pages/Home.jsx"
/*
 * Connect2ic provides essential utilities for IC app development
 */
import { createClient } from "@connect2ic/core"
import { defaultProviders } from "@connect2ic/core/providers"
import { ConnectButton, ConnectDialog, Connect2ICProvider } from "@connect2ic/react"
import "@connect2ic/core/style.css"
/*
 * Import canister definitions like this:
 */
import * as calculator from "../.dfx/local/canisters/dia1"
/*
 * Some examples to get you started
 */
import { Route, Routes } from "react-router-dom"
import Calculator from "./pages/Calculator.jsx"
import { useSelector } from "react-redux"
import Nav from "./components/Nav/index.jsx"



function App() {
  const title = useSelector(store => store.info.title)


  return (
    <div className="App">

      <div className="auth-section">
        <ConnectButton />
      </div>
      <ConnectDialog />


      <header className="App-header">
        <Nav />

      </header>

      <div className="examples-title">
        <h1>{title}</h1>
      </div>

      <Routes>
        <Route path="*" element={<Home />} />
        <Route path="/calculator" element={<Calculator />}></Route>
        <Route path="/diarys"></Route>
        <Route path="/wall"></Route>
        <Route path="/motocoin"></Route>
        <Route path="/verifier"></Route>

      </Routes>





    </div>
  )
}

const client = createClient({
  canisters: {
    calculator
  },
  providers: defaultProviders,
  globalProviderConfig: {
    /*
     * Disables dev mode in production
     * Should be enabled when using local canisters
     */
    dev: import.meta.env.DEV,
  },
})

export default () => (
  <Connect2ICProvider client={client}>
    <App />
  </Connect2ICProvider>
)
