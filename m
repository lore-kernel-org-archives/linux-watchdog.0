Return-path: <tomasw@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20151221172815.GC12696@localhost>
References: <1450645503-16661-1-git-send-email-linux@roeck-us.net>
	<1450645503-16661-3-git-send-email-linux@roeck-us.net>
	<20151221172815.GC12696@localhost>
Date: Tue, 22 Dec 2015 00:50:51 +0200
Message-ID: <CA+i0qc5LSoE8FyUxwue+GmW31aNG4tqzzkfJaZA=08LAUL_Y2A@mail.gmail.com>
Subject: Re: [PATCH 2/5] watchdog: Separate and maintain variables based on
 variable lifetime
From: Tomas Winkler <tomasw@gmail.com>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>, Guenter Roeck <linux@roeck-us.net>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Pratyush Anand <panand@redhat.com>, Hans de Goede <hdegoede@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a114527fc26ce1b052770525f
List-ID: <linux-watchdog@vger.kernel.org>

--001a114527fc26ce1b052770525f
Content-Type: text/plain; charset=UTF-8

On Mon, Dec 21, 2015 at 7:28 PM, Damien Riegel <
damien.riegel@savoirfairelinux.com> wrote:

> On Sun, Dec 20, 2015 at 01:05:00PM -0800, Guenter Roeck wrote:
> > All variables required by the watchdog core to manage a watchdog are
> > currently stored in struct watchdog_device. The lifetime of those
> > variables is determined by the watchdog driver. However, the lifetime
> > of variables used by the watchdog core differs from the lifetime of
> > struct watchdog_device. To remedy this situation, watchdog drivers
> > can implement ref and unref callbacks, to be used by the watchdog
> > core to lock struct watchdog_device in memory.
> >
> > While this solves the immediate problem, it depends on watchdog drivers
> > to actually implement the ref/unref callbacks. This is error prone,
> > often not implemented in the first place, or not implemented correctly.
> >
> > To solve the problem without requiring driver support, split the
> variables
> > in struct watchdog_device into two data structures - one for variables
> > associated with the watchdog driver, one for variables associated with
> > the watchdog core. With this approach, the watchdog core can keep track
> > of its variable lifetime and no longer depends on ref/unref callbacks
> > in the driver. As a side effect, some of the variables originally in
> > struct watchdog_driver are now private to the watchdog core and no longer
> > visible in watchdog drivers.
> >
> > The 'ref' and 'unref' callbacks in struct watchdog_driver are no longer
> > used and marked as deprecated.
>
> Two comments below. It's great to see that unbinding a driver no longer
> triggers a kernel panic.
>
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  Documentation/watchdog/watchdog-kernel-api.txt |  45 +--
> >  drivers/watchdog/watchdog_core.c               |   2 -
> >  drivers/watchdog/watchdog_core.h               |  23 ++
> >  drivers/watchdog/watchdog_dev.c                | 377
> +++++++++++++------------
> >  include/linux/watchdog.h                       |  21 +-
> >  5 files changed, 239 insertions(+), 229 deletions(-)
> >
> > diff --git a/Documentation/watchdog/watchdog-kernel-api.txt
> b/Documentation/watchdog/watchdog-kernel-api.txt
> > index 0a37da76acef..3db5092924e5 100644
> > --- a/Documentation/watchdog/watchdog-kernel-api.txt
> > +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> > @@ -44,7 +44,6 @@ The watchdog device structure looks like this:
> >
> >  struct watchdog_device {
> >       int id;
> > -     struct cdev cdev;
> >       struct device *dev;
> >       struct device *parent;
> >       const struct watchdog_info *info;
> > @@ -56,7 +55,7 @@ struct watchdog_device {
> >       struct notifier_block reboot_nb;
> >       struct notifier_block restart_nb;
> >       void *driver_data;
> > -     struct mutex lock;
> > +     void *wdd_data;
> >       unsigned long status;
> >       struct list_head deferred;
> >  };
> > @@ -66,8 +65,6 @@ It contains following fields:
> >    /dev/watchdog0 cdev (dynamic major, minor 0) as well as the old
> >    /dev/watchdog miscdev. The id is set automatically when calling
> >    watchdog_register_device.
> > -* cdev: cdev for the dynamic /dev/watchdog<id> device nodes. This
> > -  field is also populated by watchdog_register_device.
> >  * dev: device under the watchdog class (created by
> watchdog_register_device).
> >  * parent: set this to the parent device (or NULL) before calling
> >    watchdog_register_device.
> > @@ -89,11 +86,10 @@ It contains following fields:
> >  * driver_data: a pointer to the drivers private data of a watchdog
> device.
> >    This data should only be accessed via the watchdog_set_drvdata and
> >    watchdog_get_drvdata routines.
> > -* lock: Mutex for WatchDog Timer Driver Core internal use only.
> > +* wdd_data: a pointer to watchdog core internal data.
> >  * status: this field contains a number of status bits that give extra
> >    information about the status of the device (Like: is the watchdog
> timer
> > -  running/active, is the nowayout bit set, is the device opened via
> > -  the /dev/watchdog interface or not, ...).
> > +  running/active, or is the nowayout bit set).
> >  * deferred: entry in wtd_deferred_reg_list which is used to
> >    register early initialized watchdogs.
> >
> > @@ -110,8 +106,8 @@ struct watchdog_ops {
> >       int (*set_timeout)(struct watchdog_device *, unsigned int);
> >       unsigned int (*get_timeleft)(struct watchdog_device *);
> >       int (*restart)(struct watchdog_device *);
> > -     void (*ref)(struct watchdog_device *);
> > -     void (*unref)(struct watchdog_device *);
> > +     void (*ref)(struct watchdog_device *) __deprecated;
> > +     void (*unref)(struct watchdog_device *) __deprecated;
> >       long (*ioctl)(struct watchdog_device *, unsigned int, unsigned
> long);
> >  };
> >
> > @@ -120,20 +116,6 @@ driver's operations. This module owner will be used
> to lock the module when
> >  the watchdog is active. (This to avoid a system crash when you unload
> the
> >  module and /dev/watchdog is still open).
> >
> > -If the watchdog_device struct is dynamically allocated, just locking
> the module
> > -is not enough and a driver also needs to define the ref and unref
> operations to
> > -ensure the structure holding the watchdog_device does not go away.
> > -
> > -The simplest (and usually sufficient) implementation of this is to:
> > -1) Add a kref struct to the same structure which is holding the
> watchdog_device
> > -2) Define a release callback for the kref which frees the struct
> holding both
> > -3) Call kref_init on this kref *before* calling
> watchdog_register_device()
> > -4) Define a ref operation calling kref_get on this kref
> > -5) Define a unref operation calling kref_put on this kref
> > -6) When it is time to cleanup:
> > - * Do not kfree() the struct holding both, the last kref_put will do
> this!
> > - * *After* calling watchdog_unregister_device() call kref_put on the
> kref
> > -
> >  Some operations are mandatory and some are optional. The mandatory
> operations
> >  are:
> >  * start: this is a pointer to the routine that starts the watchdog timer
> > @@ -176,34 +158,21 @@ they are supported. These optional
> routines/operations are:
> >  * get_timeleft: this routines returns the time that's left before a
> reset.
> >  * restart: this routine restarts the machine. It returns 0 on success
> or a
> >    negative errno code for failure.
> > -* ref: the operation that calls kref_get on the kref of a dynamically
> > -  allocated watchdog_device struct.
> > -* unref: the operation that calls kref_put on the kref of a dynamically
> > -  allocated watchdog_device struct.
> >  * ioctl: if this routine is present then it will be called first before
> we do
> >    our own internal ioctl call handling. This routine should return
> -ENOIOCTLCMD
> >    if a command is not supported. The parameters that are passed to the
> ioctl
> >    call are: watchdog_device, cmd and arg.
> >
> > +The 'ref' and 'unref' operations are no longer used and deprecated.
> > +
> >  The status bits should (preferably) be set with the set_bit and
> clear_bit alike
> >  bit-operations. The status bits that are defined are:
> >  * WDOG_ACTIVE: this status bit indicates whether or not a watchdog
> timer device
> >    is active or not. When the watchdog is active after booting, then you
> should
> >    set this status bit (Note: when you register the watchdog timer
> device with
> >    this bit set, then opening /dev/watchdog will skip the start
> operation)
> > -* WDOG_DEV_OPEN: this status bit shows whether or not the watchdog
> device
> > -  was opened via /dev/watchdog.
> > -  (This bit should only be used by the WatchDog Timer Driver Core).
> > -* WDOG_ALLOW_RELEASE: this bit stores whether or not the magic close
> character
> > -  has been sent (so that we can support the magic close feature).
> > -  (This bit should only be used by the WatchDog Timer Driver Core).
> >  * WDOG_NO_WAY_OUT: this bit stores the nowayout setting for the
> watchdog.
> >    If this bit is set then the watchdog timer will not be able to stop.
> > -* WDOG_UNREGISTERED: this bit gets set by the WatchDog Timer Driver Core
> > -  after calling watchdog_unregister_device, and then checked before
> calling
> > -  any watchdog_ops, so that you can be sure that no operations (other
> then
> > -  unref) will get called after unregister, even if userspace still
> holds a
> > -  reference to /dev/watchdog
> >
> >    To set the WDOG_NO_WAY_OUT status bit (before registering your
> watchdog
> >    timer device) you can either:
> > diff --git a/drivers/watchdog/watchdog_core.c
> b/drivers/watchdog/watchdog_core.c
> > index f0293f7d2b80..ec1ab6c1a80b 100644
> > --- a/drivers/watchdog/watchdog_core.c
> > +++ b/drivers/watchdog/watchdog_core.c
> > @@ -210,8 +210,6 @@ static int __watchdog_register_device(struct
> watchdog_device *wdd)
> >        * corrupted in a later stage then we expect a kernel panic!
> >        */
> >
> > -     mutex_init(&wdd->lock);
> > -
> >       /* Use alias for watchdog id if possible */
> >       if (wdd->parent) {
> >               ret = of_alias_get_id(wdd->parent->of_node, "watchdog");
> > diff --git a/drivers/watchdog/watchdog_core.h
> b/drivers/watchdog/watchdog_core.h
> > index 86ff962d1e15..c9b0656284de 100644
> > --- a/drivers/watchdog/watchdog_core.h
> > +++ b/drivers/watchdog/watchdog_core.h
> > @@ -26,9 +26,32 @@
> >   *   This material is provided "AS-IS" and at no charge.
> >   */
> >
> > +#include <linux/cdev.h>
> > +#include <linux/kref.h>
> > +#include <linux/mutex.h>
> > +#include <linux/watchdog.h>
> > +
> >  #define MAX_DOGS     32      /* Maximum number of watchdog devices */
> >
> >  /*
> > + * struct _watchdog_device - watchdog core internal data
>
> Think it should be /**. Anyway, I find it confusing to have both
> _watchdog_device and watchdog_device, but I can't think of a better
> name right now.
>
> > + * @kref:    Reference count.
> > + * @cdev:    The watchdog's Character device.
> > + * @wdd:     Pointer to watchdog device.
> > + * @lock:    Lock for watchdog core.
> > + * @status:  Watchdog core internal status bits.
> > + */
> > +struct _watchdog_device {
>
we should probably find a better name for this structure... watchdog
 _adapter, _descriptor, or even _data
Also this style is quite confusing when __func() is wrapping func(),
usually this would be otherway around


> +     struct kref kref;
> > +     struct cdev cdev;
> > +     struct watchdog_device *wdd;
> > +     struct mutex lock;
> > +     unsigned long status;           /* Internal status bits */
> > +#define _WDOG_DEV_OPEN               0       /* Opened ? */
> > +#define _WDOG_ALLOW_RELEASE  1       /* Did we receive the magic char ?
> */
> > +};
> > +
> > +/*
> >   *   Functions/procedures to be called by the core
> >   */
> >  extern int watchdog_dev_register(struct watchdog_device *);
> > diff --git a/drivers/watchdog/watchdog_dev.c
> b/drivers/watchdog/watchdog_dev.c
> > index c24392623e98..e8416bdc7037 100644
> > --- a/drivers/watchdog/watchdog_dev.c
> > +++ b/drivers/watchdog/watchdog_dev.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/errno.h>     /* For the -ENODEV/... values */
> >  #include <linux/kernel.h>    /* For printk/panic/... */
> >  #include <linux/fs.h>                /* For file operations */
> > +#include <linux/slab.h>              /* For memory functions */
> >  #include <linux/watchdog.h>  /* For watchdog specific items */
> >  #include <linux/miscdevice.h>        /* For handling misc devices */
> >  #include <linux/init.h>              /* For __init/__exit/... */
> > @@ -47,12 +48,14 @@
> >  /* the dev_t structure to store the dynamically allocated watchdog
> devices */
> >  static dev_t watchdog_devt;
> >  /* the watchdog device behind /dev/watchdog */
> > -static struct watchdog_device *old_wdd;
> > +static struct _watchdog_device *_old_wdd;
> >
> >  /*
> >   *   watchdog_ping: ping the watchdog.
> >   *   @wdd: the watchdog device to ping
> >   *
> > + *   The caller must hold _wdd->lock.
> > + *
> >   *   If the watchdog has no own ping operation then it needs to be
> >   *   restarted via the start operation. This wrapper function does
> >   *   exactly that.
> > @@ -61,25 +64,37 @@ static struct watchdog_device *old_wdd;
> >
> >  static int watchdog_ping(struct watchdog_device *wdd)
>
Not sure this lockless wrappers are really needed.

> >  {
> > -     int err = 0;
> > -
> > -     mutex_lock(&wdd->lock);
> > -
> > -     if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
> > -             err = -ENODEV;
> > -             goto out_ping;
> > -     }
> > +     int err;
> >
> >       if (!watchdog_active(wdd))
> > -             goto out_ping;
> > +             return 0;
> >
> >       if (wdd->ops->ping)
> >               err = wdd->ops->ping(wdd);      /* ping the watchdog */
> >       else
> >               err = wdd->ops->start(wdd);     /* restart watchdog */
> >
> > -out_ping:
> > -     mutex_unlock(&wdd->lock);
> > +     return err;
> > +}
> > +
> > +/*
> > + *   _watchdog_ping: ping the watchdog.
> > + *   @_wdd: Watchdog core device data
> > + *
> > + *   Acquire _wdd->lock and call watchdog_ping() unless the watchdog
> > + *   driver has been unregistered.
> > + */
> > +static int _watchdog_ping(struct _watchdog_device *_wdd)
>
Use of double underscore __ is more comon .

