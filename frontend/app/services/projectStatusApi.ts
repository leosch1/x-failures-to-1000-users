export async function fetchUserCounts(): Promise<Record<string, number>> {
  await new Promise((resolve) => setTimeout(resolve, 1200));
  return {
    "Storylog": 0,
    "Vibe Radar": 30,
    "My YouTube Path": 12,
    "Spot The Pie": 4
  };
} 
