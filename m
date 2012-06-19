Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47640 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209Ab2FSMkL (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jun 2012 08:40:11 -0400
Message-ID: <4FE0733B.6020602@redhat.com>
Date: Tue, 19 Jun 2012 14:40:27 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Tony Zelenoff <antonz@parallels.com>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"wim@iguana.be" <wim@iguana.be>
Subject: Re: [PATCH] iTCO_wdt: move watchdog to proper kernel interface
References: <1339150154-25247-1-git-send-email-antonz@parallels.com> <4FE05279.7080301@parallels.com>
In-Reply-To: <4FE05279.7080301@parallels.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/19/2012 12:20 PM, Tony Zelenoff wrote:
> Ping.
>
> Is this patch wrong? Or just missed?

Definitely not wrong (on the conceptual level I've not actually
checked the code). We do want the iTCO_wdt driver to be converted
to the (new) watchdog device framework.

I think you just need to give Wim some more time to take a good
look at this. Wim does the watchdog subsystem maintainer ship in
his spare time, so sometimes you need to be a bit patient :)

Regards,

Hans



>
> 8/06/12 2:09 PM, Anton Zelenov =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Remove obsoleted fs interface and move to proper usage of
>> watchdog_device interface.
>>
>> Signed-off-by: Tony Zelenoff <antonz@parallels.com>
>> ---
>>   drivers/watchdog/iTCO_wdt.c |  246 ++++++++++++++-------------------=
----------
>>   1 files changed, 77 insertions(+), 169 deletions(-)
>>
>> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
>> index bc47e90..14e48d9 100644
>> --- a/drivers/watchdog/iTCO_wdt.c
>> +++ b/drivers/watchdog/iTCO_wdt.c
>> @@ -87,9 +87,11 @@
>>   #define TCO2_CNT    (TCOBASE + 0x0a) /* TCO2 Control Register    */
>>   #define TCOv2_TMR    (TCOBASE + 0x12) /* TCOv2 Timer Initial Value  =
  */
