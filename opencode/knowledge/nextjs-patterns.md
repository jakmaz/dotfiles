# Next.js App Router Patterns

Patterns, gotchas, and best practices for Next.js App Router. Searchable by concept.

## How to Use This File

1. **During development**: Search for patterns when implementing features
2. **Debugging**: Check gotchas section when things break unexpectedly
3. **Code review**: Reference for validating architectural decisions
4. **New patterns**: Add discoveries as you encounter them

---

## Server Components (RSC)

### Default is Server - Don't Over-Client

**Problem:** Adding `'use client'` everywhere out of habit, bloating the JS bundle.

**Pattern:** Components are Server Components by default. Only add `'use client'` when you need:

- State (`useState`, `useReducer`)
- Effects (`useEffect`, `useLayoutEffect`)
- Event handlers (`onClick`, `onChange`)
- Browser APIs (`window`, `localStorage`, `navigator`)
- Custom hooks that use the above

```tsx
// page.tsx - Server Component by default
// NO 'use client' needed - this is optimal
export default async function Page() {
  const data = await fetchData(); // Direct async, no useEffect needed
  return <DataDisplay data={data} />;
}
```

**When to avoid:** Don't add `'use client'` just because you're "not sure" - start server, add client when you hit a wall.

---

### Async Server Components

**Problem:** Wanting to fetch data in a component without useEffect/useState dance.

**Pattern:** Server Components can be async. Just await directly.

```tsx
// This is the dream - no loading states, no useEffect, just data
export default async function UserProfile({ userId }: { userId: string }) {
  const user = await getUser(userId);
  const posts = await getUserPosts(userId);

  return (
    <div>
      <h1>{user.name}</h1>
      <PostList posts={posts} />
    </div>
  );
}
```

**Gotcha:** Sequential awaits = waterfall. Use Promise.all for parallel:

```tsx
export default async function UserProfile({ userId }: { userId: string }) {
  // Parallel - both requests fire simultaneously
  const [user, posts] = await Promise.all([
    getUser(userId),
    getUserPosts(userId),
  ])

  return (/* ... */)
}
```

---

### Streaming with Suspense

**Problem:** Slow data fetch blocks entire page render.

**Pattern:** Wrap slow components in Suspense to stream them in progressively.

```tsx
import { Suspense } from "react";

export default function Page() {
  return (
    <div>
      <h1>Dashboard</h1>
      {/* Fast - renders immediately */}
      <QuickStats />

      {/* Slow - streams in when ready */}
      <Suspense fallback={<ChartSkeleton />}>
        <SlowAnalyticsChart />
      </Suspense>

      <Suspense fallback={<TableSkeleton />}>
        <SlowDataTable />
      </Suspense>
    </div>
  );
}
```

**Key insight:** Each Suspense boundary is independent. User sees progressive content, not a blank page.

---

### Server Wrapping Client (Composition Pattern)

**Problem:** Need server data in a client component, but can't make client components async.

**Pattern:** Server component fetches, passes to client via props or children.

```tsx
// page.tsx - Server Component
import { ClientModal } from "./client-modal";
import { ServerContent } from "./server-content";

export default async function Page() {
  const data = await fetchData();

  return (
    <ClientModal>
      {/* Server Component rendered BEFORE being passed */}
      <ServerContent data={data} />
    </ClientModal>
  );
}
```

```tsx
// client-modal.tsx
"use client";

export function ClientModal({ children }: { children: React.ReactNode }) {
  const [open, setOpen] = useState(false);

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      {children} {/* Server-rendered content, just passed through */}
    </Dialog>
  );
}
```

**Why it works:** `children` is already rendered RSC payload, not a function or component reference.

---

## Client Components

### 'use client' Boundary Rules

**Problem:** Confusion about what "client boundary" means.

**Pattern:** `'use client'` marks the boundary. Everything imported INTO a client component becomes client code.

