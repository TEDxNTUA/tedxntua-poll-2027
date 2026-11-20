'use client'
import { useState, useEffect } from "react";

export default function Phase3() {
    const [winner, setWinner] = useState("");

    useEffect(() => {
        const saved = sessionStorage.getItem("finalChoice"); 
        if (saved) {
            setWinner(JSON.parse(saved));
        }
    }, []);
    return (
        <main className="min-h-screen flex items-center justify-center p-4">
            <div className="w-full max-w-xl rounded-2xl bg-[oklch(57.7%_0.245_27.325)] p-8 shadow-xl">
                <h2 className="text-xl font-bold">Το αγαπημένο θέμα για το TEDxNTUA 2027 είναι:</h2>
                <p className="mt-4 text-lg">{winner ? <span lang="en">{winner}</span> : "Κανένα"}</p>
            </div>
        </main>
    );
}