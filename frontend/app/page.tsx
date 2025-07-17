import ProjectCard from "./ProjectCard";

const projects = [
  {
    title: "Storylog",
    subtitle: "Turn your life into a manga",
    description:
      "Write a paragraph every day and let AI turn it into a manga.\nMake your story (life) worthwhile.",
    imagePath: "/storylog.png",
    status: "BUILDING: 0 users",
    statusType: "building" as const,
    // expandedDefault: true,
  },
  {
    title: "Vibe Radar",
    subtitle: "Listen to playlists from other cities",
    description:
      "Click somewhere on a globe and explore what music people there are listening to.",
    imagePath: "/viberadar.png",
    status: "FAILED: 30 users",
    statusType: "failed" as const,
    tryItUrl: "https://viberadar.io",
    // blogUrl: "#",
  },
  {
    title: "My YouTube Path",
    subtitle: "Explore your YouTube journey",
    description:
      "Did you know you can export your watch history from YouTube?\nThis is a tool to visualise it.",
    imagePath: "/my-youtube-path.png",
    status: "FAILED: 12 users",
    statusType: "failed" as const,
    tryItUrl: "https://my-youtube-path.com",
    // blogUrl: "#",
  },
  {
    title: "Spot The Pie",
    subtitle: "Create a playlist we both like",
    description:
      "A website which creates a playlist with songs both you and your friend like.\nFor Spotify and Apple Music.",
    imagePath: "/spot-the-pie.png",
    status: "FAILED: 4 users",
    statusType: "failed" as const,
    // tryItUrl: "#",
    // blogUrl: "#",
  },
];

export default function Home() {
  return (
    <div className="min-h-screen flex flex-col items-center p-5 md:pt-8">
      <main className="w-full max-w-2xl flex flex-col gap-6">
        <header className="mb-2">
          <h1 className="text-4xl font-extrabold text-white leading-tight mb-3">
            how many failures until 1000 users?
          </h1>
          <p className="text-neutral-300 text-base font-medium leading-snug">
            i want to build something which has 1000 users.
            <br />these are my past attempts :)
          </p>
        </header>
        <section className="flex flex-col gap-4">
          {projects.map((project) => (
            <ProjectCard key={project.title} {...project} />
          ))}
        </section>
      </main>
    </div>
  );
}
