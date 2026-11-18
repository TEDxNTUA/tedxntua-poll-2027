import "./globals.css";
import Header from "./components/Header";
import Footer from "./components/Footer";

export const metadata = {
  title: "Poll",
  description: "Poll for TedxNtua 2027",
};


export default function RootLayout({ children }) {
  return (
    <html lang="en">
  <body className="bg-[url('/BG.png')] text-white">
        <Header />
        {children}
        <Footer />
        </body>
    </html>
  );
}
