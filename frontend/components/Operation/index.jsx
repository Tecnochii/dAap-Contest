import { useCanister } from "@connect2ic/react"
import React from "react"
import { useState } from "react"
import { useDispatch, useSelector } from "react-redux"
import { changeTotalCounter } from "../../redux/slices/counterSlice"
import { useEffect } from "react"

const Operation = ({ title, operation }) => {


    let total = useSelector((store) => store.counter.total)


    const dispatch = useDispatch()
    const [calculator] = useCanister("calculator")
    const [number, setNumbers] = useState(0)



    const calc = async (num) => {


        switch (operation) {

            case "add":
                refreshCounter(await calculator.add(num))
                break;
            case "sub":
                refreshCounter(await calculator.sub(num))
                break;
            case "div":
                refreshCounter(await calculator.div(num))
                break;
            case "mul":
                refreshCounter(await calculator.mul(num))
                break;
            case "pow":
                refreshCounter(await calculator.power(num))
                break;
            case "sqrt":
                refreshCounter(await calculator.sqrt())
                break;
            case "floor":
                refreshCounter(parseFloat(await calculator.floor()))
                break;
                default:
                refreshCounter(await calculator.reset())
                break;
        }

    }


    const refreshCounter = async (num1) => {

        dispatch(changeTotalCounter(num1)) 
    }

    const handleNumber = (e) => {
        setNumbers(e.target.value)
    }
  

    useEffect(() => {
    }, [])

    return (

        <>
            <div className="calculator-operation">
                   <div >
                <h2>{title}</h2>

                {  operation == "sqrt" || operation == "floor" || !operation? 
                <></>:
                <label>
                    <input type="number" name="number1" id="" onChange={handleNumber} />
                </label>

                }
                
            </div>
            <button onClick={() => calc(parseFloat(number))}>{title}</button> 
            </div>
        
        </>
    )
}

export default Operation;