> > +{
> > +     struct watchdog_device *wdd;
> > +     int err = -ENODEV;
> > +
> > +     mutex_lock(&_wdd->lock);
> > +     wdd = _wdd->wdd;
> > +     if (wdd)
> > +             err = watchdog_ping(wdd);
> > +     mutex_unlock(&_wdd->lock);
> > +
> >       return err;
> >  }
> >
> > @@ -87,6 +102,8 @@ out_ping:
> >   *   watchdog_start: wrapper to start the watchdog.
> >   *   @wdd: the watchdog device to start
> >   *
> > + *   The caller must hold _wdd->lock.
> > + *
> >   *   Start the watchdog if it is not active and mark it active.
> >   *   This function returns zero on success or a negative errno code for
> >   *   failure.
> > @@ -94,24 +111,15 @@ out_ping:
> >
> >  static int watchdog_start(struct watchdog_device *wdd)
> >  {
> > -     int err = 0;
> > -
> > -     mutex_lock(&wdd->lock);
> > -
> > -     if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
> > -             err = -ENODEV;
> > -             goto out_start;
> > -     }
> > +     int err;
> >
> >       if (watchdog_active(wdd))
> > -             goto out_start;
> > +             return 0;
> >
> >       err = wdd->ops->start(wdd);
> >       if (err == 0)
> >               set_bit(WDOG_ACTIVE, &wdd->status);
> >
> > -out_start:
> > -     mutex_unlock(&wdd->lock);
> >       return err;
> >  }
> >
> > @@ -119,6 +127,8 @@ out_start:
> >   *   watchdog_stop: wrapper to stop the watchdog.
> >   *   @wdd: the watchdog device to stop
> >   *
> > + *   The caller must hold _wdd->lock.
> > + *
> >   *   Stop the watchdog if it is still active and unmark it active.
> >   *   This function returns zero on success or a negative errno code for
> >   *   failure.
> > @@ -127,93 +137,58 @@ out_start:
> >
> >  static int watchdog_stop(struct watchdog_device *wdd)
> >  {
> > -     int err = 0;
> > -
> > -     mutex_lock(&wdd->lock);
> > -
> > -     if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
> > -             err = -ENODEV;
> > -             goto out_stop;
> > -     }
> > +     int err;
> >
> >       if (!watchdog_active(wdd))
> > -             goto out_stop;
> > +             return 0;
> >
> >       if (test_bit(WDOG_NO_WAY_OUT, &wdd->status)) {
> >               dev_info(wdd->dev, "nowayout prevents watchdog being
> stopped!\n");
> > -             err = -EBUSY;
> > -             goto out_stop;
> > +             return -EBUSY;
> >       }
> >
> >       err = wdd->ops->stop(wdd);
> >       if (err == 0)
> >               clear_bit(WDOG_ACTIVE, &wdd->status);
> >
> > -out_stop:
> > -     mutex_unlock(&wdd->lock);
> >       return err;
> >  }
> >
> >  /*
> >   *   watchdog_get_status: wrapper to get the watchdog status
> >   *   @wdd: the watchdog device to get the status from
> > - *   @status: the status of the watchdog device
> > + *
> > + *   The caller must hold _wdd->lock.
> >   *
> >   *   Get the watchdog's status flags.
> >   */
> >
> > -static int watchdog_get_status(struct watchdog_device *wdd,
> > -                                                     unsigned int
> *status)
> > +static unsigned int watchdog_get_status(struct watchdog_device *wdd)
> >  {
> > -     int err = 0;
> > -
> > -     *status = 0;
> >       if (!wdd->ops->status)
> > -             return -EOPNOTSUPP;
> > -
> > -     mutex_lock(&wdd->lock);
> > -
> > -     if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
> > -             err = -ENODEV;
> > -             goto out_status;
> > -     }
> > -
> > -     *status = wdd->ops->status(wdd);
> > +             return 0;
> >
> > -out_status:
> > -     mutex_unlock(&wdd->lock);
> > -     return err;
> > +     return wdd->ops->status(wdd);
> >  }
> >
> >  /*
> >   *   watchdog_set_timeout: set the watchdog timer timeout
> >   *   @wdd: the watchdog device to set the timeout for
> >   *   @timeout: timeout to set in seconds
> > + *
> > + *   The caller must hold _wdd->lock.
> >   */
> >
> >  static int watchdog_set_timeout(struct watchdog_device *wdd,
> >                                                       unsigned int
> timeout)
> >  {
> > -     int err;
> > -
> >       if (!wdd->ops->set_timeout || !(wdd->info->options &
> WDIOF_SETTIMEOUT))
> >               return -EOPNOTSUPP;
> >
> >       if (watchdog_timeout_invalid(wdd, timeout))
> >               return -EINVAL;
> >
> > -     mutex_lock(&wdd->lock);
> > -
> > -     if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
> > -             err = -ENODEV;
> > -             goto out_timeout;
> > -     }
> > -
> > -     err = wdd->ops->set_timeout(wdd, timeout);
> > -
> > -out_timeout:
> > -     mutex_unlock(&wdd->lock);
> > -     return err;
> > +     return wdd->ops->set_timeout(wdd, timeout);
> >  }
> >
> >  /*
> > @@ -221,30 +196,22 @@ out_timeout:
> >   *   @wdd: the watchdog device to get the remaining time from
> >   *   @timeleft: the time that's left
> >   *
> > + *   The caller must hold _wdd->lock.
> > + *
> >   *   Get the time before a watchdog will reboot (if not pinged).
> >   */
> >
> >  static int watchdog_get_timeleft(struct watchdog_device *wdd,
> >                                                       unsigned int
> *timeleft)
> >  {
> > -     int err = 0;
> > -
> >       *timeleft = 0;
> > +
> >       if (!wdd->ops->get_timeleft)
> >               return -EOPNOTSUPP;
> >
> > -     mutex_lock(&wdd->lock);
> > -
> > -     if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
> > -             err = -ENODEV;
> > -             goto out_timeleft;
> > -     }
> > -
> >       *timeleft = wdd->ops->get_timeleft(wdd);
> >
> > -out_timeleft:
> > -     mutex_unlock(&wdd->lock);
> > -     return err;
> > +     return 0;
> >  }
> >
> >  #ifdef CONFIG_WATCHDOG_SYSFS
> > @@ -261,14 +228,14 @@ static ssize_t status_show(struct device *dev,
> struct device_attribute *attr,
> >                               char *buf)
> >  {
> >       struct watchdog_device *wdd = dev_get_drvdata(dev);
> > -     ssize_t status;
> > -     unsigned int val;
> > +     struct _watchdog_device *_wdd = wdd->wdd_data;
> > +     unsigned int status;
> >
> > -     status = watchdog_get_status(wdd, &val);
> > -     if (!status)
> > -             status = sprintf(buf, "%u\n", val);
> > +     mutex_lock(&_wdd->lock);
> > +     status = watchdog_get_status(wdd);
> > +     mutex_unlock(&_wdd->lock);
> >
> > -     return status;
> > +     return sprintf(buf, "%u\n", status);
> >  }
> >  static DEVICE_ATTR_RO(status);
> >
> > @@ -285,10 +252,13 @@ static ssize_t timeleft_show(struct device *dev,
> struct device_attribute *attr,
> >                               char *buf)
> >  {
> >       struct watchdog_device *wdd = dev_get_drvdata(dev);
> > +     struct _watchdog_device *_wdd = wdd->wdd_data;
> >       ssize_t status;
> >       unsigned int val;
> >
> > +     mutex_lock(&_wdd->lock);
> >       status = watchdog_get_timeleft(wdd, &val);
> > +     mutex_unlock(&_wdd->lock);
> >       if (!status)
> >               status = sprintf(buf, "%u\n", val);
> >
> > @@ -363,28 +333,17 @@ __ATTRIBUTE_GROUPS(wdt);
> >   *   @wdd: the watchdog device to do the ioctl on
> >   *   @cmd: watchdog command
> >   *   @arg: argument pointer
> > + *
> > + *   The caller must hold _wdd->lock.
> >   */
> >
> >  static int watchdog_ioctl_op(struct watchdog_device *wdd, unsigned int
> cmd,
> >                                                       unsigned long arg)
> >  {
> > -     int err;
> > -
> >       if (!wdd->ops->ioctl)
> >               return -ENOIOCTLCMD;
> >
> > -     mutex_lock(&wdd->lock);
> > -
> > -     if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
> > -             err = -ENODEV;
> > -             goto out_ioctl;
> > -     }
> > -
> > -     err = wdd->ops->ioctl(wdd, cmd, arg);
> > -
> > -out_ioctl:
> > -     mutex_unlock(&wdd->lock);
> > -     return err;
> > +     return wdd->ops->ioctl(wdd, cmd, arg);
> >  }
> >
> >  /*
> > @@ -402,7 +361,7 @@ out_ioctl:
> >  static ssize_t watchdog_write(struct file *file, const char __user
> *data,
> >                                               size_t len, loff_t *ppos)
> >  {
> > -     struct watchdog_device *wdd = file->private_data;
> > +     struct _watchdog_device *_wdd = file->private_data;
> >       size_t i;
> >       char c;
> >       int err;
> > @@ -414,18 +373,18 @@ static ssize_t watchdog_write(struct file *file,
> const char __user *data,
> >        * Note: just in case someone wrote the magic character
> >        * five months ago...
> >        */
> > -     clear_bit(WDOG_ALLOW_RELEASE, &wdd->status);
> > +     clear_bit(_WDOG_ALLOW_RELEASE, &_wdd->status);
> >
> >       /* scan to see whether or not we got the magic character */
> >       for (i = 0; i != len; i++) {
> >               if (get_user(c, data + i))
> >                       return -EFAULT;
> >               if (c == 'V')
> > -                     set_bit(WDOG_ALLOW_RELEASE, &wdd->status);
> > +                     set_bit(_WDOG_ALLOW_RELEASE, &_wdd->status);
> >       }
> >
> >       /* someone wrote to us, so we send the watchdog a keepalive ping */
> > -     err = watchdog_ping(wdd);
> > +     err = _watchdog_ping(_wdd);
> >       if (err < 0)
> >               return err;
> >
> > @@ -445,71 +404,94 @@ static ssize_t watchdog_write(struct file *file,
> const char __user *data,
> >  static long watchdog_ioctl(struct file *file, unsigned int cmd,
> >                                                       unsigned long arg)
> >  {
> > -     struct watchdog_device *wdd = file->private_data;
> > +     struct _watchdog_device *_wdd = file->private_data;
> >       void __user *argp = (void __user *)arg;
> > +     struct watchdog_device *wdd;
> >       int __user *p = argp;
> >       unsigned int val;
> > -     int err;
> > +     int err = 0;
> > +
> > +     mutex_lock(&_wdd->lock);
> > +
> > +     wdd = _wdd->wdd;
> > +     if (!wdd) {
> > +             err = -ENODEV;
> > +             goto out_ioctl;
> > +     }
> >
> >       err = watchdog_ioctl_op(wdd, cmd, arg);
> >       if (err != -ENOIOCTLCMD)
> > -             return err;
> > +             goto out_ioctl;
> >
> >       switch (cmd) {
> >       case WDIOC_GETSUPPORT:
> > -             return copy_to_user(argp, wdd->info,
> > +             err = copy_to_user(argp, wdd->info,
> >                       sizeof(struct watchdog_info)) ? -EFAULT : 0;
> > +             break;
> >       case WDIOC_GETSTATUS:
> > -             err = watchdog_get_status(wdd, &val);
> > -             if (err == -ENODEV)
> > -                     return err;
> > -             return put_user(val, p);
> > +             val = watchdog_get_status(wdd);
> > +             err = put_user(val, p);
> > +             break;
> >       case WDIOC_GETBOOTSTATUS:
> > -             return put_user(wdd->bootstatus, p);
> > +             err = put_user(wdd->bootstatus, p);
> > +             break;
> >       case WDIOC_SETOPTIONS:
> > -             if (get_user(val, p))
> > -                     return -EFAULT;
> > +             if (get_user(val, p)) {
> > +                     err = -EFAULT;
> > +                     break;
> > +             }
> >               if (val & WDIOS_DISABLECARD) {
> >                       err = watchdog_stop(wdd);
> >                       if (err < 0)
> > -                             return err;
> > +                             break;
> >               }
> > -             if (val & WDIOS_ENABLECARD) {
> > +             if (val & WDIOS_ENABLECARD)
> >                       err = watchdog_start(wdd);
> > -                     if (err < 0)
> > -                             return err;
> > -             }
> > -             return 0;
> > +             break;
> >       case WDIOC_KEEPALIVE:
> > -             if (!(wdd->info->options & WDIOF_KEEPALIVEPING))
> > -                     return -EOPNOTSUPP;
> > -             return watchdog_ping(wdd);
> > +             if (!(wdd->info->options & WDIOF_KEEPALIVEPING)) {
> > +                     err = -EOPNOTSUPP;
> > +                     break;
> > +             }
> > +             err = watchdog_ping(wdd);
> > +             break;
> >       case WDIOC_SETTIMEOUT:
> > -             if (get_user(val, p))
> > -                     return -EFAULT;
> > +             if (get_user(val, p)) {
> > +                     err = -EFAULT;
> > +                     break;
> > +             }
> >               err = watchdog_set_timeout(wdd, val);
> >               if (err < 0)
> > -                     return err;
> > +                     break;
> >               /* If the watchdog is active then we send a keepalive ping
> >                * to make sure that the watchdog keep's running (and if
> >                * possible that it takes the new timeout) */
> >               err = watchdog_ping(wdd);
> >               if (err < 0)
> > -                     return err;
> > +                     break;
>
You are changing behaviour for the driver here as you are keeping lock over
two driver op calls.


> >               /* Fall */
> >       case WDIOC_GETTIMEOUT:
> >               /* timeout == 0 means that we don't know the timeout */
> > -             if (wdd->timeout == 0)
> > -                     return -EOPNOTSUPP;
> > -             return put_user(wdd->timeout, p);
> > +             if (wdd->timeout == 0) {
> > +                     err = -EOPNOTSUPP;
> > +                     break;
> > +             }
> > +             err = put_user(wdd->timeout, p);
> > +             break;
> >       case WDIOC_GETTIMELEFT:
> >               err = watchdog_get_timeleft(wdd, &val);
> > -             if (err)
> > -                     return err;
> > -             return put_user(val, p);
> > +             if (err < 0)
> > +                     break;
> > +             err = put_user(val, p);
> > +             break;
> >       default:
> > -             return -ENOTTY;
> > +             err = -ENOTTY;
> > +             break;
> >       }
> > +
> > +out_ioctl:
> > +     mutex_unlock(&_wdd->lock);
> > +     return err;
> >  }
> >
> >  /*
> > @@ -524,45 +506,68 @@ static long watchdog_ioctl(struct file *file,
> unsigned int cmd,
> >
> >  static int watchdog_open(struct inode *inode, struct file *file)
> >  {
> > -     int err = -EBUSY;
> > +     struct _watchdog_device *_wdd;
> >       struct watchdog_device *wdd;
> > +     int err;
> >
> >       /* Get the corresponding watchdog device */
> >       if (imajor(inode) == MISC_MAJOR)
> > -             wdd = old_wdd;
> > +             _wdd = _old_wdd;
> >       else
> > -             wdd = container_of(inode->i_cdev, struct watchdog_device,
> cdev);
> > +             _wdd = container_of(inode->i_cdev, struct _watchdog_device,
> > +                                 cdev);
> >
> >       /* the watchdog is single open! */
> > -     if (test_and_set_bit(WDOG_DEV_OPEN, &wdd->status))
> > +     if (test_and_set_bit(_WDOG_DEV_OPEN, &_wdd->status))
> >               return -EBUSY;
> >
> > +     mutex_lock(&_wdd->lock);
> > +
> > +     wdd = _wdd->wdd;
> > +     if (!wdd) {
> > +             err = -ENODEV;
> > +             goto out_clear;
> > +     }
> > +
> >       /*
> >        * If the /dev/watchdog device is open, we don't want the module
> >        * to be unloaded.
> >        */
> > -     if (!try_module_get(wdd->ops->owner))
> > -             goto out;
> > +     if (!try_module_get(wdd->ops->owner)) {
> > +             err = -EBUSY;
> > +             goto out_clear;
> > +     }
> >
> >       err = watchdog_start(wdd);
> >       if (err < 0)
> >               goto out_mod;
> >
> > -     file->private_data = wdd;
> > +     file->private_data = _wdd;
> >
> > -     if (wdd->ops->ref)
> > -             wdd->ops->ref(wdd);
> > +     kref_get(&_wdd->kref);
> >
> >       /* dev/watchdog is a virtual (and thus non-seekable) filesystem */
> > -     return nonseekable_open(inode, file);
> > +     err = nonseekable_open(inode, file);
> > +     goto out_unlock;
> >
> >  out_mod:
> > -     module_put(wdd->ops->owner);
> > -out:
> > -     clear_bit(WDOG_DEV_OPEN, &wdd->status);
> > +     module_put(_wdd->wdd->ops->owner);
> > +out_clear:
> > +     clear_bit(_WDOG_DEV_OPEN, &_wdd->status);
> > +out_unlock:
> > +     mutex_unlock(&_wdd->lock);
> >       return err;
> >  }
> >
> > +static void watchdog_wdd_release(struct kref *kref)
> > +{
> > +     struct _watchdog_device *_wdd;
> > +
> > +     _wdd = container_of(kref, struct _watchdog_device, kref);
> > +
> > +     kfree(_wdd);
> > +}
> > +
> >  /*
> >   *   watchdog_release: release the watchdog device.
> >   *   @inode: inode of device
> > @@ -575,9 +580,16 @@ out:
> >
> >  static int watchdog_release(struct inode *inode, struct file *file)
> >  {
> > -     struct watchdog_device *wdd = file->private_data;
> > +     struct _watchdog_device *_wdd = file->private_data;
> > +     struct watchdog_device *wdd;
> >       int err = -EBUSY;
> >
> > +     mutex_lock(&_wdd->lock);
> > +
> > +     wdd = _wdd->wdd;
> > +     if (!wdd)
> > +             goto done;
> > +
> >       /*
> >        * We only stop the watchdog if we received the magic character
> >        * or if WDIOF_MAGICCLOSE is not set. If nowayout was set then
> > @@ -585,29 +597,24 @@ static int watchdog_release(struct inode *inode,
> struct file *file)
> >        */
> >       if (!test_bit(WDOG_ACTIVE, &wdd->status))
> >               err = 0;
> > -     else if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
> > +     else if (test_and_clear_bit(_WDOG_ALLOW_RELEASE, &_wdd->status) ||
> >                !(wdd->info->options & WDIOF_MAGICCLOSE))
> >               err = watchdog_stop(wdd);
> >
> >       /* If the watchdog was not stopped, send a keepalive ping */
> >       if (err < 0) {
> > -             mutex_lock(&wdd->lock);
> > -             if (!test_bit(WDOG_UNREGISTERED, &wdd->status))
> > -                     dev_crit(wdd->dev, "watchdog did not stop!\n");
> > -             mutex_unlock(&wdd->lock);
> > +             dev_crit(wdd->dev, "watchdog did not stop!\n");
> >               watchdog_ping(wdd);
> >       }
> >
> > -     /* Allow the owner module to be unloaded again */
> > -     module_put(wdd->ops->owner);
> > -
> >       /* make sure that /dev/watchdog can be re-opened */
> > -     clear_bit(WDOG_DEV_OPEN, &wdd->status);
> > -
> > -     /* Note wdd may be gone after this, do not use after this! */
> > -     if (wdd->ops->unref)
> > -             wdd->ops->unref(wdd);
> > +     clear_bit(_WDOG_DEV_OPEN, &_wdd->status);
> >
> > +done:
> > +     mutex_unlock(&_wdd->lock);
> > +     /* Allow the owner module to be unloaded again */
> > +     module_put(_wdd->cdev.owner);
> > +     kref_put(&_wdd->kref, watchdog_wdd_release);
> >       return 0;
> >  }
> >
> > @@ -637,10 +644,20 @@ static struct miscdevice watchdog_miscdev = {
> >
> >  static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t
> devno)
> >  {
> > +     struct _watchdog_device *_wdd;
> >       int err;
> >
> > +     _wdd = kzalloc(sizeof(struct _watchdog_device), GFP_KERNEL);
> > +     if (!_wdd)
> > +             return -ENOMEM;
> > +     kref_init(&_wdd->kref);
> > +     mutex_init(&_wdd->lock);
> > +
> > +     _wdd->wdd = wdd;
> > +     wdd->wdd_data = _wdd;
> > +
> >       if (wdd->id == 0) {
> > -             old_wdd = wdd;
> > +             _old_wdd = _wdd;
> >               watchdog_miscdev.parent = wdd->parent;
> >               err = misc_register(&watchdog_miscdev);
> >               if (err != 0) {
> > @@ -649,23 +666,25 @@ static int watchdog_cdev_register(struct
> watchdog_device *wdd, dev_t devno)
> >                       if (err == -EBUSY)
> >                               pr_err("%s: a legacy watchdog module is
> probably present.\n",
> >                                       wdd->info->identity);
> > -                     old_wdd = NULL;
> > +                     _old_wdd = NULL;
> > +                     kfree(_wdd);
> >                       return err;
> >               }
> >       }
> >
> >       /* Fill in the data structures */
> > -     cdev_init(&wdd->cdev, &watchdog_fops);
> > -     wdd->cdev.owner = wdd->ops->owner;
> > +     cdev_init(&_wdd->cdev, &watchdog_fops);
> > +     _wdd->cdev.owner = wdd->ops->owner;
> >
> >       /* Add the device */
> > -     err  = cdev_add(&wdd->cdev, devno, 1);
> > +     err = cdev_add(&_wdd->cdev, devno, 1);
> >       if (err) {
> >               pr_err("watchdog%d unable to add device %d:%d\n",
> >                       wdd->id,  MAJOR(watchdog_devt), wdd->id);
> >               if (wdd->id == 0) {
> >                       misc_deregister(&watchdog_miscdev);
> > -                     old_wdd = NULL;
> > +                     _old_wdd = NULL;
> > +                     kref_put(&_wdd->kref, watchdog_wdd_release);
> >               }
> >       }
> >       return err;
> > @@ -681,15 +700,23 @@ static int watchdog_cdev_register(struct
> watchdog_device *wdd, dev_t devno)
> >
> >  static void watchdog_cdev_unregister(struct watchdog_device *wdd)
> >  {
> > -     mutex_lock(&wdd->lock);
> > -     set_bit(WDOG_UNREGISTERED, &wdd->status);
> > -     mutex_unlock(&wdd->lock);
> > +     struct _watchdog_device *_wdd = wdd->wdd_data;
> >
> > -     cdev_del(&wdd->cdev);
> > +     cdev_del(&_wdd->cdev);
> >       if (wdd->id == 0) {
> >               misc_deregister(&watchdog_miscdev);
> > -             old_wdd = NULL;
> > +             _old_wdd = NULL;
> >       }
> > +
> > +     if (watchdog_active(wdd))
> > +             pr_crit("watchdog%d: watchdog still running!\n", wdd->id);
>
> As it is now safe to unbind and rebind a driver, it means that a
> watchdog driver probe function can now be called with a running
> watchdog. Some drivers handle this situation, but I think that most of
> them expect the watchdog to be off at this point.
>
> > +
> > +     mutex_lock(&_wdd->lock);
> > +     _wdd->wdd = NULL;
> > +     wdd->wdd_data = NULL;
> > +     mutex_unlock(&_wdd->lock);
> > +
> > +     kref_put(&_wdd->kref, watchdog_wdd_release);
> >  }
> >
> >  static struct class watchdog_class = {
> > @@ -742,9 +769,9 @@ int watchdog_dev_register(struct watchdog_device
> *wdd)
> >
> >  void watchdog_dev_unregister(struct watchdog_device *wdd)
> >  {
> > -     watchdog_cdev_unregister(wdd);
> >       device_destroy(&watchdog_class, wdd->dev->devt);
> >       wdd->dev = NULL;
> > +     watchdog_cdev_unregister(wdd);
> >  }
> >
> >  /*
> > diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> > index a88f955fde92..1d3363aeb6e4 100644
> > --- a/include/linux/watchdog.h
> > +++ b/include/linux/watchdog.h
> > @@ -28,8 +28,6 @@ struct watchdog_device;
> >   * @set_timeout:The routine for setting the watchdog devices timeout
> value (in seconds).
> >   * @get_timeleft:The routine that gets the time left before a reset (in
> seconds).
> >   * @restart: The routine for restarting the machine.
> > - * @ref:     The ref operation for dyn. allocated watchdog_device
> structs
> > - * @unref:   The unref operation for dyn. allocated watchdog_device
> structs
> >   * @ioctl:   The routines that handles extra ioctl calls.
> >   *
> >   * The watchdog_ops structure contains a list of low-level operations
> > @@ -48,15 +46,14 @@ struct watchdog_ops {
> >       int (*set_timeout)(struct watchdog_device *, unsigned int);
> >       unsigned int (*get_timeleft)(struct watchdog_device *);
> >       int (*restart)(struct watchdog_device *);
> > -     void (*ref)(struct watchdog_device *);
> > -     void (*unref)(struct watchdog_device *);
> > +     void (*ref)(struct watchdog_device *) __deprecated;
> > +     void (*unref)(struct watchdog_device *) __deprecated;
> >       long (*ioctl)(struct watchdog_device *, unsigned int, unsigned
> long);
> >  };
> >
> >  /** struct watchdog_device - The structure that defines a watchdog
> device
> >   *
> >   * @id:              The watchdog's ID. (Allocated by
> watchdog_register_device)
> > - * @cdev:    The watchdog's Character device.
> >   * @dev:     The device for our watchdog
> >   * @parent:  The parent bus device
> >   * @info:    Pointer to a watchdog_info structure.
> > @@ -67,8 +64,8 @@ struct watchdog_ops {
> >   * @max_timeout:The watchdog devices maximum timeout value (in seconds).
> >   * @reboot_nb:       The notifier block to stop watchdog on reboot.
> >   * @restart_nb:      The notifier block to register a restart function.
> > - * @driver-data:Pointer to the drivers private data.
> > - * @lock:    Lock for watchdog core internal use only.
> > + * @driver_data:Pointer to the drivers private data.
> > + * @wdd_data:        Pointer to watchdog core internal data.
> >   * @status:  Field that contains the devices internal status bits.
> >   * @deferred: entry in wtd_deferred_reg_list which is used to
> >   *                      register early initialized watchdogs.
> > @@ -84,7 +81,6 @@ struct watchdog_ops {
> >   */
> >  struct watchdog_device {
> >       int id;
> > -     struct cdev cdev;
> >       struct device *dev;
> >       struct device *parent;
> >       const struct watchdog_info *info;
> > @@ -96,15 +92,12 @@ struct watchdog_device {
> >       struct notifier_block reboot_nb;
> >       struct notifier_block restart_nb;
> >       void *driver_data;
> > -     struct mutex lock;
> > +     void *wdd_data;
> >       unsigned long status;
> >  /* Bit numbers for status flags */
> >  #define WDOG_ACTIVE          0       /* Is the watchdog running/active
> */
> > -#define WDOG_DEV_OPEN                1       /* Opened via
> /dev/watchdog ? */
> > -#define WDOG_ALLOW_RELEASE   2       /* Did we receive the magic char ?
> */
> > -#define WDOG_NO_WAY_OUT              3       /* Is 'nowayout' feature
> set ? */
> > -#define WDOG_UNREGISTERED    4       /* Has the device been
> unregistered */
> > -#define WDOG_STOP_ON_REBOOT  5       /* Should be stopped on reboot */
> > +#define WDOG_NO_WAY_OUT              1       /* Is 'nowayout' feature
> set ? */
> > +#define WDOG_STOP_ON_REBOOT  2       /* Should be stopped on reboot */
> >       struct list_head deferred;
> >  };
> >
> > --
> > 2.1.4
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a114527fc26ce1b052770525f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Dec 21, 2015 at 7:28 PM, Damien Riegel <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:damien.riegel@savoirfairelinux.com" target=3D"_blank">damie=
n.riegel@savoirfairelinux.com</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><span>On Sun, Dec 20, 2015 at 01:05:00PM -0800, Guenter Roeck wr=
ote:<br>
&gt; All variables required by the watchdog core to manage a watchdog are<b=
r>
&gt; currently stored in struct watchdog_device. The lifetime of those<br>
&gt; variables is determined by the watchdog driver. However, the lifetime<=
br>
&gt; of variables used by the watchdog core differs from the lifetime of<br=
>
&gt; struct watchdog_device. To remedy this situation, watchdog drivers<br>
&gt; can implement ref and unref callbacks, to be used by the watchdog<br>
&gt; core to lock struct watchdog_device in memory.<br>
&gt;<br>
&gt; While this solves the immediate problem, it depends on watchdog driver=
s<br>
&gt; to actually implement the ref/unref callbacks. This is error prone,<br=
>
&gt; often not implemented in the first place, or not implemented correctly=
.<br>
&gt;<br>
&gt; To solve the problem without requiring driver support, split the varia=
bles<br>
&gt; in struct watchdog_device into two data structures - one for variables=
<br>
&gt; associated with the watchdog driver, one for variables associated with=
<br>
&gt; the watchdog core. With this approach, the watchdog core can keep trac=
k<br>
&gt; of its variable lifetime and no longer depends on ref/unref callbacks<=
br>
&gt; in the driver. As a side effect, some of the variables originally in<b=
r>
&gt; struct watchdog_driver are now private to the watchdog core and no lon=
ger<br>
&gt; visible in watchdog drivers.<br>
&gt;<br>
&gt; The &#39;ref&#39; and &#39;unref&#39; callbacks in struct watchdog_dri=
ver are no longer<br>
&gt; used and marked as deprecated.<br>
<br>
</span>Two comments below. It&#39;s great to see that unbinding a driver no=
 longer<br>
triggers a kernel panic.<br>
<div><div><br>
&gt;<br>
&gt; Signed-off-by: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net"=
 target=3D"_blank">linux@roeck-us.net</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 Documentation/watchdog/watchdog-kernel-api.txt |=C2=A0 45 +--<br=
>
&gt;=C2=A0 drivers/watchdog/watchdog_core.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 -<br>
&gt;=C2=A0 drivers/watchdog/watchdog_core.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 23 ++<br>
&gt;=C2=A0 drivers/watchdog/watchdog_dev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 377 +++++++++++++------------<br>
&gt;=C2=A0 include/linux/watchdog.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 21 +-<br>
&gt;=C2=A0 5 files changed, 239 insertions(+), 229 deletions(-)<br>
&gt;<br>
&gt; diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Document=
ation/watchdog/watchdog-kernel-api.txt<br>
&gt; index 0a37da76acef..3db5092924e5 100644<br>
&gt; --- a/Documentation/watchdog/watchdog-kernel-api.txt<br>
&gt; +++ b/Documentation/watchdog/watchdog-kernel-api.txt<br>
&gt; @@ -44,7 +44,6 @@ The watchdog device structure looks like this:<br>
&gt;<br>
&gt;=C2=A0 struct watchdog_device {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int id;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct cdev cdev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *parent;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct watchdog_info *info;<br>
&gt; @@ -56,7 +55,7 @@ struct watchdog_device {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct notifier_block reboot_nb;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct notifier_block restart_nb;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void *driver_data;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct mutex lock;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void *wdd_data;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head deferred;<br>
&gt;=C2=A0 };<br>
&gt; @@ -66,8 +65,6 @@ It contains following fields:<br>
&gt;=C2=A0 =C2=A0 /dev/watchdog0 cdev (dynamic major, minor 0) as well as t=
he old<br>
&gt;=C2=A0 =C2=A0 /dev/watchdog miscdev. The id is set automatically when c=
alling<br>
&gt;=C2=A0 =C2=A0 watchdog_register_device.<br>
&gt; -* cdev: cdev for the dynamic /dev/watchdog&lt;id&gt; device nodes. Th=
is<br>
&gt; -=C2=A0 field is also populated by watchdog_register_device.<br>
&gt;=C2=A0 * dev: device under the watchdog class (created by watchdog_regi=
ster_device).<br>
&gt;=C2=A0 * parent: set this to the parent device (or NULL) before calling=
<br>
&gt;=C2=A0 =C2=A0 watchdog_register_device.<br>
&gt; @@ -89,11 +86,10 @@ It contains following fields:<br>
&gt;=C2=A0 * driver_data: a pointer to the drivers private data of a watchd=
og device.<br>
&gt;=C2=A0 =C2=A0 This data should only be accessed via the watchdog_set_dr=
vdata and<br>
&gt;=C2=A0 =C2=A0 watchdog_get_drvdata routines.<br>
&gt; -* lock: Mutex for WatchDog Timer Driver Core internal use only.<br>
&gt; +* wdd_data: a pointer to watchdog core internal data.<br>
&gt;=C2=A0 * status: this field contains a number of status bits that give =
extra<br>
&gt;=C2=A0 =C2=A0 information about the status of the device (Like: is the =
watchdog timer<br>
&gt; -=C2=A0 running/active, is the nowayout bit set, is the device opened =
via<br>
&gt; -=C2=A0 the /dev/watchdog interface or not, ...).<br>
&gt; +=C2=A0 running/active, or is the nowayout bit set).<br>
&gt;=C2=A0 * deferred: entry in wtd_deferred_reg_list which is used to<br>
&gt;=C2=A0 =C2=A0 register early initialized watchdogs.<br>
&gt;<br>
&gt; @@ -110,8 +106,8 @@ struct watchdog_ops {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*set_timeout)(struct watchdog_device *,=
 unsigned int);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int (*get_timeleft)(struct watchdog=
_device *);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*restart)(struct watchdog_device *);<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0void (*ref)(struct watchdog_device *);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0void (*unref)(struct watchdog_device *);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void (*ref)(struct watchdog_device *) __deprecate=
d;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void (*unref)(struct watchdog_device *) __depreca=
ted;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0long (*ioctl)(struct watchdog_device *, unsi=
gned int, unsigned long);<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; @@ -120,20 +116,6 @@ driver&#39;s operations. This module owner will b=
e used to lock the module when<br>
&gt;=C2=A0 the watchdog is active. (This to avoid a system crash when you u=
nload the<br>
&gt;=C2=A0 module and /dev/watchdog is still open).<br>
&gt;<br>
&gt; -If the watchdog_device struct is dynamically allocated, just locking =
the module<br>
&gt; -is not enough and a driver also needs to define the ref and unref ope=
rations to<br>
&gt; -ensure the structure holding the watchdog_device does not go away.<br=
>
&gt; -<br>
&gt; -The simplest (and usually sufficient) implementation of this is to:<b=
r>
&gt; -1) Add a kref struct to the same structure which is holding the watch=
dog_device<br>
&gt; -2) Define a release callback for the kref which frees the struct hold=
ing both<br>
&gt; -3) Call kref_init on this kref *before* calling watchdog_register_dev=
ice()<br>
&gt; -4) Define a ref operation calling kref_get on this kref<br>
&gt; -5) Define a unref operation calling kref_put on this kref<br>
&gt; -6) When it is time to cleanup:<br>
&gt; - * Do not kfree() the struct holding both, the last kref_put will do =
this!<br>
&gt; - * *After* calling watchdog_unregister_device() call kref_put on the =
kref<br>
&gt; -<br>
&gt;=C2=A0 Some operations are mandatory and some are optional. The mandato=
ry operations<br>
&gt;=C2=A0 are:<br>
&gt;=C2=A0 * start: this is a pointer to the routine that starts the watchd=
og timer<br>
&gt; @@ -176,34 +158,21 @@ they are supported. These optional routines/oper=
ations are:<br>
&gt;=C2=A0 * get_timeleft: this routines returns the time that&#39;s left b=
efore a reset.<br>
&gt;=C2=A0 * restart: this routine restarts the machine. It returns 0 on su=
ccess or a<br>
&gt;=C2=A0 =C2=A0 negative errno code for failure.<br>
&gt; -* ref: the operation that calls kref_get on the kref of a dynamically=
<br>
&gt; -=C2=A0 allocated watchdog_device struct.<br>
&gt; -* unref: the operation that calls kref_put on the kref of a dynamical=
ly<br>
&gt; -=C2=A0 allocated watchdog_device struct.<br>
&gt;=C2=A0 * ioctl: if this routine is present then it will be called first=
 before we do<br>
