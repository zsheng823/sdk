import { GroupStatus } from "./types";

/**
 * Format a raw token amount to a human-readable string.
 * Soroban tokens typically use 7 decimal places.
 */
export function formatAmount(
  amount: bigint,
  decimals: number = 7
): string {
  const divisor = BigInt(10 ** decimals);
  const whole = amount / divisor;
  const fractional = amount % divisor;

  if (fractional === 0n) {
    return whole.toString();
  }

  const fractionalStr = fractional.toString().padStart(decimals, "0");
  const trimmed = fractionalStr.replace(/0+$/, "");
  return `${whole}.${trimmed}`;
}

/**
 * Parse a human-readable amount to raw token units.
 */
export function parseAmount(
  amount: string,
  decimals: number = 7
): bigint {
  const parts = amount.split(".");
  const whole = BigInt(parts[0]) * BigInt(10 ** decimals);

  if (parts.length === 1) {
    return whole;
  }

  const fractionalStr = parts[1].padEnd(decimals, "0").slice(0, decimals);
  return whole + BigInt(fractionalStr);
}

/**
 * Get a human-readable label for a group status.
 */
export function getStatusLabel(status: GroupStatus): string {
  const labels: Record<GroupStatus, string> = {
    [GroupStatus.Forming]: "Accepting Members",
    [GroupStatus.Active]: "Active",
    [GroupStatus.Completed]: "Completed",
    [GroupStatus.Disputed]: "Under Dispute",
    [GroupStatus.Paused]: "Paused",
  };
  return labels[status];
}

/**
 * Shorten a Stellar address for display.
 */
export function shortenAddress(address: string, chars: number = 4): string {
  return `${address.slice(0, chars)}...${address.slice(-chars)}`;
}

/**
 * Calculate the total pot size for a group.
 */
export function calculatePotSize(
  contributionAmount: bigint,
  memberCount: number
): bigint {
  return contributionAmount * BigInt(memberCount);
}

/**
 * Calculate which round a specific member will receive their payout.
 */
export function getPayoutRound(
  payoutOrder: string[],
  memberAddress: string
): number | null {
  const index = payoutOrder.indexOf(memberAddress);
  return index === -1 ? null : index + 1;
}
