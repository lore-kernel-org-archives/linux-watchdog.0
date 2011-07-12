Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:62457 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab1GLQZr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Jul 2011 12:25:47 -0400
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com [172.24.198.101])
	by smtp-out.google.com with ESMTP id p6CGPjY7001284
	for <linux-watchdog@vger.kernel.org>; Tue, 12 Jul 2011 09:25:46 -0700
Received: from gxk28 (gxk28.prod.google.com [10.202.11.28])
	by wpaz37.hot.corp.google.com with ESMTP id p6CGNwjM030309
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Tue, 12 Jul 2011 09:25:44 -0700
Received: by gxk28 with SMTP id 28so2491441gxk.41
        for <linux-watchdog@vger.kernel.org>; Tue, 12 Jul 2011 09:25:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E15B9FD.8080003@draigBrady.com>
References: <20110706160744.4002.94920.stgit@bhelgaas.mtv.corp.google.com> <4E15B9FD.8080003@draigBrady.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 12 Jul 2011 10:25:24 -0600
Message-ID: <CAErSpo5=TQm9SLM9dE2-Sm7ZLvaSXAZOorE1z9SK9kEh9CUbNQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] [RFC] watchdog reboot timeout
To: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 7, 2011 at 7:51 AM, P=E1draig Brady <P@draigbrady.com> wrote:
> On 06/07/11 17:09, Bjorn Helgaas wrote:
>> I'm looking for comments on these patches. =A0I'm not really happy wit=
h
>> them because they add basically identical code in each driver. =A0I al=
so
>> don't like the fact that the parameter is not generic, so I have to kn=
ow
>> which driver will be used on my machine.
>
> Hmm, so this is protecting the window between watchdog_stop and machine=
_reset.

That's part of it, but I'm really interested in reboots using kexec,
and in that case, there is no machine reset, and BIOS isn't involved
at all.  If the kexec fails or the new kernel hangs for some reason,
I'd like the watchdog to reset the machine.

Currently, we call all the driver .shutdown methods() on the way down,
and the watchdog shutdown methods turn off the watchdog, so we have no
protection after that.

> It would be nice to have this as generic code that did WDIOC_SETTIMEOUT
> immediately after (or instead of) shutdown.

Yes.  I'd prefer this to be more generic.  I've skimmed the new
generic watchdog code a bit, hoping for a nice way to do this, but the
actual .shutdown() method is still in each driver, so making it
generic doesn't seem trivial.  So consider this a plea for future
development.

> Leaving a watchdog enabled across boot does have issues on some systems=
.
> It was OK for winboond based watchdogs I tested, but for some IBM
> server systems, "weird stuff" happened if the watchdog was left enabled
> across boot.

Point taken: it's unwise to assume consistency across all BIOSes, so
it was a mistake to write the last paragraph ("If we reboot via BIOS,
BIOS should disable the watchdog ...").

My reboot_timeout is disabled by default and is only enabled if the
user specifies the module option.  I don't think it's possible to
enable something like this by default, because in general we don't
know anything about the new kernel.  It may not have a watchdog driver
at all.

But in many cases, we *do* know the machine doesn't do "weird stuff,"
the new kernel has a driver, and we can bound the expected boot time.
In those cases, I think this option provides useful protection.

> Just to mention the other watchdog boot scenario I often use
> (which does _not_ protect your window above), which is to enable the
> watchdog in the BIOS. =A0This is more general protection for the
> boot _up_ process.

Yes, that makes good sense.  In my case, I'm interested in kexec, so
the BIOS isn't involved, so enabling it in the BIOS wouldn't help.

> A related issue I noticed with iTCO_wdt is that something
> else in the kernel disables the iTCO watchdog (which my BIOS had starte=
d).
> This is undesirable for obvious reasons.

This sounds related to iTCO, but unrelated to my patch.  Right?

Thanks a lot for your comments!

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