&gt;=C2=A0 =C2=A0 our own internal ioctl call handling. This routine should=
 return -ENOIOCTLCMD<br>
&gt;=C2=A0 =C2=A0 if a command is not supported. The parameters that are pa=
ssed to the ioctl<br>
&gt;=C2=A0 =C2=A0 call are: watchdog_device, cmd and arg.<br>
&gt;<br>
&gt; +The &#39;ref&#39; and &#39;unref&#39; operations are no longer used a=
nd deprecated.<br>
&gt; +<br>
&gt;=C2=A0 The status bits should (preferably) be set with the set_bit and =
clear_bit alike<br>
&gt;=C2=A0 bit-operations. The status bits that are defined are:<br>
&gt;=C2=A0 * WDOG_ACTIVE: this status bit indicates whether or not a watchd=
og timer device<br>
&gt;=C2=A0 =C2=A0 is active or not. When the watchdog is active after booti=
ng, then you should<br>
&gt;=C2=A0 =C2=A0 set this status bit (Note: when you register the watchdog=
 timer device with<br>
&gt;=C2=A0 =C2=A0 this bit set, then opening /dev/watchdog will skip the st=
art operation)<br>
&gt; -* WDOG_DEV_OPEN: this status bit shows whether or not the watchdog de=
vice<br>
&gt; -=C2=A0 was opened via /dev/watchdog.<br>
&gt; -=C2=A0 (This bit should only be used by the WatchDog Timer Driver Cor=
e).<br>
&gt; -* WDOG_ALLOW_RELEASE: this bit stores whether or not the magic close =
character<br>
&gt; -=C2=A0 has been sent (so that we can support the magic close feature)=
.<br>
&gt; -=C2=A0 (This bit should only be used by the WatchDog Timer Driver Cor=
e).<br>
&gt;=C2=A0 * WDOG_NO_WAY_OUT: this bit stores the nowayout setting for the =
watchdog.<br>
&gt;=C2=A0 =C2=A0 If this bit is set then the watchdog timer will not be ab=
le to stop.<br>
&gt; -* WDOG_UNREGISTERED: this bit gets set by the WatchDog Timer Driver C=
ore<br>
&gt; -=C2=A0 after calling watchdog_unregister_device, and then checked bef=
ore calling<br>
&gt; -=C2=A0 any watchdog_ops, so that you can be sure that no operations (=
other then<br>
&gt; -=C2=A0 unref) will get called after unregister, even if userspace sti=
ll holds a<br>
&gt; -=C2=A0 reference to /dev/watchdog<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 To set the WDOG_NO_WAY_OUT status bit (before registering=
 your watchdog<br>
&gt;=C2=A0 =C2=A0 timer device) you can either:<br>
&gt; diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watch=
dog_core.c<br>
&gt; index f0293f7d2b80..ec1ab6c1a80b 100644<br>
&gt; --- a/drivers/watchdog/watchdog_core.c<br>
&gt; +++ b/drivers/watchdog/watchdog_core.c<br>
&gt; @@ -210,8 +210,6 @@ static int __watchdog_register_device(struct watch=
dog_device *wdd)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * corrupted in a later stage then we expect=
 a kernel panic!<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_init(&amp;wdd-&gt;lock);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Use alias for watchdog id if possible */<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (wdd-&gt;parent) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D of_alias=