```tsx
// layout.tsx - Server Component
import { ThemeProvider } from "./theme-provider"; // This is client
import { Header } from "./header"; // This stays server!

export default function Layout({ children }) {
  return (
    <ThemeProvider>
      <Header /> {/* Still server - passed as children */}
      {children}
    </ThemeProvider>
  );
}
```

```tsx
// theme-provider.tsx
"use client";

import { createContext, useState } from "react";
// Any import here becomes part of client bundle

export function ThemeProvider({ children }) {
  const [theme, setTheme] = useState("dark");
  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      {children} {/* Children rendered server-side, just passed through */}
    </ThemeContext.Provider>
  );
}
```

**Key insight:** Children/props passed FROM server TO client don't become client components. They're already-rendered RSC payload.

---

### Extracting Client Islands

**Problem:** Large page with one interactive element - don't want to client-ify everything.

**Pattern:** Extract minimal interactive part to its own client component.

```tsx
// page.tsx - Server Component (90% of the page)
import { LikeButton } from "./like-button";

export default async function BlogPost({ slug }: { slug: string }) {
  const post = await getPost(slug);

  return (
    <article>
      <h1>{post.title}</h1>
      <div dangerouslySetInnerHTML={{ __html: post.content }} />
      <footer>
        {/* Only this tiny piece is client JS */}
        <LikeButton postId={post.id} initialLikes={post.likes} />
      </footer>
    </article>
  );
}
```

```tsx
// like-button.tsx
"use client";

import { useState } from "react";
import { likePost } from "@/app/actions";

export function LikeButton({ postId, initialLikes }: Props) {
  const [likes, setLikes] = useState(initialLikes);

  return (
    <button
      onClick={async () => {
        const newLikes = await likePost(postId);
        setLikes(newLikes);
      }}
    >
      {likes} likes
    </button>
  );
}
```

**Result:** Entire blog post is zero JS except the like button.

---

### Third-Party Components Without 'use client'

**Problem:** Using a library component that needs client features but doesn't have `'use client'`.

**Pattern:** Create a thin wrapper that re-exports with the directive.

```tsx
// components/carousel.tsx
"use client";

// The library doesn't have 'use client', we add it
export { Carousel } from "acme-carousel";
```

```tsx
// page.tsx - Now works in Server Component
import { Carousel } from "@/components/carousel";

export default function Page() {
  return <Carousel items={items} />;
}
```

---

## Data Fetching

### fetch() Auto-Deduplication

**Problem:** Same data needed in multiple components - worried about duplicate requests.

**Pattern:** Just fetch where you need it. React/Next.js dedupes automatically.

```tsx
// Both these components can fetch the same URL
async function Header() {
  const user = await fetch("/api/user").then((r) => r.json());
  return <nav>{user.name}</nav>;
}

async function Sidebar() {
  const user = await fetch("/api/user").then((r) => r.json());
  return <aside>{user.avatar}</aside>;
}

// Only ONE request actually fires during render
```

**Caveat:** Deduplication only works for:

- Same URL + same options
- GET requests
- During React render pass

---

### When to Use Route Handlers vs Server Actions

**Problem:** Both can handle mutations, which to pick?

**Pattern:**

| Use Case                  | Choice        | Why                                  |
| ------------------------- | ------------- | ------------------------------------ |
| Form submissions          | Server Action | Progressive enhancement, simpler     |
| Button clicks (mutations) | Server Action | Direct invocation, better UX         |
| Webhooks                  | Route Handler | External systems need URL endpoint   |
| Third-party callbacks     | Route Handler | OAuth, Stripe, etc. need stable URLs |
| Public API                | Route Handler | Versioned, documented endpoints      |
| File uploads              | Route Handler | More control over streaming/chunks   |

```tsx
// Server Action - form mutation
"use server";

export async function createPost(formData: FormData) {
  const title = formData.get("title");
  await db.post.create({ data: { title } });
  revalidatePath("/posts");
}

// Route Handler - webhook
export async function POST(request: Request) {
  const payload = await request.json();
  const sig = request.headers.get("stripe-signature");
  // Verify and process webhook
  return Response.json({ received: true });
}
```

