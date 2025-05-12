import { defineType } from 'sanity'

export const taskEventTypes = defineType({
    name: 'taskEvent',
    title: 'Task Event',
    type: 'document',

    fields: [
        {
            name: 'employeeName',
            title: 'Employee Name',
            type: 'string',
            validation: (Rule) => Rule.required(),
        },
        {
            name: 'taskComplitionDate',
            title: 'Task Complition Date',
            type: 'datetime',
            initialValue: () => new Date().toISOString(),
            validation: (Rule) => Rule.required(),
        },
        {
            name: 'description',
            title: 'Description',
            type: 'string',
            validation: (Rule) => Rule.required(),
        },
        {
            name: 'locationLink',
            title: 'Location Link',
            type: 'string',
            
        },
        {
            name: 'emailId',
            title: 'Email Id',
            type: 'string',
            validation: (Rule) => Rule.required(),
        },
    ],
})
