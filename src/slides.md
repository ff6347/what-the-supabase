---
author: Fabian Morón Zirfas
title: What the Supabase?
date: 5th of May 2021
---

## Getting started with [Supabase!](https://supabase.io)


## 5 Questions

1. What is JWT?
3. What is Row Level Security?
4. What are Postgres Policies?
5. What are Triggers and RPCs?
4. How to run this Thing?


## What is [JWT?](https://jwt.io)

## JWT is…

> JSON Web Token (JWT) is an open standard (RFC 7519) that defines a compact and self-contained way for securely transmitting information between parties as a JSON object. (…) JWTs can be signed using a secret (with the HMAC algorithm) or a public/private key pair using RSA or ECDSA.


## JWTs in Supabase

```bash
SUPABASE_ANON_KEY=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJzdXBhYmFzZSIsImlhdCI6MTYwMzk2ODgzNCwiZXhwIjoyNTUwNjUzNjM0LCJyb2xlIjoiYW5vbiJ9.36fUebxgx1mcBo4s19v0SzqmzunP--hm_hep0uLX0ew
SUPABASE_SERVICE_ROLE_KEY=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJzdXBhYmFzZSIsImlhdCI6MTYwMzk2ODgzNCwiZXhwIjoyNTUwNjUzNjM0LCJyb2xlIjoic2VydmljZV9yb2xlIn0.necIJaiP7X2T2QjGeV-FhpkizcNTX8HjDDBAxpgQTEI
JWT_SECRET=super-secret-jwt-token-with-at-least-32-characters-long
```

Checkout [jwt.io](https://jwt.io)

## What is Row Level Security

```sql
ALTER TABLE table_name ENABLE ROW LEVEL SECURITY;
```
## Row Level Security is…
> In addition to the SQL-standard privilege system available through GRANT, tables can have row security policies that restrict, on a per-user basis, which rows can be returned by normal queries or inserted, updated, or deleted by data modification commands.

* [Row Security Policies](https://www.postgresql.org/docs/current/ddl-rowsecurity.html)

## What are Postgres Policies?

```sql
CREATE POLICY name ON table_name
    [ FOR { ALL | SELECT | INSERT | UPDATE | DELETE } ]
    [ TO { role_name | PUBLIC | CURRENT_USER | SESSION_USER } [, ...] ]
    [ USING ( using_expression ) ]
    [ WITH CHECK ( check_expression ) ]
```

## Postgres Policies are…

> The CREATE POLICY command defines a new row-level security policy for a table. Note that row-level security must be enabled on the table.

* [CREATE POLICY | SQL Commands](https://www.postgresql.org/docs/current/sql-createpolicy.html)


## In [Next IoT Hub](https://github.com/technologiestiftung/next-iot-hub-api/blob/1965e4488d64f10e1c51c62e3465dc73f37d981d/dev-tools/local-supabase/docker/postgres/docker-entrypoint-initdb.d/40-triggers-and-rls.sql#L56-L64)



## What are Triggers and RPCs?


## Triggers are…

```sql
-- trigger
create function public.handle_new_user() returns trigger as $$ begin
insert into public.userprofiles (id)
values (new.id);
return new;
end;
$$ language plpgsql security definer;
-- trigger the function every time a user is created
create trigger on_auth_user_created
after
insert on auth.users for each row execute procedure public.handle_new_user();
```

## Remote Procedure Calls (RPC) are…


```sql
-- RPC
create or replace function delete_user() returns void LANGUAGE SQL SECURITY DEFINER AS $$
delete from public.userprofiles
where id = auth.uid();
delete from auth.users
where id = auth.uid();
$$;
```

## How to Run this (Vanilla Locally)?

prerequisites:

* Node.js
* Docker
* Docker Compose

```bash
npm init -y
npm i supabase -D
npx supabase init
```

## How to Run Next IoT Hub (Locally)?

```bash
cd next-iot-hub-api/dev-tools/local-supabase/docker
docker compose up
```

---

### The Credentials

are still the defaults

```bash
SUPABASE_ANON_KEY=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJzdXBhYmFzZSIsImlhdCI6MTYwMzk2ODgzNCwiZXhwIjoyNTUwNjUzNjM0LCJyb2xlIjoiYW5vbiJ9.36fUebxgx1mcBo4s19v0SzqmzunP--hm_hep0uLX0ew
SUPABASE_SERVICE_ROLE_KEY=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJzdXBhYmFzZSIsImlhdCI6MTYwMzk2ODgzNCwiZXhwIjoyNTUwNjUzNjM0LCJyb2xlIjoic2VydmljZV9yb2xlIn0.necIJaiP7X2T2QjGeV-FhpkizcNTX8HjDDBAxpgQTEI
JWT_SECRET=super-secret-jwt-token-with-at-least-32-characters-long
DATABASE_URL=DATABASE_URL="postgresql://postgres:postgres@localhost:5432/postgres?schema=public"
```


## How to Run Next IoT Hub (in Production)?

---

* Clone the next-iot-hub-api repository
* Create a Supabase Project remote
* Get its postgeresql connection string, anon key, service role key and jwt secret
* Setup `.env` in the root of te repo
* Setup `.env` in `next-iot-hub-api/dev-tools/next-iot-hub-db/` (`DATABASE_URL`)

---

### Setup your public schema using Prisma

```bash
cd next-iot-hub-api/dev-tools/next-iot-hub-db/
npm ci
npx prisma db push --preview-feature --skip-generate
```


---

### Connect with TablePlus

and execute the scripts in `next-iot-hub-api/dev-tools/local-supabase/docker/postgres/docker-entrypoint-initdb.d/`:

* `30-delete-cascades.sql`
* `40-triggers-and-rls.sql`
* `50-remote-procedure-calls.sql`
* `60-categories.sql`



## Q & A



## Thank you

for your attention.
