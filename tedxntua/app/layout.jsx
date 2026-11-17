import "./globals.css";
import Header from "./components/Header";

export const metadata = {
  title: "Poll",
  description: "Poll for TedxNtua 2027",
};


export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>
        <Header />
        {children}
        </body>
    </html>
  );
}