_get_id(wdd-&gt;parent-&gt;of_node, &quot;watchdog&quot;);<br>
&gt; diff --git a/drivers/watchdog/watchdog_core.h b/drivers/watchdog/watch=
dog_core.h<br>
&gt; index 86ff962d1e15..c9b0656284de 100644<br>
&gt; --- a/drivers/watchdog/watchdog_core.h<br>
&gt; +++ b/drivers/watchdog/watchdog_core.h<br>
&gt; @@ -26,9 +26,32 @@<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0This material is provided &quot;AS-IS&quot; =
and at no charge.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;<br>
&gt; +#include &lt;linux/cdev.h&gt;<br>
&gt; +#include &lt;linux/kref.h&gt;<br>
&gt; +#include &lt;linux/mutex.h&gt;<br>
&gt; +#include &lt;linux/watchdog.h&gt;<br>
&gt; +<br>
&gt;=C2=A0 #define MAX_DOGS=C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A0 /* Ma=
ximum number of watchdog devices */<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt; + * struct _watchdog_device - watchdog core internal data<br>
<br>
</div></div>Think it should be /**. Anyway, I find it confusing to have bot=
h<br>
_watchdog_device and watchdog_device, but I can&#39;t think of a better<br>
name right now.<br>
<div><div><br>
&gt; + * @kref:=C2=A0 =C2=A0 Reference count.<br>
&gt; + * @cdev:=C2=A0 =C2=A0 The watchdog&#39;s Character device.<br>
&gt; + * @wdd:=C2=A0 =C2=A0 =C2=A0Pointer to watchdog device.<br>
&gt; + * @lock:=C2=A0 =C2=A0 Lock for watchdog core.<br>
&gt; + * @status:=C2=A0 Watchdog core internal status bits.<br>
&gt; + */<br>
&gt; +struct _watchdog_device {<br></div></div></blockquote><div>we should =
probably find a better name for this structure... watchdog =C2=A0_adapter, =
_descriptor, or even _data=C2=A0</div><div>Also this style is quite confusi=
ng when __func() is wrapping func(), usually this would be otherway around=
=C2=A0</div><div><br></div><div><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><d=
iv><div>
&gt; +=C2=A0 =C2=A0 =C2=A0struct kref kref;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct cdev cdev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct mutex lock;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned long status;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* Internal status bits */<br>
&gt; +#define _WDOG_DEV_OPEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Opened ? */<br>
&gt; +#define _WDOG_ALLOW_RELEASE=C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Did =
we receive the magic char ? */<br>
&gt; +};<br>
&gt; +<br>
&gt; +/*<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0Functions/procedures to be called by the cor=
e<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 extern int watchdog_dev_register(struct watchdog_device *);<br>
&gt; diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchd=
og_dev.c<br>
&gt; index c24392623e98..e8416bdc7037 100644<br>
&gt; --- a/drivers/watchdog/watchdog_dev.c<br>
&gt; +++ b/drivers/watchdog/watchdog_dev.c<br>
&gt; @@ -37,6 +37,7 @@<br>
&gt;=C2=A0 #include &lt;linux/errno.h&gt;=C2=A0 =C2=A0 =C2=A0/* For the -EN=
ODEV/... values */<br>
&gt;=C2=A0 #include &lt;linux/kernel.h&gt;=C2=A0 =C2=A0 /* For printk/panic=
/... */<br>
&gt;=C2=A0 #include &lt;linux/fs.h&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* For file operations */<br>
&gt; +#include &lt;linux/slab.h&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* For memory functions */<br>
&gt;=C2=A0 #include &lt;linux/watchdog.h&gt;=C2=A0 /* For watchdog specific=
 items */<br>
