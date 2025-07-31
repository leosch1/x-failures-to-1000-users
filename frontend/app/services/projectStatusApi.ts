export const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL;

export async function fetchUserCounts(): Promise<Record<string, number>> {
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
  return data as Record<string, number>;
}
