import { Controller } from "@hotwired/stimulus"
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';
import timeGridPlugin from '@fullcalendar/timegrid';
import resourceTimelinePlugin from '@fullcalendar/resource-timeline';
import '../../assets/stylesheets/calendars/index.css'


export default class extends Controller {
  connect() {
    this.calendar = new Calendar(this.element, {
      plugins: [ dayGridPlugin, listPlugin, timeGridPlugin, resourceTimelinePlugin ],
      schedulerLicenseKey: 'XXX',
      headerToolbar: {
        left: 'today prev,next',
        center: 'title',
        right: 'timeGridWeek,dayGridMonth,listWeek'
      },
      initialView: 'timeGridWeek',
      views: {
        resourceTimelineThreeDays: {
          type: 'resourceTimeline',
          duration: { days: 3 },
          buttonText: '3 day'
        }
      },
      resourceAreaHeaderContent: 'Trucks',
      resources: [
        { id: 'a', title: 'Truck 1' },
        { id: 'b', title: 'Truck 2', eventColor: 'green' },
        { id: 'c', title: 'Truck 3', eventColor: 'orange' },
      ],
    });
    this.fetchEvents().then((events) => {
    this.calendar.setOption('events', events);
    this.calendar.render();
  });
  }

  disconnect() {
    this.calendar.destroy();
  }

  fetchEvents() {
    return fetch("/calendars/get_jobs.json")
      .then(response => response.json())
      .then(data => {
        const jobs = data.map(job => {
          return {
            title: job.title,
            start: job.start,
            end: job.end,
            url: `/jobs/${job.id}`
          };
        });
        return jobs;
      })
  }
}