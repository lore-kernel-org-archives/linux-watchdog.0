Return-path: <panand@redhat.com>
Date: Wed, 2 Sep 2015 10:37:10 +0530
From: Pratyush Anand <panand@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: dyoung@redhat.com, dzickus@redhat.com, linux-watchdog@vger.kernel.org,
        open list:  ABI/API <linux-api@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH V2] watchdog: Add watchdog device control through sysfs
 attributes
Message-ID: <20150902050710.GC31796@dhcppc13.redhat.com>
References: <5417c42a93ef68062c4bfdbcf1d1253ea5ce9e08.1441000946.git.panand@redhat.com>
 <55E66C8F.1020309@roeck-us.net>
 <20150902044714.GB31796@dhcppc13.redhat.com>
 <55E68053.3060006@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55E68053.3060006@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On 01/09/2015:09:51:31 PM, Guenter Roeck wrote:
> On 09/01/2015 09:47 PM, Pratyush Anand wrote:
> >Hi Guenter,
> >
> >Thanks for review and explaining it.
> >
> >On 01/09/2015:08:27:11 PM, Guenter Roeck wrote:
> >>Playing with it, I see two alternatives (2a/2b), both of which I prefer.
> >
> >OK..I will make the changes as you prefer. May be I will keep these changes as
> >1st patch and another patch to add sysfs attributes.
> >
> >>
> >>1) Move struct class watchdog_class to watchdog_dev.c, and initialize it there.
> >>    Attach the groups to the .dev_groups variable in watchdog_class.
> >>2a) Make watchdog_class global, and use a pointer to it in watchdog_core.c.
> >>     Use class_register / class_unregister instead of class_create / class_destroy.
> >>2b) Make watchdog_class static in watchdog_dev.c. Move its registration and de-registration
> >>     to watchdog_dev_init() and watchdog_dev_exit(). Again, use class_register
> >>     and class_unregister.
> >>     Have watchdog_dev_init return a pointer to watchdog_class (and ERR_PTR on errors).
> >>3) Keep the rest of the code in place as-is, specifically keep using device_create()
> >>    as is in __watchdog_register_device().
> >>
> >>Maybe 1 / 2b / 3 so we don't need to introduce a new global ?
> >
> >But with 2b, we will still have to move device_create() to
> >watchdog_dev_register, because it needs watchdog_class. So, are you OK
> >with that? Else I can implement 2a, if that seems more suitable to you.
> >
> 
> Not if you return the pointer to the watchdog class from watchdog_dev_init().

But in that case another static class * will be needed to share the  returned
value in __watchdog_register_device().

> That avoids making it global (though I don't really have a problem with
> making it global).

OK Thanks.. Then I will send a V3 with 2a.

~Pratyush
