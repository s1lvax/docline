# Docline Practitioner Portal

A Ruby on Rails application for medical practitioners to manage their availabilities, holidays, and subscription-based licenses. Patients can only book appointments with practitioners who have an active license.

---

## Technologies Used

- **Ruby on Rails 8**
- **PostgreSQL**
- **Tailwind CSS** (utility-first CSS framework for UI)
- **Stimulus.js** (for dynamic frontend interactions)
- **Stripe API** (subscription payments & invoicing)
- **Solid Trifecta** (Solid Cable, Solid Queue and Solid Cache)
- **ActionMailer** (transactional emails)
- **Hotwire/Turbo** (for responsive updates)

---

## Core Features

### Practitioner Availabilities

- Doctors can configure recurring weekly availabilities (day, start/end time, duration, bookable weeks ahead).
- Slots are automatically generated based on availabilities.
- Slots are only visible/bookable if the doctor has an active license.
- Availabilities can be created, edited, and deleted.

### Holidays

- Practitioners can define holiday periods (name, start/end date).
- Any slots within a holiday are deleted when the holiday is created.
- Future slots are not generated during holidays.
- Holidays are managed on the same page as availabilities, with a consistent UI.

### License & Subscription Management

- Only practitioners with an active license (Stripe subscription) are visible to patients and can have their slots booked.
- License purchase handled via Stripe Checkout (subscription model).
- Practitioners can cancel subscriptions at any time ("cancel at period end" supported).

### Invoices

- The 4 most recent invoices are displayed in the profile dashboard.
- When a new subscription is created, an invoice email with a PDF download link is sent automatically.
- When a subscription is canceled, a cancellation email is sent.

### UI

- Mobile-friendly layouts using Tailwind CSS.
- All forms and tables follow a consistent, modern design.
- Turbo Streams for updating tables and status on subscription/license changes.

---

## Background Jobs

- **CreatePractitionerProfileJob:** Generates practitioner profile upon account creation.
- **SlotGenerationJob:** Generates appointment slots based on practitioner's availability, skipping any slots that fall within a holiday period.
- **SlotRegenerationJob:** Adapts slots if availability is edited.
- **SlotDeletionJob:** Deletes slots when an availability is deleted.
- **DeleteHolidaySlotsJob:** Deletes all slots that overlap a newly-created holiday.
- **MakeSlotsVisibleJob:** When a license is purchased, this job marks all future, unbooked slots as visible/bookable.
- **SendSubscriptionInvoiceJob:** Sends a subscription invoice (with Stripe PDF) to the practitioner on subscription activation.
- **SendSubscriptionCanceledJob:** Sends a cancellation email when the subscription is ended.

---

## How it Works

1. **Configure Availabilities:** Practitioners define their weekly schedule and how far in advance bookings are allowed.
2. **Define Holidays:** Practitioners can block out periods (vacation, etc.), preventing slots from being generated or booked.
3. **Purchase License:** Practitioners pay via Stripe. Only after purchasing are their availabilities visible to patients.
4. **Automated Emails:** Practitioners receive invoices on subscription, and notifications on cancellation.
5. **Booking:** Patients can only see and book availabilities for practitioners with an active license.

---

## Development Notes

- All code is fully Turbo/Hotwire compatible and follows modern Rails 8 conventions.
- Models and controllers are namespaced under `PractitionerDashboard`.
- Uses Rails' encrypted credentials for API keys (Stripe, etc).
- Background jobs use `Solid Queue`

---

## Documentation

Documentation is managed using `yardoc`. To generate the documentation, use:

```bash
yard server
```