---

### Parallel vs Sequential Fetching

**Problem:** Page is slow because data fetches are waterfalling.

**Pattern:** Identify independent fetches and parallelize them.

```tsx
// BAD - Sequential waterfall (each waits for previous)
async function Page() {
  const user = await getUser();
  const posts = await getPosts(); // Waits for user
  const comments = await getComments(); // Waits for posts
  // Total time: user + posts + comments
}

// GOOD - Parallel where possible
async function Page() {
  const user = await getUser();

  // These don't depend on each other - fire together
  const [posts, comments] = await Promise.all([
    getPosts(user.id),
    getComments(user.id),
  ]);
  // Total time: user + max(posts, comments)
}

// BEST - Use Suspense for progressive streaming
async function Page() {
  const user = await getUser();

  return (
    <>
      <UserHeader user={user} />
      <Suspense fallback={<PostsSkeleton />}>
        <Posts userId={user.id} />
      </Suspense>
      <Suspense fallback={<CommentsSkeleton />}>
        <Comments userId={user.id} />
      </Suspense>
    </>
  );
}
```

---

### Revalidation Strategies

**Problem:** Data is stale, need to refresh cache appropriately.

**Pattern:** Match revalidation strategy to data characteristics.

```tsx
// Time-based - good for data that changes predictably
fetch(url, { next: { revalidate: 3600 } }); // Refresh hourly

// On-demand by path - good after mutations affecting a route
import { revalidatePath } from "next/cache";
revalidatePath("/posts"); // Revalidate specific path
revalidatePath("/posts", "layout"); // Revalidate including layouts

// On-demand by tag - good for related data across routes
fetch(url, { next: { tags: ["posts"] } });
// Then in server action:
import { revalidateTag } from "next/cache";
revalidateTag("posts"); // All fetches tagged 'posts' revalidate

// No cache - always fresh
fetch(url, { cache: "no-store" });

// Route-level config
export const revalidate = 3600; // All fetches in this route
export const dynamic = "force-dynamic"; // Always dynamic render
```

---

## Caching Deep Dive

### The Four Caches

**Problem:** Caching is confusing - what's cached where?

**Pattern:** Understand the four layers:

| Cache               | Where  | What                | Duration       | Opt Out             |
| ------------------- | ------ | ------------------- | -------------- | ------------------- |
| Request Memoization | Server | fetch return values | Single request | Use AbortController |
| Data Cache          | Server | fetch responses     | Persistent     | `cache: 'no-store'` |
| Full Route Cache    | Server | HTML + RSC payload  | Persistent     | Dynamic APIs        |
| Router Cache        | Client | RSC payload         | Session        | `router.refresh()`  |

```tsx
// Request Memoization - same fetch called twice = one request
async function Component1() {
  await fetch("/api/data");
}
async function Component2() {
  await fetch("/api/data");
} // Deduped!

// Data Cache - persists across requests
fetch("/api/data", { cache: "force-cache" }); // Cached
fetch("/api/data", { cache: "no-store" }); // Not cached

// Full Route Cache - static routes cached at build
export default function StaticPage() {
  /* ... */
}

// Router Cache - client caches visited routes
// Invalidate with:
import { useRouter } from "next/navigation";
const router = useRouter();
router.refresh(); // Clears router cache for current route
```

---

### What Triggers Dynamic Rendering

**Problem:** Route unexpectedly became dynamic, can't figure out why.

**Pattern:** These APIs opt you into dynamic rendering:

```tsx
// Any of these = dynamic route
import { cookies, headers } from "next/headers";
import { connection } from "next/server";

// Using cookies
const cookieStore = await cookies();
const token = cookieStore.get("token");

// Using headers
const headersList = await headers();
const userAgent = headersList.get("user-agent");

// Using searchParams in page
export default function Page({ searchParams }) {
  const query = (await searchParams).q; // Makes page dynamic
}

// Using connection (replaces unstable_noStore)
await connection();

// Uncached fetch
fetch(url, { cache: "no-store" });

// Route segment config
export const dynamic = "force-dynamic";
```

