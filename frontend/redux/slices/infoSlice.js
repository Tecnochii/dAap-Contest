import { createSlice } from "@reduxjs/toolkit";


const initialState = {
    title : "Home"
}

export const infoSlice = createSlice({
    name: "info",
    initialState,
    reducers:{
        changeTitle: (state, {payload})=>{
            state.title = payload;
        }
    }
})


export const {changeTitle} = infoSlice.actions

