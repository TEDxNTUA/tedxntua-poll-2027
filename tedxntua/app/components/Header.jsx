export default function Header() {
    return (
        <header className="flex items-center justify-between bg-black text-white">
            <img src="/tedxntua_logo.png" alt="TEDxNTUA" className="w-28 shrink-0 sm:w-2xs" />
            <nav className="flex flex-1 items-center justify-end p-2 sm:p-4">
                <ul>
                    <li className="px-2 py-2 sm:px-10"><a lang="en" href="https://www.tedxntua.com/" target="_blank" rel="noopener noreferrer" className="hover:text-[oklch(57.7%_0.245_27.325)] active:text-[oklch(57.7%_0.245_27.325)] font-bold font-sans transition-colors duration-300">Archive</a></li>
                </ul>
            </nav>
        </header>
    )
}