---

### Opting Out of Each Cache

**Problem:** Need fresh data, cache is getting in the way.

**Pattern:**

```tsx
// Opt out of Data Cache (per-fetch)
fetch(url, { cache: "no-store" });

// Opt out of Full Route Cache (whole route)
export const dynamic = "force-dynamic";
// OR use any dynamic API (cookies, headers, searchParams)

// Opt out of Router Cache (client-side)
import { useRouter } from "next/navigation";
const router = useRouter();
router.refresh();

// In Server Action - invalidates both Data Cache and Router Cache
import { revalidatePath, revalidateTag } from "next/cache";
revalidatePath("/posts");
revalidateTag("posts");
```

---

## Server Actions

### 'use server' Placement

**Problem:** Where does the directive go?

**Pattern:** Two valid patterns:

```tsx
// Pattern 1: File-level directive (recommended for reusable actions)
// app/actions.ts
"use server";

export async function createPost(formData: FormData) {
  /* ... */
}
export async function deletePost(id: string) {
  /* ... */
}

// Pattern 2: Inline in Server Component
// app/page.tsx
export default function Page() {
  async function handleSubmit(formData: FormData) {
    "use server";
    // This function runs on server
  }

  return <form action={handleSubmit}>...</form>;
}
```

**Note:** You cannot define Server Actions inside Client Components. Import them instead.

---

### Form Actions with useActionState

**Problem:** Need loading state, error handling, optimistic updates for forms.

**Pattern:** Use `useActionState` for full control.

```tsx
"use client";

import { useActionState } from "react";
import { createPost } from "@/app/actions";

const initialState = { error: null, success: false };

export function CreatePostForm() {
  const [state, formAction, pending] = useActionState(createPost, initialState);

  return (
    <form action={formAction}>
      <input name="title" disabled={pending} />
      {state.error && <p className="error">{state.error}</p>}
      <button disabled={pending}>
        {pending ? "Creating..." : "Create Post"}
      </button>
    </form>
  );
}
```

```tsx
// app/actions.ts
"use server";

export async function createPost(prevState: State, formData: FormData) {
  const title = formData.get("title");

  if (!title) {
    return { error: "Title required", success: false };
  }

  await db.post.create({ data: { title } });
  revalidatePath("/posts");

  return { error: null, success: true };
}
```

---

### useFormStatus for Submit Buttons

**Problem:** Want disabled/loading state on submit button without prop drilling.

**Pattern:** `useFormStatus` reads parent form state automatically.

```tsx
"use client";

import { useFormStatus } from "react-dom";

function SubmitButton() {
  const { pending } = useFormStatus();

  return (
    <button disabled={pending}>{pending ? "Submitting..." : "Submit"}</button>
  );
}

// Usage - button automatically knows form state
export function Form() {
  return (
    <form action={serverAction}>
      <input name="email" />
      <SubmitButton /> {/* No props needed! */}
    </form>
  );
}
```

**Gotcha:** `useFormStatus` must be used in a component that's a CHILD of the form, not the form component itself.

---

### Revalidation After Mutations

**Problem:** Data updated but UI shows stale content.

**Pattern:** Always revalidate after mutations.

```tsx
"use server";

import { revalidatePath, revalidateTag } from "next/cache";
import { redirect } from "next/navigation";

export async function createPost(formData: FormData) {
  await db.post.create({
    data: {
      /* ... */
    },
  });

  // Option 1: Revalidate specific path
  revalidatePath("/posts");

  // Option 2: Revalidate by tag (if you tagged your fetches)
  revalidateTag("posts");

  // Option 3: Revalidate and redirect
  revalidatePath("/posts");
  redirect("/posts"); // Must come AFTER revalidate
}
```

---

### Error Handling in Server Actions

**Problem:** Server action throws, what happens to the UI?

**Pattern:** Return error state instead of throwing (for form UX).

