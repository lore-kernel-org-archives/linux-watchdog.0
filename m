Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:36399 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbbLTMYA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 20 Dec 2015 07:24:00 -0500
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next v2 6/7] watchdog: mei_wdt: register wd device
 only if required
Date: Sun, 20 Dec 2015 12:23:56 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B540EEA99@hasmsx108.ger.corp.intel.com>
References: <1450363780-30008-1-git-send-email-tomas.winkler@intel.com>
 <1450363780-30008-7-git-send-email-tomas.winkler@intel.com>
 <56743B3B.4080502@roeck-us.net>
In-Reply-To: <56743B3B.4080502@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> 
> On 12/17/2015 06:49 AM, Tomas Winkler wrote:
> > From: Alexander Usyskin <alexander.usyskin@intel.com>
> >
> > For Intel Broadwell and newer platforms, the ME device can inform
> > the host whether the watchdog functionality is activated or not.
> > If the watchdog functionality is not activated then the watchdog interface
> > can be not registered and eliminate unnecessary pings and hence lower the
> > power consumption by avoiding waking up the device.
> >
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> > V2: rework unregistration
> >
> >   drivers/watchdog/mei_wdt.c | 180
> +++++++++++++++++++++++++++++++++++++++++----
> >   1 file changed, 167 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
> > index a3f1c1613c32..00d1b8e630b7 100644
> > --- a/drivers/watchdog/mei_wdt.c
> > +++ b/drivers/watchdog/mei_wdt.c
> > @@ -16,6 +16,7 @@
> >   #include <linux/slab.h>
> >   #include <linux/interrupt.h>
> >   #include <linux/watchdog.h>
> > +#include <linux/completion.h>
> >   #include <linux/debugfs.h>
> >
> >   #include <linux/uuid.h>
> > @@ -38,43 +39,54 @@
> >
> >   /* Sub Commands */
> >   #define MEI_MC_START_WD_TIMER_REQ  0x13
> > +#define MEI_MC_START_WD_TIMER_RES  0x83
> > +#define   MEI_WDT_STATUS_SUCCESS 0
> > +#define   MEI_WDT_WDSTATE_NOT_REQUIRED 0x1
> >   #define MEI_MC_STOP_WD_TIMER_REQ   0x14
> >
> >   /**
> >    * enum mei_wdt_state - internal watchdog state
> >    *
> > + * @MEI_WDT_PROBE: wd in probing stage
> >    * @MEI_WDT_IDLE: wd is idle and not opened
> >    * @MEI_WDT_START: wd was opened, start was called
> >    * @MEI_WDT_RUNNING: wd is expecting keep alive pings
> >    * @MEI_WDT_STOPPING: wd is stopping and will move to IDLE
> > + * @MEI_WDT_NOT_REQUIRED: wd device is not required
> >    */
> >   enum mei_wdt_state {
> > +	MEI_WDT_PROBE,
> >   	MEI_WDT_IDLE,
> >   	MEI_WDT_START,
> >   	MEI_WDT_RUNNING,
> >   	MEI_WDT_STOPPING,
> > +	MEI_WDT_NOT_REQUIRED,
> >   };
> >
> > -#if IS_ENABLED(CONFIG_DEBUG_FS)
> >   static const char *mei_wdt_state_str(enum mei_wdt_state state)
> >   {
> >   	switch (state) {
> > +	case MEI_WDT_PROBE: return "PROBE";
> >   	case MEI_WDT_IDLE: return "IDLE";
> >   	case MEI_WDT_START: return "START";
> >   	case MEI_WDT_RUNNING: return "RUNNING";
> >   	case MEI_WDT_STOPPING: return "STOPPING";
> > +	case MEI_WDT_NOT_REQUIRED: return "NOT_REQUIRED";
> >   	default: return "unknown";
> >   	}
> >   }
> > -#endif /* CONFIG_DEBUG_FS */
> >
> >   /**
> >    * struct mei_wdt - mei watchdog driver
> >    * @wdd: watchdog device
> >    * @refcnt: watchdog device reference counter
> > + * @reg_lock: watchdog device registration lock
> > + * @is_registered: is watchdog device registered
> >    *
> > - * @state: watchdog internal state
> >    * @cldev: mei watchdog client device
> > + * @state: watchdog internal state
> > + * @resp_required: ping required response
> > + * @response: ping response
> >    * @timeout: watchdog current timeout
> >    *
> >    * @dbgfs_dir: debugfs dir entry
> > @@ -82,9 +94,13 @@ static const char *mei_wdt_state_str(enum
> mei_wdt_state state)
> >   struct mei_wdt {
> >   	struct watchdog_device wdd;
> >   	struct kref refcnt;
> > +	struct mutex reg_lock;
> > +	bool   is_registered;
> >
> >   	struct mei_cl_device *cldev;
> >   	enum mei_wdt_state state;
> > +	bool resp_required;
> > +	struct completion response;
> >   	u16 timeout;
> >
> >   #if IS_ENABLED(CONFIG_DEBUG_FS)
> > @@ -121,6 +137,19 @@ struct mei_wdt_start_request {
> >   } __packed;
> >
> >   /**
> > + * struct mei_wdt_start_response watchdog start/ping response
> > + *
> > + * @hdr: Management Control Command Header
> > + * @status: operation status
> > + * @wdstate: watchdog status bit mask
> > + */
> > +struct mei_wdt_start_response {
> > +	struct mei_mc_hdr hdr;
> > +	u8 status;
> > +	u8 wdstate;
> > +} __packed;
> > +
> > +/**
> >    * struct mei_wdt_stop_request - watchdog stop
> >    *
> >    * @hdr: Management Control Command Header
> > @@ -192,6 +221,23 @@ static void mei_wdt_release(struct kref *ref)
> >   }
> >
> >   /**
> > + * mei_wdt_unregister - unregister from the watchdog subsystem
> > + *
> > + * @wdt: mei watchdog device
> > + */
> > +static void mei_wdt_unregister(struct mei_wdt *wdt)
> > +{
> > +
> > +	mutex_lock(&wdt->reg_lock);
> > +	if (wdt->is_registered) {
> > +		clear_bit(WDOG_ACTIVE, &wdt->wdd.status);
> 
> WDOG_ACTIVE is commonly handled by the core. Why does it have to be
> touched here ?

This have to be cleaned otherwise we ops->start is won't be called on new open()

> I am a bit concerned about the entire sequence.
> 
> If the following happens
> 
> - watchdog character device is opened
> - watchdog goes away
> - watchdog reappears
> - watchdog character device is accessed


> the code may access the driver through an old instance of the watchdog
> character device. The behavior in this situation is pretty much undefined.
> It may work, but only by luck, not by design.

You won't get through as the file descriptor is stale, you have to open the device again.
This should work by design, you have pluggable devices.

> 
> > +		watchdog_unregister_device(&wdt->wdd);
> > +		wdt->is_registered = false;
> > +	}
> > +	mutex_unlock(&wdt->reg_lock);
> > +}
> > +
> > +/**
> >    * mei_wdt_register - register with the watchdog subsystem
> >    *
> >    * @wdt: mei watchdog device
> > @@ -205,15 +251,20 @@ static int mei_wdt_register(struct mei_wdt *wdt)
> >
> >   	dev = &wdt->cldev->dev;
> >
> > -	watchdog_set_drvdata(&wdt->wdd, wdt);
> > +	wdt->state = MEI_WDT_IDLE;
> >
> > +	mutex_lock(&wdt->reg_lock);
> > +	clear_bit(WDOG_UNREGISTERED, &wdt->wdd.status);
> 
> Please don't touch watchdog core internal states 

No choice here. This is a bit tricky bit. This is not cleared, by the core as fresh watchdog device upon registering 
I think in the overall design it would be cleaner if this flag would have positive logic. i.e.  WDOG_REGISTERED. 
The code would be simpler if I would be able just toggle this bit, but there is no event propagated to the user space on this change, so 
I prefer to remove the whole device as this is something already supported..

- this flag will likely
> go away soon

We will have to deal with that when this happens. 
Tomas

