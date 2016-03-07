Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:40793 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbcCGLNP (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 7 Mar 2016 06:13:15 -0500
Date: Mon, 7 Mar 2016 12:13:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
	<hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>,
	Javi Merino <javi.merino@arm.com>,
	Michal Hocko <mhocko@suse.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"Steven Rostedt (Red Hat)" <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Michal Nazarewicz <mina86@mina86.com>,
	Michal Hocko <mhocko@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
	Gobinda Charan Maji <gobinda.cemk07@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v3 PATCH 1/3] panic: Change nmi_panic from macro to function
Message-ID: <20160307111300.GA27820@pd.tnic>
References: <20160303105741.4587.49047.stgit@softrs>
 <20160303105744.4587.1001.stgit@softrs>
 <20160303131458.GD24621@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A84454B18988@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A84454B18988@GSjpTKYDCembx31.service.hitachi.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 10:53:51AM +0000, =E6=B2=B3=E5=90=88=E8=8B=B1=E5=AE=
=8F / KAWAI=EF=BC=8CHIDEHIRO wrote:
> > From: Borislav Petkov [mailto:bp@alien8.de]
> > On Thu, Mar 03, 2016 at 07:57:44PM +0900, Hidehiro Kawai wrote:
> > > Change nmi_panic() macro to a normal function for the portability.
> >=20
> > portability?
>=20
> I wanted to say encapsulating things into a function makes modules
> only have to know about the function. Modules don't need to know
> all things in the macro.  But I thought again, and `portability'
> was not appropriate.
>=20
> However, this patch set has been queued into -mm now.  So I'll
> leave this if not necessary.

Unless Andrew is willing to do a quick "quilt header -e" on your patch
and paste in a corrected commit message text which you give him...

:-)

--=20
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
