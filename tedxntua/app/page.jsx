'use client'
import { useState } from "react";
import { useRouter } from "next/navigation";


export default function Home() {
  const options = ["Moires", "Anisotropia", "Reflect", "Cycle 0", "Synelixis"]
  const [selected, setSelected] = useState([])
  const router = useRouter()

  function handleSubmit() {
    sessionStorage.setItem("selected", JSON.stringify(selected));
    router.push("/waiting1_2");
  }

  function checkboxHandler(opt) {
    setSelected((s)=>{
      if (s.includes(opt)) {
        return s.filter(i => i !== opt)
      }
      if(s.length >=3) {
        return s
      }

      return [...s, opt]
    })
  }


  return (
    <>
      <main className="min-h-screen flex items-center justify-center p-4"><div className="w-full max-w-xl rounded-2xl bg-[oklch(57.7%_0.245_27.325)] p-8 shadow-xl">
        <h2 className="text-xl font-bold">Επιλέξτε θέμα για το TEDxNTUA 2027 (εώς 3 επιλογές)</h2>
        <div className="flex flex-col p-2">
          {options.map((opt) => (
            <label key={opt}>
              <input type="checkbox" checked={selected.includes(opt)} onChange={() => checkboxHandler(opt)} />
              <span lang="en" className="pl-1">{opt}</span>
            </label>
          ))}
          <br/>
          <p className="mt-2 mb-3">Επιλεγμένα θέματα: {selected.length}</p>
          <br/>
          <div className="flex justify-center">
            <button onClick={handleSubmit} className="bg-black text-white py-2 px-6 w-fit hover:bg-[oklch(27.1%_0.105_12.094)] active:bg-[oklch(27.1%_0.105_12.094)] font-bold hover:scale-105 transition-all duration-300" type="button">
              <span lang="en">Submit</span>
            </button>
          </div>
        </div>
      </div></main>
    </> 
  );
}
