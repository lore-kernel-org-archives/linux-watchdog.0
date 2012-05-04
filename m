Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:57705 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756461Ab2EDNEF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 May 2012 09:04:05 -0400
Date: Fri, 4 May 2012 14:34:34 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-watchdog@vger.kernel.org,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>,
	=?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Subject: Re: [PATCH 1/3] watchdog_dev: Add support for having more then 1 watchdog
Message-ID: <20120504123434.GR3074@spo001.leaseweb.com>
References: <1331812757-3491-1-git-send-email-hdegoede@redhat.com> <1331812757-3491-2-git-send-email-hdegoede@redhat.com> <20120315131131.1096f8c8@pyramind.ukuu.org.uk> <4F61FA18.70104@redhat.com> <20120315153833.40bd2f16@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120315153833.40bd2f16@pyramind.ukuu.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alan,

> > You do this even for watchdog0 / for the watchdog we've also registered as
> > misc_dev. I guess this is intentional and you want the watchdog to be
> > available as both misc,130 as well as as MAJOR(dog_devt),0 ?
> 
> Yes - so that it appears in the watchdog class in sysfs for example.

What happens if one program opens the miscdevice and another program opens the MAJOR(dog_devt),0 device?
I presume that the WDOG_DEV_OPEN status bit will prohibit the opening of the second device in that case...

Thanks,
Wim.

