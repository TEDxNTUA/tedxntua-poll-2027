'use client'
import { useRouter } from "next/navigation";
import { useState, useEffect } from "react";

export default function Waiting1_2() {

    const router = useRouter();

    const targetDate = new Date(2026, 10, 20, 20, 30, 0);

    const [timeLeft, setTimeLeft] = useState({
        days: 0,
        hours: 0,
        minutes: 0,
        seconds: 0
    });

    const [timeExpired, setTimeExpired] = useState(false);

    useEffect(() => {
        function updateCountdown(){

        const timeDifference = (targetDate.getTime() - Date.now()) / 1000; /*Πόσα δευτερόλεπτα απέχει η ημερομηνία στόχος*/
        const totalSeconds = Math.max(0, Math.floor(timeDifference)); /*Απαλείφω τα κλάσματα του δευτερολέπτου*/
        if (timeDifference <= 0) {
            setTimeLeft({
                days: 0,
                hours: 0,
                minutes: 0,
                seconds: 0
            });
            setTimeExpired(true);
            clearInterval(countdownTimer);
            return;
        }
        const days = Math.floor(totalSeconds / 86400);
        const hours = Math.floor((totalSeconds % 86400) / 3600);
        const minutes = Math.floor((totalSeconds % 3600) / 60);
        const seconds =Math.floor(totalSeconds % 60);

        setTimeLeft({days, hours, minutes, seconds});
    

        }


        const countdownTimer = setInterval(updateCountdown, 1000);

        updateCountdown();

        return () => clearInterval(countdownTimer);

    }, []);



    return (
        <main className="min-h-screen flex items-center justify-center p-4">
            <div className="w-full max-w-xl rounded-2xl bg-[oklch(57.7%_0.245_27.325)] p-8 shadow-xl">
                <h2 className="text-xl font-bold">Η πρώτη φάση της ψηφοφορίας λήγει σε:</h2>

                <div className="flex flex-col gap-3 p-2 mt-4">
                    {timeExpired ? (
                        <p className="text-lg">Η πρώτη φάση της ψηφοφορίας ολοκληρώθηκε!</p>
                    ) : (
                        <p className="text-lg">{timeLeft.days} ημέρες, {timeLeft.hours} ώρες, {timeLeft.minutes} λεπτά, {timeLeft.seconds} δευτερόλεπτα</p>
                    )}
                </div>
            </div>
        </main>
    );
}

