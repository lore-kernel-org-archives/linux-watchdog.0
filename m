Return-path: <rpjday@crashcourse.ca>
Date: Mon, 17 Oct 2016 09:31:42 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Guenter Roeck <linux@roeck-us.net>
cc: Linux watchdog mailing list <linux-watchdog@vger.kernel.org>
Subject: Re: is watchdog_ops stop() routine mandatory or optional?
In-Reply-To: <83fbc8ba-5f1c-9420-2e64-3008abc433ee@roeck-us.net>
Message-ID: <alpine.LFD.2.20.1610170931180.7980@ca624034.mitel.com>
References: <alpine.LFD.2.20.1610170638260.6042@ca624034.mitel.com> <83fbc8ba-5f1c-9420-2e64-3008abc433ee@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, 17 Oct 2016, Guenter Roeck wrote:

> On 10/17/2016 03:42 AM, Robert P. J. Day wrote:
> >
> >   continuing with annoying pedantry, there's this from
> > Documentation/watchdog/watchdog-kernel-api.txt:
> >
> >   The list of watchdog operations is defined as:
> >
> >   struct watchdog_ops {
> >         struct module *owner;
> >         /* mandatory operations */
> >         int (*start)(struct watchdog_device *);
> >         int (*stop)(struct watchdog_device *);
> >         /* optional operations */
> >         ... snip ...
> >
> > followed shortly by:
> >
> > Some operations are mandatory and some are optional. The mandatory
> > operations
> > are:
> > * start: this is a pointer to the routine that starts the watchdog timer
> >   device.
> >   The routine needs a pointer to the watchdog timer device structure as a
> >   parameter. It returns zero on success or a negative errno code for
> >   failure.
> >
> > Not all watchdog timer hardware supports the same functionality. That's why
> > all other routines/operations are optional. They only need to be provided if
> > they are supported. These optional routines/operations are:
> > * stop: with this routine the watchdog timer device is being stopped.
> > ... snip ...
> >
> >   so the first snippet implies that stop() is mandatory, while the
> > subsequent snippet describes it as optional. thoughts?
> >
>
> stop used to be mandatory, but isn't anymore. I missed updating the
> structure.

  you can patch it if you prefer, or i can do it. your choice.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
