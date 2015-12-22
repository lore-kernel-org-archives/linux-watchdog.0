Return-path: <damien.riegel@savoirfairelinux.com>
Date: Tue, 22 Dec 2015 14:28:09 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Pratyush Anand <panand@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] watchdog: Separate and maintain variables based on
 variable lifetime
Message-ID: <20151222192807.GA16755@localhost>
References: <1450645503-16661-1-git-send-email-linux@roeck-us.net>
 <1450645503-16661-3-git-send-email-linux@roeck-us.net>
 <20151221172815.GC12696@localhost>
 <5678A322.2010109@roeck-us.net>
 <20151222160907.GC6164@localhost>
 <567978D0.2060801@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <567978D0.2060801@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Dec 22, 2015 at 08:22:40AM -0800, Guenter Roeck wrote:
> On 12/22/2015 08:09 AM, Damien Riegel wrote:
> >On Mon, Dec 21, 2015 at 05:10:58PM -0800, Guenter Roeck wrote:
> >>On 12/21/2015 09:28 AM, Damien Riegel wrote:
> >>>On Sun, Dec 20, 2015 at 01:05:00PM -0800, Guenter Roeck wrote:
> >>>>All variables required by the watchdog core to manage a watchdog are
> >>>>currently stored in struct watchdog_device. The lifetime of those
> >>>>variables is determined by the watchdog driver. However, the lifetime
> >>>>of variables used by the watchdog core differs from the lifetime of
> >>>>struct watchdog_device. To remedy this situation, watchdog drivers
> >>>>can implement ref and unref callbacks, to be used by the watchdog
> >>>>core to lock struct watchdog_device in memory.
> >>>>
> >>>>While this solves the immediate problem, it depends on watchdog drivers
> >>>>to actually implement the ref/unref callbacks. This is error prone,
> >>>>often not implemented in the first place, or not implemented correctly.
> >>>>
> >>>>To solve the problem without requiring driver support, split the variables
> >>>>in struct watchdog_device into two data structures - one for variables
> >>>>associated with the watchdog driver, one for variables associated with
> >>>>the watchdog core. With this approach, the watchdog core can keep track
> >>>>of its variable lifetime and no longer depends on ref/unref callbacks
> >>>>in the driver. As a side effect, some of the variables originally in
> >>>>struct watchdog_driver are now private to the watchdog core and no longer
> >>>>visible in watchdog drivers.
> >>>>
> >>>>The 'ref' and 'unref' callbacks in struct watchdog_driver are no longer
> >>>>used and marked as deprecated.
> >>>
> >>>Two comments below. It's great to see that unbinding a driver no longer
> >>>triggers a kernel panic.
> >>>
> >>It should not have caused a panic to start with, but the ref/unref functions
> >>for the most part were either not or wrongly implemented. Not really
> >>surprising - it took me a while to understand the problem.
> >
> >I tested on a driver which did not implement ref/unref. When ping is
> >called, it tries to dereference a freed 'struct watchdog_device' in
> >watchdog_get_drvdata, leading to a panic.
> >
> Yes, that will happen. Problem here is that the driver is buggy -
> pretty much all drivers which dynamically allocate struct watchdog_device
> have this problem.
> 
> This is the ultimate reason for coming up with this patch.
> 
> >>
> >>[ ... ]
> >>
> >>>>
> >>>>  /*
> >>>>+ * struct _watchdog_device - watchdog core internal data
> >>>
> >>>Think it should be /**. Anyway, I find it confusing to have both
> >>>_watchdog_device and watchdog_device, but I can't think of a better
> >>>name right now.
> >>
> >>I renamed the data structure to watchdog_data and moved it into watchdog_dev.c
> >>since it is only used there. No '**', though, because it is not a published
> >>API, but just an internal data structure.
> >>
> >>I also renamed the matching variable name to 'wd_data' (from '_wdd').
> >
> >Okay. Also, why didn't you use the explicit type for 'wdd_data' in
> >'struct watchdog_device' instead of a void*?
> >
> 
> This is to hide the data type, since the structure is not exported
> to drivers.
> 
> I could pre-declare the structure with 'struct watchdog_data;', but
> then I'd have to use a different structure name (watchdog_cdev_data,
> maybe, or watchdog_core_data) to make it less generic. Any opinion ?
> Would that be better / preferred ? I am 50/50 about it.

My personal preference would be to be explicit. That makes code
nagivation easier and it might help the compiler catch some mistakes.
Plus, as you moved the structure definition in watchdog_dev.c, it is
very clear that drivers aren't supposed to use it.

Thanks,
Damien
