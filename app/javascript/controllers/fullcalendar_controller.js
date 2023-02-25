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
        right: 'resourceTimelineDay,timeGridWeek,dayGridMonth,listWeek'
      },
      initialView: 'resourceTimelineDay',
      views: {
        resourceTimelineThreeDays: {
          type: 'resourceTimeline',
          duration: { days: 3 },
          buttonText: '3 day'
        }
      },
      resourceAreaHeaderContent: 'Trucks',
    });
    this.fetchEvents().then(({events, resources}) => {
    this.calendar.setOption('events', events);
    this.calendar.setOption('resources', resources);
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
        const resources = data.reduce((acc, job) => {
          if (job.resource.id > 0) {
            acc.push({ id: job.resource.id, title: job.resource.name });
          } else {
            acc.push({ id: job.resource.id, title: "Uncategorized" });
          }
          return acc;
        }, []);
        const events = data.map(job => {
          return {
            id: job.id,
            resourceId: job.resource ? job.resource.id : null,
            title: job.title,
            start: job.start,
            end: job.end,
            url: `/jobs/${job.id}`
          };
        });
        return { events, resources };
      })
  }
}