import React, { useEffect } from "react";
import { useDispatch } from "react-redux";
import { changeTitle } from "../redux/slices/infoSlice";
import Card from "../components/Card";


const Home = () =>{

        const dispatch = useDispatch()

    useEffect(() => {
        dispatch(changeTitle("Home"))
    }, [])

    return (
        <>
            <Card/>

        </>
    )
}


export default Home;