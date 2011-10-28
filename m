Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28080 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442Ab1J1NkC (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 28 Oct 2011 09:40:02 -0400
Date: Fri, 28 Oct 2011 09:39:54 -0400
From: Don Zickus <dzickus@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: linux-watchdog@vger.kernel.org, kexec@lists.infradead.org,
	vgoyal@redhat.com, amwang@redhat.com
Subject: Re: watchdogs and kdump
Message-ID: <20111028133954.GS3452@redhat.com>
References: <20111027203029.GR3452@redhat.com>
 <4EA9D09E.800@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4EA9D09E.800@draigBrady.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2011 at 10:43:58PM +0100, P=E1draig Brady wrote:
> On 10/27/2011 09:30 PM, Don Zickus wrote:
> > Hi,
> >=20
> > I was assisting a customer the other day debugging a kdump[1] problem=
, when we
> > noticed the real problem was the hardware watchdog was firing and
> > rebooting the box.
> >=20
> > Of course, this can be inconvienant if the panic happens right before=
 the
> > watchdog is supposed to be kicked, leading to a spontaneous reboot be=
fore
> > the second kernel finishes booting and loading the watchdog module.
> >=20
> > I was trying to think of a way to solve this and thought, one way to
> > minimize the problem is to kick the watchdog before we jump into the =
kdump
> > kernel.  Another way is to disable the watchdog entirely, but that do=
esn't
> > work on all hardware I believe.
> >=20
> > Anyway, I was posting on the watchdog mailing list to see if anyone h=
ad any
> > ideas that might help.  And if my above idea to kick the watchdog bef=
ore
> > jumping into the kdump kernel seems ok, then an api would need to be
> > developed.
> >=20
> > I am willing to do any coding and testing necessary, but before I did=
, I
> > wanted help to get a direction to go in first.
> >=20
> > Thoughts?
>=20
> Seems like the appropriate thing to do is to call all the
> reboot notifiers that each watchdog registers.
> Since one is not doingn a full SYS_RESTART (SYS_DOWN) though,
> i.e. not running through the BIOS code again,
> it might be worth having a different SYS_JUMP code in notifier.h
> that would allow you to kick rather than stop the watchdogs
> as the reboot notifiers generally do at the moment.

That is an interesting idea.  Not sure if calling a blocking notifier in
the kdump path would be acceptable to the kexec folks.  Then again using
the reboot notifier in the panic path may not be a good idea either, it
might lead to false expectations. :-/

> I think it would be important not to stop the watchdog if possible,
> given the large amount of logic that's going to be executed
> after the jump.

I agree.  Especially since kdump is still not 100% reliable.

Thanks for the feedback!

Cheers,
Don
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