```tsx
"use server";

import { z } from "zod";

const schema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
});

export async function signUp(prevState: State, formData: FormData) {
  // Validate
  const result = schema.safeParse({
    email: formData.get("email"),
    password: formData.get("password"),
  });

  if (!result.success) {
    return {
      errors: result.error.flatten().fieldErrors,
      message: "Validation failed",
    };
  }

  try {
    await createUser(result.data);
    return { errors: null, message: "Success" };
  } catch (e) {
    // Don't expose internal errors
    return { errors: null, message: "Something went wrong" };
  }
}
```

---

## Routing

### Layouts vs Templates

**Problem:** When to use layout vs template?

**Pattern:**

| Feature                    | Layout | Template |
| -------------------------- | ------ | -------- |
| Persists across navigation | Yes    | No       |
| Maintains state            | Yes    | No       |
| Re-renders on navigate     | No     | Yes      |
| useEffect runs on navigate | No     | Yes      |

```tsx
// layout.tsx - Persists, good for:
// - Shared UI (nav, sidebar)
// - Keeping state (shopping cart)
// - Not re-animating on every page

// template.tsx - Re-mounts, good for:
// - Enter/exit animations per page
// - useEffect that should run on every navigation
// - Resetting state on navigation
```

```tsx
// app/template.tsx - Animates on every route change
"use client";

import { motion } from "framer-motion";

export default function Template({ children }: { children: React.ReactNode }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -20 }}
    >
      {children}
    </motion.div>
  );
}
```

---

### Loading and Error Boundaries

**Problem:** Want automatic loading/error states for route segments.

**Pattern:** Add `loading.tsx` and `error.tsx` files.

```
app/
  posts/
    page.tsx
    loading.tsx   ← Shows while page.tsx loads
    error.tsx     ← Shows if page.tsx throws
    [id]/
      page.tsx
      loading.tsx ← Nested loading state
```

```tsx
// loading.tsx - Instant loading UI
export default function Loading() {
  return <PostsSkeleton />;
}

// error.tsx - Must be client component
("use client");

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  return (
    <div>
      <h2>Something went wrong!</h2>
      <button onClick={() => reset()}>Try again</button>
    </div>
  );
}
```

---

### Parallel Routes

**Problem:** Need multiple independent UI sections that load independently.

**Pattern:** Use `@folder` convention for parallel routes.

```
app/
  @dashboard/
    page.tsx
    loading.tsx
  @analytics/
    page.tsx
    loading.tsx
  layout.tsx    ← Receives both as props
```

```tsx
// layout.tsx
export default function Layout({
  children,
  dashboard,
  analytics,
}: {
  children: React.ReactNode;
  dashboard: React.ReactNode;
  analytics: React.ReactNode;
}) {
  return (
    <div className="grid grid-cols-2">
      <div>{dashboard}</div>
      <div>{analytics}</div>
      {children}
    </div>
  );
}
```

**Key benefit:** Each slot loads independently with its own loading.tsx.

---

### Intercepting Routes

**Problem:** Want modal behavior where URL changes but page doesn't full-navigate.

**Pattern:** Use `(.)`, `(..)`, `(...)` to intercept routes.

```
app/
  feed/
    page.tsx
    @modal/
      (..)photo/[id]/   ← Intercepts /photo/[id] when coming FROM /feed
        page.tsx        ← Shows as modal
  photo/
    [id]/
      page.tsx          ← Direct navigation shows full page
```

```tsx
// app/feed/@modal/(..)photo/[id]/page.tsx
export default function PhotoModal({ params }: { params: { id: string } }) {
  return (
    <Modal>
      <Photo id={params.id} />
    </Modal>
  );
}

// Clicking photo in feed = modal
// Direct URL /photo/123 = full page
// Refresh on modal = full page (progressive enhancement!)
```

---

### Route Groups

**Problem:** Want to organize routes without affecting URL structure.

**Pattern:** Use `(folder)` - parentheses make it invisible to URL.

