import { configureStore } from "@reduxjs/toolkit";
import { counterSlice } from "./slices/counterSlice";
import { infoSlice } from "./slices/infoSlice";

export const store = configureStore({
    reducer:{
        counter: counterSlice.reducer,
        info: infoSlice.reducer  
    }
})