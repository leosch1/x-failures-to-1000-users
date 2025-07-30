export const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL;

export async function fetchUserCounts(): Promise<Record<string, number>> {
  console.log(API_BASE_URL);
  if (!API_BASE_URL) {
    throw new Error("API_BASE_URL is not defined");
  }
  const response = await fetch(`${API_BASE_URL}/userCounts`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    }
  });

  if (!response.ok) {
    throw new Error(`Failed to fetch user counts: ${response.statusText}`);
  }

  const data = await response.json();
  console.log(data);
  return data.data as Record<string, number>;

  // await new Promise((resolve) => setTimeout(resolve, 1200));
  // return {
  //   "Storylog": 0,
  //   "Vibe Radar": 30,
  //   "My YouTube Path": 12,
  //   "Spot The Pie": 4
  // };
}
