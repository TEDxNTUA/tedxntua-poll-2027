'use client'
import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";

export default function Phase2() {
    const router = useRouter();
    const [options, setOptions] = useState([]);
    const [finalChoice, setFinalChoice] = useState("");

    function handleSubmit() {
        sessionStorage.setItem("finalChoice", JSON.stringify(finalChoice));
        router.push("/phase3");
    }

    useEffect(() => {
        const saved = sessionStorage.getItem("selected");

        if (saved) {
            setOptions(JSON.parse(saved));
        }
    }, []);

    return (
        <main className="min-h-screen flex items-center justify-center p-4">
            <div className="w-full max-w-xl rounded-2xl bg-[oklch(57.7%_0.245_27.325)] p-8 shadow-xl">

                <h2 className="text-xl font-bold">
                    Επιλέξτε το αγαπημένο σας θέμα
                </h2>

                <div className="flex flex-col gap-3 p-2 mt-4">
                    {options.map((opt) => (
                        <label key={opt} className="flex items-center gap-2">
                            <input
                                type="radio"
                                name="finalChoice"
                                value={opt}
                                checked={finalChoice === opt}
                                onChange={() => setFinalChoice(opt)}
                            />
                            <span lang="en">{opt}</span>
                        </label>
                    ))}
                </div>

                <p className="mt-4">
                    Επιλεγμένο θέμα: {finalChoice ? <span lang="en">{finalChoice}</span> : "Κανένα"}
                </p>
                <div className="flex justify-center">
            <button onClick={handleSubmit} className="bg-black text-white py-2 px-6 w-fit hover:bg-[oklch(27.1%_0.105_12.094)] active:bg-[oklch(27.1%_0.105_12.094)] font-bold hover:scale-105 transition-all duration-300" type="button">
              <span lang="en">Submit</span>
            </button>
          </div>

            </div>
        </main>
    );
}