```
app/
  (marketing)/      ← Not in URL
    page.tsx        ← /
    about/
      page.tsx      ← /about
    layout.tsx      ← Shared marketing layout
  (app)/            ← Not in URL
    dashboard/
      page.tsx      ← /dashboard
    settings/
      page.tsx      ← /settings
    layout.tsx      ← Shared app layout (with auth)
```

**Use cases:**

- Different layouts for different sections
- Organizing code without changing URLs
- Multiple root layouts

---

## Common Gotchas

### Hydration Mismatches

**Problem:** `Text content does not match server-rendered HTML`

**Causes & Fixes:**

```tsx
// BAD - Date/time differs between server and client
function Timestamp() {
  return <span>{new Date().toLocaleString()}</span>;
}

// GOOD - Render on client only
("use client");
import { useState, useEffect } from "react";

function Timestamp() {
  const [time, setTime] = useState<string>();

  useEffect(() => {
    setTime(new Date().toLocaleString());
  }, []);

  if (!time) return null; // Or skeleton
  return <span>{time}</span>;
}

// GOOD - Use suppressHydrationWarning for truly dynamic content
<time dateTime={date.toISOString()} suppressHydrationWarning>
  {date.toLocaleString()}
</time>;
```

```tsx
// BAD - Browser extension injected content
// (Can't fix, but can identify by the mismatch being weird HTML)

// BAD - Conditional rendering based on window
function Component() {
  if (typeof window !== "undefined" && window.innerWidth < 768) {
    return <MobileView />;
  }
  return <DesktopView />;
}

// GOOD - Use CSS or client-side state
("use client");
import { useMediaQuery } from "@/hooks/use-media-query";

function Component() {
  const isMobile = useMediaQuery("(max-width: 768px)");
  return isMobile ? <MobileView /> : <DesktopView />;
}
```

---

### "Functions cannot be passed directly to Client Components"

**Problem:** Passing a function prop from server to client.

**Cause:** Functions aren't serializable - can't cross the server/client boundary.

```tsx
// BAD - onClick is a function
export default function Page() {
  function handleClick() {
    console.log("clicked");
  }

  return <ClientButton onClick={handleClick} />; // ERROR
}

// GOOD - Move handler to client component
("use client");
export function ClientButton() {
  function handleClick() {
    console.log("clicked");
  }
  return <button onClick={handleClick}>Click</button>;
}

// GOOD - Use Server Action (serializable reference)
export default function Page() {
  async function handleSubmit() {
    "use server";
    // This IS serializable - it's a server action reference
  }

  return <form action={handleSubmit}>...</form>;
}
```

---

### Dynamic Server Usage Errors

**Problem:** `Dynamic server usage: cookies` - route can't be statically generated.

**Pattern:** Understand what makes a route dynamic and embrace it.

```tsx
// These make your route dynamic (can't be static):
import { cookies, headers } from "next/headers";
const c = await cookies();
const h = await headers();

// searchParams makes page dynamic
export default function Page({ searchParams }) {
  const query = (await searchParams).q;
}

// If you NEED static, don't use these APIs
// If you're using them, the route SHOULD be dynamic

// Explicit dynamic declaration
export const dynamic = "force-dynamic";

// Or accept dynamic and optimize other ways
export const fetchCache = "default-cache"; // Cache fetches even though dynamic
```

---

### Metadata in Client Components

**Problem:** `Metadata export is not allowed in a client component`

**Pattern:** Metadata must be in Server Components.

```tsx
// BAD - page.tsx has 'use client' AND metadata
"use client";
export const metadata = { title: "My Page" }; // ERROR

// GOOD - Keep page as Server Component, extract client parts
// page.tsx
import { InteractiveSection } from "./interactive-section";

export const metadata = { title: "My Page" }; // Works!

export default function Page() {
  return (
    <div>
      <h1>Server rendered</h1>
      <InteractiveSection /> {/* Client component */}
    </div>
  );
}
```

---

### params and searchParams Are Now Async

**Problem:** `params.id` is undefined or a Promise.

