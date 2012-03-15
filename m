Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:42565 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396Ab2COPhG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Mar 2012 11:37:06 -0400
Date: Thu, 15 Mar 2012 15:38:33 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>,
	=?ISO-8859-1?B?UOFkcmFpZw==?= Brady <P@draigBrady.com>
Subject: Re: [PATCH 1/3] watchdog_dev: Add support for having more then 1
 watchdog
Message-ID: <20120315153833.40bd2f16@pyramind.ukuu.org.uk>
In-Reply-To: <4F61FA18.70104@redhat.com>
References: <1331812757-3491-1-git-send-email-hdegoede@redhat.com>
	<1331812757-3491-2-git-send-email-hdegoede@redhat.com>
	<20120315131131.1096f8c8@pyramind.ukuu.org.uk>
	<4F61FA18.70104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> +static unsigned long dog_mask; /* Watcodgs that are in use */
> 
> Please fix (spelling) the comment after dog_mask.

Oops

> +               err = misc_register(&watchdog_miscdev);
> +               if (err == 0)
> +                       old_wdd = watchdog;
> +               else {
> +                       pr_err("%s: cannot register miscdev on minor=%d (err=%d
> +                               watchdog->info->identity, WATCHDOG_MINOR, err);
> +                       pr_err("%s: probably a legacy watchdog module is presen
> +                               watchdog->info->identity);
> +                       watchdog_release_id(watchdog);
> +                       err = watchdog_assign_id(watchdog, 1);
> +                       if (err < 0)
> +                               return err;
> +               }
> +       }
> 
> You may want to check for err == -EBUSY in the fallback instead of assuming
> the problem is a legacy watchdog driver

Yes that is probably wise

> +       err = watchdog_add_device(watchdog);
> +       }
> 
> You do this even for watchdog0 / for the watchdog we've also registered as
> misc_dev. I guess this is intentional and you want the watchdog to be
> available as both misc,130 as well as as MAJOR(dog_devt),0 ?

Yes - so that it appears in the watchdog class in sysfs for example.

> Other then these few remarks it looks fine. If you can resend it
> with my remarks addressed I'll add a Reviewed-By.

Ok I'll sort those next week.

Thanks

Alan
