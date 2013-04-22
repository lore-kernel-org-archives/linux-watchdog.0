Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from longford.logfs.org ([213.229.74.203]:58894 "EHLO
	longford.logfs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab3DWAMd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Apr 2013 20:12:33 -0400
Date: Mon, 22 Apr 2013 18:45:48 -0400
From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alan Cox <alan@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] Watchdog: add pretimeout
Message-ID: <20130422224548.GA15867@logfs.org>
References: <20130422194347.GA14907@logfs.org>
 <20130422224203.GA8805@roeck-us.net>
 <20130422213839.GB14907@logfs.org>
 <20130422232613.GA28472@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130422232613.GA28472@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, 22 April 2013 16:26:13 -0700, Guenter Roeck wrote:
> On Mon, Apr 22, 2013 at 05:38:39PM -0400, J=C3=B6rn Engel wrote:
> > On Mon, 22 April 2013 15:42:03 -0700, Guenter Roeck wrote:
> >=20
> > The counter-argument is that applications have to opt-in by setting a
> > pretimeout.  Although I have to admit to not testing applications tha=
t
> > don't opt-in.
> >=20
> Still, how does the application distinguish SIGINT (real from SIGINT (w=
atchdog) ?

It cannot.  I picked SIGILL based on "this couldn't ever matter to
us", but when using instructions for modern cpus on older cpus it
actually does.  So whatever signal you pick, you always pick wrong.
Which is why you should have commented on the two paragraphs below
instead. ;)

> > Udev sounds like a bad idea, as that usually means spawning a number
> > of shell scripts and is more likely to get lost in realtime systems o=
r
> > similar.  Polling on a file descriptor would make sense.
> >=20
> > I would be fine with removing the notification for now and have
> > someone else add a proper interface as time permits.  Someone else ma=
y
> > well be a future version of me.
> >=20
> > > Also, I think there should be a callback into the watchdog drivers.
> > > There are watchdogs out there implementing a pre-timeout in hardwar=
e,
> > > and the watchdog code could make use of that functionality.
> >=20
> > Sounds like a good idea in principle, but I can see few advantages in
> > reality.  The code gets slightly more complex, test coverage is
> > divided between platforms and it only matters if kernel timers are
> > somehow borked.  Not sure if you have a strong argument in favor.
> >=20
> I am currently dealing with a watchdog which does support pre-timeouts.
> It would seem odd to me if the core watchdog API would support pre-time=
outs,
> but not the pre-timeouts supported by the actual watchdog driver.

Agreed.  However the pretimeout gets generated and delivered to the
kernel, the userspace ABI should be identical.  Currently that covers
the ipmi_watchdog and my patch.

Neat.  Ipmi already has the poll interface.  So what we should be
doing is generalize it from the ipmi driver.  I will see if I can
sneak off into a dark corner and do so before $BOSS notices.

J=C3=B6rn

--
Linux is more the core point of a concept that surrounds "open source"
which, in turn, is based on a false concept. This concept is that
people actually want to look at source code.
-- Rob Enderle
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