**Pattern:** In Next.js 15+, these are async. Must await them.

```tsx
// Next.js 14 (old)
export default function Page({ params }) {
  const id = params.id; // Direct access
}

// Next.js 15+ (current)
export default async function Page({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params; // Must await
}

// Also applies to generateMetadata
export async function generateMetadata({ params }: Props) {
  const { id } = await params;
  return { title: `Post ${id}` };
}
```

---

## Performance Patterns

### Partial Prerendering (PPR)

**Problem:** Want static shell with dynamic holes.

**Pattern:** Enable PPR, use Suspense for dynamic parts.

```tsx
// next.config.js
module.exports = {
  experimental: {
    ppr: true,
  },
};

// page.tsx - Static shell, dynamic content
import { Suspense } from "react";

export default function Page() {
  return (
    <div>
      {/* Static - prerendered at build */}
      <Header />
      <Hero />

      {/* Dynamic - rendered at request time */}
      <Suspense fallback={<CartSkeleton />}>
        <Cart /> {/* Uses cookies() */}
      </Suspense>

      {/* Static */}
      <Footer />
    </div>
  );
}
```

**Result:** Static parts serve instantly from edge, dynamic parts stream in.

---

### Image Optimization

**Problem:** Images are slow, wrong size, no lazy loading.

**Pattern:** Always use `next/image`.

```tsx
import Image from 'next/image'

// Basic responsive image
<Image
  src="/hero.jpg"
  alt="Hero"
  width={1200}
  height={600}
  priority // For above-fold images
/>

// Fill container
<div className="relative h-64 w-full">
  <Image
    src="/hero.jpg"
    alt="Hero"
    fill
    className="object-cover"
    sizes="(max-width: 768px) 100vw, 50vw"
  />
</div>

// Remote images - configure domains
// next.config.js
module.exports = {
  images: {
    remotePatterns: [
      { protocol: 'https', hostname: 'cdn.example.com' },
    ],
  },
}
```

---

### Font Optimization

**Problem:** Fonts cause layout shift (CLS).

**Pattern:** Use `next/font` for automatic optimization.

```tsx
// app/layout.tsx
import { Inter, Playfair_Display } from "next/font/google";

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-inter",
});

const playfair = Playfair_Display({
  subsets: ["latin"],
  variable: "--font-playfair",
});

export default function RootLayout({ children }) {
  return (
    <html lang="en" className={`${inter.variable} ${playfair.variable}`}>
      <body className="font-sans">{children}</body>
    </html>
  );
}

// tailwind.config.js
module.exports = {
  theme: {
    fontFamily: {
      sans: ["var(--font-inter)"],
      serif: ["var(--font-playfair)"],
    },
  },
};
```

**Benefits:** Self-hosted, no external requests, zero layout shift.

---

### Prefetching Control

**Problem:** Too much prefetching, or want more aggressive prefetching.

**Pattern:** Control Link prefetch behavior.

```tsx
import Link from 'next/link'

// Default - prefetches on hover (production only)
<Link href="/about">About</Link>

// Disable prefetch
<Link href="/huge-page" prefetch={false}>Huge Page</Link>

// Full prefetch (including dynamic data)
<Link href="/dashboard" prefetch={true}>Dashboard</Link>

// Programmatic prefetch
'use client'
import { useRouter } from 'next/navigation'

function Component() {
  const router = useRouter()

  useEffect(() => {
    router.prefetch('/likely-next-page')
  }, [router])
}
```

---

## Adding New Patterns

When you discover a new pattern:

1. **Identify the problem**: What were you trying to do?
2. **Document the pattern**: What's the solution?
3. **Show the code**: Minimal example
4. **Note gotchas**: What to watch out for

```markdown
### Pattern Name

**Problem:** What challenge does this solve?

**Pattern:** Brief description of the solution.

\`\`\`tsx
// Code example
\`\`\`

**When to use / avoid:** Context for when this applies.
```

Then:

```bash
bd create "Next.js pattern: <name>" -t chore --tags nextjs-pattern
```
