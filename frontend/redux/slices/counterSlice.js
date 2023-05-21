import { createSlice } from "@reduxjs/toolkit";

const initialState = {
    total: 0
}

export const counterSlice = createSlice({
    name: "counter",
    initialState,
    reducers: {
        changeTotalCounter: (state, { payload }) => {
            if (!payload) {
                state.total = 0;
            } else {
                state.total = payload;
            }

        }
    }
})


export const { changeTotalCounter } = counterSlice.actions

