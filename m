Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail2.vodafone.ie ([213.233.128.44]:63430 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486Ab1J0Vyk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Oct 2011 17:54:40 -0400
Message-ID: <4EA9D09E.800@draigBrady.com>
Date: Thu, 27 Oct 2011 22:43:58 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Don Zickus <dzickus@redhat.com>
CC: linux-watchdog@vger.kernel.org, kexec@lists.infradead.org,
	vgoyal@redhat.com, amwang@redhat.com
Subject: Re: watchdogs and kdump
References: <20111027203029.GR3452@redhat.com>
In-Reply-To: <20111027203029.GR3452@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 10/27/2011 09:30 PM, Don Zickus wrote:
> Hi,
>=20
> I was assisting a customer the other day debugging a kdump[1] problem, =
when we
> noticed the real problem was the hardware watchdog was firing and
> rebooting the box.
>=20
> Of course, this can be inconvienant if the panic happens right before t=
he
> watchdog is supposed to be kicked, leading to a spontaneous reboot befo=
re
> the second kernel finishes booting and loading the watchdog module.
>=20
> I was trying to think of a way to solve this and thought, one way to
> minimize the problem is to kick the watchdog before we jump into the kd=
ump
> kernel.  Another way is to disable the watchdog entirely, but that does=
n't
> work on all hardware I believe.
>=20
> Anyway, I was posting on the watchdog mailing list to see if anyone had=
 any
> ideas that might help.  And if my above idea to kick the watchdog befor=
e
> jumping into the kdump kernel seems ok, then an api would need to be
> developed.
>=20
> I am willing to do any coding and testing necessary, but before I did, =
I
> wanted help to get a direction to go in first.
>=20
> Thoughts?

Seems like the appropriate thing to do is to call all the
reboot notifiers that each watchdog registers.
Since one is not doingn a full SYS_RESTART (SYS_DOWN) though,
i.e. not running through the BIOS code again,
it might be worth having a different SYS_JUMP code in notifier.h
that would allow you to kick rather than stop the watchdogs
as the reboot notifiers generally do at the moment.
I think it would be important not to stop the watchdog if possible,
given the large amount of logic that's going to be executed
after the jump.

cheers,
P=E1draig.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