&gt;=C2=A0 #include &lt;linux/miscdevice.h&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
* For handling misc devices */<br>
&gt;=C2=A0 #include &lt;linux/init.h&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* For __init/__exit/... */<br>
&gt; @@ -47,12 +48,14 @@<br>
&gt;=C2=A0 /* the dev_t structure to store the dynamically allocated watchd=
og devices */<br>
&gt;=C2=A0 static dev_t watchdog_devt;<br>
&gt;=C2=A0 /* the watchdog device behind /dev/watchdog */<br>
&gt; -static struct watchdog_device *old_wdd;<br>
&gt; +static struct _watchdog_device *_old_wdd;<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0watchdog_ping: ping the watchdog.<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0@wdd: the watchdog device to ping<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; + *=C2=A0 =C2=A0The caller must hold _wdd-&gt;lock.<br>
&gt; + *<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0If the watchdog has no own ping operation th=
en it needs to be<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0restarted via the start operation. This wrap=
per function does<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0exactly that.<br>
&gt; @@ -61,25 +64,37 @@ static struct watchdog_device *old_wdd;<br>
&gt;<br>
&gt;=C2=A0 static int watchdog_ping(struct watchdog_device *wdd)</div></div=
></blockquote><div>Not sure this lockless wrappers are really needed. =C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div><div>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_UNREGISTERED, &amp;wdd-&gt;stat=
us)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -ENODEV;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_ping;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!watchdog_active(wdd))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_ping;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (wdd-&gt;ops-&gt;ping)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D wdd-&gt;=
ops-&gt;ping(wdd);=C2=A0 =C2=A0 =C2=A0 /* ping the watchdog */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D wdd-&gt;=
ops-&gt;start(wdd);=C2=A0 =C2=A0 =C2=A0/* restart watchdog */<br>
&gt;<br>
&gt; -out_ping:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + *=C2=A0 =C2=A0_watchdog_ping: ping the watchdog.<br>
&gt; + *=C2=A0 =C2=A0@_wdd: Watchdog core device data<br>
&gt; + *<br>
&gt; + *=C2=A0 =C2=A0Acquire _wdd-&gt;lock and call watchdog_ping() unless =
the watchdog<br>
&gt; + *=C2=A0 =C2=A0driver has been unregistered.<br>
&gt; + */<br>
&gt; +static int _watchdog_ping(struct _watchdog_device *_wdd)<br></div></d=
iv></blockquote><div>Use of double underscore __ is more comon . =C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><div><div>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err =3D -ENODEV;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;_wdd-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdd =3D _wdd-&gt;wdd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (wdd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D watchdog_ping=
(wdd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;_wdd-&gt;lock);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; @@ -87,6 +102,8 @@ out_ping:<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0watchdog_start: wrapper to start the watchdo=
g.<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0@wdd: the watchdog device to start<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; + *=C2=A0 =C2=A0The caller must hold _wdd-&gt;lock.<br>
&gt; + *<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0Start the watchdog if it is not active and m=
ark it active.<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0This function returns zero on success or a n=
egative errno code for<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0failure.<br>
&gt; @@ -94,24 +111,15 @@ out_ping:<br>
&gt;<br>
&gt;=C2=A0 static int watchdog_start(struct watchdog_device *wdd)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_UNREGISTERED, &amp;wdd-&gt;stat=
us)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -ENODEV;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_start;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (watchdog_active(wdd))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_start;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D wdd-&gt;ops-&gt;start(wdd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err =3D=3D 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(WDOG_ACT=
IVE, &amp;wdd-&gt;status);<br>
&gt;<br>
&gt; -out_start:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; @@ -119,6 +127,8 @@ out_start:<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0watchdog_stop: wrapper to stop the watchdog.=
<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0@wdd: the watchdog device to stop<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; + *=C2=A0 =C2=A0The caller must hold _wdd-&gt;lock.<br>
&gt; + *<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0Stop the watchdog if it is still active and =
unmark it active.<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0This function returns zero on success or a n=
egative errno code for<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0failure.<br>
&gt; @@ -127,93 +137,58 @@ out_start:<br>
&gt;<br>
&gt;=C2=A0 static int watchdog_stop(struct watchdog_device *wdd)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_UNREGISTERED, &amp;wdd-&gt;stat=
us)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -ENODEV;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_stop;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!watchdog_active(wdd))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_stop;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_NO_WAY_OUT, &amp;wdd-&gt;s=
tatus)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(wdd-&gt=
;dev, &quot;nowayout prevents watchdog being stopped!\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -EBUSY;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_stop;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D wdd-&gt;ops-&gt;stop(wdd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err =3D=3D 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(WDOG_A=
CTIVE, &amp;wdd-&gt;status);<br>
&gt;<br>
&gt; -out_stop:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0watchdog_get_status: wrapper to get the watc=
hdog status<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0@wdd: the watchdog device to get the status =
from<br>
&gt; - *=C2=A0 =C2=A0@status: the status of the watchdog device<br>
&gt; + *<br>
&gt; + *=C2=A0 =C2=A0The caller must hold _wdd-&gt;lock.<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0Get the watchdog&#39;s status flags.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;<br>
&gt; -static int watchdog_get_status(struct watchdog_device *wdd,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int *status)<br>
&gt; +static unsigned int watchdog_get_status(struct watchdog_device *wdd)<=
br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0*status =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!wdd-&gt;ops-&gt;status)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP;<b=
r>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_UNREGISTERED, &amp;wdd-&gt;stat=
us)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -ENODEV;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_status;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0*status =3D wdd-&gt;ops-&gt;status(wdd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;<br>
&gt; -out_status:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return wdd-&gt;ops-&gt;status(wdd);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0watchdog_set_timeout: set the watchdog timer=
 timeout<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0@wdd: the watchdog device to set the timeout=
 for<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0@timeout: timeout to set in seconds<br>
&gt; + *<br>
&gt; + *=C2=A0 =C2=A0The caller must hold _wdd-&gt;lock.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;<br>
&gt;=C2=A0 static int watchdog_set_timeout(struct watchdog_device *wdd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int timeout)<b=
r>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!wdd-&gt;ops-&gt;set_timeout || !(wdd-&g=
t;info-&gt;options &amp; WDIOF_SETTIMEOUT))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSU=
PP;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (watchdog_timeout_invalid(wdd, timeout))<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_UNREGISTERED, &amp;wdd-&gt;stat=
us)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -ENODEV;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_timeout;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0err =3D wdd-&gt;ops-&gt;set_timeout(wdd, timeout)=
;<br>
&gt; -<br>
&gt; -out_timeout:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return wdd-&gt;ops-&gt;set_timeout(wdd, timeout);=
<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt; @@ -221,30 +196,22 @@ out_timeout:<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0@wdd: the watchdog device to get the remaini=
ng time from<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0@timeleft: the time that&#39;s left<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; + *=C2=A0 =C2=A0The caller must hold _wdd-&gt;lock.<br>
&gt; + *<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0Get the time before a watchdog will reboot (=
if not pinged).<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;<br>
&gt;=C2=A0 static int watchdog_get_timeleft(struct watchdog_device *wdd,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int *timeleft)=
<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*timeleft =3D 0;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!wdd-&gt;ops-&gt;get_timeleft)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSU=
PP;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_UNREGISTERED, &amp;wdd-&gt;stat=
us)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -ENODEV;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_timeleft;<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*timeleft =3D wdd-&gt;ops-&gt;get_timeleft(w=
dd);<br>
&gt;<br>
&gt; -out_timeleft:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 #ifdef CONFIG_WATCHDOG_SYSFS<br>
&gt; @@ -261,14 +228,14 @@ static ssize_t status_show(struct device *dev, s=
truct device_attribute *attr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd =3D dev_get_drvd=
ata(dev);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0ssize_t status;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned int val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct _watchdog_device *_wdd =3D wdd-&gt;wdd_dat=
a;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int status;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0status =3D watchdog_get_status(wdd, &amp;val);<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!status)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D sprintf(bu=
f, &quot;%u\n&quot;, val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;_wdd-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D watchdog_get_status(wdd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;_wdd-&gt;lock);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return status;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return sprintf(buf, &quot;%u\n&quot;, status);<br=
>
&gt;=C2=A0 }<br>
&gt;=C2=A0 static DEVICE_ATTR_RO(status);<br>
&gt;<br>
&gt; @@ -285,10 +252,13 @@ static ssize_t timeleft_show(struct device *dev,=
 struct device_attribute *attr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd =3D dev_get_drvd=
ata(dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct _watchdog_device *_wdd =3D wdd-&gt;wdd_dat=
a;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int val;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;_wdd-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D watchdog_get_timeleft(wdd, &amp;v=
al);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;_wdd-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!status)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D sprin=
tf(buf, &quot;%u\n&quot;, val);<br>
&gt;<br>
&gt; @@ -363,28 +333,17 @@ __ATTRIBUTE_GROUPS(wdt);<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0@wdd: the watchdog device to do the ioctl on=
<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0@cmd: watchdog command<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0@arg: argument pointer<br>
&gt; + *<br>
&gt; + *=C2=A0 =C2=A0The caller must hold _wdd-&gt;lock.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;<br>
&gt;=C2=A0 static int watchdog_ioctl_op(struct watchdog_device *wdd, unsign=
ed int cmd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long arg)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!wdd-&gt;ops-&gt;ioctl)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOIOCTL=
CMD;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_UNREGISTERED, &amp;wdd-&gt;stat=
us)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -ENODEV;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_ioctl;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0err =3D wdd-&gt;ops-&gt;ioctl(wdd, cmd, arg);<br>
&gt; -<br>
&gt; -out_ioctl:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return wdd-&gt;ops-&gt;ioctl(wdd, cmd, arg);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt; @@ -402,7 +361,7 @@ out_ioctl:<br>
&gt;=C2=A0 static ssize_t watchdog_write(struct file *file, const char __us=
er *data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0size_t len, loff_t *ppos)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd =3D file-&gt;private_=
data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct _watchdog_device *_wdd =3D file-&gt;privat=
e_data;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char c;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; @@ -414,18 +373,18 @@ static ssize_t watchdog_write(struct file *file,=
 const char __user *data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Note: just in case someone wrote the magi=
c character<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * five months ago...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0clear_bit(WDOG_ALLOW_RELEASE, &amp;wdd-&gt;status=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clear_bit(_WDOG_ALLOW_RELEASE, &amp;_wdd-&gt;stat=
us);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* scan to see whether or not we got the mag=
ic character */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i !=3D len; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (get_user(c, =
data + i))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EFAULT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (c =3D=3D &#3=
9;V&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0set_bit(WDOG_ALLOW_RELEASE, &amp;wdd-&gt;status);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0set_bit(_WDOG_ALLOW_RELEASE, &amp;_wdd-&gt;status);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* someone wrote to us, so we send the watch=
dog a keepalive ping */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0err =3D watchdog_ping(wdd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0err =3D _watchdog_ping(_wdd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;<br>
&gt; @@ -445,71 +404,94 @@ static ssize_t watchdog_write(struct file *file,=
 const char __user *data,<br>
&gt;=C2=A0 static long watchdog_ioctl(struct file *file, unsigned int cmd,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long arg)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd =3D file-&gt;private_=
data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct _watchdog_device *_wdd =3D file-&gt;privat=
e_data;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void __user *argp =3D (void __user *)arg;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int __user *p =3D argp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int val;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;_wdd-&gt;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdd =3D _wdd-&gt;wdd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!wdd) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -ENODEV;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_ioctl;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D watchdog_ioctl_op(wdd, cmd, arg);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err !=3D -ENOIOCTLCMD)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_ioctl;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (cmd) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_GETSUPPORT:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return copy_to_user(a=
rgp, wdd-&gt;info,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D copy_to_user(=
argp, wdd-&gt;info,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0sizeof(struct watchdog_info)) ? -EFAULT : 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_GETSTATUS:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D watchdog_get_=
status(wdd, &amp;val);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err =3D=3D -ENODE=
V)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return err;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return put_user(val, =
p);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D watchdog_get_=
status(wdd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D put_user(val,=
 p);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_GETBOOTSTATUS:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return put_user(wdd-&=
gt;bootstatus, p);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D put_user(wdd-=
&gt;bootstatus, p);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_SETOPTIONS:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (get_user(val, p))=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (get_user(val, p))=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0err =3D -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; WD=
IOS_DISABLECARD) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0err =3D watchdog_stop(wdd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (err &lt; 0)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; WDIOS_E=
NABLECARD) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; WDIOS_E=
NABLECARD)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0err =3D watchdog_start(wdd);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (err &lt; 0)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_KEEPALIVE:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(wdd-&gt;info-&g=
t;options &amp; WDIOF_KEEPALIVEPING))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EOPNOTSUPP;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return watchdog_ping(=
wdd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(wdd-&gt;info-&g=
t;options &amp; WDIOF_KEEPALIVEPING)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0err =3D -EOPNOTSUPP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D watchdog_ping=
(wdd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_SETTIMEOUT:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (get_user(val, p))=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (get_user(val, p))=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0err =3D -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D watchdog=
_set_timeout(wdd, val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If the watchd=
og is active then we send a keepalive ping<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * to make sure =
that the watchdog keep&#39;s running (and if<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * possible that=
 it takes the new timeout) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D watchdog=
_ping(wdd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br></div></div></blockquote><div>You are changing behaviour f=
or the driver here as you are keeping lock over two driver op calls.=C2=A0<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Fall */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_GETTIMEOUT:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* timeout =3D=
=3D 0 means that we don&#39;t know the timeout */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (wdd-&gt;timeout =
=3D=3D 0)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EOPNOTSUPP;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return put_user(wdd-&=
gt;timeout, p);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (wdd-&gt;timeout =
=3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0err =3D -EOPNOTSUPP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D put_user(wdd-=
&gt;timeout, p);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_GETTIMELEFT:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D watchdog=
_get_timeleft(wdd, &amp;val);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return err;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return put_user(val, =
p);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D put_user(val,=
 p);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTTY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -ENOTTY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +out_ioctl:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;_wdd-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt; @@ -524,45 +506,68 @@ static long watchdog_ioctl(struct file *file, un=
signed int cmd,<br>
&gt;<br>
&gt;=C2=A0 static int watchdog_open(struct inode *inode, struct file *file)=
<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int err =3D -EBUSY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct _watchdog_device *_wdd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get the corresponding watchdog device */<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (imajor(inode) =3D=3D MISC_MAJOR)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wdd =3D old_wdd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_wdd =3D _old_wdd;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wdd =3D container_of(=
inode-&gt;i_cdev, struct watchdog_device, cdev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_wdd =3D container_of=
(inode-&gt;i_cdev, struct _watchdog_device,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cdev);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* the watchdog is single open! */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (test_and_set_bit(WDOG_DEV_OPEN, &amp;wdd-&gt;=
status))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (test_and_set_bit(_WDOG_DEV_OPEN, &amp;_wdd-&g=
t;status))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<b=
r>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;_wdd-&gt;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdd =3D _wdd-&gt;wdd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!wdd) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -ENODEV;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_clear;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If the /dev/watchdog device is open, we d=
on&#39;t want the module<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * to be unloaded.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!try_module_get(wdd-&gt;ops-&gt;owner))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!try_module_get(wdd-&gt;ops-&gt;owner)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -EBUSY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_clear;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D watchdog_start(wdd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_mod;<br=
>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0file-&gt;private_data =3D wdd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0file-&gt;private_data =3D _wdd;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (wdd-&gt;ops-&gt;ref)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wdd-&gt;ops-&gt;ref(w=
dd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0kref_get(&amp;_wdd-&gt;kref);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* dev/watchdog is a virtual (and thus non-s=
eekable) filesystem */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return nonseekable_open(inode, file);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0err =3D nonseekable_open(inode, file);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0goto out_unlock;<br>
&gt;<br>
&gt;=C2=A0 out_mod:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0module_put(wdd-&gt;ops-&gt;owner);<br>
&gt; -out:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0clear_bit(WDOG_DEV_OPEN, &amp;wdd-&gt;status);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0module_put(_wdd-&gt;wdd-&gt;ops-&gt;owner);<br>
&gt; +out_clear:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clear_bit(_WDOG_DEV_OPEN, &amp;_wdd-&gt;status);<=
br>
&gt; +out_unlock:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;_wdd-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static void watchdog_wdd_release(struct kref *kref)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct _watchdog_device *_wdd;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0_wdd =3D container_of(kref, struct _watchdog_devi=
ce, kref);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0kfree(_wdd);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0watchdog_release: release the watchdog devic=
e.<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0@inode: inode of device<br>
&gt; @@ -575,9 +580,16 @@ out:<br>
&gt;<br>
&gt;=C2=A0 static int watchdog_release(struct inode *inode, struct file *fi=
le)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd =3D file-&gt;private_=
data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct _watchdog_device *_wdd =3D file-&gt;privat=
e_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D -EBUSY;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;_wdd-&gt;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdd =3D _wdd-&gt;wdd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!wdd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto done;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * We only stop the watchdog if we received =
the magic character<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * or if WDIOF_MAGICCLOSE is not set. If now=
ayout was set then<br>
&gt; @@ -585,29 +597,24 @@ static int watchdog_release(struct inode *inode,=
 struct file *file)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_bit(WDOG_ACTIVE, &amp;wdd-&gt;stat=
us))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0else if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &=
amp;wdd-&gt;status) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else if (test_and_clear_bit(_WDOG_ALLOW_RELEASE, =
&amp;_wdd-&gt;status) ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !(wdd-&gt;info-=
&gt;options &amp; WDIOF_MAGICCLOSE))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D watchdog=
_stop(wdd);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* If the watchdog was not stopped, send a k=
eepalive ping */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&=
gt;lock);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_bit(WDOG_UN=
REGISTERED, &amp;wdd-&gt;status))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_crit(wdd-&gt;dev, &quot;watchdog did not stop!\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd=
-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_crit(wdd-&gt;dev,=
 &quot;watchdog did not stop!\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0watchdog_ping(wd=
d);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* Allow the owner module to be unloaded again */=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0module_put(wdd-&gt;ops-&gt;owner);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* make sure that /dev/watchdog can be re-op=
ened */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0clear_bit(WDOG_DEV_OPEN, &amp;wdd-&gt;status);<br=
>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* Note wdd may be gone after this, do not use af=
ter this! */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (wdd-&gt;ops-&gt;unref)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wdd-&gt;ops-&gt;unref=
(wdd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clear_bit(_WDOG_DEV_OPEN, &amp;_wdd-&gt;status);<=
br>
&gt;<br>
&gt; +done:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;_wdd-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Allow the owner module to be unloaded again */=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0module_put(_wdd-&gt;cdev.owner);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0kref_put(&amp;_wdd-&gt;kref, watchdog_wdd_release=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; @@ -637,10 +644,20 @@ static struct miscdevice watchdog_miscdev =3D {<=
br>
&gt;<br>
&gt;=C2=A0 static int watchdog_cdev_register(struct watchdog_device *wdd, d=
ev_t devno)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct _watchdog_device *_wdd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0_wdd =3D kzalloc(sizeof(struct _watchdog_device),=
 GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!_wdd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0kref_init(&amp;_wdd-&gt;kref);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_init(&amp;_wdd-&gt;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0_wdd-&gt;wdd =3D wdd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdd-&gt;wdd_data =3D _wdd;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (wdd-&gt;id =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0old_wdd =3D wdd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_old_wdd =3D _wdd;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0watchdog_miscdev=
.parent =3D wdd-&gt;parent;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D misc_reg=
ister(&amp;watchdog_miscdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err !=3D 0) =
{<br>
&gt; @@ -649,23 +666,25 @@ static int watchdog_cdev_register(struct watchdo=
g_device *wdd, dev_t devno)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (err =3D=3D -EBUSY)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;%s: a legacy watchdog=
 module is probably present.\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wdd-&g=
t;info-&gt;identity);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0old_wdd =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0_old_wdd =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0kfree(_wdd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return err;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Fill in the data structures */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0cdev_init(&amp;wdd-&gt;cdev, &amp;watchdog_fops);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0wdd-&gt;cdev.owner =3D wdd-&gt;ops-&gt;owner;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cdev_init(&amp;_wdd-&gt;cdev, &amp;watchdog_fops)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0_wdd-&gt;cdev.owner =3D wdd-&gt;ops-&gt;owner;<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add the device */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0err=C2=A0 =3D cdev_add(&amp;wdd-&gt;cdev, devno, =
1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0err =3D cdev_add(&amp;_wdd-&gt;cdev, devno, 1);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;wat=
chdog%d unable to add device %d:%d\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0wdd-&gt;id,=C2=A0 MAJOR(watchdog_devt), wdd-&gt;id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (wdd-&gt;id =
=3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0misc_deregister(&amp;watchdog_miscdev);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0old_wdd =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0_old_wdd =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0kref_put(&amp;_wdd-&gt;kref, watchdog_wdd_release);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; @@ -681,15 +700,23 @@ static int watchdog_cdev_register(struct watchdo=
g_device *wdd, dev_t devno)<br>
&gt;<br>
&gt;=C2=A0 static void watchdog_cdev_unregister(struct watchdog_device *wdd=
)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0set_bit(WDOG_UNREGISTERED, &amp;wdd-&gt;status);<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct _watchdog_device *_wdd =3D wdd-&gt;wdd_dat=
a;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0cdev_del(&amp;wdd-&gt;cdev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cdev_del(&amp;_wdd-&gt;cdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (wdd-&gt;id =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0misc_deregister(=
&amp;watchdog_miscdev);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0old_wdd =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_old_wdd =3D NULL;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (watchdog_active(wdd))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_crit(&quot;watchdo=
g%d: watchdog still running!\n&quot;, wdd-&gt;id);<br>
<br>
</div></div>As it is now safe to unbind and rebind a driver, it means that =
a<br>
watchdog driver probe function can now be called with a running<br>
watchdog. Some drivers handle this situation, but I think that most of<br>
them expect the watchdog to be off at this point.<br>
<div><div><br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;_wdd-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0_wdd-&gt;wdd =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdd-&gt;wdd_data =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;_wdd-&gt;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0kref_put(&amp;_wdd-&gt;kref, watchdog_wdd_release=
);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static struct class watchdog_class =3D {<br>
&gt; @@ -742,9 +769,9 @@ int watchdog_dev_register(struct watchdog_device *=
wdd)<br>
&gt;<br>
&gt;=C2=A0 void watchdog_dev_unregister(struct watchdog_device *wdd)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0watchdog_cdev_unregister(wdd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0device_destroy(&amp;watchdog_class, wdd-&gt;=
dev-&gt;devt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0wdd-&gt;dev =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0watchdog_cdev_unregister(wdd);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt; diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h<br>
&gt; index a88f955fde92..1d3363aeb6e4 100644<br>
&gt; --- a/include/linux/watchdog.h<br>
&gt; +++ b/include/linux/watchdog.h<br>
&gt; @@ -28,8 +28,6 @@ struct watchdog_device;<br>
&gt;=C2=A0 =C2=A0* @set_timeout:The routine for setting the watchdog device=
s timeout value (in seconds).<br>
&gt;=C2=A0 =C2=A0* @get_timeleft:The routine that gets the time left before=
 a reset (in seconds).<br>
&gt;=C2=A0 =C2=A0* @restart: The routine for restarting the machine.<br>
&gt; - * @ref:=C2=A0 =C2=A0 =C2=A0The ref operation for dyn. allocated watc=
hdog_device structs<br>
&gt; - * @unref:=C2=A0 =C2=A0The unref operation for dyn. allocated watchdo=
g_device structs<br>
&gt;=C2=A0 =C2=A0* @ioctl:=C2=A0 =C2=A0The routines that handles extra ioct=
l calls.<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* The watchdog_ops structure contains a list of low-level =
operations<br>
&gt; @@ -48,15 +46,14 @@ struct watchdog_ops {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*set_timeout)(struct watchdog_device *,=
 unsigned int);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int (*get_timeleft)(struct watchdog=
_device *);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*restart)(struct watchdog_device *);<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0void (*ref)(struct watchdog_device *);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0void (*unref)(struct watchdog_device *);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void (*ref)(struct watchdog_device *) __deprecate=
d;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void (*unref)(struct watchdog_device *) __depreca=
ted;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0long (*ioctl)(struct watchdog_device *, unsi=
gned int, unsigned long);<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 /** struct watchdog_device - The structure that defines a watchd=
og device<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* @id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The=
 watchdog&#39;s ID. (Allocated by watchdog_register_device)<br>
&gt; - * @cdev:=C2=A0 =C2=A0 The watchdog&#39;s Character device.<br>
&gt;=C2=A0 =C2=A0* @dev:=C2=A0 =C2=A0 =C2=A0The device for our watchdog<br>
&gt;=C2=A0 =C2=A0* @parent:=C2=A0 The parent bus device<br>
&gt;=C2=A0 =C2=A0* @info:=C2=A0 =C2=A0 Pointer to a watchdog_info structure=
.<br>
&gt; @@ -67,8 +64,8 @@ struct watchdog_ops {<br>
&gt;=C2=A0 =C2=A0* @max_timeout:The watchdog devices maximum timeout value =
(in seconds).<br>
&gt;=C2=A0 =C2=A0* @reboot_nb:=C2=A0 =C2=A0 =C2=A0 =C2=A0The notifier block=
 to stop watchdog on reboot.<br>
&gt;=C2=A0 =C2=A0* @restart_nb:=C2=A0 =C2=A0 =C2=A0 The notifier block to r=
egister a restart function.<br>
&gt; - * @driver-data:Pointer to the drivers private data.<br>
&gt; - * @lock:=C2=A0 =C2=A0 Lock for watchdog core internal use only.<br>
&gt; + * @driver_data:Pointer to the drivers private data.<br>
&gt; + * @wdd_data:=C2=A0 =C2=A0 =C2=A0 =C2=A0 Pointer to watchdog core int=
ernal data.<br>
&gt;=C2=A0 =C2=A0* @status:=C2=A0 Field that contains the devices internal =
status bits.<br>
&gt;=C2=A0 =C2=A0* @deferred: entry in wtd_deferred_reg_list which is used =
to<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 register early initialized watchdogs.<br>
&gt; @@ -84,7 +81,6 @@ struct watchdog_ops {<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 struct watchdog_device {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int id;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct cdev cdev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *parent;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct watchdog_info *info;<br>
&gt; @@ -96,15 +92,12 @@ struct watchdog_device {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct notifier_block reboot_nb;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct notifier_block restart_nb;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void *driver_data;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct mutex lock;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void *wdd_data;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long status;<br>
&gt;=C2=A0 /* Bit numbers for status flags */<br>
&gt;=C2=A0 #define WDOG_ACTIVE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* Is the watchdog running/active */<br>
&gt; -#define WDOG_DEV_OPEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Opened via /dev/watchdog ? */<br>
&gt; -#define WDOG_ALLOW_RELEASE=C2=A0 =C2=A02=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 Did we receive the magic char ? */<br>
&gt; -#define WDOG_NO_WAY_OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 3=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Is &#39;nowayout&#39; feature set ? */<b=
r>
&gt; -#define WDOG_UNREGISTERED=C2=A0 =C2=A0 4=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 Has the device been unregistered */<br>
&gt; -#define WDOG_STOP_ON_REBOOT=C2=A0 5=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Shou=
ld be stopped on reboot */<br>
&gt; +#define WDOG_NO_WAY_OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Is &#39;nowayout&#39; feature set ? */<b=
r>
&gt; +#define WDOG_STOP_ON_REBOOT=C2=A0 2=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Shou=
ld be stopped on reboot */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head deferred;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; --<br>
&gt; 2.1.4<br>
&gt;<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-watchd=
og&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org" targe=
t=3D"_blank">majordomo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/majord=
omo-info.html</a><br>
</div></div></blockquote></div><br></div></div>

--001a114527fc26ce1b052770525f--
