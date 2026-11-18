export default function Header() {
    return (
        <header className="flex justify-start bg-black text-white">
            <img src="/tedxntua_logo.png" className="w-2xs"></img>
            <nav className="flex items-center justify-end w-full p-4">
                <ul>
                    <li className="px-10"><a href="https://www.tedxntua.com/" target="_blank" rel="noopener noreferrer" className="hover:text-[oklch(57.7%_0.245_27.325)] active:text-[oklch(57.7%_0.245_27.325)] font-bold font-sans transition-colors duration-300">Archive</a></li>
                </ul>
            </nav>
        </header>
    )
}