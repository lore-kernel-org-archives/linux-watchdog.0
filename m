Return-path: <yibin.gong@freescale.com>
Date: Tue, 3 Nov 2015 12:47:44 +0800
From: Robin Gong <b38343@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 1/2] watchdog: add WDIOC_SETPRETIMEOUT and
 WDIOC_GETPRETIMEOUT
Message-ID: <20151103044741.GA26305@shlinux2>
References: <1446521367-25748-1-git-send-email-b38343@freescale.com>
 <56383244.3030801@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <56383244.3030801@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Nov 02, 2015 at 08:04:20PM -0800, Guenter Roeck wrote:
> On 11/02/2015 07:29 PM, Robin Gong wrote:
> >Since the watchdog common framework centrialize the IOCTL interfaces of
> >device driver now, the SETPRETIMEOUT and GETPRETIMEOUT need to be added
> >in the common code.
> >
> >Signed-off-by: Robin Gong <b38343@freescale.com>
> >---
> >  drivers/watchdog/watchdog_dev.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/watchdog.h        |  9 +++++++++
> >  2 files changed, 47 insertions(+)
> >
> >diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> >index 6aaefba..02632fe 100644
> >--- a/drivers/watchdog/watchdog_dev.c
> >+++ b/drivers/watchdog/watchdog_dev.c
> >@@ -218,6 +218,37 @@ out_timeout:
> >  }
> >
> >  /*
> >+ *	watchdog_set_pretimeout: set the watchdog timer pretimeout
> >+ *	@wddev: the watchdog device to set the timeout for
> >+ *	@timeout: pretimeout to set in seconds
> >+ */
> >+
> >+static int watchdog_set_pretimeout(struct watchdog_device *wddev,
> >+							unsigned int timeout)
> 
> Please align with "(".
Will fix in v2.
> 
> >+{
> >+	int err;
> >+
> >+	if ((wddev->ops->set_pretimeout == NULL) ||
> 
> Unnecessary ( ), and "== NULL" is unnecessary as well.
> 
why? It's useful if other device driver didn't implement set_pretimeout.
> >+	    !(wddev->info->options & WDIOF_PRETIMEOUT))
> >+		return -EOPNOTSUPP;
> >+	if (watchdog_pretimeout_invalid(wddev, timeout))
> >+		return -EINVAL;
> >+
> >+	mutex_lock(&wddev->lock);
> >+
> >+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
> >+		err = -ENODEV;
> >+		goto out_timeout;
> >+	}
> >+
> >+	err = wddev->ops->set_pretimeout(wddev, timeout);
> >+
> >+out_timeout:
> >+	mutex_unlock(&wddev->lock);
> >+	return err;
> >+}
> >+
> >+/*
> >   *	watchdog_get_timeleft: wrapper to get the time left before a reboot
> >   *	@wddev: the watchdog device to get the remaining time from
> >   *	@timeleft: the time that's left
> >@@ -393,6 +424,13 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
> >  		if (err)
> >  			return err;
> >  		return put_user(val, p);
> >+	case WDIOC_SETPRETIMEOUT:
> >+		if (get_user(val, p))
> >+			return -EFAULT;
> >+		err = watchdog_set_pretimeout(wdd, val);
> >+		return err;
> 
> 		return watchdog_set_pretimeout(wdd, val);
> 
> >+	case WDIOC_GETPRETIMEOUT:
> >+		return put_user(wdd->pretimeout, p);
> >  	default:
> >  		return -ENOTTY;
> >  	}
> >diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> >index d74a0e9..6ddb2d6 100644
> >--- a/include/linux/watchdog.h
> >+++ b/include/linux/watchdog.h
> >@@ -25,6 +25,7 @@ struct watchdog_device;
> >   * @ping:	The routine that sends a keepalive ping to the watchdog device.
> >   * @status:	The routine that shows the status of the watchdog device.
> >   * @set_timeout:The routine for setting the watchdog devices timeout value.
> >+ * @set_pretimeout:The routine for setting the watchdog devices pretimeout.
> >   * @get_timeleft:The routine that get's the time that's left before a reset.
> >   * @ref:	The ref operation for dyn. allocated watchdog_device structs
> >   * @unref:	The unref operation for dyn. allocated watchdog_device structs
> >@@ -44,6 +45,7 @@ struct watchdog_ops {
> >  	int (*ping)(struct watchdog_device *);
> >  	unsigned int (*status)(struct watchdog_device *);
> >  	int (*set_timeout)(struct watchdog_device *, unsigned int);
> >+	int (*set_pretimeout)(struct watchdog_device *, unsigned int);
> >  	unsigned int (*get_timeleft)(struct watchdog_device *);
> >  	void (*ref)(struct watchdog_device *);
> >  	void (*unref)(struct watchdog_device *);
> >@@ -86,6 +88,7 @@ struct watchdog_device {
> >  	const struct watchdog_ops *ops;
> >  	unsigned int bootstatus;
> >  	unsigned int timeout;
> >+	unsigned int pretimeout;
> 
> Description (further below) missing.
> 
I describe it in the ahead of this structure as the above.
> >  	unsigned int min_timeout;
> >  	unsigned int max_timeout;
> >  	void *driver_data;
> >@@ -123,6 +126,12 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
> >  		(t < wdd->min_timeout || t > wdd->max_timeout));
> >  }
> >
> >+/* Use the following function to check if a pretimeout value is invalid */
> >+static inline bool watchdog_pretimeout_invalid(struct watchdog_device *wdd, unsigned int t)
> 
> Please fix checkpatch warnings.
> 
You mean over 80 characters? Will fix in v2.
> >+{
> >+	return ((wdd->timeout != 0) && (t >= wdd->timeout));
> 
> Unnecessary ( ), and "!= 0" is unnecessary.
> 
I think t >= wdd->timeout is need, since it's a pre-timeout.
> >+}
> >+
> >  /* Use the following functions to manipulate watchdog driver specific data */
> >  static inline void watchdog_set_drvdata(struct watchdog_device *wdd, void *data)
> >  {
> >
> 
