Return-path: <panand@redhat.com>
Date: Mon, 31 Aug 2015 08:34:10 +0530
From: Pratyush Anand <panand@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, dyoung@redhat.com, dzickus@redhat.com,
        open list:  ABI/API <linux-api@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [RFC] watchdog: Add watchdog device control through sysfs
 attributes
Message-ID: <20150831030410.GB4660@dhcppc13>
References: <d9ac417a3bc1c6846f1ddfcd3cd07e5a92865c19.1440179209.git.panand@redhat.com>
 <20150829165124.GA22494@roeck-us.net>
 <20150830141650.GA31158@dhcp-0-82.del.redhat.com>
 <55E31A13.80503@roeck-us.net>
 <20150830181706.GA4660@dhcppc13>
 <55E34DEA.7010206@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55E34DEA.7010206@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On 30/08/2015:11:39:38 AM, Guenter Roeck wrote:
> On 08/30/2015 11:17 AM, Pratyush Anand wrote:
> >Hi Guenter,
> >On 30/08/2015:07:58:27 AM, Guenter Roeck wrote:
> >>
> >>I can only see a single caller of watchdog_dev_register().
> >>Changing that one call should not be such a problem.
> >
> >Sure..Probably I was sleeping when I greped watchdog_dev_register :(
> >
> >>
> >>Also, you could name the groups variable something like wdc_class_dev_groups,
> >>make it public, and assign it in watchdog_core.c as follows.
> >
> >I will avoid making public whereever possible.
> >
> Your argument seems to be that it is better to introduce a new public
> single-use API function to avoid introducing a public variable.
> 
> Not sure if I understand the logic.

Sorry, if it was not clear..I agreed to change watchdog_dev_register instead of
introducing a new public variable.

> 
> >>
> >>static struct class watchdog_class = {
> >>	.name = "watchdog",
> >>	.owner = THIS_MODULE,
> >>	.dev_groups = wdc_class_dev_groups,
> >>};
> >>
> >>Then use class_register() and class_unregister() instead of class_create()
> >>and class_destroy(), and you would be done w/o any further API change.
> >>
> >>>>
> >>>>>+		return size;
> >>>>>+}
> >>>>>+
> >>>>>+static ssize_t timeout_show(struct device *dev,
> >>>>>+		struct device_attribute *attr, char *buf)
> >>>>>+{
> >>>>>+	struct watchdog_device *wdd = dev_get_drvdata(dev);
> >>>>>+	ssize_t status;
> >>>>>+
> >>>>>+	mutex_lock(&wdd->lock);
> >>>>>+	if (wdd->timeout == 0)
> >>>>>+		status = -EOPNOTSUPP;
> >>>>
> >>>>Why ?
> >>>
> >>>It has been copied from case WDIOC_GETTIMEOUT: which says:
> >>>timeout == 0 means that we don't know the timeout.
> >>>
> >>
> >>Just return 0 to mean "the timeout is unknown", and make it part of the
> >>sysfs ABI. Returning an error just makes user space code more complicated.
> >
> >Now the new code will check wdd->timeout == 0 in is_visible. So should be fine.
> >What do you say.?
> >
> timeout can be configured through ioctl, unless I am missing something,
> so I am not sure if I agree. It could still end up being 0.

Hummm..it did not allow to set timeout=0 for iTCO_wdt..but I can see that there
are some devices which sets min_timeout=0 and so your argument seems to be
correct and I will change as you suggested.
However, I am wondering should a device be allowed to set timeout=0. What
purpose will that serve?... may be for testing purpose can be used..

~Pratyush
