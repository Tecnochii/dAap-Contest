import React, { useEffect, useState } from "react";
import { useCanister } from "@connect2ic/react"
import { useDispatch, useSelector } from "react-redux";
import Operation from "../components/Operation";
import { changeTotalCounter } from "../redux/slices/counterSlice";
import { changeTitle } from "../redux/slices/infoSlice";


const Calculator = () => {
    let total = useSelector((store) => store.counter.total)

    const [calculator] = useCanister("calculator")
    const dispatch = useDispatch()

    const loadCounter = async () => {
        dispatch(changeTotalCounter(await calculator.see()))

    }



    useEffect(() => {
        loadCounter()
        dispatch(changeTitle("Calculator"))
    }, [])

    return (

        <>

            <div className="calculator-container">

                <div >
                    <h2>Total</h2>
                    <p className="calculator-counter">{total}</p>
                    <div className="operations">
                        <div className="first-column">
                            <div>
                                <Operation title={"Add"} operation={"add"} />
                            </div>
                            <div>
                                <Operation title={"Sub"} operation={"sub"} />
                            </div>
                            <div>
                                <Operation title={"Divide"} operation={"div"} />
                            </div>
                        </div>
                        <div className="second-column">
                            <div>
                                <Operation title={"Multiply"} operation={"mul"} />
                            </div>
                            <div>
                                <Operation title={"Root"} operation={"sqrt"} />
                            </div>
                            <div>
                                <Operation title={"Floor"} operation={"floor"} />
                            </div>
                        </div>
                        <div className="third-column">
                            <div>
                                <Operation title={"Power"} operation={"pow"} />
                            </div>
                            <div>
                                <Operation title={"Reset"} />
                            </div>
                        </div>

                    </div>
                </div>

            </div>

        </>
    )
}


export default Calculator;