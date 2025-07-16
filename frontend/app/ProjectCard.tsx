"use client";
import React, { useState } from "react";

interface ProjectCardProps {
  title: string;
  subtitle: string;
  description: string;
  image?: React.ReactNode;
  status: string;
  statusType: "building" | "failed";
  tryItUrl?: string;
  blogUrl?: string;
  expandedDefault?: boolean;
}

export default function ProjectCard({
  title,
  subtitle,
  description,
  image,
  status,
  statusType,
  tryItUrl,
  blogUrl,
  expandedDefault = false,
}: ProjectCardProps) {
  const [expanded, setExpanded] = useState(expandedDefault);

  return (
    <div className="bg-[#2E2E2E] rounded-xl shadow-md px-4 py-4 flex flex-col gap-2 cursor-pointer select-none"
      onClick={() => setExpanded((e) => !e)}>
      <div className="flex items-center justify-between">
        <span className="text-lg leading-none font-semibold text-white">{title}</span>
        <span
          className={`text-white text-2xl transition-transform duration-200 ${expanded ? "scale-y-[-1]" : "scale-y-[1]"
            }`}
        >
          <svg
            width="16"
            height="11"
            viewBox="0 0 16 11"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M2 2L8 8L14 2"
              stroke="white"
              strokeWidth="3"
              strokeLinecap="round"
            />
          </svg>
        </span>
      </div>
      <div
        className={`transition-all duration-300 overflow-hidden ${expanded ? "max-h-[999px] opacity-100 visible" : "max-h-0 opacity-0 invisible"}`}
      >
        <div className="flex flex-col gap-2 pt-2">
          <div className="text-2xl font-extrabold text-white leading-tight">{subtitle}</div>
          <div className="text-neutral-200 text-base font-medium leading-snug whitespace-pre-line">{description}</div>
          {image && (
            <div className="rounded-lg bg-neutral-600 flex items-center justify-center mt-1 mb-1">
              {image}
            </div>
          )}
          {(tryItUrl || blogUrl) && (
            <div className="flex gap-2 my-1">
              {tryItUrl && (
                <a
                  href={tryItUrl}
                  className="bg-neutral-200 text-neutral-900 text-xs font-semibold rounded px-3 py-1 flex items-center gap-1 hover:bg-white transition"
                  target="_blank"
                  rel="noopener noreferrer"
                  onClick={e => e.stopPropagation()}
                >
                  TRY IT <span className="ml-1">↗</span>
                </a>
              )}
              {blogUrl && (
                <a
                  href={blogUrl}
                  className="bg-neutral-500 text-white text-xs font-semibold rounded px-3 py-1 flex items-center gap-1 hover:bg-neutral-400 transition"
                  target="_blank"
                  rel="noopener noreferrer"
                  onClick={e => e.stopPropagation()}
                >
                  BLOG <span className="ml-1">📄</span>
                </a>
              )}
            </div>
          )}
        </div>
      </div>
      <span
        className={`inline-block text-xs font-semibold rounded px-2 py-1 w-fit ${statusType === "building"
          ? "bg-yellow-300 text-yellow-900"
          : "bg-red-400 text-white"
          }`}
      >
        {status}
      </span>
    </div >
  );
}
