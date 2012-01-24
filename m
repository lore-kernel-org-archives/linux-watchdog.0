Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33475 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773Ab2AXGpO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Jan 2012 01:45:14 -0500
From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
CC: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH RFC 1/2] watchdog : omap_wdt : Implement
 WDIOC_GETBOOTSTATUS for omap3+
Date: Tue, 24 Jan 2012 06:29:01 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D12143317902D6@DBDE01.ent.ti.com>
References: <1327317188-14782-1-git-send-email-shubhrajyoti@ti.com>
	<1327317188-14782-2-git-send-email-shubhrajyoti@ti.com>
	<B5906170F1614E41A8A28DE3B8D12143317901B9@DBDE01.ent.ti.com>
 <CAM=Q2ctL_Z5P6=NwAWBHD2bR=xqHMCF15g6v0Ap=hJMPdgXwyQ@mail.gmail.com>
In-Reply-To: <CAM=Q2ctL_Z5P6=NwAWBHD2bR=xqHMCF15g6v0Ap=hJMPdgXwyQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Shubhrajyoti,

On Tue, Jan 24, 2012 at 11:40:43, Shubhrajyoti Datta wrote:
> Hi Vaibhav,
>=20
> On Tue, Jan 24, 2012 at 10:32 AM, Bedia, Vaibhav <vaibhav.bedia@ti.com>=
 wrote:
> > On Mon, Jan 23, 2012 at 16:43:07, Datta, Shubhrajyoti wrote:
> >> This patch intends to implement the WDIOC_GETBOOTSTATUS ioctl
> >> for the omap3 and omap4.
> >>
> >
> > Instead of just returning the register content why not parse
> > the RSTST register value and check if it's really a watchdog
> > reset or not?
>=20
> That is what is done for 24xx and below cpus. So I thought of extending=
 it.
>=20
>=20

IMO they also need to be fixed then :)

Just returning the register content does not help much and looking at oth=
er
implementations, like Blackfin, I am guessing this IOCTL is supposed to g=
ive
a yes/no sort of result.

Regards,
Vaibhav B.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