>>
>> +/* Maximum allowed timeouts for iTCO */
>> +#define iTCO_V1_MAX_TIMEOUT    0x03f
>> +#define iTCO_V2_MAX_TIMEOUT    0x3ff
>> +
>>   /* internal variables */
>> -static unsigned long is_active;
>> -static char expect_release;
>>   static struct {        /* this is private data for the iTCO_wdt devi=
ce */
>>       /* TCO version/generation */
>>       unsigned int iTCO_version;
>> @@ -107,9 +109,9 @@ static struct {        /* this is private data for=
 the iTCO_wdt device */
>>
>>   /* module parameters */
>>   #define WATCHDOG_HEARTBEAT 30    /* 30 sec default heartbeat */
>> -static int heartbeat =3D WATCHDOG_HEARTBEAT;  /* in seconds */
>> -module_param(heartbeat, int, 0);
>> -MODULE_PARM_DESC(heartbeat, "Watchdog timeout in seconds. "
>> +static unsigned int heartbeat_param =3D WATCHDOG_HEARTBEAT;  /* in se=
conds */
>> +module_param(heartbeat_param, uint, 0);
>> +MODULE_PARM_DESC(heartbeat_param, "Watchdog timeout in seconds. "
>>       "5..76 (TCO v1) or 3..614 (TCO v2), default=3D"
>>                   __MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
>>
>> @@ -178,13 +180,13 @@ static int iTCO_wdt_unset_NO_REBOOT_bit(void)
>>       return ret; /* returns: 0 =3D OK, -EIO =3D Error */
>>   }
>>
>> -static int iTCO_wdt_start(void)
>> +static int iTCO_wdt_start(struct watchdog_device *w)
>>   {
>>       unsigned int val;
>>
>>       spin_lock(&iTCO_wdt_private.io_lock);
>>
>> -    iTCO_vendor_pre_start(iTCO_wdt_private.smi_res, heartbeat);
>> +    iTCO_vendor_pre_start(iTCO_wdt_private.smi_res, w->timeout);
>>
>>       /* disable chipset's NO_REBOOT bit */
>>       if (iTCO_wdt_unset_NO_REBOOT_bit()) {
>> @@ -212,7 +214,7 @@ static int iTCO_wdt_start(void)
>>       return 0;
>>   }
>>
>> -static int iTCO_wdt_stop(void)
>> +static int iTCO_wdt_stop(struct watchdog_device *w)
>>   {
>>       unsigned int val;
>>
>> @@ -236,11 +238,11 @@ static int iTCO_wdt_stop(void)
>>       return 0;
>>   }
>>
>> -static int iTCO_wdt_keepalive(void)
>> +static int iTCO_wdt_ping(struct watchdog_device *w)
>>   {
>>       spin_lock(&iTCO_wdt_private.io_lock);
>>
>> -    iTCO_vendor_pre_keepalive(iTCO_wdt_private.smi_res, heartbeat);
>> +    iTCO_vendor_pre_keepalive(iTCO_wdt_private.smi_res, w->timeout);
>>
>>       /* Reload the timer by writing to the TCO Timer Counter register=
 */
>>       if (iTCO_wdt_private.iTCO_version =3D=3D 2)
>> @@ -257,7 +259,24 @@ static int iTCO_wdt_keepalive(void)
>>       return 0;
>>   }
>>
>> -static int iTCO_wdt_set_heartbeat(int t)
>> +static inline int iTCO_wdt_timeout_valid(unsigned int t)
>> +{
>> +    unsigned int timeout =3D 0;
>> +
>> +    if (iTCO_wdt_private.iTCO_version =3D=3D 2)
>> +        timeout =3D iTCO_V2_MAX_TIMEOUT;
>> +
>> +    if (iTCO_wdt_private.iTCO_version =3D=3D 1)
>> +        timeout =3D iTCO_V1_MAX_TIMEOUT;
>> +
>> +    if (t > timeout)
>> +        return 0;
>> +
>> +    return 1;
>> +}
>> +
>> +static int iTCO_wdt_set_timeout(struct watchdog_device *w,
>> +                unsigned int t)
>>   {
>>       unsigned int val16;
>>       unsigned char val8;
>> @@ -273,8 +292,8 @@ static int iTCO_wdt_set_heartbeat(int t)
>>       /* "Values of 0h-3h are ignored and should not be attempted" */
>>       if (tmrval < 0x04)
>>           return -EINVAL;
>> -    if (((iTCO_wdt_private.iTCO_version =3D=3D 2) && (tmrval > 0x3ff)=
) ||
>> -        ((iTCO_wdt_private.iTCO_version =3D=3D 1) && (tmrval > 0x03f)=
))
>> +
>> +    if (!iTCO_wdt_timeout_valid(t))
>>           return -EINVAL;
>>
>>       iTCO_vendor_pre_set_heartbeat(tmrval);
>> @@ -304,11 +323,11 @@ static int iTCO_wdt_set_heartbeat(int t)
>>               return -EINVAL;
>>       }
>>
>> -    heartbeat =3D t;
>> +    w->timeout =3D t;
>>       return 0;
>>   }
>>
>> -static int iTCO_wdt_get_timeleft(int *time_left)
>> +static unsigned int iTCO_wdt_get_timeleft(struct watchdog_device *w)
>>   {
>>       unsigned int val16;
>>       unsigned char val8;
>> @@ -320,8 +339,10 @@ static int iTCO_wdt_get_timeleft(int *time_left)
>>           val16 &=3D 0x3ff;
>>           spin_unlock(&iTCO_wdt_private.io_lock);
>>
>> -        *time_left =3D (val16 * 6) / 10;
>> -    } else if (iTCO_wdt_private.iTCO_version =3D=3D 1) {
>> +        return (val16 * 6) / 10;
>> +    }
>> +
>> +    if (iTCO_wdt_private.iTCO_version =3D=3D 1) {
>>           spin_lock(&iTCO_wdt_private.io_lock);
>>           val8 =3D inb(TCO_RLD);
>>           val8 &=3D 0x3f;
>> @@ -329,156 +350,39 @@ static int iTCO_wdt_get_timeleft(int *time_left=
)
>>               val8 +=3D (inb(TCOv1_TMR) & 0x3f);
>>           spin_unlock(&iTCO_wdt_private.io_lock);
>>
>> -        *time_left =3D (val8 * 6) / 10;
>> -    } else
>> -        return -EINVAL;
>> -    return 0;
>> -}
>> -
>> -/*
>> - *    /dev/watchdog handling
>> - */
>> -
>> -static int iTCO_wdt_open(struct inode *inode, struct file *file)
>> -{
>> -    /* /dev/watchdog can only be opened once */
>> -    if (test_and_set_bit(0, &is_active))
>> -        return -EBUSY;
>> -
>> -    /*
>> -     *      Reload and activate timer
>> -     */
>> -    iTCO_wdt_start();
>> -    return nonseekable_open(inode, file);
>> -}
>> -
>> -static int iTCO_wdt_release(struct inode *inode, struct file *file)
>> -{
>> -    /*
>> -     *      Shut off the timer.
>> -     */
>> -    if (expect_release =3D=3D 42) {
>> -        iTCO_wdt_stop();
>> -    } else {
>> -        pr_crit("Unexpected close, not stopping watchdog!\n");
>> -        iTCO_wdt_keepalive();
>> -    }
>> -    clear_bit(0, &is_active);
>> -    expect_release =3D 0;
>> -    return 0;
>> -}
>> -
>> -static ssize_t iTCO_wdt_write(struct file *file, const char __user *d=
ata,
>> -                  size_t len, loff_t *ppos)
>> -{
>> -    /* See if we got the magic character 'V' and reload the timer */
>> -    if (len) {
>> -        if (!nowayout) {
>> -            size_t i;
>> -
>> -            /* note: just in case someone wrote the magic
>> -               character five months ago... */
>> -            expect_release =3D 0;
>> -
>> -            /* scan to see whether or not we got the
>> -               magic character */
>> -            for (i =3D 0; i !=3D len; i++) {
>> -                char c;
>> -                if (get_user(c, data + i))
>> -                    return -EFAULT;
>> -                if (c =3D=3D 'V')
>> -                    expect_release =3D 42;
>> -            }
>> -        }
>> -
>> -        /* someone wrote to us, we should reload the timer */
>> -        iTCO_wdt_keepalive();
>> -    }
>> -    return len;
>> -}
>> -
>> -static long iTCO_wdt_ioctl(struct file *file, unsigned int cmd,
>> -                            unsigned long arg)
>> -{
>> -    int new_options, retval =3D -EINVAL;
>> -    int new_heartbeat;
>> -    void __user *argp =3D (void __user *)arg;
>> -    int __user *p =3D argp;
>> -    static const struct watchdog_info ident =3D {
>> -        .options =3D        WDIOF_SETTIMEOUT |
>> -                    WDIOF_KEEPALIVEPING |
>> -                    WDIOF_MAGICCLOSE,
>> -        .firmware_version =3D    0,
>> -        .identity =3D        DRV_NAME,
>> -    };
>> -
>> -    switch (cmd) {
>> -    case WDIOC_GETSUPPORT:
>> -        return copy_to_user(argp, &ident, sizeof(ident)) ? -EFAULT : =
0;
>> -    case WDIOC_GETSTATUS:
>> -    case WDIOC_GETBOOTSTATUS:
>> -        return put_user(0, p);
>> -
>> -    case WDIOC_SETOPTIONS:
>> -    {
>> -        if (get_user(new_options, p))
>> -            return -EFAULT;
>> -
>> -        if (new_options & WDIOS_DISABLECARD) {
>> -            iTCO_wdt_stop();
>> -            retval =3D 0;
>> -        }
>> -        if (new_options & WDIOS_ENABLECARD) {
>> -            iTCO_wdt_keepalive();
>> -            iTCO_wdt_start();
>> -            retval =3D 0;
>> -        }
>> -        return retval;
>> +        return (val8 * 6) / 10;
>>       }
>> -    case WDIOC_KEEPALIVE:
>> -        iTCO_wdt_keepalive();
>> -        return 0;
>>
>> -    case WDIOC_SETTIMEOUT:
>> -    {
>> -        if (get_user(new_heartbeat, p))
>> -            return -EFAULT;
>> -        if (iTCO_wdt_set_heartbeat(new_heartbeat))
>> -            return -EINVAL;
>> -        iTCO_wdt_keepalive();
>> -        /* Fall */
>> -    }
>> -    case WDIOC_GETTIMEOUT:
>> -        return put_user(heartbeat, p);
>> -    case WDIOC_GETTIMELEFT:
>> -    {
>> -        int time_left;
>> -        if (iTCO_wdt_get_timeleft(&time_left))
>> -            return -EINVAL;
>> -        return put_user(time_left, p);
>> -    }
>> -    default:
>> -        return -ENOTTY;
>> -    }
>> +    return -EINVAL;
>>   }
>>
>>   /*
>>    *    Kernel Interfaces
>>    */
>>
>> -static const struct file_operations iTCO_wdt_fops =3D {
>> -    .owner =3D        THIS_MODULE,
>> -    .llseek =3D        no_llseek,
>> -    .write =3D        iTCO_wdt_write,
>> -    .unlocked_ioctl =3D    iTCO_wdt_ioctl,
>> -    .open =3D            iTCO_wdt_open,
>> -    .release =3D        iTCO_wdt_release,
>> +static const struct watchdog_info iTCO_wdt_info =3D {
>> +    .options =3D        WDIOF_SETTIMEOUT |
>> +                WDIOF_KEEPALIVEPING |
>> +                WDIOF_MAGICCLOSE,
>> +    .firmware_version =3D    0,
>> +    .identity =3D        DRV_NAME,
>> +};
>> +
>> +static struct watchdog_ops iTCO_wdt_ops =3D {
>> +    .owner =3D THIS_MODULE,
>> +    .start =3D iTCO_wdt_start,
>> +    .stop =3D iTCO_wdt_stop,
>> +    .ping =3D iTCO_wdt_ping,
>> +    .set_timeout =3D iTCO_wdt_set_timeout,
>> +    .get_timeleft =3D iTCO_wdt_get_timeleft,
>>   };
>>
>> -static struct miscdevice iTCO_wdt_miscdev =3D {
>> -    .minor =3D    WATCHDOG_MINOR,
>> -    .name =3D        "watchdog",
>> -    .fops =3D        &iTCO_wdt_fops,
>> +static struct watchdog_device iTCO_wdt_dev =3D {
>> +    .info =3D &iTCO_wdt_info,
>> +    .ops =3D &iTCO_wdt_ops,
>> +    .min_timeout =3D 1,
>> +    /* It will be set up at _probe */
>> +    .max_timeout =3D 0xFFFF
>>   };
>>
>>   /*
>> @@ -489,10 +393,10 @@ static void __devexit iTCO_wdt_cleanup(void)
>>   {
>>       /* Stop the timer before we leave */
>>       if (!nowayout)
>> -        iTCO_wdt_stop();
>> +        iTCO_wdt_stop(&iTCO_wdt_dev);
>>
>>       /* Deregister */
>> -    misc_deregister(&iTCO_wdt_miscdev);
>> +    watchdog_unregister_device(&iTCO_wdt_dev);
>>
>>       /* release resources */
>>       release_region(iTCO_wdt_private.tco_res->start,
>> @@ -559,7 +463,10 @@ static int __devinit iTCO_wdt_probe(struct platfo=
rm_device *dev)
>>               ret =3D -EIO;
>>               goto unreg_gcs;
>>           }
>> -    }
>> +
>> +        iTCO_wdt_dev.max_timeout =3D iTCO_V2_MAX_TIMEOUT;
>> +    } else
>> +        iTCO_wdt_dev.max_timeout =3D iTCO_V1_MAX_TIMEOUT;
>>
>>       /* Check chipset's NO_REBOOT bit */
>>       if (iTCO_wdt_unset_NO_REBOOT_bit() && iTCO_vendor_check_noreboot=
_on()) {
>> @@ -606,24 +513,25 @@ static int __devinit iTCO_wdt_probe(struct platf=
orm_device *dev)
>>       outw(0x0004, TCO2_STS);    /* Clear BOOT_STS bit */
>>
>>       /* Make sure the watchdog is not running */
>> -    iTCO_wdt_stop();
>> +    iTCO_wdt_stop(&iTCO_wdt_dev);
>>
>>       /* Check that the heartbeat value is within it's range;
>>          if not reset to the default */
>> -    if (iTCO_wdt_set_heartbeat(heartbeat)) {
>> -        iTCO_wdt_set_heartbeat(WATCHDOG_HEARTBEAT);
>> -        pr_info("timeout value out of range, using %d\n", heartbeat);
>> +    if (iTCO_wdt_set_timeout(&iTCO_wdt_dev, heartbeat_param)) {
>> +        iTCO_wdt_set_timeout(&iTCO_wdt_dev, WATCHDOG_HEARTBEAT);
>> +        pr_info("timeout value out of range, using %d\n", heartbeat_p=
aram);
>>       }
>>
>> -    ret =3D misc_register(&iTCO_wdt_miscdev);
>> +    watchdog_set_nowayout(&iTCO_wdt_dev, nowayout);
>> +
>> +    ret =3D watchdog_register_device(&iTCO_wdt_dev);
>>       if (ret !=3D 0) {
>> -        pr_err("cannot register miscdev on minor=3D%d (err=3D%d)\n",
>> -               WATCHDOG_MINOR, ret);
>> +        pr_err("cannot register watchdog device (err=3D%d)\n", ret);
>>           goto unreg_tco;
>>       }
>>
>>       pr_info("initialized. heartbeat=3D%d sec (nowayout=3D%d)\n",
>> -        heartbeat, nowayout);
>> +        heartbeat_param, nowayout);
>>
>>       return 0;
>>
>> @@ -659,7 +567,7 @@ static int __devexit iTCO_wdt_remove(struct platfo=
rm_device *dev)
>>
>>   static void iTCO_wdt_shutdown(struct platform_device *dev)
>>   {
>> -    iTCO_wdt_stop();
>> +    iTCO_wdt_stop(&iTCO_wdt_dev);
>>   }
>>
>>   static struct platform_driver iTCO_wdt_driver =3D {
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
