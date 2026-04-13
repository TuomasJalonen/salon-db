# Bash Salon Scheduler (PostgreSQL)

A simple command-line salon booking system written in Bash and backed by PostgreSQL. Users can select services, enter a phone number, create customers, and schedule appointments.

## Features

- Interactive CLI menu
- PostgreSQL-backed data storage
- Customer lookup by phone number
- Create new customers automatically
- Schedule appointments
- Services table-driven menu

## Requirements

- Bash
- PostgreSQL (`psql`)

## Setup

Clone the repository:

```bash
git clone https://github.com/your-username/salon.git
cd salon
```

Create the database from dump:

```bash
psql -U postgres < salon.sql
```

Make the script executable:

```bash
chmod +x salon.sh
```

Run it:

```bash
./salon.sh
```

## Example

```text
~~~~~ MY SALON ~~~~~
Welcome to My Salon, how can I help you?
1) cut
2) color
3) perm
4) style
5) trim
```

## Database Schema

Tables:

- `services`
- `customers`
- `appointments`

Relationships:

```text
customers 1 ────< appointments >──── 1 services
```

## Notes

- Phone number must be unique
- Appointment time is stored as text for simplicity

## Project

freeCodeCamp — Relational Database Certification  
Salon Appointment Scheduler
