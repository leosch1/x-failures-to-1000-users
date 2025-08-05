"use client";
import React, { useState } from "react";
import Image from "next/image";

interface ProjectCardProps {
  title: string;
  subtitle: string;
  description: string;
  imagePath: string;
  userCounts: number;
  isBuilding?: boolean;
  tryItUrl?: string;
  blogUrl?: string;
  expandedDefault?: boolean;
  loading?: boolean;
}

export default function ProjectCard({
  title,
  subtitle,
  description,
  imagePath,
  userCounts,
  isBuilding = false,
  tryItUrl,
  blogUrl,
  expandedDefault = false,
  loading = false,
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
        <div className="flex flex-col gap-2 pt-1">
          <div className="text-2xl font-extrabold text-white leading-tight">{subtitle}</div>
          <div className="text-neutral-200 text-base font-medium leading-snug whitespace-pre-line">{description}</div>
          <Image
            src={imagePath}
            alt={title}
            width={280}
            height={150}
            className="w-full h-auto object-contain rounded-lg mt-1 mb-1"
          />
          {(tryItUrl || blogUrl) && (
            <div className="flex gap-2 mb-2">
              {tryItUrl && (
                <a
                  href={tryItUrl}
                  className="bg-neutral-200 text-neutral-900 text-sm font-bold rounded px-3 py-2 flex items-center gap-1 hover:bg-white transition"
                  target="_blank"
                  rel="noopener noreferrer"
                  onClick={e => e.stopPropagation()}
                >
                  TRY IT
                  <span className="ml-1">
                    <svg width="15" height="18" viewBox="0 0 15 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path d="M14.0481 0.577148H8.53846C8.30769 0.577148 8.07692 0.721379 8.07692 0.952148V1.81753C8.07692 2.0483 8.27884 2.30792 8.53846 2.30792H10.8173C11.0769 2.30792 11.2211 2.59638 11.0192 2.76946L6.11538 7.6733C5.9423 7.84638 5.9423 8.10599 6.11538 8.27907L6.72115 8.88484C6.89423 9.05792 7.15384 9.05792 7.32692 8.88484L12.2308 3.98099C12.4038 3.80792 12.6923 3.9233 12.6923 4.18292V6.46176C12.6923 6.69253 12.9231 6.95215 13.1538 6.95215H13.9904C14.2211 6.95215 14.4231 6.69253 14.4231 6.46176V0.980995C14.4231 0.721379 14.2788 0.577148 14.0481 0.577148Z" fill="#1C1C1C" />
                      <path d="M10.4712 7.35588L9.49038 8.3655C9.3173 8.53857 9.23077 8.7405 9.23077 8.97127V12.2597C9.23077 12.4905 9.02884 12.6924 8.79807 12.6924H2.74038C2.50961 12.6924 2.30769 12.4905 2.30769 12.2597V6.20204C2.30769 5.97127 2.50961 5.76934 2.74038 5.76934H6.05769C6.28846 5.76934 6.51923 5.68281 6.66346 5.50973L7.64423 4.52896C7.8173 4.35588 7.70192 4.03857 7.4423 4.03857H1.73077C1.09615 4.03857 0.57692 4.5578 0.57692 5.19242V13.2693C0.57692 13.904 1.09615 14.4232 1.73077 14.4232H9.80769C10.4423 14.4232 10.9615 13.904 10.9615 13.2693V7.55781C10.9615 7.29819 10.6442 7.1828 10.4712 7.35588Z" fill="#1C1C1C" />
                    </svg>
                  </span>
                </a>
              )}
              {blogUrl && (
                <a
                  href={blogUrl}
                  className="bg-neutral-500 text-white text-sm font-bold rounded px-3 py-2 flex items-center gap-1 hover:bg-neutral-400 transition"
                  target="_blank"
                  rel="noopener noreferrer"
                  onClick={e => e.stopPropagation()}
                >
                  BLOG
                  <span className="ml-1">
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path d="M8 7.3335H9.66667H11.3333" stroke="white" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
                      <path d="M8 4.6665H9.66667H11.3333" stroke="white" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
                      <path d="M5.33333 10V2.4C5.33333 2.17909 5.51242 2 5.73333 2H13.6C13.8209 2 14 2.17909 14 2.4V11.3333C14 12.8061 12.8061 14 11.3333 14" stroke="white" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
                      <path d="M3.33333 10H5.33333H8.26667C8.4876 10 8.66873 10.1779 8.68653 10.3981C8.7684 11.4098 9.18747 14 11.3333 14H5.33333H4C2.89543 14 2 13.1046 2 12V11.3333C2 10.5969 2.59695 10 3.33333 10Z" stroke="white" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
                    </svg>
                  </span>
                </a>
              )}
            </div>
          )}
        </div>
      </div>
      <span
        className={`inline-block text-sm font-semibold rounded px-2 py-1 w-fit ${loading
          ? "bg-neutral-500 text-neutral-300 animate-pulse"
          : isBuilding
            ? "bg-yellow-300 text-yellow-900"
            : userCounts < 1000
              ? "bg-red-400 text-white"
              : "bg-green-400 text-white"
          }`}
      >
        {loading ? (
          <span className="opacity-0">0 users: STATUS</span>
        ) : isBuilding ? (
          "BUILDING..."
        ) : userCounts < 1000 ? (
          `${userCounts} users: FAILED`
        ) : (
          `${userCounts} users: SUCCESS`
        )}
      </span>
    </div >
  );
}
