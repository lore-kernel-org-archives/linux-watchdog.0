Return-path: <jtheou@adeneo-embedded.us>
Date: Fri, 5 Jun 2015 23:39:30 -0700
From: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] watchdog_core: Add watchdog registration
 deferral mechanism
Message-ID: <20150605233930.c59deac8b2dafa1f3f734aba@adeneo-embedded.us>
In-Reply-To: <55727614.9010008@roeck-us.net>
References: <1433555212-4729-1-git-send-email-jtheou@adeneo-embedded.us>
	<55727614.9010008@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Thanks for the valuable feedbacks.

I am working on a v3.

JB

On Fri, 5 Jun 2015 21:24:52 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 06/05/2015 06:46 PM, Jean-Baptiste Theou wrote:
> > Currently, watchdog subsystem require the misc subsystem to
> > register a watchdog. This may not be the case in case of an
> > early registration of a watchdog, which can be required when
> > the watchdog cannot be disabled.
> >
> > This patch use deferral mechanism to remove this requirement.
> 
>   ... introduces a deferral ...
> 
> I think this is going into the right direction. Couple of comments below.
> 
> Guenter
> 
> >
> > Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
> > ---
> >   drivers/watchdog/watchdog_core.c | 92 ++++++++++++++++++++++++++++++++++++++--
> >   include/linux/watchdog.h         |  3 ++
> >   2 files changed, 91 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> > index cec9b55..edf6294 100644
> > --- a/drivers/watchdog/watchdog_core.c
> > +++ b/drivers/watchdog/watchdog_core.c
> > @@ -43,6 +43,41 @@
> >   static DEFINE_IDA(watchdog_ida);
> >   static struct class *watchdog_class;
> >
> > +/*
> > + * Deferred Registration infrastructure.
> > + *
> > + * Sometimes watchdog drivers need to be loaded as soon as possible,
> > + * for example when it's impossible to disable it. To do so,
> > + * raising the initcall level of the watchdog driver is a solution.
> > + * But in such case, the miscdev is maybe not ready (subsys_initcall), and
> > + * watchdog core need miscdev to be populate.
> 
> s/need/needs/
> s/populate/populated/
> 
> watchdog_core needs miscdev to be populated for what ?
> 
> > + *
> > + * The deferred registration infrastructure offer a way for the watchdog
> > + * subsystem to register a watchdog properly, even before miscdev is ready
> > + *
> Add '.'.
> 
> > + * This is based on driver probe deferral mechanism.
> 
> I don't understand the last sentence, and I don't think it adds value.
> 
> > + */
> > +
> > +static DEFINE_MUTEX(watchdog_deferred_registration_mutex);
> > +static LIST_HEAD(watchdog_deferred_registration_pending_list);
> > +static bool watchdog_deferred_registration_done;
> > +
> > +static int watchdog_deferred_registration_add(struct watchdog_device *wdd)
> > +{
> > +	dev_dbg(wdd->dev, "Added to deferred list\n");
> 
> Did you try to run this code with debugging enabled ?
> Presumably not, because it should result in a NULL pointer access,
> since wdd->dev is only set during registration.
> 
> This leads to the question why you have this debug message
> in the first place.
> 
> > +	list_add(&wdd->deferred_registration,
> > +		 &watchdog_deferred_registration_pending_list);
> 
> list_add_tail(). We want to register watchdog devices in the original order,
> not in reverse order. The first caller gets /dev/watchdog.
> 
> > +	return 0;
> > +}
> > +
> > +static void watchdog_deferred_registration_del(struct watchdog_device *wdd)
> > +{
> > +	if (!list_empty(&wdd->deferred_registration)) {
> 
> I don't think this check is necessary, even if the member is uninitialized.
> Problem here is that is watchdog_register was never called, the list members
> will be NULL, list->next will be NULL, and not point to the list itself.
> So you'd end up with trouble (try calling watchdog_unregister_device
> before calling watchdog_register_device just for fun to see what happens).
> 
> Not really sure how to handle this. The safe approach may be to walk the list
> and remove the entry (only) if it is found.
> 
> > +		dev_dbg(wdd->dev, "Removed from deferred list\n");
> 
> ... and another crash ;-)
> 
> > +		list_del_init(&wdd->deferred_registration);
> > +	}
> > +}
> > +
> >   static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
> >   {
> >   	/*
> > @@ -99,7 +134,7 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
> >   EXPORT_SYMBOL_GPL(watchdog_init_timeout);
> >
> >   /**
> > - * watchdog_register_device() - register a watchdog device
> > + * __watchdog_register_device() - register a watchdog device
> >    * @wdd: watchdog device
> >    *
> >    * Register a watchdog device with the kernel so that the
> > @@ -108,7 +143,7 @@ EXPORT_SYMBOL_GPL(watchdog_init_timeout);
> >    * A zero is returned on success and a negative errno code for
> >    * failure.
> >    */
> > -int watchdog_register_device(struct watchdog_device *wdd)
> > +int __watchdog_register_device(struct watchdog_device *wdd)
> 
> Why do you want to make this global (but unexported) ? I think it should be static,
> and the published API should remain the same.
> 
> >   {
> >   	int ret, id, devno;
> >
> > @@ -164,16 +199,35 @@ int watchdog_register_device(struct watchdog_device *wdd)
> >
> >   	return 0;
> >   }
> > +
> > +/*
> > + * watchdog_register_device use either the deferred approach,
> > + * or directly register the watchdog, depending on the current
> > + * initcall level.
> > + */
> > +
> Please move the API comment to here. The above comment doesn't really add
> value unless it is part of the API documentation.
> 
> > +int watchdog_register_device(struct watchdog_device *wdd)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&watchdog_deferred_registration_mutex);
> > +	if (watchdog_deferred_registration_done)
> > +		ret = __watchdog_register_device(wdd);
> > +	else
> > +		ret = watchdog_deferred_registration_add(wdd);
> > +	mutex_unlock(&watchdog_deferred_registration_mutex);
> > +	return ret;
> > +}
> >   EXPORT_SYMBOL_GPL(watchdog_register_device);
> >
> >   /**
> > - * watchdog_unregister_device() - unregister a watchdog device
> > + * __watchdog_unregister_device() - unregister a watchdog device
> 
> Same as above. This isn't the API.
> 
> >    * @wdd: watchdog device to unregister
> >    *
> >    * Unregister a watchdog device that was previously successfully
> >    * registered with watchdog_register_device().
> >    */
> > -void watchdog_unregister_device(struct watchdog_device *wdd)
> > +void __watchdog_unregister_device(struct watchdog_device *wdd)
> >   {
> >   	int ret;
> >   	int devno;
> > @@ -189,8 +243,37 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
> >   	ida_simple_remove(&watchdog_ida, wdd->id);
> >   	wdd->dev = NULL;
> >   }
> > +
> > +void watchdog_unregister_device(struct watchdog_device *wdd)
> > +{
> > +	mutex_lock(&watchdog_deferred_registration_mutex);
> > +	if (watchdog_deferred_registration_done)
> > +		__watchdog_unregister_device(wdd);
> > +	else
> > +		watchdog_deferred_registration_del(wdd);
> > +	mutex_unlock(&watchdog_deferred_registration_mutex);
> > +}
> > +
> >   EXPORT_SYMBOL_GPL(watchdog_unregister_device);
> >
> > +/**
> > + * watchdog_deferred_registration_initcall() - Register queued watchdog
> > + */
> > +static int watchdog_deferred_registration_initcall(void)
> 
> Mark with __init ?
> 
> > +{
> > +	mutex_lock(&watchdog_deferred_registration_mutex);
> > +	watchdog_deferred_registration_done = true;
> > +	while (!list_empty(&watchdog_deferred_registration_pending_list)) {
> > +		struct watchdog_device *wdd = list_first_entry(&watchdog_deferred_registration_pending_list,
> > +							       struct watchdog_device, deferred_registration);
> > +		list_del_init(&wdd->deferred_registration);
> > +		__watchdog_register_device(wdd);
> > +	}
> > +	mutex_unlock(&watchdog_deferred_registration_mutex);
> > +	return 0;
> > +}
> > +late_initcall(watchdog_deferred_registration_initcall);
> 
> Too late. miscdev is initialized with subsys_initcall.
> module_init maps to late_initcall as well, meaning many watchdog
> devices would end up with deferred registration for no good reason.
> 
> I think it should be possible to just tag this onto watchdog_init,
> and call watchdog_init with subsys_initcall_sync instead of
> subsys_initcall.
> 
> > +
> >   static int __init watchdog_init(void)
> >   {
> >   	int err;
> > @@ -222,5 +305,6 @@ module_exit(watchdog_exit);
> >
> >   MODULE_AUTHOR("Alan Cox <alan@lxorguk.ukuu.org.uk>");
> >   MODULE_AUTHOR("Wim Van Sebroeck <wim@iguana.be>");
> > +MODULE_AUTHOR("Jean-Baptiste Theou <jbtheou@gmail.com>");
> 
> Not for a few lines of added code, please.
> 
> >   MODULE_DESCRIPTION("WatchDog Timer Driver Core");
> >   MODULE_LICENSE("GPL");
> > diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> > index a746bf5..fcc190e 100644
> > --- a/include/linux/watchdog.h
> > +++ b/include/linux/watchdog.h
> > @@ -65,6 +65,8 @@ struct watchdog_ops {
> >    * @driver-data:Pointer to the drivers private data.
> >    * @lock:	Lock for watchdog core internal use only.
> >    * @status:	Field that contains the devices internal status bits.
> > + * @deferred_registration: entry in deferred_registration_list which is used to
> > + *			   register early initialized watchdog.
> 
> watchdogs.
> 
> >    *
> >    * The watchdog_device structure contains all information about a
> >    * watchdog timer device.
> > @@ -95,6 +97,7 @@ struct watchdog_device {
> >   #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
> >   #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
> >   #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
> > +	struct list_head deferred_registration;
> >   };
> >
> >   #define WATCHDOG_NOWAYOUT		IS_BUILTIN(CONFIG_WATCHDOG_NOWAYOUT)
> >
> 


-- 
Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
